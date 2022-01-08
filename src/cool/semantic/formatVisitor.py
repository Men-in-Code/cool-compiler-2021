import visitor as visitor
from cool.Parser.AstNodes import *

class FormatVisitor(object):
    @visitor.on('node')
    def visit(self, node, tabs):
        pass
    
    @visitor.when(ProgramNode)
    def visit(self, node, tabs=0):
        ans = '\t' * tabs + f'\\__ProgramNode [<class> ... <class>]'
        statements = '\n'.join(self.visit(child, tabs + 1) for child in node.declarations)
        return f'{ans}\n{statements}'
    
    @visitor.when(ClassDeclarationNode)
    def visit(self, node, tabs=0):
        parent = '' if node.parent is None else f": {node.parent}"
        ans = '\t' * tabs + f'\\__ClassDeclarationNode: class {node.id} {parent} {{ <feature> ... <feature> }}'
        features = '\n'.join(self.visit(child, tabs + 1) for child in node.features)
        return f'{ans}\n{features}'
    
    @visitor.when(AttrDeclarationNode)
    def visit(self, node, tabs=0):
        if node.expr:
            ans = '\t' * tabs + f'\\__AttrDeclarationNode: {node.id}: {node.type} <- <expr>'
            expr = self.visit(node.expr, tabs + 1)
            return f'{ans}\n{expr}'
        else:
            ans = '\t' * tabs + f'\\__AttrDeclarationNode: {node.id} : {node.type}'
            return f'{ans}'

    @visitor.when(VarDeclarationNode)
    def visit(self, node, tabs=0):
        ans = '\t' * tabs + f'\\__VarDeclarationNode: let {node.id} : {node.type} = <expr>'
        expr = self.visit(node.expr, tabs + 1)
        return f'{ans}\n{expr}'
    
    @visitor.when(LetDeclarationNode)
    def visit(self, node, tabs=0):
        ans = '\t' * tabs + f'\\__LetDeclarationNode: let {node.id} : {node.type} = <expr>'
        if node.expr:
            expr = self.visit(node.expr, tabs + 1)
            return f'{ans}\n{expr}'
        else:
            return f'{ans}'
    
    @visitor.when(AssignNode)
    def visit(self, node, tabs=0):
        ans = '\t' * tabs + f'\\__AssignNode: {node.id} <- <expr>'
        expr = self.visit(node.expr, tabs + 1)
        return f'{ans}\n{expr}'
    
    @visitor.when(FuncDeclarationNode)
    def visit(self, node, tabs=0):
        params = ', '.join(':'.join(param) for param in node.params)
        ans = '\t' * tabs + f'\\__FuncDeclarationNode: def {node.id}({params}) : {node.type} -> <body>'
        body = self.visit(node.body, tabs + 1)
        return f'{ans}\n{body}'
    
    @visitor.when(ExpressionGroupNode)
    def visit(self, node, tabs=0):
        ans = '\t' * tabs + f'\\__ExpressionGroupNode: <expr_list> '
        body = '\n'.join(self.visit(child, tabs + 1) for child in node.body)
        return f'{ans}\n{body}'  
    
    @visitor.when(IfNode)
    def visit(self, node, tabs=0):
        ans = '\t' * tabs + f'\\__IfNode: if <expr> then <expr> else <expr> fi'
        ifx = self.visit(node.ifexp, tabs + 1)
        thenx = self.visit(node.thenexp, tabs + 1)
        elsex = self.visit(node.elseexp, tabs + 1)
        return f'{ans}\n{ifx}\n{thenx}\n{elsex}'
    
    @visitor.when(WhileNode)
    def visit(self, node, tabs=0):
        ans = '\t' * tabs + f'\\__WhileNode: while <expr> loop <expr> pool'
        condition = self.visit(node.condition, tabs + 1)
        loopexp = self.visit(node.body, tabs + 1)
        return f'{ans}\n{condition}\n{loopexp}'
    
    @visitor.when(LetNode)
    def visit(self, node, tabs=0):
        ans = '\t' * tabs + f'\\__LetNode: let <dec_list> in <expr>'
        args = '\n'.join(self.visit(arg, tabs + 1) for arg in node.params)
        body = self.visit(node.body, tabs + 1)
        return f'{ans}\n{args}\n{body}'
    
    @visitor.when(CaseNode)
    def visit(self, node, tabs=0): 
        ans = '\t' * tabs + f'\\__CaseNode: case <expr> of <declar_list> esac'
        case = self.visit(node.case, tabs + 1)
        body = '\n'.join(self.visit(arg, tabs + 1) for arg in node.body)
        return f'{ans}\n{case}\n{body}'
    
    @visitor.when(BinaryNode)
    def visit(self, node, tabs=0):
        ans = '\t' * tabs + f'\\__<expr> {node.__class__.__name__} <expr>'
        left = self.visit(node.left, tabs + 1)
        right = self.visit(node.right, tabs + 1)
        return f'{ans}\n{left}\n{right}'
    
    @visitor.when(UnaryNode)
    def visit(self,node,tabs = 0):
        ans = '\t' * tabs + f'\\__<expr> {node.__class__.__name__} <expr>'
        right = self.visit(node.right, tabs + 1)
        return f'{ans}\n{right}'

    @visitor.when(AtomicNode)
    def visit(self, node, tabs=0):
        return '\t' * tabs + f'\\__ {node.__class__.__name__}: {node.lex}'
    
    @visitor.when(CallNode)
    def visit(self, node, tabs=0):
        obj = self.visit(node.obj, tabs + 1)
        if (not node.parent):
            ans = '\t' * tabs + f'\\__CallNode: <obj>.{node.id}(<expr>, ..., <expr>)'
        else:
            ans = '\t' * tabs + f'\\__CallNode: <obj>@{node.parent}.{node.id}(<expr>, ..., <expr>)'
            
        args = '\n'.join(self.visit(arg, tabs + 1) for arg in node.args)
        parent = self.visit(node.parent, tabs + 1)
        if not obj:
            obj = 'self.'
            
        return f'{ans}\n{obj}\n{args}'
    
    @visitor.when(InstantiateNode)
    def visit(self, node, tabs=0):
        return '\t' * tabs + f'\\__ InstantiateNode: new {node.lex}()'
