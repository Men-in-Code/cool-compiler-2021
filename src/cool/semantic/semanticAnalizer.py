from cool.semantic.type_builder import TypeBuilder
from cool.semantic.type_checker import TypeChecker
from cool.semantic.type_collector import TypeCollector



def run_semantic_pipeline(ast):
    errors = []
    # inference_list = []
    # parse_error = None
    # formatter = FormatVisitor()
    # tree = formatter.visit(ast)
    # print(tree)
    # print('============== COLLECTING TYPES ===============')
    errors = []
    collector = TypeCollector(errors)
    collector.visit(ast)
    context = collector.context
    print_error(errors)
    # print('Errors:', errors)
    # print('Context:')
    # print(context)
    # print('=============== BUILDING TYPES ================')
    builder = TypeBuilder(context, errors)
    builder.visit(ast)
    actual_counter = builder.counter
    print_error(errors)
    # print('Errors: [')
    # for error in errors:
    #     print('\t', error)
    # print(']')
    # print('Context:')
    # print(context)
    # print('=============== CHECKING TYPES ================')
    checker = TypeChecker(context, errors,actual_counter)
    scope = checker.visit(ast) # scope = checker.visit(ast)
    print_error(errors)
    # inferences = checker.inference
    # print('Errors: [')
    # for error in errors:
    #     print('\t', error)
    # print(']')
    # print('Inference: [')
    # for inf in inferences:
    #     print('\t', inf)
    # print(']')
    # fixed_inferences = inference_cleaner(inferences)
    # inference_solver(fixed_inferences)
    # print('Inference_solved: [')
    # for inf in fixed_inferences.items() :
    #     print('\t', inf)
    # print(']')
    return context,scope

def print_error(errors):
    if errors:
        print(errors[0])
        raise Exception()