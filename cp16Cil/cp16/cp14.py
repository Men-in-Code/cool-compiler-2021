import cmp.nbpackage
import cmp.visitor as visitor

from cp13 import G, text
from cp13 import Node, ProgramNode, DeclarationNode, ExpressionNode
from cp13 import ClassDeclarationNode, FuncDeclarationNode, AttrDeclarationNode
from cp13 import VarDeclarationNode, AssignNode, CallNode
from cp13 import AtomicNode, BinaryNode
from cp13 import ConstantNumNode, VariableNode, InstantiateNode, PlusNode, MinusNode, StarNode, DivNode
from cp13 import FormatVisitor, tokenize_text, pprint_tokens

from cmp.tools.parsing import LR1Parser
from cmp.evaluation import evaluate_reverse_parse

def run_pipeline(G, text):
    print('=================== TEXT ======================')
    print(text)
    print('================== TOKENS =====================')
    tokens = tokenize_text(text)
    pprint_tokens(tokens)
    print('=================== PARSE =====================')
    parser = LR1Parser(G)
    parse, operations = parser([t.token_type for t in tokens], get_shift_reduce=True)
    print('\n'.join(repr(x) for x in parse))
    print('==================== AST ======================')
    ast = evaluate_reverse_parse(parse, operations, tokens)
    formatter = FormatVisitor()
    tree = formatter.visit(ast)
    print(tree)
    return ast
    
# ast = run_pipeline(G, text)

from cmp.semantic import SemanticError
from cmp.semantic import Attribute, Method, Type
from cmp.semantic import VoidType, ErrorType
from cmp.semantic import Context

class TypeCollector(object):
    def __init__(self, errors=[]):
        self.context = None
        self.errors = errors
        self.type_level = {}
    
    @visitor.on('node')
    def visit(self, node):
        pass
    
    @visitor.when(ProgramNode)
    def visit(self, node):
        self.context = Context()
        # Your code here!!!
        self.context.create_type('int') # ask for missing built-in types
        
        for def_class in node.declarations:
            self.visit(def_class)
             
        # comparison for sort node.declarations
        def get_type_level(typex):
            try:
                parent = self.type_level[typex]
            except KeyError:
                return 0
            
            if parent == 0:
                self.errors.append('Cyclic heritage.')
            elif type(parent) is not int:
                self.type_level[typex] = 0 if parent else 1
                if type(parent) is str:
                    self.type_level[typex] = get_type_level(parent) + 1
                
            return self.type_level[typex]
        
        node.declarations.sort(key = lambda node: get_type_level(node.id))
                
                
        
    # Your code here!!!
    # ????
    @visitor.when(ClassDeclarationNode)
    def visit(self, node):
        try:
            self.context.create_type(node.id)
            self.type_level[node.id] = node.parent
        except SemanticError as ex:
            self.errors.append(ex.text)

errors = []

# collector = TypeCollector(errors)
# collector.visit(ast)

# context = collector.context

# print('Errors:', errors)
# print('Context:')
# print(context)

# assert errors == []

class TypeBuilder:
    def __init__(self, context, errors=[]):
        self.context = context
        self.current_type = None
        self.errors = errors
    
    @visitor.on('node')
    def visit(self, node):
        pass
    
    # Your code here!!!
    # ????
    @visitor.when(ProgramNode)
    def visit(self, node):
        for def_class in node.declarations:
            self.visit(def_class)           
    
    @visitor.when(ClassDeclarationNode)
    def visit(self, node):
        self.current_type = self.context.get_type(node.id)
        
        if node.parent:
            try:
                parent_type = self.context.get_type(node.parent)
                self.current_type.set_parent(parent_type)
            except SemanticError as ex:
                self.errors.append(ex.text)
        
        for feature in node.features:
            self.visit(feature)
            
    @visitor.when(AttrDeclarationNode)
    def visit(self, node):
        try:
            attr_type = self.context.get_type(node.type)
        except SemanticError as ex:
            self.errors.append(ex.text)
            attr_type = ErrorType()
            
        try:
            self.current_type.define_attribute(node.id, attr_type)
        except SemanticError as ex:
            self.errors.append(ex.text)
        
    @visitor.when(FuncDeclarationNode)
    def visit(self, node):
        arg_names, arg_types = [], []
        for idx, typex in node.params:
            try:
                arg_type = self.context.get_type(typex)
            except SemanticError as ex:
                self.errors.append(ex.text)
                arg_type = ErrorType()
                
            arg_names.append(idx)
            arg_types.append(arg_type)
        
        try:
            ret_type = VoidType() if node.type == 'void' else self.context.get_type(node.type)
        except SemanticError as ex:
            self.errors.append(ex.text)
            ret_type = ErrorType()
        
        try:
            self.current_type.define_method(node.id, arg_names, arg_types, ret_type)
        except SemanticError as ex:
            self.errors.append(ex.text)

# builder = TypeBuilder(context, errors)
# builder.visit(ast)

# print('Errors:', errors)
# print('Context:')
# print(context)
        
deprecated_pipeline = run_pipeline

def run_pipeline(G, text):
    ast = deprecated_pipeline(G, text)
    print('============== COLLECTING TYPES ===============')
    errors = []
    collector = TypeCollector(errors)
    collector.visit(ast)
    context = collector.context
    print('Errors:', errors)
    print('Context:')
    print(context)
    print('=============== BUILDING TYPES ================')
    builder = TypeBuilder(context, errors)
    builder.visit(ast)
    print('Errors: [')
    for error in errors:
        print('\t', error)
    print(']')
    print('Context:')
    print(context)
    return ast, errors, context

from cp13 import text

# ast, errors, context = run_pipeline(G, text)
# assert errors == []

text = '''
class A {
    a : Z ;
    def suma ( a : int , b : B ) : int {
        a + b ;
    }
    b : int ;
    c : C ;
}

class B : A {
    c : A ;
    def f ( d : int , a : A ) : void {
        let f : int = 8 ;
        let c = new A ( ) . suma ( 5 , f ) ;
        c ;
    }
    z : int ;
    z : A ;
}

class C : Z {
}

class D : A {
    def suma ( a : int , d : B ) : int {
        d ;
    }
}

class E : A {
    def suma ( a : A , b : B ) : C {
        a ;
    }
}

class F : B {
    def f ( d : int , a : A ) : void {
        a ;
    }
}
'''

# ast, errors, context = run_pipeline(G, text)

# assert sorted(errors) == sorted([
# 	 'Type "Z" is not defined.',
# 	 'Attribute "c" is already defined in B.',
# 	 'Attribute "z" is already defined in B.',
# 	 'Type "Z" is not defined.',
# 	 'Method "suma" already defined in E with a different signature.'
# ])

text = '''
class A : B {
}
class B : A {
}
'''

# ast, errors, context = run_pipeline(G, text)
# assert len(errors) != 0