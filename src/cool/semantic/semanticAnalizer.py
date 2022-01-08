from Visitors import TypeChecker,TypeBuilder,TypeCollector,TypeInferences,FormatVisitor
from Tools import inference_cleaner,inference_solver

def run_pipeline(text,ast):
    errors = []
    inference_list = []
    parse_error = None
    formatter = FormatVisitor()
    tree = formatter.visit(ast)
    # print(tree)
    # print('============== COLLECTING TYPES ===============')
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
    actual_counter = builder.counter
    print('Errors: [')
    for error in errors:
        print('\t', error)
    print(']')
    print('Context:')
    print(context)
    print('=============== CHECKING TYPES ================')
    checker = TypeChecker(context, errors,actual_counter)
    scope = checker.visit(ast)
    inferences = checker.inference
    print('Errors: [')
    for error in errors:
        print('\t', error)
    print(']')
    print('Inference: [')
    for inf in inferences:
        print('\t', inf)
    print(']')
    fixed_inferences = inference_cleaner(inferences)
    inference_solver(fixed_inferences)
    print('Inference_solved: [')
    for inf in fixed_inferences.items() :
        print('\t', inf)
    print(']')

    print('===============SHOWING INFERENCE===============')
    context = checker.context
    inference = fixed_inferences
    inferer = TypeInferences(context, inference)
    inferer.visit(ast)
    inference_list = inferer.inference_solved
    print('Inferences: [')
    for inf in inference_list:
        print('\t', inf)
    print(']')
    print('================================================')
    return errors,inference_list,parse_error