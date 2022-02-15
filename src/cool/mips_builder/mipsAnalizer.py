from cool.mips_builder.cil_to_mips_visitor import CILtoMIPSVisitor
def run_mips_gen_pipeline(cil_ast,context,scope):
    cool_to_cilVisitor = CILtoMIPSVisitor(context)
    
    return mips_text