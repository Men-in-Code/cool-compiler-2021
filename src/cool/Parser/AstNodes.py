class Node:
    pass

class ProgramNode(Node):
    def __init__(self, declarations):
        self.declarations = declarations
class DeclarationNode(Node):
    pass
class ExpressionNode(Node):
    pass

class ClassDeclarationNode(DeclarationNode):
    def __init__(self, idx, features, parent=None):
        self.id = idx
        self.parent = parent
        self.features = features
        self.place_holder = None

class FuncDeclarationNode(DeclarationNode):
    def __init__(self, idx, params, return_type, body):
        self.id = idx
        self.params = params
        self.type = return_type
        self.body = body
        self.place_holder = None

class IfNode(ExpressionNode):
    def __init__(self,ifexp, thenexp,elseexp):
        self.ifexp = ifexp
        self.thenexp = thenexp
        self.elseexp = elseexp
        self.place_holder = None

class WhileNode(ExpressionNode):
    def __init__(self, condition, body):
        self.condition = condition
        self.body = body
        self.place_holder = None

class CaseNode(ExpressionNode):
    def __init__(self,case,body):
        self.case = case
        self.body = body
        self.place_holder = None

class LetNode(ExpressionNode):
    def __init__(self, params, body):
        self.params = params
        self.body = body
        self.place_holder = None

class ExpressionGroupNode(ExpressionNode):
    def __init__(self, body):
        self.body = body
        self.place_holder = None

class AttrDeclarationNode(DeclarationNode):
    def __init__(self, idx, typex, expr = None):
        self.id = idx
        self.type = typex
        self.expr = expr
        self.place_holder = None

class VarDeclarationNode(ExpressionNode):
    def __init__(self, idx, typex, expr = None):
        self.id = idx
        self.type = typex
        self.expr = expr
        self.place_holder = None
        
class LetDeclarationNode(ExpressionNode):
    def __init__(self, idx, typex, expr = None):
        self.id = idx
        self.type = typex
        self.expr = expr
        self.place_holder = None

class AssignNode(ExpressionNode):
    def __init__(self, idx, expr):
        self.id = idx
        self.expr = expr
        self.place_holder = None

class CallNode(ExpressionNode):
    def __init__(self, obj, idx, args, parent = None):
        self.obj = obj
        self.id = idx
        self.args = args
        self.parent = parent
        self.place_holder = None

class ExpressionGroupNode(ExpressionNode):
    def __init__(self,body):
        self.body = body
        self.place_holder = None

class AtomicNode(ExpressionNode):
    def __init__(self, lex):
        self.lex = lex
        self.place_holder = None

class BinaryNode(ExpressionNode):
    def __init__(self, left, right):
        self.left = left
        self.right = right
        self.place_holder = None
        
class BinaryIntNode(BinaryNode):
    pass
class BinaryBoolNode(BinaryNode):
    pass

class UnaryNode(ExpressionNode):
    def __init__(self,right):
        self.right = right
        self.place_holder = None

class StringNode(AtomicNode):
    pass
class ConstantNumNode(AtomicNode):
    pass
class VariableNode(AtomicNode):
    pass
class InstantiateNode(AtomicNode):
    pass
class BooleanNode(AtomicNode):
    pass
class SelfNode(AtomicNode):
    pass
class PlusNode(BinaryIntNode):
    pass
class MinusNode(BinaryIntNode):
    pass
class StarNode(BinaryIntNode):
    pass
class DivNode(BinaryIntNode):
    pass
class EqualNode(BinaryNode):
    pass
class LessEqual(BinaryBoolNode):
    pass
class LessNode(BinaryBoolNode):
    pass
class IsVoidNode(UnaryNode):
    pass
class NotNode(UnaryNode):
    pass
class NegateNode(UnaryNode):
    pass