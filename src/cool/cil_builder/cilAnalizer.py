from cool.cil_builder.cool_to_cil_visitor import COOLToCILVisitor
from cool.cil_builder import cil_ast as cil
def run_code_gen_pipeline(cool_ast,context,scope):
    cool_to_cilVisitor = COOLToCILVisitor(context)
    cil_ast = cool_to_cilVisitor.visit(cool_ast,scope)
    return cil_ast