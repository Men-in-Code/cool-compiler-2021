import cool.cmp.visitor as visitor


class CilNode:
    pass

class ProgramCilNode(CilNode):
    def __init__(self, dottypes, dotdata, dotcode):
        self.dottypes = dottypes
        self.dotdata = dotdata
        self.dotcode = dotcode

class TypeCilNode(CilNode):
    def __init__(self, name):
        self.name = name
        self.attributes = []
        self.methods = []

class DataCilNode(CilNode):
    def __init__(self, vname, value):
        self.name = vname
        self.value = value

class FunctionCilNode(CilNode):
    def __init__(self, fname, params, localvars, instructions):
        self.name = fname
        self.params = params
        self.localvars = localvars
        self.instructions = instructions

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


# class IfCilNode(InstructionCilNode): #7.5 If Conditional
#     def __init__(self,if_expr,then_label,else_label):
#         self.if_expr = if_expr
#         self.then_label = then_label
#         self.else_label = else_label

# class WhileCilNode(InstructionCilNode): #7.6 Loops
#     def __init__(self,condition,body):
#         self.condition = condition
#         self.body = body

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
class PlusCilNode(BinaryCilNode): 
    pass

class MinusCilNode(BinaryCilNode):
    pass

class StarCilNode(BinaryCilNode):
    pass
class DivCilNode(BinaryCilNode):
    pass


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



#TypesCilNodes
class IntCilNode(InstructionCilNode):
    def __init__(self,value):
        self.value = value

class StringCilNode(InstructionCilNode):
    def __init__(self,value):
        self.value = value

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


def get_formatter():

    class PrintVisitor(object):
        @visitor.on('CilNode')
        def visit(self, CilNode):
            pass

        @visitor.when(ProgramCilNode)
        def visit(self, CilNode):
            dottypes = '\n'.join(self.visit(t) for t in CilNode.dottypes)
            dotdata = '\n'.join(self.visit(t) for t in CilNode.dotdata)
            dotcode = '\n'.join(self.visit(t) for t in CilNode.dotcode)

            return f'.TYPES\n{dottypes}\n\n.DATA\n{dotdata}\n\n.CODE\n{dotcode}'

        @visitor.when(TypeCilNode)
        def visit(self, CilNode):
            attributes = '\n\t'.join(f'attribute {x}' for x in CilNode.attributes)
            methods = '\n\t'.join(f'method {x}: {y}' for x,y in CilNode.methods)

            return f'type {CilNode.name} {{\n\t{attributes}\n\n\t{methods}\n}}'

        @visitor.when(FunctionCilNode)
        def visit(self, CilNode):
            params = '\n\t'.join(self.visit(x) for x in CilNode.params)
            localvars = '\n\t'.join(self.visit(x) for x in CilNode.localvars)
            instructions = '\n\t'.join(self.visit(x) for x in CilNode.instructions)

            return f'function {CilNode.name} {{\n\t{params}\n\n\t{localvars}\n\n\t{instructions}\n}}'

        @visitor.when(ParamCilNode)
        def visit(self, CilNode):
            return f'PARAM {CilNode.name}'

        @visitor.when(LocalCilNode)
        def visit(self, CilNode):
            return f'LOCAL {CilNode.name}'

        @visitor.when(AssignCilNode)
        def visit(self, CilNode):
            return f'{CilNode.dest} = {CilNode.source}'

        @visitor.when(PlusCilNode)
        def visit(self, CilNode):
            return f'{CilNode.dest} = {CilNode.left} + {CilNode.right}'

        @visitor.when(MinusCilNode)
        def visit(self, CilNode):
            return f'{CilNode.dest} = {CilNode.left} - {CilNode.right}'

        @visitor.when(StarCilNode)
        def visit(self, CilNode):
            return f'{CilNode.dest} = {CilNode.left} * {CilNode.right}'

        @visitor.when(DivCilNode)
        def visit(self, CilNode):
            return f'{CilNode.dest} = {CilNode.left} / {CilNode.right}'

        @visitor.when(AllocateCilNode)
        def visit(self, CilNode):
            return f'{CilNode.dest} = ALLOCATE {CilNode.type}'

        @visitor.when(TypeOfCilNode)
        def visit(self, CilNode):
            return f'{CilNode.dest} = TYPEOF {CilNode.type}'

        @visitor.when(StaticCallCilNode)
        def visit(self, CilNode):
            return f'{CilNode.dest} = CALL {CilNode.function}'

        @visitor.when(DynamicCallCilNode)
        def visit(self, CilNode):
            return f'{CilNode.dest} = VCALL {CilNode.type} {CilNode.method}'

        @visitor.when(ArgCilNode)
        def visit(self, CilNode):
            return f'ARG {CilNode.name}'

        @visitor.when(ReturnCilNode)
        def visit(self, CilNode):
            return f'RETURN {CilNode.value if CilNode.value is not None else ""}'

    printer = PrintVisitor()
    return (lambda ast: printer.visit(ast))