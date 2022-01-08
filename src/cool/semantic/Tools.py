from backend.Utils import ContainerSet
from itertools import islice
#from pandas import DataFrame

#Fase1
# Computes First(alpha), given First(Vt) and First(Vn) 
# alpha in (Vt U Vn)*
def compute_local_first(firsts, alpha):
    first_alpha = ContainerSet()
    
    try:
        alpha_is_epsilon = alpha.IsEpsilon
    except:
        alpha_is_epsilon = False
    
    # alpha == epsilon ? First(alpha) = { epsilon }
    if alpha_is_epsilon:
        first_alpha.set_epsilon()

    # alpha = X1 ... XN
    else:
        for item in alpha:
            first_symbol = firsts[item]
    # First(Xi) subconjunto First(alpha)
            first_alpha.update(first_symbol)
    # epsilon pertenece a First(X1)...First(Xi) ? First(Xi+1) subconjunto de First(X) y First(alpha)
            if not first_symbol.contains_epsilon:
                break
    # epsilon pertenece a First(X1)...First(XN) ? epsilon pertence a First(X) y al First(alpha)
        else:
            first_alpha.set_epsilon()

    # First(alpha)
    return first_alpha

#Fase2
# Computes First(Vt) U First(Vn) U First(alpha)
# P: X -> alpha
def compute_firsts(G):
    firsts = {}
    change = True
    
    # init First(Vt)
    for terminal in G.terminals:
        firsts[terminal] = ContainerSet(terminal)
        
    # init First(Vn)
    for nonterminal in G.nonTerminals:
        firsts[nonterminal] = ContainerSet()
    
    while change:
        change = False
        
        # P: X -> alpha
        for production in G.Productions:
            X = production.Left
            alpha = production.Right
            
            # get current First(X)
            first_X = firsts[X]
                
            # init First(alpha)
            try:
                first_alpha = firsts[alpha]
            except:
                first_alpha = firsts[alpha] = ContainerSet()
            
            # CurrentFirst(alpha)???
            local_first = compute_local_first(firsts, alpha)
            
            # update First(X) and First(alpha) from CurrentFirst(alpha)
            change |= first_alpha.hard_update(local_first)
            change |= first_X.hard_update(local_first)
                    
    # First(Vt) + First(Vt) + First(RightSides)
    return firsts

def compute_follows(G, firsts):
    follows = { }
    change = True
    
    local_firsts = {}
    
    # init Follow(Vn)
    for nonterminal in G.nonTerminals:
        follows[nonterminal] = ContainerSet()
    follows[G.startSymbol] = ContainerSet(G.EOF)
    
    while change:
        change = False
        
        # P: X -> alpha
        for production in G.Productions:
            X = production.Left
            alpha = production.Right
            
            follow_X = follows[X]
            
            # # X -> zeta Y beta
            for i,symbol in enumerate(alpha):
                    if symbol.IsNonTerminal:
                        follow_Y = follows[symbol]
                        try:
                            first_beta = local_firsts[alpha,i]
                        except KeyError:
                            first_beta = local_firsts[alpha,i] = compute_local_first(firsts,islice(alpha,i+1,None))
                # First(beta) - { epsilon } subset of Follow(Y)
                        change |= follow_Y.update(first_beta)

                # beta ->* epsilon or X -> zeta Y ? Follow(X) subset of Follow(Y)
                        if first_beta.contains_epsilon:
                            change |= follow_Y.update(follow_X)

    # Follow(Vn)
    return follows

class ShiftReduceParser:
    SHIFT = 'SHIFT'
    REDUCE = 'REDUCE'
    OK = 'OK'
    
    def __init__(self, G, verbose=False):
        self.G = G
        self.verbose = verbose
        self.action = {}
        self.goto = {}
        self._build_parsing_table()
    
    def _build_parsing_table(self):
        raise NotImplementedError()

    def __call__(self, w):
        stack = [ 0 ]
        cursor = 0
        output = []
        operations = []
        
        while True:
            state = stack[-1]
            lookahead = w[cursor]
            if self.verbose: print(stack, '<---||--->', w[cursor:])
                
            # Your code here!!! (Detect error)
            
            try:
                action, tag = self.action[state, lookahead]
                # Your code here!!! (Shift case)
                if action == self.SHIFT:
                    operations.append(self.SHIFT)
                    stack.append(tag)
                    cursor += 1

                # Your code here!!! (Reduce case)
                elif action == self.REDUCE:
                    operations.append(self.REDUCE)
                    output.append(tag)
                    for _ in tag.Right: stack.pop()
                    a = self.goto[stack[-1],tag.Left]
                    stack.append(a)


                # Your code here!!! (OK case)
                elif action == self.OK:
                    return output,operations
                # Your code here!!! (Invalid case)
                else:
                    raise NameError
            except Exception as ex:
                raise Exception(ex.args[0])
            
    def GetConflict(self):
        
        dic = { }

        for (state, symb), value in self.action.items():
            for i in range(len(value)):
                for j in range(i + 1, len(value)):
                    action1 = value[i]
                    action2 = value[j]

                    if ((action1 == self.SHIFT and action2 == self.REDUCE) or
                        (action2 == self.REDUCE and action1 == self.SHIFT)):
                        try:
                            if 'SHIFT-REDUCE' not in dic[state, symb]: 
                                dic[state, symb].append('SHIFT-REDUCE')
                        except:
                            dic[state, symb] = ['SHIFT-REDUCE']

                    if action1 == self.REDUCE and action2 == self.REDUCE:
                        try:
                            if 'REDUCE-REDUCE' not in dic[state, symb]: 
                                dic[state, symb].append('REDUCE-REDUCE')
                        except:
                            dic[state, symb] = ['REDUCE-REDUCE']
        
        return dic

class SLR1Parser(ShiftReduceParser):

    def _build_parsing_table(self):
        G = self.G.AugmentedGrammar(True)
        firsts = compute_firsts(G)
        follows = compute_follows(G, firsts)
        
        automaton = build_LR0_automaton(G).to_deterministic()
        for i, node in enumerate(automaton):
            if self.verbose: print(i, '\t', '\n\t '.join(str(x) for x in node.state), '\n')
            node.idx = i

        for node in automaton:
            idx = node.idx
            for state in node.state:
                item = state.state
                # Your code here!!!         

                if item.IsReduceItem :
                    if item.production.Left == G.startSymbol:
                        self._register(self.action,(idx,G.EOF),ShiftReduceParser.OK)
                    else:
                        for c in follows[item.production.Left]:
                            self._register(self.action,(idx,c),(ShiftReduceParser.REDUCE,item.production))
                else:
                    symbol = item.NextSymbol
                    next_node = node.transitions[symbol.Name]
                    if symbol.IsTerminal:
                        self._register(self.action,(idx,symbol),(ShiftReduceParser.SHIFT,next_node[0].idx))
                    else:
                        self._register(self.goto,(idx,symbol),next_node[0].idx)
                
                # - Fill `self.Action` and `self.Goto` according to `item`)
                # - Feel free to use `self._register(...)`)
    
    @staticmethod
    def _register(table, key, value):
        assert key not in table or table[key] == value, 'Shift-Reduce or Reduce-Reduce conflict!!!'
        table[key] = value

def encode_value(value):
    try:
        action, tag = value
        if action == ShiftReduceParser.SHIFT:
            return 'S' + str(tag)
        elif action == ShiftReduceParser.REDUCE:
            return repr(tag)
        elif action ==  ShiftReduceParser.OK:
            return action
        else:
            return value
    except TypeError:
        return value


class ShiftReduceParser2:
    SHIFT = 'SHIFT'
    REDUCE = 'REDUCE'
    OK = 'OK'
    
    def __init__(self, G, verbose=False):
        self.G = G
        self.verbose = verbose
        self.action = {}
        self.goto = {}
        self._build_parsing_table()
    
    def _build_parsing_table(self):
        raise NotImplementedError()

    def __call__(self, w):
        stack = [ 0 ]
        cursor = 0
        output = []
        
        while True:
            state = stack[-1]
            lookahead = w[cursor]
            if self.verbose: print(stack, '<---||--->', w[cursor:])
                
            #(Detect error)
            try:
                action, tag = self.action[state, lookahead]
            #(Shift case)
                if action == ShiftReduceParser.SHIFT:
                    stack.append(tag)
                    cursor += 1
            #(Reduce case)
                elif action ==ShiftReduceParser.REDUCE:
                    for _ in range(len(tag.Right)):
                        stack.pop()
                    stack.append(self.goto[stack[-1], tag.Left])
                    output.append(tag)
            #(OK case)
                elif action==ShiftReduceParser.OK:
                    return output
            #(Invalid case)
                else:
                    assert False, 'Must be something wrong!'
            except KeyError:
                raise Exception('Aborting parsing, item is not viable.')


def metodo_predictivo_no_recursivo(G, M=None, firsts=None, follows=None):
    
    # checking table...
    if M is None:
        if firsts is None:
            firsts = compute_firsts(G)
        if follows is None:
            follows = compute_follows(G, firsts)
        M = build_parsing_table(G, firsts, follows)
    
    
    # parser construction...
    def parser(w):
        
        # w ends with $ (G.EOF)
        # init:
        ### stack =  ????
        stack = []
        stack.append(G.startSymbol) 
        ### cursor = ????
        cursor = 0
        ### output = ????
        output = []
        aux = []
        # parsing w...
        while len(stack) > 0:
            top = stack.pop()
            a = w[cursor]


            if top.IsNonTerminal:
                next_prod = M[top,a]
                output.append(next_prod[0])


                for symbols in next_prod[0].Right:
                    aux.append(symbols)
                while len(aux)>0:
                    stack.append(aux.pop())
            else:
                if a == top:
                    cursor += 1
                else:
                    raise Exception('Malformed Expression')

#             print((top, a))
        # left parse is ready!!!
        return output
    
    # parser is ready!!!
    return parser

def build_parsing_table(G, firsts, follows):
    # init parsing table
    M = {}
    
    # P: X -> alpha
    for production in G.Productions:
        X = production.Left
        alpha = production.Right

        # working with symbols on First(alpha) ...  
        for firsts_alpha in firsts[alpha]:
            try:
                M[X,firsts_alpha].append(production)
            except KeyError:
                M[X,firsts_alpha] = [production]

        # working with epsilon...
        if alpha.IsEpsilon:
            for follows_X in follows[X]:
                try:
                    M[X,follows_X].append(production)
                except KeyError:
                    M[X,follows_X] = [production]
    
    # parsing table is ready!!!
    return M   

def metodo_predictivo_no_recursivo_especial(G, M=None, firsts=None, follows=None):
    
    # checking table...
    if M is None:
        if firsts is None:
            firsts = compute_firsts(G)
        if follows is None:
            follows = compute_follows(G, firsts)
        M = build_parsing_table(G, firsts, follows)
    
    
    # parser construction...
    def parser(w):
        
        # w ends with $ (G.EOF)
        # init:
        ### stack =  ????
        stack = []
        stack.append(G.startSymbol) 
        ### cursor = ????
        cursor = 0
        ### output = ????
        output = []
        aux = []
        # parsing w...
        while len(stack) > 0:
            top = stack.pop()
            a = w[cursor]


            if top.IsNonTerminal:
                next_prod = M[top,a]
                output.append(next_prod[0])


                for symbols in next_prod[0].Right:
                    aux.append(symbols)
                while len(aux)>0:
                    stack.append(aux.pop())
            else:
                if a == top:
                    cursor += 1
                else:
                    raise Exception('Malformed Expression')

#             print((top, a))
        # left parse is ready!!!
        return output
    
    # parser is ready!!!
    return parser


def inference_cleaner(inference_list):
    fixed_list = {}
    for item in inference_list:
        fixed_list[item[0]] = item[1]
    return fixed_list

def inference_solver(inference_dict:dict):
    change = True
    while change:
        change = False
        for key,value in inference_dict.items():
            try:
                a = inference_dict[key]
                inference_dict[key] = inference_dict[value]
                b = inference_dict[key]
                if a != b:
                    change = True
            except KeyError:
                pass




