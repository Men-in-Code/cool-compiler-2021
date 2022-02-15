from pydoc import text
from git import typ
from numpy import VisibleDeprecationWarning
from cool.cil_builder.cil_ast import * 
from cool.semantic import visitor
from cool.semantic.semantic import ObjectType, Scope
from cool.semantic.semantic import get_common_parent,multiple_get_common_parent,is_local
from cool.semantic.semantic import SemanticException
from cool.semantic.semantic import ErrorType, IntType, BoolType
from cool.utils.Errors.semantic_errors import *
from cool.semantic.semantic import *


class BaseCILToMIPSVisitor:
    def __init__(self, context):
        self.dottypes = []
        self.dotdata = []
        self.dotcode = []
        self.current_type = None
        self.current_method = None
        self.current_function = None
        self.context = context
        self.label_id = 0

        self.text_section = ""
        self.data_section = ""
        self.mips_type = ""
        self.type_offset = {}
        self.attribute_offset = {}
        self.method_offset = {}
        self.var_offset = {}
        self.errors = {
            'call_void_expr':'Runtime Error: A dispatch (static or dynamic) on void',
            'case_void_expr': 'Runtime Error: A case on void',
            'case_branch':'Runtime Error: Execution of a case statement without a matching branch',
            'zero_division':'Runtime Error: Division by zero',
            'substring_out_of_range':'Runtime Error: Substring out of range',
            'heap_overflow':'Runtime Error: Heap overflow'
        }

    @property
    def params(self):
        return self.current_function.params
    
    @property
    def localvars(self):
        return self.current_function.localvars
    
    @property
    def instructions(self):
        return self.current_function.instructions

    def fill_dotdata_with_errors(self):
        self.mips_data+= '''
    call_void_error: .asciiz 'Runtime Error 1: A dispatch (static or dynamic) on void'\n
    case_void_expr: .asciiz 'Runtime Error 2: A case on void.'\n
    case_branch_error: .asciiz 'Runtime Error 3: Execution of a case statement without a matching branch.'\n
    zero_division: .asciiz 'Runtime Error 4: Division by zero'\n
    substring_out_of_range: .asciiz 'Runtime Error 5: Substring out of range.'\n
    heap_overflow: .asciiz 'Runtime Error 5: Heap overflow'\n
        '''


class CILtoMIPSVisitor(BaseCILToMIPSVisitor):


    @visitor.when(ProgramCilNode)
    def visit(self,node,scope):
    ########################################
    # self.dottypes = dottypes [TypeNodeList]
    # self.dotdata = dotdata [DataNodeList]
    # self.dotcode = dotcode [FunctionNodeList]
    ########################################
        for type in self.dottypes:
            self.visit(type)
        for data in self.dotdata:
            self.visit(data)
        for inst in self.dotcode:
            self.visit(inst,scope)

    @visitor.when(TypeCilNode)
    def visit(self,node):
        for i,param in enumerate(node.attributes):
            self.attribute_offset[node.name,param] = 4*i
            i+=1

        for i,method in enumerate(node.methods):
            self.method_offset[node.name,method] = 4*i
            i+=1
      
    @visitor.when(DataCilNode)
    def visist(self,node):
        self.data_section += f'{node.name}: .asciiz {node.value}'
            
    @visitor.when(FunctionCilNode)
    def visist(self,node):
        def __init__(self, fname, params, localvars, instructions):
            self.name = fname
            self.params = params
            self.localvars = localvars
            self.instructions = instructions

        self.current_function = node
        for i,var in enumerate(node.params + node.localvars):
            self.data_offset[self.current_function.name,var.name] = 4*i

        self.text_section += f'{node.name}:\n'
        self.text_section += f'addi, $sp, $sp, {-4*len(node.params + node.localvars)}'#get space for vars
        ## ojo faltaria ver que hago con el retorno

        for inst in node.instructions:
            self.visit(inst)


    class ParamCilNode(CilNode):
        def __init__(self, name):
            self.name = name

    class LocalCilNode(CilNode):
        def __init__(self, name):
            self.name = name

    class InstructionCilNode(CilNode):
        pass


    class BinaryCilNode(InstructionCilNode): #Binary Operations
        def __init__(self, dest, left, right):
            self.dest = dest
            self.left = left
            self.right = right

    class UnaryCilNode(InstructionCilNode): #Unary Operations
        def __init__(self, dest, right):
            self.dest = dest
            self.right = right


    class ConstantCilNode(InstructionCilNode): #7.1 Constant
        def __init__(self,vname,value):
            self.vname = vname
            self.value = value

    #7.2 Identifiers, not necesary cil Node

    class AssignCilNode(InstructionCilNode): # 7.3 Assignment
        def __init__(self, dest, source):
            self.dest = dest
            self.source = source

    class StaticCallCilNode(InstructionCilNode): #7.4 Distaptch Static
        def __init__(self,expresion_instance,expresion_type,method_name,args, result):
            self.expresion_instance = expresion_instance
            self.expresion_type = expresion_type
            self.method_name = method_name
            self.args = args
            self.result = result

    class DynamicCallCilNode(InstructionCilNode): #7.4 Dispatch Dynamic
        def __init__(self,expresion_instance, dynamic_type, method_name,args, result):
            self.expresion_instance = expresion_instance
            self.dynamic_type = dynamic_type
            self.method_name = method_name
            self.args = args
            self.result = result

    class BlockCilNode(InstructionCilNode): #7.7 Blocks
        pass

    class LetCilNode(InstructionCilNode): #7.8 Let
        pass

    class CaseCilNode(InstructionCilNode): #7.9 Case
        def __init__(self,expr,expr_list,label_list):
            self.main_expr = expr
            self.expr_list = expr_list
            self.label = label_list

    class InstantiateCilNode(InstructionCilNode): #7.10 New
        pass

    class IsVoidCilNode(InstructionCilNode): #7.11 IsVoid
        def __init__(self, expresion, result):
            self.expresion = expresion
            self.result = result
        pass


    #Binary Aritmetic Operations
    @visitor.when(PlusCilNode)
    def visit(self, node):   
        offset_right = self.var_offset[self.current_function,node.right]
        offset_left = self.var_offset[self.current_function,node.left]
        offset_dest = self.var_offset[self.current_function,node.dest]

        self.text+= f'lw, t0, {offset_right}($sp)'
        self.text+= f'lw, t1, {offset_left}($sp)'
        self.text+= f'add, $t0,$t0,$t1'

        self.text+=f'sw, t0, {offset_dest}($sp)'
        
        
    @visitor.when(MinusCilNode)
    def visit(self, node):
        offset_right = self.var_offset[self.current_function,node.right]
        offset_left = self.var_offset[self.current_function,node.left]
        offset_dest = self.var_offset[self.current_function,node.dest]

        self.text+= f'lw, t0, {offset_right}($sp)'
        self.text+= f'lw, t1, {offset_left}($sp)'
        self.text+= f'sub, $t0,$t0,$t1'

        self.text+=f'sw, t0, {offset_dest}($sp)'
    @visitor.when(StarCilNode)
    def visit(self, node):
        offset_right = self.var_offset[self.current_function,node.right]
        offset_left = self.var_offset[self.current_function,node.left]
        offset_dest = self.var_offset[self.current_function,node.dest]

        self.text+= f'lw, t0, {offset_right}($sp)'
        self.text+= f'lw, t1, {offset_left}($sp)'
        self.text+= f'mul, $t0,$t0,$t1'

        self.text+=f'sw, t0, {offset_dest}($sp)'

    @visitor.when(DivCilNode)
    def visit(self, node):
        offset_right = self.var_offset[self.current_function,node.right]
        offset_left = self.var_offset[self.current_function,node.left]
        offset_dest = self.var_offset[self.current_function,node.dest]

        self.text+= f'lw, t0, {offset_right}($sp)'
        self.text+= f'lw, t1, {offset_left}($sp)'
        self.text+= f'div, $t0,$t0,$t1'

        self.text+=f'sw, t0, {offset_dest}($sp)'


    # Attributes operations
    class GetAttribCilNode(InstructionCilNode):
        def __init__(self,instance,stype,attribute,dest):
            self.instance = instance
            self.stype = stype
            self.attribute = attribute
            self.dest = dest

    class SetAttribCilNode(InstructionCilNode):
        def __init__(self,stype,value,attribute):
            self.stype = stype
            self.value = value
            self.attribute = attribute

    class AllocateCilNode(InstructionCilNode):
        def __init__(self, itype, dest):
            self.type = itype
            self.dest = dest

    class TypeOfCilNode(InstructionCilNode):
        def __init__(self, obj, dest):
            self.obj = obj
            self.dest = dest

    class LabelCilNode(InstructionCilNode):
        def __init__(self,label):
            self.label = label

    class GotoCilNode(InstructionCilNode):
        def __init__(self,label):
            self.label = label

    class GotoIfCilNode(InstructionCilNode):
        def __init__(self,val,label):
            self.val = val
            self.label = label

    class ArgCilNode(InstructionCilNode):
        def __init__(self, name):
            self.name = name

    class ReturnCilNode(InstructionCilNode):
        def __init__(self, value=None):
            self.value = value

    class LoadCilNode(InstructionCilNode):
        def __init__(self, dest, msg):
            self.dest = dest
            self.msg = msg



    #TypesCilNodes falta bool ojo
    @visitor.when(IntCilNode)
    def visit(self, node):   
        # def __init__(self,value,result):
        #     self.value = value
        #     self.result = result
        offset = self.var_offset[self.current_function.name,node.result]
        self.text_section += f'addi, t0, $zero, {node.value}'
        self.text_section += f'sw, $t0, {offset}($sp)'



    class StringCilNode(InstructionCilNode):
        def __init__(self,value,result):
            self.value = value
            self.result = result

    #Function CilNodes 
    class ToStrCilNode(InstructionCilNode):
        def __init__(self, dest, ivalue):
            self.dest = dest
            self.ivalue = ivalue

    class ReadCilNode(InstructionCilNode):
        def __init__(self,self_param,input_var,dest):
            self.self_param = self_param
            self.input_var = input_var
            self.dest = dest

    class PrintCilNode(InstructionCilNode):
        def __init__(self,self_param,str_addr):
            self.self_param = self_param
            self.str_addr = str_addr
    class AbortCilNode(InstructionCilNode):
        pass
    class TypeNameCilNode(InstructionCilNode):
        def __init__(self, type, result):
            self.type = type
            self.result = result
    class CopyCilNode(InstructionCilNode):
        def __init__(self, type, result):
            self.type = type
            self.result = result
    class PrintStringCilNode(PrintCilNode):
        pass
    class PrintIntCilNode(PrintCilNode):
        pass
    class ReadStringCilNode(ReadCilNode):
        pass
    class ReadIntCilNode(ReadCilNode):
        pass
    class LengthCilNode(InstructionCilNode):
        def __init__(self, strVar, result):
            self.str = strVar
            self.length = result
    class ConcatCilNode(InstructionCilNode):
        def __init__(self, strVal, var2,result):
            self.strVal = strVal
            self.var2 = var2
            self.length = result

    class SubstringCilNode(InstructionCilNode):
        def __init__(self, strVal,value1, value2,result):
            self.strVal = strVal
            self.value1 = value1
            self.value2 = value2
            self.length = result


    #Given 2 memory location calculate the distance of his types
    class TypeDistanceCilNode(InstructionCilNode):
        def __init__(self,type1,type2,result):
            self.type1 = type1
            self.type2 = type2
            self.result = result 


    class MinCilNode(InstructionCilNode):
        def __init__(self,num1,num2,result):
            self.num1 = num1
            self.num2 = num2
            self.result = result



    class ErrorCilNode(InstructionCilNode):
        def __init__(self,name):
            self.name = name

    class EqualsCilNode(BinaryCilNode):
        pass
