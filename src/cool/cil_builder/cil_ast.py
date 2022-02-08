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
 
class ConstantCilNode(InstructionCilNode):
    def __init__(self,vname,value):
        self.vname = vname
        self.value = value
        
class AssignCilNode(InstructionCilNode): # Operation "="
    def __init__(self, dest, source):
        self.dest = dest
        self.source = source

class BinaryCilNode(InstructionCilNode): #Binary Operations
    def __init__(self, dest, left, right):
        self.dest = dest
        self.left = left
        self.right = right

class UnaryCilNode(InstructionCilNode): #Unary Operations
    def __init__(self, dest, right):
        self.dest = dest
        self.right = right

class WhileCilNode(InstructionCilNode): #7.6 Loops
    pass

class BlockCilNode(InstructionCilNode): #7.7 Blocks
    pass

class LetCilNode(InstructionCilNode): #7.8 Let
    pass

class CaseCilNode(InstructionCilNode): #7.0 Case
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
class IfCilNode(InstructionCilNode):
    pass



class PlusCilNode(BinaryCilNode):
    pass

class MinusCilNode(BinaryCilNode):
    pass

class StarCilNode(BinaryCilNode):
    pass
class DivCilNode(BinaryCilNode):
    pass



class GetAttribCilNode(InstructionCilNode):
    def __init__(self,instance,stype,attribute,dest):
        self.instance = instance
        self.stype = stype
        self.attribute = attribute
        self.dest = dest

class SetAttribCilNode(InstructionCilNode):
    def __init__(self,instance,value,attribute,dest):
        self.instance = instance
        self.value = value
        self.attribute = attribute
        self.dest = dest

class GetIndexCilNode(InstructionCilNode):
    pass

class SetIndexCilNode(InstructionCilNode):
    pass

class AllocateCilNode(InstructionCilNode):
    def __init__(self, itype, dest):
        self.type = itype
        self.dest = dest

class ArrayCilNode(InstructionCilNode):
    pass

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
class StaticCallCilNode(InstructionCilNode):
    def __init__(self, function, dest):
        self.function = function
        self.dest = dest

class DynamicCallCilNode(InstructionCilNode):
    def __init__(self, xtype, method, dest):
        self.type = xtype
        self.method = method
        self.dest = dest

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
    def __init__(self, dest):
        self.dest = dest

class PrintCilNode(InstructionCilNode):
    def __init__(self, str_addr):
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
    def __init__(self, dest, msg_readed):
        self.dest = dest
        self.msg_readed = msg_readed
class ReadIntCilNode(ReadCilNode):
    def __init__(self, dest, num_readed):
        self.dest = dest
        self.num_readed = num_readed
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