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

        self.text_section = ".text\n"
        self.data_section = ".data\n"
        self.mips_type = ""
        self.type_offset = {}
        self.attribute_offset = {}
        self.method_offset = {}
        self.method_original = {}
        self.var_offset = {}
        self.type_size = {} #quantity of attr. of that type
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
        self.data_section+= '''
    #Errors
    call_void_error: .asciiz "Runtime Error 1: A dispatch (static or dynamic) on void"
    case_void_expr: .asciiz "Runtime Error 2: A case on void."
    case_branch_error: .asciiz "Runtime Error 3: Execution of a case statement without a matching branch."
    zero_division: .asciiz "Runtime Error 4: Division by zero"
    substring_out_of_range: .asciiz "Runtime Error 5: Substring out of range."
    heap_overflow: .asciiz "Runtime Error 6: Heap overflow"
'''
    def fill_dottext_with_errors(self):
        self.text_section+= '\n\n'
        self.text_section+= 'error_call_void:\n' #dispatch error 1
        self.text_section+= 'la $a0,call_void_error\n'
        self.text_section+= 'j print_error\n'

        self.text_section+= 'error_expr_void:\n' #case error 2
        self.text_section+= 'la $a0,case_void_expr\n'
        self.text_section+= 'j print_error\n'
        
        self.text_section+= 'error_branch:\n' #branch error 3
        self.text_section+= 'la $a0,case_branch_error\n'
        self.text_section+= 'j print_error\n'

        self.text_section+= 'error_div_by_zero:\n' #division by zero error 4
        self.text_section+= 'la $a0,zero_division\n'
        self.text_section+= 'j print_error\n'

        self.text_section+= 'error_substring:\n' #substring out of range
        self.text_section+= 'la $a0,substring_out_of_range\n'
        self.text_section+= 'j print_error\n'

        self.text_section+= 'error_heap:\n'
        self.text_section+= 'la $a0,heap_overflow\n'


        self.text_section+= 'print_error:\n'
        self.text_section+= 'li $v0, 4\n'
        self.text_section+= 'syscall\n'
        self.text_section+= 'j end\n'




class CILtoMIPSVisitor(BaseCILToMIPSVisitor):

    @visitor.on('node')
    def visit(self, node):
        pass

    @visitor.when(ProgramCilNode)
    def visit(self,node):
    ########################################
    # self.dottypes = dottypes [TypeNodeList]
    # self.dotdata = dotdata [DataNodeList]
    # self.dotcode = dotcode [FunctionNodeList]
    ########################################
        self.dottypes = node.dottypes
        self.dotcode = node.dotcode
        self.dotdata = node.dotdata
        self.fill_dotdata_with_errors()

        self.text_section+= 'jal entry\n'

        self.text_section+=f'\n'
        self.text_section+=f'end:\n' 
        self.text_section+=f'li, $v0, 10\n'
        self.text_section+=f'syscall\n'

        self.fill_dottext_with_errors()

        self.data_section+= '#TYPES\n'
        for type in self.dottypes:
            self.visit(type)
        for data in self.dotdata:
            self.visit(data)
        for code in self.dotcode:
            self.visit(code)

        return self.data_section+self.text_section

    @visitor.when(TypeCilNode)
    def visit(self,node):
        # self.text_section += '\n'

        self.data_section+= f'type_{node.name}: .asciiz "{node.name}"\n'
        self.data_section+= f'{node.name}_methods:\n'

        for i,attr in enumerate(node.attributes):
            self.attribute_offset[node.name,attr] = 4*(i+1)
        self.type_size[node.name] = len(node.attributes)

        for i,method in enumerate(node.methods):
            self.data_section+= f'.word {method[1]}\n'
            self.method_offset[node.name,method[1]] = 4*i
            self.method_original[node.name,method[0]] = method[1]

        self.data_section+= '\n'
      
    @visitor.when(DataCilNode)
    def visit(self,node):
        self.data_section += f'{node.name}: .asciiz "{node.value}"\n'
            
    @visitor.when(FunctionCilNode)
    def visit(self,node):
        #############################################3
        #     node.name = fname
        #     node.params = params
        #     node.localvars = localvars
        #     node.instructions = instructions
        #############################################3
        self.current_function = node
        for i,var in enumerate(node.localvars+node.params):
            self.var_offset[self.current_function.name,var.name] = 4*(i+1)

        self.text_section += '\n'
        self.text_section += f'{node.name}:\n'
        self.text_section += f'addi, $sp, $sp, {-4*(len(node.localvars)+1)}\n'#get space for vars and return adress
        ## ojo faltaria ver que hago con el retorno
        self.text_section += 'sw $ra, ($sp)\n'

        for inst in node.instructions:
            self.visit(inst)

        self.text_section+= 'lw $ra, ($sp)\n'
        self.text_section+= f'addi $sp, $sp,{4*(len(node.localvars)+1)}\n'
        self.text_section+= 'jr $ra\n'

        

        


    # class ParamCilNode(CilNode):
    #     def __init__(self, name):
    #         self.name = name

    # class LocalCilNode(CilNode):
    #     def __init__(self, name):
    #         self.name = name

    # class InstructionCilNode(CilNode):
    #     pass


    # class BinaryCilNode(InstructionCilNode): #Binary Operations
    #     def __init__(self, dest, left, right):
    #         self.dest = dest
    #         self.left = left
    #         self.right = right

    # class UnaryCilNode(InstructionCilNode): #Unary Operations
    #     def __init__(self, dest, right):
    #         self.dest = dest
    #         self.right = right


    # class ConstantCilNode(InstructionCilNode): #7.1 Constant
    #     def __init__(self,vname,value):
    #         self.vname = vname
    #         self.value = value

    # #7.2 Identifiers, not necesary cil Node

    # class AssignCilNode(InstructionCilNode): # 7.3 Assignment
    #     def __init__(self, dest, source):
    #         self.dest = dest
    #         self.source = source

    @visitor.when(StaticCallCilNode) #7.4 Distaptch Static
    def visit(self,node): 
        #########################################################################
        # node.type = type
        # node.method_name = method_name
        # node.args = args
        # node.result = result
        ########################################################################
        arg_amount = (len(node.args))*4


        self.text_section+= f'move $t0 $sp #call to function {node.method_name}\n'
        self.text_section+= f'addi, $sp, $sp, -{arg_amount}\n'
        # self.text_section+= f'sw $ra, ($sp)\n'
        for i,arg in enumerate(node.args):
            arg_offset = self.var_offset[self.current_function.name,arg]
            self.text_section+= f'lw, $s0, {arg_offset}($t0) #loading param_{arg}\n'
            self.text_section+= f'sw, $s0 {(i)*4}($sp) #setting param for function call\n'

        if node.method_name[:4] == 'init':
            self.text_section+= f'jal {node.method_name}\n'
        else:
            function_offset = self.method_original[node.type,node.method_name]
            # self.text_section+= f'lw $s1, 4($sp)\n' #instance location
            # self.text_section+= f'la $s2, {function_offset}($s1)\n' #$s2 method name

            # self.text_section+= f'jalr $s2\n'
            self.text_section+= f'jal {function_offset}\n'

        self.text_section+= f'addi, $sp, $sp, {arg_amount}\n'

        result_offset = self.var_offset[self.current_function.name,node.result]
        self.text_section += f'sw $s0, {result_offset}($sp) #Saving result on {node.result}\n'

        # self.text_section+= 'jr $ra\n'


    @visitor.when(DynamicCallCilNode) #7.4 Dispatch Dynamic
    def visit(self,node):
        #########################################################################
        # node.expresion_instance = expresion_instance
        # node.static_type = static_type
        # node.method_name = method_name
        # node.args = args
        # node.result = result
        ########################################################################
        arg_amount = (len(node.args))*4
        self.text_section+= f'move $t0 $sp\n'
        self.text_section+= f'addi, $sp, $sp, -{arg_amount}\n'
        # self.text_section+= f'sw $ra, ($sp)\n'

        for i,arg in enumerate(node.args):
            arg_offset = self.var_offset[self.current_function.name,arg]
            self.text_section+= f'lw, $s0, {arg_offset}($t0)\n'
            self.text_section+= f'sw, $s0 {(i)*4}($sp)\n'


        expresion_offset = self.var_offset[self.current_function.name,node.expresion_instance]  
        self.text_section += f'lw $a0, {expresion_offset}($t0)\n' #OJO
        #El tipo dinamico se consigue a partir de expresion offset
        self.text_section += 'la $t1, call_void_error\n'
        self.text_section += 'beq $a0, $t1, call_void_error\n'
        

        #Selecting Function
        self.text_section += f'lw $a1, ($a0)\n'
        original_fun = self.method_original[node.static_type,node.method_name]
        self.text_section += f'lw $a2, {self.method_offset[node.static_type,original_fun]}($a1)\n'
        self.text_section += 'jalr $a2\n'


        #Restoring SP and returning
        self.text_section+= f'addi, $sp, $sp, {arg_amount}\n'
        result_offset = self.var_offset[self.current_function.name,node.result]
        self.text_section += f'sw $s0, {result_offset}($sp)\n'




    @visitor.when(DynamicParentCallCilNode) #7.4 Dispatch Dynamic
    def visit(self,node):
        #########################################################################
        # node.expresion_instance = expresion_instance
        # node.static_type = static_type
        # node.method_name = method_name
        # node.args = args
        # node.result = result
        ########################################################################
        arg_amount = (len(node.args)+1)*4
        self.text_section+= f'move $t0 $sp\n'
        self.text_section+= f'subu, $sp, $sp, {arg_amount}\n'
        self.text_section+= f'sw $ra, ($sp)\n'

        for i,arg in enumerate(node.args):
            arg_offset = self.var_offset[self.current_function.name,arg]
            self.text_section+= f'lw, $s0, {arg_offset}($t0)\n'
            self.text_section+= f'sw, $s0 {(i+1)*4}($sp)\n'


        expresion_offset = self.var_offset[self.current_function.name,node.expresion_instance]  
        self.text_section += f'lw $v0, {expresion_offset}($t0)\n' #OJO puede que no se haga la operacion asi
        #El tipo dinamico se consigue a partir de expresion offset
        self.text_section += 'la $t1, call_void_error\n'
        self.text_section += 'beq $v0, $t1, call_void_error\n'
        
        self.text_section += f'la $v1, {node.static_type}_methods\n'
        self.text_section += f'lw $v2, {self.method_offset[node.static_type,node.method_name]}($vi)\n'
        self.text_section += 'jalr $v2\n'

        result_offset = self.var_offset[self.current_function.name,node.result]
        self.text_section += f'sw $v0, {result_offset}($sp)\n'

    # class BlockCilNode(InstructionCilNode): #7.7 Blocks
    #     pass

    # class LetCilNode(InstructionCilNode): #7.8 Let
    #     pass

    # class CaseCilNode(InstructionCilNode): #7.9 Case
    #     def __init__(self,expr,expr_list,label_list):
    #         self.main_expr = expr
    #         self.expr_list = expr_list
    #         self.label = label_list

    # @visitor.when(InstantiateCilNode)
    # def visit(self,node):


    # class IsVoidCilNode(InstructionCilNode): #7.11 IsVoid
    #     def __init__(self, expresion, result):
    #         self.expresion = expresion
    #         self.result = result
    #     pass


    #Binary Aritmetic Operations
    @visitor.when(PlusCilNode)
    def visit(self, node):   
        offset_right = self.var_offset[self.current_function.name,node.right]
        offset_left = self.var_offset[self.current_function.name,node.left]
        offset_dest = self.var_offset[self.current_function.name,node.dest]
        self.text_section += '\n'

        self.text_section+= f'lw, $t3, {offset_right}($sp)\n'
        self.text_section+=f'lw,$t1,4($t3)\n'


        self.text_section+= f'lw, $t3, {offset_left}($sp)\n'
        self.text_section+=f'lw,$t2,4($t3)\n'



        self.text_section+= f'add, $t3,$t1,$t2\n' #resultado de la suma

        self.text_section+=f'sw, $t3, {offset_dest}($sp)\n'
        
        
    @visitor.when(MinusCilNode)
    def visit(self, node):
        offset_right = self.var_offset[self.current_function.name,node.right]
        offset_left = self.var_offset[self.current_function.name,node.left]
        offset_dest = self.var_offset[self.current_function.name,node.dest]
        self.text_section += '\n'

        self.text_section+= f'lw, $t0, {offset_right}($sp)\n'
        self.text_section+= f'lw, $t1, {offset_left}($sp)\n'
        self.text_section+= f'sub, $t0,$t1,$t0\n'

        self.text_section+=f'sw, $t0, {offset_dest}($sp)\n'
    @visitor.when(StarCilNode)
    def visit(self, node):
        offset_right = self.var_offset[self.current_function.name,node.right]
        offset_left = self.var_offset[self.current_function.name,node.left]
        offset_dest = self.var_offset[self.current_function.name,node.dest]
        self.text_section += '\n'

        self.text_section+= f'lw, $t0, {offset_right}($sp)\n' 
        self.text_section+= f'lw, $t1, {offset_left}($sp)\n'
        self.text_section+= f'mul, $t0,$t1,$t0\n'

        self.text_section+=f'sw, $t0, {offset_dest}($sp)\n'

    @visitor.when(DivCilNode)
    def visit(self, node):
        offset_right = self.var_offset[self.current_function.name,node.right]
        offset_left = self.var_offset[self.current_function.name,node.left]
        offset_dest = self.var_offset[self.current_function.name,node.dest]
        self.text_section += '\n'
        self.text_section += 'beq,$t1,$zero, zero_division' #ojo falta poner la etiqueta q me lleve a la funcion donde se da el error
        self.text_section+= f'lw, $t0, {offset_right}($sp)\n'
        self.text_section+= f'lw, $t1, {offset_left}($sp)\n'
        self.text_section+= f'div, $t0,$t1,$t0\n'
        self.text_section+=f'sw, $t0, {offset_dest}($sp)\n'


    @visitor.when(GetAttribCilNode)
    def visit(self,node):
        #######################################
            # node.instance = instance
            # node.type = type
            # node.attribute = attribute
            # node.result = result
        #######################################
        attr_offset = self.attribute_offset[node.type,node.attribute]
        instance_offset = self.var_offset[self.current_function.name,node.instance]
        result_offset = self.var_offset[self.current_function.name,node.result]

        # (instance_offset+attr_offset)
        self.text_section += '\n'
        self.text_section+= f'lw, $t3, {instance_offset}($sp) #getting instance {node.instance} \n' #Buscar la local que tiene la direccion del heap
        self.text_section+= f'lw, $t1, {attr_offset}($t3)  #getting offset {node.attribute} \n' #Cargar en un registro el valor del atributo
        self.text_section+= f'sw, $t1, {result_offset}($sp)   \n' #Guardo el valor 

    @visitor.when(SetAttribCilNode)
    def visit(self,node):
    # class SetAttribCilNode(InstructionCilNode):
    #######################################
        # node.instance = instance
        # node.type = type
        # node.attribute = attribute
        # node.value = value
    #######################################
        attr_offset = self.attribute_offset[node.type,node.attribute]
        instance_offset = self.var_offset[self.current_function.name,node.instance]
        value_offset = self.var_offset[self.current_function.name,node.value]
        self.text_section += '\n'
        self.text_section+= f'lw, $t1, {value_offset}($sp)   \n' #Guardo el valor 
        self.text_section+= f'lw, $t3, {instance_offset}($sp)  \n' #Buscar la local que tiene la direccion del heap
        self.text_section+= f'sw, $t1, {attr_offset}($t3)   \n' #Cargar en un registro el valor del atributo(ojo puede q no haya q restar)


    @visitor.when(SetDefaultCilNode)
    def visit(self,node):
    # class SetAttribCilNode(InstructionCilNode):
    #######################################
        # node.instance = instance
        # node.type = type
        # node.attribute = attribute
        # node.value = value
    #######################################
        attr_offset = self.attribute_offset[node.type,node.attribute]
        instance_offset = self.var_offset[self.current_function.name,node.instance]
        if node.value == '0':
            value = f'move, $t1, $zero\n'
        elif node.value == "":
            value = f'la, $t1, data_empty\n'
        else:
            value = f''

        # self.text_section+= f'lw, $t1, {value}   \n' #Guardo el valor 
        self.text_section+= value
        self.text_section += '\n'
        self.text_section+= f'lw, $t3, {instance_offset}($sp)  \n' #Buscar la local que tiene la direccion del heap
        self.text_section+= f'sw, $t1, {attr_offset}($t3)   \n' #Cargar en un registro el valor del atributo

    @visitor.when(AllocateCilNode)
    def visit(self, node):
        #######################################
        #node.type = type
        #node.result = result
        #######################################
        result_offset = self.var_offset[self.current_function.name,node.result]
        type_size = (self.type_size[node.type] + 1) * 4 #mas 1 para guardar el addr del tipo
        self.text_section += '\n'
        
        self.text_section += f'addi $a0, $zero, {type_size}\n' #ojo pudiera faltar un +4
        self.text_section += 'li, $v0, 9\n'
        self.text_section += 'syscall\n'
        self.text_section += 'blt, $sp, $v0,error_heap\n'
        self.text_section += 'move, $t3, $v0\n'

        self.text_section += f'la $t1,{node.type}_methods\n'#recupero el addr del tipo
        self.text_section += 'sw $t1, ($t3)\n' #guardo en el primer espacio de memoria de la nueva instancia el addr del tipo
        self.text_section += f'sw, $t3, {result_offset}($sp)\n'

    @visitor.when(AllocateBySizeCilNode)   
    def visit(self,node):
        #######################################
        # node.amount_location = amount_location
        # node.result = result
        #######################################
        result_offset = self.var_offset[self.current_function.name,node.result]
        size_offset = self.var_offset[self.current_function.name,node.result] #mas 1 para guardar el addr del tipo
        
        self.text_section += '\n'
        self.text_section += f'lw $a0,{size_offset}($sp)\n'
        self.text_section += 'li, $v0, 9\n'
        self.text_section += 'syscall\n'
        self.text_section += 'blt, $sp, $v0,error_heap\n'
        self.text_section += 'move, $t3, $v0\n'

        self.text_section += f'sw, $t3, {result_offset}($sp)\n'


    @visitor.when(GetDataCilNode)
    def visit(self,node):
        #######################################
        # node.name = name
        # node.result = result
        #######################################
        self.text_section += f'\n'
        result_offset = self.var_offset[self.current_function.name,node.result]
        self.text_section += f'la $t1, {node.name}\n'
        self.text_section += f'sw $t1, {result_offset}($sp)\n'



    @visitor.when(ReturnCilNode)
    def visit(self,node):
        ###########################################
        #node.value = value
        ###########################################
        self.text_section += '\n'
        if node.value:
            offset = self.var_offset[self.current_function.name,node.value]
            self.text_section += f'lw $s0, {offset}($sp)\n'
        else:
            self.text_section += f'move $a1, $zero\n'

#Function Mips Implementattion
    @visitor.when(PrintStringCilNode)
    def visit(self, node):
        ###########################################
        # node.self_param = self_param
        # node.to_print = to_print
        ###########################################
        str_offset = self.var_offset[self.current_function.name,node.to_print]

        self.text_section += '\n'
        self.text_section+= f'li, $v0, 4\n'
        self.text_section+= f'lw, $a0, {str_offset}($sp)\n'
        self.text_section+= f'syscall\n'

    @visitor.when (PrintIntCilNode)
    def visit(self, node):
        ###########################################
        # node.to_print = to_print 
        ###########################################
        str_offset = self.var_offset[self.current_function.name,node.to_print]
        self.text_section += '\n'
        self.text_section+= f'li, $v0, 1\n'
        self.text_section+= f'lw, $a0, {str_offset}($sp)\n'
        self.text_section+= f'syscall\n'



    
    # class TypeOfCilNode(InstructionCilNode):
    #     def __init__(self, obj, dest):
    #         self.obj = obj
    #         self.dest = dest
    @visitor.when (LabelCilNode)
    def visit(self, node):
        # self.label = label
        self.text_section += f' {node.label}:\n'
        

    @visitor.when (GotoCilNode)
    def visit(self, node):
        # self.label = label
        self.text_section += f'j {node.label}\n'

    @visitor.when (GotoIfCilNode)
    def visit(self, node):
    #         self.val = val
    #         self.label = label
        offset = self.var_offset[self.current_function,node.val]
        self.text_section += f'lw t0, {offset}($sp)\n'
        self.text_section += f'lw t1, 4(t0)\n'


    # class ArgCilNode(InstructionCilNode):
    #     def __init__(self, name):
    #         self.name = name

    # class LoadCilNode(InstructionCilNode):
    #     def __init__(self, dest, msg):
    #         self.dest = dest
    #         self.msg = msg



    #TypesCilNodes falta bool ojo
    @visitor.when(IntCilNode)
    def visit(self, node):   
        #     node.value = value
        #     node.result = result
        offset = self.var_offset[self.current_function.name,node.result]
        self.text_section += '\n'
        self.text_section += f'addi, $t1, $zero, {node.value}\n'
        self.text_section += f'sw, $t1, {offset}($sp)\n'


    @visitor.when(StringCilNode)
    def visit(self, node):   
        ###############################
        #     node.dir1 = dir1
        #     node.dir2 = dir2
        ###############################
        dir1_offset = self.var_offset[self.current_function.name,node.dir1]
        dir2_offset = self.var_offset[self.current_function.name,node.dir2]
        self.text_section += '\n'
        self.text_section += f'lw, $t1, {dir1_offset}($sp)\n' #Cargo en t1 la direccion del string en data
        self.text_section += f'lw, $t2, {dir2_offset}($sp)\n' #Cargo en t2 la direccion donde guardare el string en el heap

        # self.text_section += 

    @visitor.when(LengthCilNode)
    def visit(self, node):
        #####################################  
        # node.self_dir = self_dir
        # node.length = length
        #####################################  

        offset_self = self.var_offset[self.current_function.name,node.self_dir]
        offset_length = self.var_offset[self.current_function.name,node.length]
        self.text_section += f'lw $t1, {offset_self}($sp)\n'

        self.text_section += 'li $s1, 0\n' #contador de caracteres (el ultimo es 0 y no se cuenta)
        self.text_section += 'loop_function_length:\n' 
        self.text_section += 'lb $t2, ($t1)\n' #Cargo un caracter
        self.text_section += 'beqz $t2, end_function_length\n' #si el caracter que cargue es 0, termino
        self.text_section += 'addi $t1, $t1, 1\n' #sumo 1 a la direccion de donde estoy buscando el string
        self.text_section += 'addi $s1, $s1, 1\n' #Sumo 1 al contador
        self.text_section += 'j loop_function_length\n' #Reinicio el loop
        self.text_section += 'end_function_length:\n' #Fin del loop

        self.text_section += f'sw $s1, {offset_length}($sp)\n'  #


    # #Function CilNodes 
    # class ToStrCilNode(InstructionCilNode):
    #     def __init__(self, dest, ivalue):
    #         self.dest = dest
    #         self.ivalue = ivalue

    # class ReadCilNode(InstructionCilNode):
    #     def __init__(self,self_param,input_var,dest):
    #         self.self_param = self_param
    #         self.input_var = input_var
    #         self.dest = dest

    # class AbortCilNode(InstructionCilNode):
    #     pass
    # class TypeNameCilNode(InstructionCilNode):
    #     def __init__(self, type, result):
    #         self.type = type
    #         self.result = result
    # class CopyCilNode(InstructionCilNode):
    #     def __init__(self, type, result):
    #         self.type = type
    #         self.result = result
    
  
        
    # class ReadStringCilNode(ReadCilNode):
    #     pass
    # class ReadIntCilNode(ReadCilNode):
    #     pass


    # class ConcatCilNode(InstructionCilNode):
    #     def __init__(self, strVal, var2,result):
    #         self.strVal = strVal
    #         self.var2 = var2
    #         self.length = result

    # class SubstringCilNode(InstructionCilNode):
    #     def __init__(self, strVal,value1, value2,result):
    #         self.strVal = strVal
    #         self.value1 = value1
    #         self.value2 = value2
    #         self.length = result


    # #Given 2 memory location calculate the distance of his types
    # class TypeDistanceCilNode(InstructionCilNode):
    #     def __init__(self,type1,type2,result):
    #         self.type1 = type1
    #         self.type2 = type2
    #         self.result = result 


    # class MinCilNode(InstructionCilNode):
    #     def __init__(self,num1,num2,result):
    #         self.num1 = num1
    #         self.num2 = num2
    #         self.result = result



    # class ErrorCilNode(InstructionCilNode):
    #     def __init__(self,name):
    #         self.name = name

    # class EqualsCilNode(BinaryCilNode):
    #     pass
