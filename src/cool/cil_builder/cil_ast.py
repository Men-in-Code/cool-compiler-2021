import cool.cmp.visitor as visitor


class Node:
    pass

class ProgramNode(Node):
    def __init__(self, dottypes, dotdata, dotcode):
        self.dottypes = dottypes
        self.dotdata = dotdata
        self.dotcode = dotcode

class TypeNode(Node):
    def __init__(self, name):
        self.name = name
        self.attributes = []
        self.methods = []

class DataNode(Node):
    def __init__(self, vname, value):
        self.name = vname
        self.value = value

class FunctionNode(Node):
    def __init__(self, fname, params, localvars, instructions):
        self.name = fname
        self.params = params
        self.localvars = localvars
        self.instructions = instructions

class ParamNode(Node):
    def __init__(self, name):
        self.name = name

class LocalNode(Node):
    def __init__(self, name):
        self.name = name

class InstructionNode(Node):
    pass
 
class AssignNode(InstructionNode): # Operation "="
    def __init__(self, dest, source):
        self.dest = dest
        self.source = source

class BinaryNode(InstructionNode): #Binary Operations
    def __init__(self, dest, left, right):
        self.dest = dest
        self.left = left
        self.right = right

class UnaryNode(InstructionNode): #Unary Operations
    def __init__(self, dest, right):
        self.dest = dest
        self.right = right

class WhileNode(InstructionNode): #7.6 Loops
    pass

class BlockNode(InstructionNode): #7.7 Blocks
    pass

class LetNode(InstructionNode): #7.8 Let
    pass

class CaseNode(InstructionNode): #7.0 Case
    def __init__(self,expr,expr_list,label_list):
        self.main_expr = expr
        self.expr_list = expr_list
        self.label = label_list

class InstantiateNode(InstructionNode): #7.10 New
    pass

class IsVoidNode(InstructionNode): #7.11 IsVoid
    def __init__(self, expresion, result):
        self.expresion = expresion
        self.result = result
    pass
class IfNode(InstructionNode):
    pass



class PlusNode(BinaryNode):
    pass

class MinusNode(BinaryNode):
    pass

class StarNode(BinaryNode):
    pass
class DivNode(BinaryNode):
    pass



class GetAttribNode(InstructionNode):
    def __init__(self,instance,stype,attribute,dest):
        self.instance = instance
        self.stype = stype
        self.attribute = attribute
        self.dest = dest

class SetAttribNode(InstructionNode):
    def __init__(self,instance,value,attribute,dest):
        self.instance = instance
        self.value = value
        self.attribute = attribute
        self.dest = dest

class GetIndexNode(InstructionNode):
    pass

class SetIndexNode(InstructionNode):
    pass

class AllocateNode(InstructionNode):
    def __init__(self, itype, dest):
        self.type = itype
        self.dest = dest

class ArrayNode(InstructionNode):
    pass

class TypeOfNode(InstructionNode):
    def __init__(self, obj, dest):
        self.obj = obj
        self.dest = dest

class LabelNode(InstructionNode):
    def __init__(self,label):
        self.label = label

class GotoNode(InstructionNode):
    def __init__(self,label):
        self.label = label

class GotoIfNode(InstructionNode):
    def __init__(self,val,label):
        self.val = val
        self.label = label
class StaticCallNode(InstructionNode):
    def __init__(self, function, dest):
        self.function = function
        self.dest = dest

class DynamicCallNode(InstructionNode):
    def __init__(self, xtype, method, dest):
        self.type = xtype
        self.method = method
        self.dest = dest

class ArgNode(InstructionNode):
    def __init__(self, name):
        self.name = name

class ReturnNode(InstructionNode):
    def __init__(self, value=None):
        self.value = value

class LoadNode(InstructionNode):
    def __init__(self, dest, msg):
        self.dest = dest
        self.msg = msg



#TypesNodes
class IntNode(InstructionNode):
    def __init__(self,value):
        self.value = value

class StringNode(InstructionNode):
    def __init__(self,value):
        self.value = value

#Function Nodes
class ToStrNode(InstructionNode):
    def __init__(self, dest, ivalue):
        self.dest = dest
        self.ivalue = ivalue

class ReadNode(InstructionNode):
    def __init__(self, dest):
        self.dest = dest

class PrintNode(InstructionNode):
    def __init__(self, str_addr):
        self.str_addr = str_addr
class AbortNode(InstructionNode):
    pass
class TypeNameNode(InstructionNode):
    def __init__(self, type, result):
        self.type = type
        self.result = result
class CopyNode(InstructionNode):
    def __init__(self, type, result):
        self.type = type
        self.result = result
class PrintStringNode(PrintNode):
    pass
class PrintIntNode(PrintNode):
    pass
class ReadStringNode(ReadNode):
    def __init__(self, dest, msg_readed):
        self.dest = dest
        self.msg_readed = msg_readed
class ReadIntNode(ReadNode):
    def __init__(self, dest, num_readed):
        self.dest = dest
        self.num_readed = num_readed
class LengthNode(InstructionNode):
    def __init__(self, strVar, result):
        self.str = strVar
        self.length = result
class ConcatNode(InstructionNode):
    def __init__(self, strVal, var2,result):
        self.strVal = strVal
        self.var2 = var2
        self.length = result

class SubstringNode(InstructionNode):
    def __init__(self, strVal,value1, value2,result):
        self.strVal = strVal
        self.value1 = value1
        self.value2 = value2
        self.length = result


def get_formatter():

    class PrintVisitor(object):
        @visitor.on('node')
        def visit(self, node):
            pass

        @visitor.when(ProgramNode)
        def visit(self, node):
            dottypes = '\n'.join(self.visit(t) for t in node.dottypes)
            dotdata = '\n'.join(self.visit(t) for t in node.dotdata)
            dotcode = '\n'.join(self.visit(t) for t in node.dotcode)

            return f'.TYPES\n{dottypes}\n\n.DATA\n{dotdata}\n\n.CODE\n{dotcode}'

        @visitor.when(TypeNode)
        def visit(self, node):
            attributes = '\n\t'.join(f'attribute {x}' for x in node.attributes)
            methods = '\n\t'.join(f'method {x}: {y}' for x,y in node.methods)

            return f'type {node.name} {{\n\t{attributes}\n\n\t{methods}\n}}'

        @visitor.when(FunctionNode)
        def visit(self, node):
            params = '\n\t'.join(self.visit(x) for x in node.params)
            localvars = '\n\t'.join(self.visit(x) for x in node.localvars)
            instructions = '\n\t'.join(self.visit(x) for x in node.instructions)

            return f'function {node.name} {{\n\t{params}\n\n\t{localvars}\n\n\t{instructions}\n}}'

        @visitor.when(ParamNode)
        def visit(self, node):
            return f'PARAM {node.name}'

        @visitor.when(LocalNode)
        def visit(self, node):
            return f'LOCAL {node.name}'

        @visitor.when(AssignNode)
        def visit(self, node):
            return f'{node.dest} = {node.source}'

        @visitor.when(PlusNode)
        def visit(self, node):
            return f'{node.dest} = {node.left} + {node.right}'

        @visitor.when(MinusNode)
        def visit(self, node):
            return f'{node.dest} = {node.left} - {node.right}'

        @visitor.when(StarNode)
        def visit(self, node):
            return f'{node.dest} = {node.left} * {node.right}'

        @visitor.when(DivNode)
        def visit(self, node):
            return f'{node.dest} = {node.left} / {node.right}'

        @visitor.when(AllocateNode)
        def visit(self, node):
            return f'{node.dest} = ALLOCATE {node.type}'

        @visitor.when(TypeOfNode)
        def visit(self, node):
            return f'{node.dest} = TYPEOF {node.type}'

        @visitor.when(StaticCallNode)
        def visit(self, node):
            return f'{node.dest} = CALL {node.function}'

        @visitor.when(DynamicCallNode)
        def visit(self, node):
            return f'{node.dest} = VCALL {node.type} {node.method}'

        @visitor.when(ArgNode)
        def visit(self, node):
            return f'ARG {node.name}'

        @visitor.when(ReturnNode)
        def visit(self, node):
            return f'RETURN {node.value if node.value is not None else ""}'

    printer = PrintVisitor()
    return (lambda ast: printer.visit(ast))