from logging import exception
from matplotlib.pyplot import cool
from matplotlib.style import context
import cmp.nbpackage
import cmp.visitor as visitor

from cp13 import G
from cp13 import Node, ProgramNode, DeclarationNode, ExpressionNode
from cp13 import ClassDeclarationNode, FuncDeclarationNode, AttrDeclarationNode
from cp13 import VarDeclarationNode, AssignNode, CallNode
from cp13 import AtomicNode, BinaryNode
from cp13 import ConstantNumNode, VariableNode, InstantiateNode, PlusNode, MinusNode, StarNode, DivNode
from cp13 import FormatVisitor, tokenize_text

from cmp.tools.parsing import LR1Parser
from cmp.evaluation import evaluate_reverse_parse

from cmp.semantic import SemanticError
from cmp.semantic import Attribute, Method, Type
from cmp.semantic import VoidType, ErrorType, IntType
from cmp.semantic import Context

from cp14 import TypeCollector, TypeBuilder

from cmp.semantic import Scope, VariableInfo
from cp15 import TypeChecker

import cmp.cil as cil

class BaseCOOLToCILVisitor:
    def __init__(self, context):
        self.dottypes = []
        self.dotdata = []
        self.dotcode = []
        self.current_type = None
        self.current_method = None
        self.current_function = None
        self.context = context
    
    @property
    def params(self):
        return self.current_function.params
    
    @property
    def localvars(self):
        return self.current_function.localvars
    
    @property
    def instructions(self):
        return self.current_function.instructions
    
    def register_local(self, vinfo):
        vinfo.name = f'local_{self.current_function.name[9:]}_{vinfo.name}_{len(self.localvars)}'
        local_node = cil.LocalNode(vinfo.name)
        self.localvars.append(local_node)
        return vinfo.name

    def define_internal_local(self):
        vinfo = VariableInfo('internal', None)
        return self.register_local(vinfo)

    def register_instruction(self, instruction):
        self.instructions.append(instruction)
        return instruction
    
    def to_function_name(self, method_name, type_name):
        return f'function_{method_name}_at_{type_name}'
    
    def register_function(self, function_name):
        function_node = cil.FunctionNode(function_name, [], [], [])
        self.dotcode.append(function_node)
        return function_node
    
    def register_type(self, name):
        type_node = cil.TypeNode(name)
        self.dottypes.append(type_node)
        return type_node

    def register_data(self, value):
        vname = f'data_{len(self.dotdata)}'
        data_node = cil.DataNode(vname, value)
        self.dotdata.append(data_node)
        return data_node

    def fill_cil_types(self,context):
        for p in [t for t in self.dottypes]:
            p_type = context.get_type(p.name)
            parents = p_type.get_all_parents()
            for p_type in parents:
                for method in p_type.methods:
                    p.methods.append((method.name,self.to_function_name(method.name,p_type.name)))

            # p.methods += [self.to_function_name(method,type) for method in p_type.methods 
            #     for p_type in parents]

class MiniCOOLToCILVisitor(BaseCOOLToCILVisitor):
    @visitor.on('node')
    def visit(self, node):
        pass
    
    @visitor.when(ProgramNode)
    def visit(self, node, scope,context):
        ######################################################
        # node.declarations -> [ ClassDeclarationNode ... ]
        ######################################################
        cil_scope = Scope()
        self.current_function = self.register_function('entry')
        instance = self.define_internal_local()
        result = self.define_internal_local()
        main_method_name = self.to_function_name('main', 'Main')
        self.register_instruction(cil.AllocateNode('Main', instance))
        self.register_instruction(cil.ArgNode(instance))
        self.register_instruction(cil.StaticCallNode(main_method_name, result))
        self.register_instruction(cil.ReturnNode(0))
        self.current_function = None

        
        for declaration, child_scope in zip(node.declarations, scope.children):
            self.visit(declaration, child_scope,cil_scope.create_child())

        self.fill_cil_types(context)

        return cil.ProgramNode(self.dottypes, self.dotdata, self.dotcode)
    
    @visitor.when(ClassDeclarationNode)
    def visit(self, node, scope,cil_scope):
        ####################################################################
        # node.id -> str
        # node.parent -> str
        # node.features -> [ FuncDeclarationNode/AttrDeclarationNode ... ]
        ####################################################################
        
        self.current_type = self.context.get_type(node.id)

        # Your code here!!! (Handle all the .TYPE section)
        cil_type = self.register_type(node.id)
        cil_type.attributes = [v.name for (v,_) in self.current_type.all_attributes()]

        

        func_declarations = (f for f in node.features if isinstance(f, FuncDeclarationNode))
        for feature, child_scope in zip(func_declarations, scope.children):
            value = self.visit(feature, child_scope,cil_scope.create_child())
        

        self.current_type = None

                
    @visitor.when(FuncDeclarationNode)
    def visit(self, node, scope,cil_scope):
        ###############################
        # node.id -> str
        # node.params -> [ (str, str) ... ]
        # node.type -> str
        # node.body -> [ ExpressionNode ... ]
        ###############################
        self.current_method = self.current_type.get_method(node.id)

        # Your code here!!! (Handle PARAMS)
        function_name = self.to_function_name(node.id,self.current_type.name)
        self.dottypes[-1].methods.append((node.id,function_name))
        self.current_function = self.register_function(function_name)
        self_param = [cil.ParamNode('self')]
        self.current_function.params = self_param+[cil.ParamNode(param_name) for (param_name,_) in node.params] 

        value = 0
        for instruction, child_scope in zip(node.body, scope.children):
            value = self.visit(instruction, child_scope,cil_scope)

        # Your code here!!! (Handle RETURN)
        self.register_instruction(cil.ReturnNode(value))
        self.current_method = None
        return self.current_function

    @visitor.when(VarDeclarationNode)
    def visit(self, node, scope,cil_scope):
        ###############################
        # node.id -> str
        # node.type -> str
        # node.expr -> ExpressionNode
        ###############################
        # Your code here!!!
        pass

    @visitor.when(AssignNode)
    def visit(self, node, scope,cil_scope):
        ###############################
        # node.id -> str
        # node.expr -> ExpressionNode
        ###############################
        
        # Your code here!!!
        # dest = self.register_local(node.id)
        # source = self.visit(node.expr)
        # return cil.AssignNode(dest,source)
        pass

    @visitor.when(CallNode)
    def visit(self, node, scope,cil_scope):
        ###############################
        # node.obj -> AtomicNode
        # node.id -> str
        # node.args -> [ ExpressionNode ... ]
        ###############################
        
        # Your code here!!!
        pass

    @visitor.when(ConstantNumNode)
    def visit(self, node, scope,cil_scope):
        ###############################
        # node.lex -> str
        ###############################
        
        # Your code here!!! (Pretty easy ;-))
        return node.lex
        pass

    @visitor.when(VariableNode)
    def visit(self, node, scope,cil_scope):
        ###############################
        # node.lex -> str
        ###############################
        
        # Your code here!!!

        if cil_scope.find_variable(node.lex):
            self.register_local(node.lex)
            return node.lex
        elif node.lex in [param_nodes.name[0] for param_nodes in self.current_function.params]:
            return node.lex
        elif node.lex in self.current_type.all_attributes():
            new_local = self.define_internal_local()
        else:
            pass

    @visitor.when(InstantiateNode)
    def visit(self, node, scope,cil_scope):
        ###############################
        # node.lex -> str
        ###############################
        
        # Your code here!!!
        pass

    @visitor.when(PlusNode)
    def visit(self, node, scope,cil_scope):
        ###############################
        # node.left -> ExpressionNode
        # node.right -> ExpressionNode
        ###############################
        
        # Your code here!!!
        dest = self.define_internal_local()
        left = self.visit(node.left,scope,cil_scope)
        right = self.visit(node.right,scope,cil_scope)
        self.register_instruction(cil.PlusNode(dest,left,right))
        return dest
        pass

    @visitor.when(MinusNode)
    def visit(self, node, scope):
        ###############################
        # node.left -> ExpressionNode
        # node.right -> ExpressionNode
        ###############################
        
        # Your code here!!!
        pass

    @visitor.when(StarNode)
    def visit(self, node, scope):
        ###############################
        # node.left -> ExpressionNode
        # node.right -> ExpressionNode
        ###############################
        
        # Your code here!!!
        pass

    @visitor.when(DivNode)
    def visit(self, node, scope):
        ###############################
        # node.left -> ExpressionNode
        # node.right -> ExpressionNode
        ###############################
        
        # Your code here!!!
        cil.DivNode
        pass
        
    # ======================================================================

from cp15 import run_pipeline as deprecated_pipeline
from cmp.cil import get_formatter

formatter = get_formatter()

def run_pipeline(G, text):
    ast, errors, context, scope = deprecated_pipeline(G, text)
    print('============= TRANSFORMING TO CIL =============')
    cool_to_cil = MiniCOOLToCILVisitor(context)
    cil_ast = cool_to_cil.visit(ast, scope,context)
    formatter = get_formatter()
    print(formatter(cil_ast))
    return ast, errors, context, scope, cil_ast



text = '''
class A {
    a : int ;
    def suma ( a : int , b : int ) : int {
        a + b ;
    }
    b : int ;
}

class B : A {
    c : int ;
    def f ( d : int , a : A ) : void {
        let f : int = 8 ;
        let c = new A ( ) . suma ( 5 , f ) ;
        c ;
    }
}
'''

run_pipeline(G,text)