from cool.mips_builder.cil_to_mips_visitor import CILtoMIPSVisitor
def run_code_gen_pipeline(cil_ast,context,scope):
    cool_to_cilVisitor = CILtoMIPSVisitor(context)
    mips_text = cool_to_cilVisitor.visit(cil_ast,scope)
    return mips_text