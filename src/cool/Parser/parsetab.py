
# parsetab.py
# This file is automatically generated. Do not edit.
# pylint: disable=W,C,R
_tabversion = '3.10'

_lr_method = 'LALR'

_lr_signature = 'programARROBA CCUR COLON COMMA CPAR DIV DOT EQUAL ID LARROW LESS LESSEQ MINUS NOX NUMBER OCUR OPAR PLUS RARROW SEMI STAR STRING TYPE case class else esac false fi if in inherits isvoid let loop new not of pool then true whileempty :program : class_listclass_list : def_class SEMI class_list\n                      | def_class SEMIdef_class : class TYPE OCUR feature_list CCUR\n                     | class TYPE inherits TYPE OCUR feature_list CCURfeature_list : def_attr SEMI feature_list\n                        | def_func SEMI feature_list\n                        | emptydef_attr : ID COLON TYPE\n                    | ID COLON TYPE LARROW exprdef_func : ID OPAR param_list CPAR COLON TYPE OCUR expr CCURparam_list : empty\n                      | param\n                      | param COMMA param_listparam : ID COLON TYPEexpr_list : expr SEMI expr_list\n                     | expr SEMIdeclar_list : declar\n                       | declar COMMA declar_listdeclar : ID COLON TYPE\n                  | ID COLON TYPE LARROW exprassign_list : case_assign\n                       | case_assign assign_listcase_assign : ID COLON TYPE RARROW expr SEMIexpr : let declar_list in exprexpr : while expr loop expr poolexpr : if expr then expr else expr fiexpr : case expr of assign_list esacexpr : OCUR expr_list CCURexpr : ID LARROW exprexpr : booleanboolean : not comparison\n                   | comparisoncomparison : comparison EQUAL arith\n                      | comparison LESS arith\n                      | comparison LESSEQ arith \n                      | aritharith : arith PLUS term\n                 | arith MINUS term\n                 | termterm : term STAR unary\n                | term DIV unary\n                | unaryunary : factorunary : NOX unaryunary : isvoid unaryfactor : atomfactor : OPAR expr CPARfactor : factor DOT ID OPAR arg_list CPAR\n                  | ID OPAR arg_list CPAR\n                  | factor ARROBA ID DOT ID OPAR arg_list CPARatom : NUMBERatom : true\n                | falseatom : IDatom : new TYPEatom : STRINGarg_list : expr\n                    | expr COMMA arg_list\n                    | empty'
    
_lr_action_items = {'class':([0,5,],[4,4,]),'$end':([1,2,5,7,],[0,-2,-4,-3,]),'SEMI':([3,11,12,16,24,34,35,36,42,44,45,46,47,48,51,53,54,55,57,70,71,72,82,83,85,87,97,99,100,101,102,103,104,105,108,110,112,126,128,133,137,139,142,143,],[5,17,18,-5,-10,-6,-56,-11,-32,-34,-38,-41,-44,-45,-48,-53,-54,-55,-58,98,-33,-56,-46,-47,-57,-31,-30,-35,-36,-37,-39,-40,-42,-43,-49,-51,-26,-27,-29,-12,-50,-28,144,-52,]),'TYPE':([4,9,19,31,56,59,93,130,],[6,15,24,58,85,86,114,136,]),'OCUR':([6,15,30,38,39,40,41,52,61,62,86,91,94,95,98,109,111,121,125,127,138,140,],[8,21,41,41,41,41,41,41,41,41,109,41,41,41,41,41,41,41,41,41,41,41,]),'inherits':([6,],[9,]),'ID':([8,17,18,20,21,30,33,37,38,39,40,41,43,49,50,52,61,62,73,74,75,76,77,78,79,80,81,91,92,94,95,96,98,109,111,118,121,122,125,127,138,140,144,],[14,14,14,25,14,35,25,65,35,35,35,35,72,72,72,35,35,35,72,72,72,72,72,72,72,106,107,35,65,35,35,119,35,35,35,119,35,132,35,35,35,35,-25,]),'CCUR':([8,10,13,17,18,21,22,23,29,35,42,44,45,46,47,48,51,53,54,55,57,69,71,72,82,83,85,87,97,98,99,100,101,102,103,104,105,108,110,112,120,123,126,128,137,139,143,],[-1,16,-9,-1,-1,-1,-7,-8,34,-56,-32,-34,-38,-41,-44,-45,-48,-53,-54,-55,-58,97,-33,-56,-46,-47,-57,-31,-30,-18,-35,-36,-37,-39,-40,-42,-43,-49,-51,-26,-17,133,-27,-29,-50,-28,-52,]),'COLON':([14,25,32,65,119,],[19,31,59,93,130,]),'OPAR':([14,30,35,38,39,40,41,43,49,50,52,61,62,72,73,74,75,76,77,78,79,91,94,95,98,106,109,111,121,125,127,132,138,140,],[20,52,62,52,52,52,52,52,52,52,52,52,52,62,52,52,52,52,52,52,52,52,52,52,52,121,52,52,52,52,52,138,52,52,]),'CPAR':([20,26,27,28,33,35,42,44,45,46,47,48,51,53,54,55,57,58,60,62,71,72,82,83,84,85,87,88,89,90,97,99,100,101,102,103,104,105,108,110,111,112,121,124,126,128,131,137,138,139,141,143,],[-1,32,-13,-14,-1,-56,-32,-34,-38,-41,-44,-45,-48,-53,-54,-55,-58,-16,-15,-1,-33,-56,-46,-47,108,-57,-31,110,-59,-61,-30,-35,-36,-37,-39,-40,-42,-43,-49,-51,-1,-26,-1,-60,-27,-29,137,-50,-1,-28,143,-52,]),'LARROW':([24,35,114,],[30,61,125,]),'COMMA':([28,35,42,44,45,46,47,48,51,53,54,55,57,58,64,71,72,82,83,85,87,89,97,99,100,101,102,103,104,105,108,110,112,114,126,128,134,137,139,143,],[33,-56,-32,-34,-38,-41,-44,-45,-48,-53,-54,-55,-58,-16,92,-33,-56,-46,-47,-57,-31,111,-30,-35,-36,-37,-39,-40,-42,-43,-49,-51,-26,-21,-27,-29,-22,-50,-28,-52,]),'let':([30,38,39,40,41,52,61,62,91,94,95,98,109,111,121,125,127,138,140,],[37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,]),'while':([30,38,39,40,41,52,61,62,91,94,95,98,109,111,121,125,127,138,140,],[38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,]),'if':([30,38,39,40,41,52,61,62,91,94,95,98,109,111,121,125,127,138,140,],[39,39,39,39,39,39,39,39,39,39,39,39,39,39,39,39,39,39,39,]),'case':([30,38,39,40,41,52,61,62,91,94,95,98,109,111,121,125,127,138,140,],[40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,]),'not':([30,38,39,40,41,52,61,62,91,94,95,98,109,111,121,125,127,138,140,],[43,43,43,43,43,43,43,43,43,43,43,43,43,43,43,43,43,43,43,]),'NOX':([30,38,39,40,41,43,49,50,52,61,62,73,74,75,76,77,78,79,91,94,95,98,109,111,121,125,127,138,140,],[49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,]),'isvoid':([30,38,39,40,41,43,49,50,52,61,62,73,74,75,76,77,78,79,91,94,95,98,109,111,121,125,127,138,140,],[50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,]),'NUMBER':([30,38,39,40,41,43,49,50,52,61,62,73,74,75,76,77,78,79,91,94,95,98,109,111,121,125,127,138,140,],[53,53,53,53,53,53,53,53,53,53,53,53,53,53,53,53,53,53,53,53,53,53,53,53,53,53,53,53,53,]),'true':([30,38,39,40,41,43,49,50,52,61,62,73,74,75,76,77,78,79,91,94,95,98,109,111,121,125,127,138,140,],[54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,]),'false':([30,38,39,40,41,43,49,50,52,61,62,73,74,75,76,77,78,79,91,94,95,98,109,111,121,125,127,138,140,],[55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,]),'new':([30,38,39,40,41,43,49,50,52,61,62,73,74,75,76,77,78,79,91,94,95,98,109,111,121,125,127,138,140,],[56,56,56,56,56,56,56,56,56,56,56,56,56,56,56,56,56,56,56,56,56,56,56,56,56,56,56,56,56,]),'STRING':([30,38,39,40,41,43,49,50,52,61,62,73,74,75,76,77,78,79,91,94,95,98,109,111,121,125,127,138,140,],[57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,]),'DOT':([35,48,51,53,54,55,57,72,85,107,108,110,137,143,],[-56,80,-48,-53,-54,-55,-58,-56,-57,122,-49,-51,-50,-52,]),'ARROBA':([35,48,51,53,54,55,57,72,85,108,110,137,143,],[-56,81,-48,-53,-54,-55,-58,-56,-57,-49,-51,-50,-52,]),'STAR':([35,46,47,48,51,53,54,55,57,72,82,83,85,102,103,104,105,108,110,137,143,],[-56,78,-44,-45,-48,-53,-54,-55,-58,-56,-46,-47,-57,78,78,-42,-43,-49,-51,-50,-52,]),'DIV':([35,46,47,48,51,53,54,55,57,72,82,83,85,102,103,104,105,108,110,137,143,],[-56,79,-44,-45,-48,-53,-54,-55,-58,-56,-46,-47,-57,79,79,-42,-43,-49,-51,-50,-52,]),'PLUS':([35,45,46,47,48,51,53,54,55,57,72,82,83,85,99,100,101,102,103,104,105,108,110,137,143,],[-56,76,-41,-44,-45,-48,-53,-54,-55,-58,-56,-46,-47,-57,76,76,76,-39,-40,-42,-43,-49,-51,-50,-52,]),'MINUS':([35,45,46,47,48,51,53,54,55,57,72,82,83,85,99,100,101,102,103,104,105,108,110,137,143,],[-56,77,-41,-44,-45,-48,-53,-54,-55,-58,-56,-46,-47,-57,77,77,77,-39,-40,-42,-43,-49,-51,-50,-52,]),'EQUAL':([35,44,45,46,47,48,51,53,54,55,57,71,72,82,83,85,99,100,101,102,103,104,105,108,110,137,143,],[-56,73,-38,-41,-44,-45,-48,-53,-54,-55,-58,73,-56,-46,-47,-57,-35,-36,-37,-39,-40,-42,-43,-49,-51,-50,-52,]),'LESS':([35,44,45,46,47,48,51,53,54,55,57,71,72,82,83,85,99,100,101,102,103,104,105,108,110,137,143,],[-56,74,-38,-41,-44,-45,-48,-53,-54,-55,-58,74,-56,-46,-47,-57,-35,-36,-37,-39,-40,-42,-43,-49,-51,-50,-52,]),'LESSEQ':([35,44,45,46,47,48,51,53,54,55,57,71,72,82,83,85,99,100,101,102,103,104,105,108,110,137,143,],[-56,75,-38,-41,-44,-45,-48,-53,-54,-55,-58,75,-56,-46,-47,-57,-35,-36,-37,-39,-40,-42,-43,-49,-51,-50,-52,]),'loop':([35,42,44,45,46,47,48,51,53,54,55,57,66,71,72,82,83,85,87,97,99,100,101,102,103,104,105,108,110,112,126,128,137,139,143,],[-56,-32,-34,-38,-41,-44,-45,-48,-53,-54,-55,-58,94,-33,-56,-46,-47,-57,-31,-30,-35,-36,-37,-39,-40,-42,-43,-49,-51,-26,-27,-29,-50,-28,-52,]),'then':([35,42,44,45,46,47,48,51,53,54,55,57,67,71,72,82,83,85,87,97,99,100,101,102,103,104,105,108,110,112,126,128,137,139,143,],[-56,-32,-34,-38,-41,-44,-45,-48,-53,-54,-55,-58,95,-33,-56,-46,-47,-57,-31,-30,-35,-36,-37,-39,-40,-42,-43,-49,-51,-26,-27,-29,-50,-28,-52,]),'of':([35,42,44,45,46,47,48,51,53,54,55,57,68,71,72,82,83,85,87,97,99,100,101,102,103,104,105,108,110,112,126,128,137,139,143,],[-56,-32,-34,-38,-41,-44,-45,-48,-53,-54,-55,-58,96,-33,-56,-46,-47,-57,-31,-30,-35,-36,-37,-39,-40,-42,-43,-49,-51,-26,-27,-29,-50,-28,-52,]),'pool':([35,42,44,45,46,47,48,51,53,54,55,57,71,72,82,83,85,87,97,99,100,101,102,103,104,105,108,110,112,115,126,128,137,139,143,],[-56,-32,-34,-38,-41,-44,-45,-48,-53,-54,-55,-58,-33,-56,-46,-47,-57,-31,-30,-35,-36,-37,-39,-40,-42,-43,-49,-51,-26,126,-27,-29,-50,-28,-52,]),'else':([35,42,44,45,46,47,48,51,53,54,55,57,71,72,82,83,85,87,97,99,100,101,102,103,104,105,108,110,112,116,126,128,137,139,143,],[-56,-32,-34,-38,-41,-44,-45,-48,-53,-54,-55,-58,-33,-56,-46,-47,-57,-31,-30,-35,-36,-37,-39,-40,-42,-43,-49,-51,-26,127,-27,-29,-50,-28,-52,]),'in':([35,42,44,45,46,47,48,51,53,54,55,57,63,64,71,72,82,83,85,87,97,99,100,101,102,103,104,105,108,110,112,113,114,126,128,134,137,139,143,],[-56,-32,-34,-38,-41,-44,-45,-48,-53,-54,-55,-58,91,-19,-33,-56,-46,-47,-57,-31,-30,-35,-36,-37,-39,-40,-42,-43,-49,-51,-26,-20,-21,-27,-29,-22,-50,-28,-52,]),'fi':([35,42,44,45,46,47,48,51,53,54,55,57,71,72,82,83,85,87,97,99,100,101,102,103,104,105,108,110,112,126,128,135,137,139,143,],[-56,-32,-34,-38,-41,-44,-45,-48,-53,-54,-55,-58,-33,-56,-46,-47,-57,-31,-30,-35,-36,-37,-39,-40,-42,-43,-49,-51,-26,-27,-29,139,-50,-28,-52,]),'esac':([117,118,129,144,],[128,-23,-24,-25,]),'RARROW':([136,],[140,]),}

_lr_action = {}
for _k, _v in _lr_action_items.items():
   for _x,_y in zip(_v[0],_v[1]):
      if not _x in _lr_action:  _lr_action[_x] = {}
      _lr_action[_x][_k] = _y
del _lr_action_items

_lr_goto_items = {'program':([0,],[1,]),'class_list':([0,5,],[2,7,]),'def_class':([0,5,],[3,3,]),'feature_list':([8,17,18,21,],[10,22,23,29,]),'def_attr':([8,17,18,21,],[11,11,11,11,]),'def_func':([8,17,18,21,],[12,12,12,12,]),'empty':([8,17,18,20,21,33,62,111,121,138,],[13,13,13,27,13,27,90,90,90,90,]),'param_list':([20,33,],[26,60,]),'param':([20,33,],[28,28,]),'expr':([30,38,39,40,41,52,61,62,91,94,95,98,109,111,121,125,127,138,140,],[36,66,67,68,70,84,87,89,112,115,116,70,123,89,89,134,135,89,142,]),'boolean':([30,38,39,40,41,52,61,62,91,94,95,98,109,111,121,125,127,138,140,],[42,42,42,42,42,42,42,42,42,42,42,42,42,42,42,42,42,42,42,]),'comparison':([30,38,39,40,41,43,52,61,62,91,94,95,98,109,111,121,125,127,138,140,],[44,44,44,44,44,71,44,44,44,44,44,44,44,44,44,44,44,44,44,44,]),'arith':([30,38,39,40,41,43,52,61,62,73,74,75,91,94,95,98,109,111,121,125,127,138,140,],[45,45,45,45,45,45,45,45,45,99,100,101,45,45,45,45,45,45,45,45,45,45,45,]),'term':([30,38,39,40,41,43,52,61,62,73,74,75,76,77,91,94,95,98,109,111,121,125,127,138,140,],[46,46,46,46,46,46,46,46,46,46,46,46,102,103,46,46,46,46,46,46,46,46,46,46,46,]),'unary':([30,38,39,40,41,43,49,50,52,61,62,73,74,75,76,77,78,79,91,94,95,98,109,111,121,125,127,138,140,],[47,47,47,47,47,47,82,83,47,47,47,47,47,47,47,47,104,105,47,47,47,47,47,47,47,47,47,47,47,]),'factor':([30,38,39,40,41,43,49,50,52,61,62,73,74,75,76,77,78,79,91,94,95,98,109,111,121,125,127,138,140,],[48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,]),'atom':([30,38,39,40,41,43,49,50,52,61,62,73,74,75,76,77,78,79,91,94,95,98,109,111,121,125,127,138,140,],[51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,]),'declar_list':([37,92,],[63,113,]),'declar':([37,92,],[64,64,]),'expr_list':([41,98,],[69,120,]),'arg_list':([62,111,121,138,],[88,124,131,141,]),'assign_list':([96,118,],[117,129,]),'case_assign':([96,118,],[118,118,]),}

_lr_goto = {}
for _k, _v in _lr_goto_items.items():
   for _x, _y in zip(_v[0], _v[1]):
       if not _x in _lr_goto: _lr_goto[_x] = {}
       _lr_goto[_x][_k] = _y
del _lr_goto_items
_lr_productions = [
  ("S' -> program","S'",1,None,None,None),
  ('empty -> <empty>','empty',0,'p_empty','parser.py',23),
  ('program -> class_list','program',1,'p_program','parser.py',27),
  ('class_list -> def_class SEMI class_list','class_list',3,'p_class_list','parser.py',31),
  ('class_list -> def_class SEMI','class_list',2,'p_class_list','parser.py',32),
  ('def_class -> class TYPE OCUR feature_list CCUR','def_class',5,'p_def_class','parser.py',36),
  ('def_class -> class TYPE inherits TYPE OCUR feature_list CCUR','def_class',7,'p_def_class','parser.py',37),
  ('feature_list -> def_attr SEMI feature_list','feature_list',3,'p_feature_list','parser.py',43),
  ('feature_list -> def_func SEMI feature_list','feature_list',3,'p_feature_list','parser.py',44),
  ('feature_list -> empty','feature_list',1,'p_feature_list','parser.py',45),
  ('def_attr -> ID COLON TYPE','def_attr',3,'p_def_attr','parser.py',50),
  ('def_attr -> ID COLON TYPE LARROW expr','def_attr',5,'p_def_attr','parser.py',51),
  ('def_func -> ID OPAR param_list CPAR COLON TYPE OCUR expr CCUR','def_func',9,'p_def_func','parser.py',57),
  ('param_list -> empty','param_list',1,'p_param_list','parser.py',62),
  ('param_list -> param','param_list',1,'p_param_list','parser.py',63),
  ('param_list -> param COMMA param_list','param_list',3,'p_param_list','parser.py',64),
  ('param -> ID COLON TYPE','param',3,'p_param','parser.py',73),
  ('expr_list -> expr SEMI expr_list','expr_list',3,'p_expr_list','parser.py',77),
  ('expr_list -> expr SEMI','expr_list',2,'p_expr_list','parser.py',78),
  ('declar_list -> declar','declar_list',1,'p_declar_list','parser.py',83),
  ('declar_list -> declar COMMA declar_list','declar_list',3,'p_declar_list','parser.py',84),
  ('declar -> ID COLON TYPE','declar',3,'p_declar','parser.py',88),
  ('declar -> ID COLON TYPE LARROW expr','declar',5,'p_declar','parser.py',89),
  ('assign_list -> case_assign','assign_list',1,'p_assign_list','parser.py',94),
  ('assign_list -> case_assign assign_list','assign_list',2,'p_assign_list','parser.py',95),
  ('case_assign -> ID COLON TYPE RARROW expr SEMI','case_assign',6,'p_case_assign','parser.py',100),
  ('expr -> let declar_list in expr','expr',4,'p_expr_let','parser.py',104),
  ('expr -> while expr loop expr pool','expr',5,'p_expr_while','parser.py',108),
  ('expr -> if expr then expr else expr fi','expr',7,'p_expr_if','parser.py',112),
  ('expr -> case expr of assign_list esac','expr',5,'p_expr_case','parser.py',116),
  ('expr -> OCUR expr_list CCUR','expr',3,'p_expr_group','parser.py',120),
  ('expr -> ID LARROW expr','expr',3,'p_expr_assign','parser.py',124),
  ('expr -> boolean','expr',1,'p_expr_boolean','parser.py',128),
  ('boolean -> not comparison','boolean',2,'p_boolean','parser.py',132),
  ('boolean -> comparison','boolean',1,'p_boolean','parser.py',133),
  ('comparison -> comparison EQUAL arith','comparison',3,'p_comparison','parser.py',137),
  ('comparison -> comparison LESS arith','comparison',3,'p_comparison','parser.py',138),
  ('comparison -> comparison LESSEQ arith','comparison',3,'p_comparison','parser.py',139),
  ('comparison -> arith','comparison',1,'p_comparison','parser.py',140),
  ('arith -> arith PLUS term','arith',3,'p_arith','parser.py',150),
  ('arith -> arith MINUS term','arith',3,'p_arith','parser.py',151),
  ('arith -> term','arith',1,'p_arith','parser.py',152),
  ('term -> term STAR unary','term',3,'p_term','parser.py',160),
  ('term -> term DIV unary','term',3,'p_term','parser.py',161),
  ('term -> unary','term',1,'p_term','parser.py',162),
  ('unary -> factor','unary',1,'p_unary_factor','parser.py',170),
  ('unary -> NOX unary','unary',2,'p_unary_negate','parser.py',174),
  ('unary -> isvoid unary','unary',2,'p_unary_isvoid','parser.py',178),
  ('factor -> atom','factor',1,'p_factor_atom','parser.py',182),
  ('factor -> OPAR expr CPAR','factor',3,'p_factor_expr','parser.py',186),
  ('factor -> factor DOT ID OPAR arg_list CPAR','factor',6,'p_factor_call','parser.py',190),
  ('factor -> ID OPAR arg_list CPAR','factor',4,'p_factor_call','parser.py',191),
  ('factor -> factor ARROBA ID DOT ID OPAR arg_list CPAR','factor',8,'p_factor_call','parser.py',192),
  ('atom -> NUMBER','atom',1,'p_atom_num','parser.py',201),
  ('atom -> true','atom',1,'p_atom_boolean','parser.py',205),
  ('atom -> false','atom',1,'p_atom_boolean','parser.py',206),
  ('atom -> ID','atom',1,'p_atom_id','parser.py',210),
  ('atom -> new TYPE','atom',2,'p_atom_instantiate','parser.py',214),
  ('atom -> STRING','atom',1,'p_atom_string','parser.py',218),
  ('arg_list -> expr','arg_list',1,'p_arg_list','parser.py',222),
  ('arg_list -> expr COMMA arg_list','arg_list',3,'p_arg_list','parser.py',223),
  ('arg_list -> empty','arg_list',1,'p_arg_list','parser.py',224),
]