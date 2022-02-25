.data

#Errors
call_void_error: .asciiz "Runtime Error: A dispatch (static or dynamic) on void
"
case_void_expr: .asciiz "Runtime Error: A case on void.
"
case_branch_error: .asciiz "Runtime Error: Execution of a case statement without a matching branch.
"
zero_division: .asciiz "Runtime Error: Division by zero.
"
substring_out_of_range: .asciiz "Runtime Error: Substring out of range.
"
heap_overflow: .asciiz "Runtime Error: Heap overflow.
"
abort_label: .asciiz "Abort called from class "
slash_n: .asciiz "\n" 

#TYPES
type_Object: .asciiz "Object"
Object_methods:
.word 4
.word type_Object
.word 0
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object

type_IO: .asciiz "IO"
IO_methods:
.word 4
.word type_IO
.word Object_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object
.word function_out_string_at_IO
.word function_out_int_at_IO
.word function_in_string_at_IO
.word function_in_int_at_IO

type_Int: .asciiz "Int"
Int_methods:
.word 8
.word type_Int
.word Object_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object

type_String: .asciiz "String"
String_methods:
.word 12
.word type_String
.word Object_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object
.word function_length_at_String
.word function_concat_at_String
.word function_substr_at_String

type_Bool: .asciiz "Bool"
Bool_methods:
.word 8
.word type_Bool
.word Object_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object

type_Graph: .asciiz "Graph"
Graph_methods:
.word 12
.word type_Graph
.word Object_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object
.word function_add_vertice_at_Graph
.word function_print_E_at_Graph
.word function_print_V_at_Graph

type_Vertice: .asciiz "Vertice"
Vertice_methods:
.word 12
.word type_Vertice
.word IO_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object
.word function_out_string_at_IO
.word function_out_int_at_IO
.word function_in_string_at_IO
.word function_in_int_at_IO
.word function_outgoing_at_Vertice
.word function_number_at_Vertice
.word function_init_at_Vertice
.word function_add_out_at_Vertice
.word function_print_at_Vertice

type_Edge: .asciiz "Edge"
Edge_methods:
.word 16
.word type_Edge
.word IO_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object
.word function_out_string_at_IO
.word function_out_int_at_IO
.word function_in_string_at_IO
.word function_in_int_at_IO
.word function_init_at_Edge
.word function_print_at_Edge

type_EList: .asciiz "EList"
EList_methods:
.word 8
.word type_EList
.word IO_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object
.word function_out_string_at_IO
.word function_out_int_at_IO
.word function_in_string_at_IO
.word function_in_int_at_IO
.word function_isNil_at_EList
.word function_head_at_EList
.word function_tail_at_EList
.word function_cons_at_EList
.word function_append_at_EList
.word function_print_at_EList

type_VList: .asciiz "VList"
VList_methods:
.word 8
.word type_VList
.word IO_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object
.word function_out_string_at_IO
.word function_out_int_at_IO
.word function_in_string_at_IO
.word function_in_int_at_IO
.word function_isNil_at_VList
.word function_head_at_VList
.word function_tail_at_VList
.word function_cons_at_VList
.word function_print_at_VList

type_Parse: .asciiz "Parse"
Parse_methods:
.word 12
.word type_Parse
.word IO_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object
.word function_out_string_at_IO
.word function_out_int_at_IO
.word function_in_string_at_IO
.word function_in_int_at_IO
.word function_read_input_at_Parse
.word function_parse_line_at_Parse
.word function_c2i_at_Parse
.word function_a2i_at_Parse
.word function_a2i_aux_at_Parse

type_BoolOp: .asciiz "BoolOp"
BoolOp_methods:
.word 4
.word type_BoolOp
.word Object_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object
.word function_and_at_BoolOp
.word function_or_at_BoolOp

type_ECons: .asciiz "ECons"
ECons_methods:
.word 12
.word type_ECons
.word EList_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object
.word function_out_string_at_IO
.word function_out_int_at_IO
.word function_in_string_at_IO
.word function_in_int_at_IO
.word function_isNil_at_ECons
.word function_head_at_ECons
.word function_tail_at_ECons
.word function_cons_at_EList
.word function_append_at_EList
.word function_print_at_ECons
.word function_init_at_ECons

type_VCons: .asciiz "VCons"
VCons_methods:
.word 12
.word type_VCons
.word VList_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object
.word function_out_string_at_IO
.word function_out_int_at_IO
.word function_in_string_at_IO
.word function_in_int_at_IO
.word function_isNil_at_VCons
.word function_head_at_VCons
.word function_tail_at_VCons
.word function_cons_at_VList
.word function_print_at_VCons
.word function_init_at_VCons

type_Main: .asciiz "Main"
Main_methods:
.word 16
.word type_Main
.word Parse_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object
.word function_out_string_at_IO
.word function_out_int_at_IO
.word function_in_string_at_IO
.word function_in_int_at_IO
.word function_read_input_at_Parse
.word function_parse_line_at_Parse
.word function_c2i_at_Parse
.word function_a2i_at_Parse
.word function_a2i_aux_at_Parse
.word function_main_at_Main


#DATA_STR
empty_str_data: .asciiz ""
void_data: .word 0
aux_input_string: .space 1028

data_0: .asciiz " ("
data_1: .asciiz ","
data_2: .asciiz ")"
data_3: .asciiz "\n"
data_4: .asciiz "\n"
data_5: .asciiz "\n"
data_6: .asciiz ""
data_7: .asciiz "0"
data_8: .asciiz "1"
data_9: .asciiz "2"
data_10: .asciiz "3"
data_11: .asciiz "4"
data_12: .asciiz "5"
data_13: .asciiz "6"
data_14: .asciiz "7"
data_15: .asciiz "8"
data_16: .asciiz "9"
data_17: .asciiz "-"
data_18: .asciiz " "
data_19: .asciiz " "
data_20: .asciiz ","
data_21: .asciiz ""
data_22: .asciiz ""
.text
main:
jal entry

end:
li, $v0, 10
syscall


error_call_void:
la $a0,call_void_error
j print_error
error_expr_void:
la $a0,case_void_expr
j print_error
error_branch:
la $a0,case_branch_error
j print_error
error_div_by_zero:
la $a0,zero_division
j print_error
error_substring:
la $a0,substring_out_of_range
j print_error
error_heap:
la $a0,heap_overflow
print_error:
li $v0, 4
syscall
j end

Equals_comparison:
beq $t1,$t2 equalsTrue
li $t3,0
j end_equals_comparison
equalsTrue: 
li $t3,1
end_equals_comparison:
jr $ra


LessEqual_comparison:
ble $t1,$t2 lessEqualTrue
li $t3,0
j end_LessEqual_comparison
lessEqualTrue: 
li $t3,1
end_LessEqual_comparison:
jr $ra


Less_comparison:
blt $t1,$t2 lessTrue
li $t3,0
j end_less_comparison
lessTrue: 
li $t3,1
end_less_comparison:
jr $ra


Void_comparison:
la $t2 void_data 
blt $t1,$t2 VoidTrue
li $t3,0
j end_Void_comparison
VoidTrue: 
li $t3,1
end_Void_comparison:
jr $ra


calculateDistance:
li $a1, 0 #calculateDistance Funct
loop_distance_types:
beq $t1, $t2 end_ancestor_search
beqz $t1 end_method_compute_distance
lw  $t1,8($t1)
addi $a1,$a1,1
j loop_distance_types
end_ancestor_search:
blt $a1,$s1 new_min_label_distance
jr $ra
new_min_label_distance:
move $s1,$a1
move $s0,$t2
end_method_compute_distance:
jr $ra

read_string_function: 
move $t1,$a0
li $s1, 0
loop_function_length_read:
li $t2,0
lb $t2, ($t1)
beqz $t2, end_function_length_read
addi $t1, $t1, 1
addi $s1, $s1, 1
j loop_function_length_read
end_function_length_read:

addi $s1,$s1,1
string_fix:
addi $t1, $t1, -1
addi $s1, $s1, -1
li $t0, 0
lb $t0, ($t1)
bne $t0, 10, end_fix_str
sb $zero, ($t1)
addi $s1,$s1,-1 
addi $t1, $t1, -1
lb $t0, ($t1)
bne $t0, 13, end_fix_str
sb $zero, ($t1)
j string_fix
end_fix_str:
move $a0,$s1
addi $a0,$a0,1
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
move $t4,$v0
la $t1, aux_input_string
loop_readString:
li $a1,0
lb $a1, ($t1)
sb $a1, ($t3)
addi $t1,$t1,1
addi $t3,$t3,1
beqz $a1,end_readString
j loop_readString
end_readString:
jr $ra
String_comparison_fun:
bne $a1,$a2, false_string_comparison 
beqz $a1, true_string_comparison 
lb $a1,($t1)
lb $a2,($t2)
addi $t1,$t1,1
addi $t2,$t2,1
j String_comparison_fun
false_string_comparison:
li $t3,0
j end_string_comparison
true_string_comparison:
li $t3,1
end_string_comparison:jr $ra

#CODE

entry:
addi, $sp, $sp, -12
sw $ra, ($sp)

addi $a0, $zero, 16
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Main_methods
sw $t1, ($t3)
sw, $t3, 4($sp)
lw $s4,4($sp)
move $t0, $sp #call to function init_Main
addi, $sp, $sp, -4
lw, $s0, 4($t0) #loading param_local__internal_0
sw, $s0 0($sp) #setting param for function call
jal init_Main
addi, $sp, $sp, 4
sw $s0, 4($sp) #Saving result on local__internal_0
lw $s4,4($sp)
move $t0, $sp #call to function main
addi, $sp, $sp, -4
lw, $s0, 4($t0) #loading param_local__internal_0
sw, $s0 0($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 60 ($a1)
jalr $a2
addi, $sp, $sp, 4
sw $s0, 8($sp) #Saving result on local__internal_1

move $s0, $zero
lw $ra, ($sp)
addi $sp, $sp,12
jr $ra

init_Object:
addi, $sp, $sp, -4
sw $ra, ($sp)

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,4
jr $ra

function_abort_at_Object:
addi, $sp, $sp, -4
sw $ra, ($sp)
la $a0 abort_label
li $v0,4
syscall
lw $a0 4($sp)
lw $a0 ($a0)
lw $a0 4($a0)
syscall
la $a0, slash_n
syscall
j end

move $s0, $zero
lw $ra, ($sp)
addi $sp, $sp,4
jr $ra

function_type_name_at_Object:
addi, $sp, $sp, -12
sw $ra, ($sp)

lw $a0, 12($sp)
lw $a1, ($a0)
lw $a2, 4($a1)
sw $a2, 8($sp)
addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 4($sp)
lw $s4,4($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -8
lw, $s0, 4($t0) #loading param_local_type_name_at_Object_internal_0
sw, $s0 0($sp) #setting param for function call
lw, $s0, 8($t0) #loading param_local_type_name_at_Object_internal_1
sw, $s0 4($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 8
sw $s0, 4($sp) #Saving result on local_type_name_at_Object_internal_0

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,12
jr $ra

function_copy_at_Object:
addi, $sp, $sp, -8
sw $ra, ($sp)

lw $t1, 8($sp)
lw $t2, ($t1)
lw $a0, ($t2)

li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
move $t4,$v0
loop_copyNode:
lw $t2, ($t1)
sw $t2, ($t3)
addi $t1,$t1,4
addi $t3,$t3,4
subu $a0,$a0,4
beqz $a0,end_loop_copy
j loop_copyNode
end_loop_copy:
sw $t4, 4($sp)

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,8
jr $ra

init_Int:
addi, $sp, $sp, -4
sw $ra, ($sp)

lw, $t1, 8($sp)   
lw, $t3, 4($sp)  
sw, $t1, 4($t3)   

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,4
jr $ra

init_String:
addi, $sp, $sp, -4
sw $ra, ($sp)

lw, $t1, 8($sp)   
lw, $t3, 4($sp)  
sw, $t1, 4($t3)   

lw, $t1, 12($sp)   
lw, $t3, 4($sp)  
sw, $t1, 8($t3)   

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,4
jr $ra

function_length_at_String:
addi, $sp, $sp, -12
sw $ra, ($sp)
lw $t3, 12($sp) #getting instance self 

lw, $t3, 12($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset len 
sw, $t1, 4($sp)   

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 8($sp)
lw $s4,8($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 8($t0) #loading param_local_length_at_String_internal_1
sw, $s0 0($sp) #setting param for function call
lw, $s0, 4($t0) #loading param_local_length_at_String_internal_0
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 8($sp) #Saving result on local_length_at_String_internal_1

lw $s0, 8($sp)
lw $ra, ($sp)
addi $sp, $sp,12
jr $ra

init_length:
addi, $sp, $sp, -8
sw $ra, ($sp)
lw $t1, 8($sp)
li $s1, 0
loop_function_length:
lb $t2, ($t1)
beqz $t2, end_function_length
addi $t1, $t1, 1
addi $s1, $s1, 1
j loop_function_length
end_function_length:
sw $s1, 4($sp)

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,8
jr $ra

function_concat_at_String:
addi, $sp, $sp, -16
sw $ra, ($sp)

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 4($sp)

lw $t1, 16($sp)
lw $t2, 20($sp)
lw $a1, 8($t1)
lw $a2, 8($t2)
add $a0, $a1, $a2
lw $t1, 4($t1)
lw $t2, 4($t2)

addi $a0,$a0, 1
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
move $t4,$v0
loop_concat_dirSelf:
lb $a1, ($t1)
beqz $a1,loop_concat_dirParam
sb $a1, ($t3)
addi $t1,$t1,1
addi $t3,$t3,1
j loop_concat_dirSelf
loop_concat_dirParam:
lb $a1, ($t2)
sb $a1, ($t3)
addi $t2,$t2,1
addi $t3,$t3,1
beqz $a1,end_loop_concat
j loop_concat_dirParam
end_loop_concat:
sw $t4, 8($sp)
lw $s4,8($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 8($t0) #loading param_local_concat_at_String_internal_1
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 12($sp) #Saving result on local_concat_at_String_internal_2
lw $s4,4($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 4($t0) #loading param_local_concat_at_String_internal_0
sw, $s0 0($sp) #setting param for function call
lw, $s0, 8($t0) #loading param_local_concat_at_String_internal_1
sw, $s0 4($sp) #setting param for function call
lw, $s0, 12($t0) #loading param_local_concat_at_String_internal_2
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 4($sp) #Saving result on local_concat_at_String_internal_0

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,16
jr $ra

function_substr_at_String:
addi, $sp, $sp, -16
sw $ra, ($sp)

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 4($sp)

lw $t0, 16($sp)
lw $t1, 20($sp)
lw $t2, 24($sp)
lw $a2, 8($t0)
lw $a1, 4($t1)
lw $a0, 4($t2)
add $a3,$a1,$a0
bgt $a3,$a2, substring_out_of_range

addi $a0,$a0,1
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
move $t4,$v0
lw $a2, 4($t0)
add $a2,$a2,$a1
lw $a0, 4($t2)
loop_substring_dirSelf:
beqz $a0,end_loop_substr
lb $a1, ($a2)
sb $a1, ($t3)
addi $a2,$a2,1
addi $t3,$t3,1
addi $a0,$a0,-1
j loop_substring_dirSelf
end_loop_substr:
sb $zero, ($t3)
sw $t4, 8($sp)
lw $s4,8($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 8($t0) #loading param_local_substr_at_String_internal_1
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 12($sp) #Saving result on local_substr_at_String_internal_2
lw $s4,4($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 4($t0) #loading param_local_substr_at_String_internal_0
sw, $s0 0($sp) #setting param for function call
lw, $s0, 8($t0) #loading param_local_substr_at_String_internal_1
sw, $s0 4($sp) #setting param for function call
lw, $s0, 12($t0) #loading param_local_substr_at_String_internal_2
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 4($sp) #Saving result on local_substr_at_String_internal_0

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,16
jr $ra

init_Bool:
addi, $sp, $sp, -4
sw $ra, ($sp)

lw, $t1, 8($sp)   
lw, $t3, 4($sp)  
sw, $t1, 4($t3)   

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,4
jr $ra

init_IO:
addi, $sp, $sp, -4
sw $ra, ($sp)

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,4
jr $ra

function_out_string_at_IO:
addi, $sp, $sp, -8
sw $ra, ($sp)
lw $t3, 12($sp) #getting instance param1 

lw, $t3, 12($sp) #getting instance param1 
lw, $t1, 4($t3)  #getting offset value 
sw, $t1, 4($sp)   

li, $v0, 4
lw, $a0, 4($sp)
syscall

lw $s0, 8($sp)
lw $ra, ($sp)
addi $sp, $sp,8
jr $ra

function_out_int_at_IO:
addi, $sp, $sp, -8
sw $ra, ($sp)
lw $t3, 12($sp) #getting instance param1 

lw, $t3, 12($sp) #getting instance param1 
lw, $t1, 4($t3)  #getting offset value 
sw, $t1, 4($sp)   

li, $v0, 1
lw, $a0, 4($sp)
syscall

lw $s0, 8($sp)
lw $ra, ($sp)
addi $sp, $sp,8
jr $ra

function_in_int_at_IO:
addi, $sp, $sp, -12
sw $ra, ($sp)

li $v0,5 # Read_Int_Section
syscall
sw $v0,8($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 4($sp)
lw $s4,4($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 4($t0) #loading param_local_in_int_at_IO_internal_0
sw, $s0 0($sp) #setting param for function call
lw, $s0, 8($t0) #loading param_local_in_int_at_IO_internal_1
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 4($sp) #Saving result on local_in_int_at_IO_internal_0

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,12
jr $ra

function_in_string_at_IO:
addi, $sp, $sp, -16
sw $ra, ($sp)

li $v0,8 # Read_string_Section
la $a0,aux_input_string 
li $a1,1024
syscall 
jal read_string_function
sw $t4,8($sp)
lw $s4,8($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 8($t0) #loading param_local_in_string_at_IO_internal_1
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 12($sp) #Saving result on local_in_string_at_IO_internal_2

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 4($sp)
lw $s4,4($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 4($t0) #loading param_local_in_string_at_IO_internal_0
sw, $s0 0($sp) #setting param for function call
lw, $s0, 8($t0) #loading param_local_in_string_at_IO_internal_1
sw, $s0 4($sp) #setting param for function call
lw, $s0, 12($t0) #loading param_local_in_string_at_IO_internal_2
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 4($sp) #Saving result on local_in_string_at_IO_internal_0

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,16
jr $ra

init_Graph:
addi, $sp, $sp, -20
sw $ra, ($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,VList_methods
sw $t1, ($t3)
sw, $t3, 4($sp)
lw $s4,4($sp)
move $t0, $sp #call to function init_VList
addi, $sp, $sp, -4
lw, $s0, 4($t0) #loading param_local_h_internal_0
sw, $s0 0($sp) #setting param for function call
jal init_VList
addi, $sp, $sp, 4
sw $s0, 8($sp) #Saving result on local_h_internal_1

lw, $t1, 4($sp)   
lw, $t3, 20($sp)  
sw, $t1, 4($t3)   

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,EList_methods
sw $t1, ($t3)
sw, $t3, 12($sp)
lw $s4,12($sp)
move $t0, $sp #call to function init_EList
addi, $sp, $sp, -4
lw, $s0, 12($t0) #loading param_local_h_internal_2
sw, $s0 0($sp) #setting param for function call
jal init_EList
addi, $sp, $sp, 4
sw $s0, 16($sp) #Saving result on local_h_internal_3

lw, $t1, 12($sp)   
lw, $t3, 20($sp)  
sw, $t1, 8($t3)   

lw $s0, 20($sp)
lw $ra, ($sp)
addi $sp, $sp,20
jr $ra

function_add_vertice_at_Graph:
addi, $sp, $sp, -24
sw $ra, ($sp)
lw $t3, 24($sp) #getting instance self 

lw, $t3, 24($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset edges 
sw, $t1, 8($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 28($t0)
sw, $s0 0($sp)
lw $a0, 28($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 40($a1)#Function outgoing:function_outgoing_at_Vertice
jalr $a2
addi, $sp, $sp, 4
sw $s0, 12($sp)
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -8
lw, $s0, 12($t0)
sw, $s0 0($sp)
lw, $s0, 8($t0)
sw, $s0 4($sp)
lw $a0, 12($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 56($a1)#Function append:function_append_at_EList
jalr $a2
addi, $sp, $sp, 8
sw $s0, 4($sp)

lw, $t1, 4($sp)   
lw, $t3, 24($sp)  
sw, $t1, 8($t3)   
lw $t3, 24($sp) #getting instance self 

lw, $t3, 24($sp) #getting instance self 
lw, $t1, 4($t3)  #getting offset vertices 
sw, $t1, 20($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -8
lw, $s0, 20($t0)
sw, $s0 0($sp)
lw, $s0, 28($t0)
sw, $s0 4($sp)
lw $a0, 20($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 52($a1)#Function cons:function_cons_at_VList
jalr $a2
addi, $sp, $sp, 8
sw $s0, 16($sp)

lw, $t1, 16($sp)   
lw, $t3, 24($sp)  
sw, $t1, 4($t3)   

lw $s0, 16($sp)
lw $ra, ($sp)
addi $sp, $sp,24
jr $ra

function_print_E_at_Graph:
addi, $sp, $sp, -12
sw $ra, ($sp)
lw $t3, 12($sp) #getting instance self 

lw, $t3, 12($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset edges 
sw, $t1, 8($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 8($t0)
sw, $s0 0($sp)
lw $a0, 8($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 60($a1)#Function print:function_print_at_EList
jalr $a2
addi, $sp, $sp, 4
sw $s0, 4($sp)

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,12
jr $ra

function_print_V_at_Graph:
addi, $sp, $sp, -12
sw $ra, ($sp)
lw $t3, 12($sp) #getting instance self 

lw, $t3, 12($sp) #getting instance self 
lw, $t1, 4($t3)  #getting offset vertices 
sw, $t1, 8($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 8($t0)
sw, $s0 0($sp)
lw $a0, 8($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 56($a1)#Function print:function_print_at_VList
jalr $a2
addi, $sp, $sp, 4
sw $s0, 4($sp)

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,12
jr $ra

init_Vertice:
addi, $sp, $sp, -20
sw $ra, ($sp)

addi, $t1, $zero, 0
sw, $t1, 4($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 8($sp)
lw $s4,8($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 8($t0) #loading param_local_ice_internal_1
sw, $s0 0($sp) #setting param for function call
lw, $s0, 4($t0) #loading param_local_ice_internal_0
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 8($sp) #Saving result on local_ice_internal_1

lw, $t1, 8($sp)   
lw, $t3, 20($sp)  
sw, $t1, 4($t3)   

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,EList_methods
sw $t1, ($t3)
sw, $t3, 12($sp)
lw $s4,12($sp)
move $t0, $sp #call to function init_EList
addi, $sp, $sp, -4
lw, $s0, 12($t0) #loading param_local_ice_internal_2
sw, $s0 0($sp) #setting param for function call
jal init_EList
addi, $sp, $sp, 4
sw $s0, 16($sp) #Saving result on local_ice_internal_3

lw, $t1, 12($sp)   
lw, $t3, 20($sp)  
sw, $t1, 8($t3)   

lw $s0, 20($sp)
lw $ra, ($sp)
addi $sp, $sp,20
jr $ra

function_outgoing_at_Vertice:
addi, $sp, $sp, -8
sw $ra, ($sp)
lw $t3, 8($sp) #getting instance self 

lw, $t3, 8($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset out 
sw, $t1, 4($sp)   

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,8
jr $ra

function_number_at_Vertice:
addi, $sp, $sp, -8
sw $ra, ($sp)
lw $t3, 8($sp) #getting instance self 

lw, $t3, 8($sp) #getting instance self 
lw, $t1, 4($t3)  #getting offset num 
sw, $t1, 4($sp)   

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,8
jr $ra

function_init_at_Vertice:
addi, $sp, $sp, -8
sw $ra, ($sp)

lw, $t1, 12($sp)   
lw, $t3, 8($sp)  
sw, $t1, 4($t3)   
lw $t3, 8($sp) #getting instance self 
sw $t3, 4($sp)

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,8
jr $ra

function_add_out_at_Vertice:
addi, $sp, $sp, -16
sw $ra, ($sp)
lw $t3, 16($sp) #getting instance self 

lw, $t3, 16($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset out 
sw, $t1, 8($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -8
lw, $s0, 8($t0)
sw, $s0 0($sp)
lw, $s0, 20($t0)
sw, $s0 4($sp)
lw $a0, 8($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 52($a1)#Function cons:function_cons_at_EList
jalr $a2
addi, $sp, $sp, 8
sw $s0, 4($sp)

lw, $t1, 4($sp)   
lw, $t3, 16($sp)  
sw, $t1, 8($t3)   
lw $t3, 16($sp) #getting instance self 
sw $t3, 12($sp)

lw $s0, 12($sp)
lw $ra, ($sp)
addi $sp, $sp,16
jr $ra

function_print_at_Vertice:
addi, $sp, $sp, -20
sw $ra, ($sp)
lw $t3, 20($sp) #getting instance self 

lw, $t3, 20($sp) #getting instance self 
lw, $t1, 4($t3)  #getting offset num 
sw, $t1, 8($sp)   
lw $s4,20($sp)
move $t0, $sp #call to function out_int
addi, $sp, $sp, -8
lw, $s0, 20($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 8($t0) #loading param_local_print_at_Vertice_internal_1
sw, $s0 4($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 28 ($a1)
jalr $a2
addi, $sp, $sp, 8
sw $s0, 4($sp) #Saving result on local_print_at_Vertice_internal_0
lw $t3, 20($sp) #getting instance self 

lw, $t3, 20($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset out 
sw, $t1, 16($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 16($t0)
sw, $s0 0($sp)
lw $a0, 16($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 60($a1)#Function print:function_print_at_EList
jalr $a2
addi, $sp, $sp, 4
sw $s0, 12($sp)

lw $s0, 12($sp)
lw $ra, ($sp)
addi $sp, $sp,20
jr $ra

init_Edge:
addi, $sp, $sp, -28
sw $ra, ($sp)

addi, $t1, $zero, 0
sw, $t1, 4($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 8($sp)
lw $s4,8($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 8($t0) #loading param_local__internal_1
sw, $s0 0($sp) #setting param for function call
lw, $s0, 4($t0) #loading param_local__internal_0
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 8($sp) #Saving result on local__internal_1

lw, $t1, 8($sp)   
lw, $t3, 28($sp)  
sw, $t1, 4($t3)   

addi, $t1, $zero, 0
sw, $t1, 12($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 16($sp)
lw $s4,16($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 16($t0) #loading param_local__internal_3
sw, $s0 0($sp) #setting param for function call
lw, $s0, 12($t0) #loading param_local__internal_2
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 16($sp) #Saving result on local__internal_3

lw, $t1, 16($sp)   
lw, $t3, 28($sp)  
sw, $t1, 8($t3)   

addi, $t1, $zero, 0
sw, $t1, 20($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 24($sp)
lw $s4,24($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 24($t0) #loading param_local__internal_5
sw, $s0 0($sp) #setting param for function call
lw, $s0, 20($t0) #loading param_local__internal_4
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 24($sp) #Saving result on local__internal_5

lw, $t1, 24($sp)   
lw, $t3, 28($sp)  
sw, $t1, 12($t3)   

lw $s0, 28($sp)
lw $ra, ($sp)
addi $sp, $sp,28
jr $ra

function_init_at_Edge:
addi, $sp, $sp, -8
sw $ra, ($sp)

lw, $t1, 12($sp)   
lw, $t3, 8($sp)  
sw, $t1, 4($t3)   

lw, $t1, 16($sp)   
lw, $t3, 8($sp)  
sw, $t1, 8($t3)   

lw, $t1, 20($sp)   
lw, $t3, 8($sp)  
sw, $t1, 12($t3)   
lw $t3, 8($sp) #getting instance self 
sw $t3, 4($sp)

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,8
jr $ra

function_print_at_Edge:
addi, $sp, $sp, -88
sw $ra, ($sp)

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 12($sp)

la $t1, data_0
sw $t1, 16($sp)
lw $s4,16($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 16($t0) #loading param_local_print_at_Edge_internal_3
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 20($sp) #Saving result on local_print_at_Edge_internal_4
lw $s4,12($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 12($t0) #loading param_local_print_at_Edge_internal_2
sw, $s0 0($sp) #setting param for function call
lw, $s0, 16($t0) #loading param_local_print_at_Edge_internal_3
sw, $s0 4($sp) #setting param for function call
lw, $s0, 20($t0) #loading param_local_print_at_Edge_internal_4
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 8($sp) #Saving result on local_print_at_Edge_internal_1
lw $s4,88($sp)
move $t0, $sp #call to function out_string
addi, $sp, $sp, -8
lw, $s0, 88($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 12($t0) #loading param_local_print_at_Edge_internal_2
sw, $s0 4($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 24 ($a1)
jalr $a2
addi, $sp, $sp, 8
sw $s0, 4($sp) #Saving result on local_print_at_Edge_internal_0
lw $t3, 88($sp) #getting instance self 

lw, $t3, 88($sp) #getting instance self 
lw, $t1, 4($t3)  #getting offset from 
sw, $t1, 28($sp)   
lw $s4,88($sp)
move $t0, $sp #call to function out_int
addi, $sp, $sp, -8
lw, $s0, 88($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 28($t0) #loading param_local_print_at_Edge_internal_6
sw, $s0 4($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 28 ($a1)
jalr $a2
addi, $sp, $sp, 8
sw $s0, 24($sp) #Saving result on local_print_at_Edge_internal_5

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 40($sp)

la $t1, data_1
sw $t1, 44($sp)
lw $s4,44($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 44($t0) #loading param_local_print_at_Edge_internal_10
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 48($sp) #Saving result on local_print_at_Edge_internal_11
lw $s4,40($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 40($t0) #loading param_local_print_at_Edge_internal_9
sw, $s0 0($sp) #setting param for function call
lw, $s0, 44($t0) #loading param_local_print_at_Edge_internal_10
sw, $s0 4($sp) #setting param for function call
lw, $s0, 48($t0) #loading param_local_print_at_Edge_internal_11
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 36($sp) #Saving result on local_print_at_Edge_internal_8
lw $s4,88($sp)
move $t0, $sp #call to function out_string
addi, $sp, $sp, -8
lw, $s0, 88($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 40($t0) #loading param_local_print_at_Edge_internal_9
sw, $s0 4($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 24 ($a1)
jalr $a2
addi, $sp, $sp, 8
sw $s0, 32($sp) #Saving result on local_print_at_Edge_internal_7
lw $t3, 88($sp) #getting instance self 

lw, $t3, 88($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset to 
sw, $t1, 56($sp)   
lw $s4,88($sp)
move $t0, $sp #call to function out_int
addi, $sp, $sp, -8
lw, $s0, 88($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 56($t0) #loading param_local_print_at_Edge_internal_13
sw, $s0 4($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 28 ($a1)
jalr $a2
addi, $sp, $sp, 8
sw $s0, 52($sp) #Saving result on local_print_at_Edge_internal_12

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 68($sp)

la $t1, data_2
sw $t1, 72($sp)
lw $s4,72($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 72($t0) #loading param_local_print_at_Edge_internal_17
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 76($sp) #Saving result on local_print_at_Edge_internal_18
lw $s4,68($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 68($t0) #loading param_local_print_at_Edge_internal_16
sw, $s0 0($sp) #setting param for function call
lw, $s0, 72($t0) #loading param_local_print_at_Edge_internal_17
sw, $s0 4($sp) #setting param for function call
lw, $s0, 76($t0) #loading param_local_print_at_Edge_internal_18
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 64($sp) #Saving result on local_print_at_Edge_internal_15
lw $s4,88($sp)
move $t0, $sp #call to function out_string
addi, $sp, $sp, -8
lw, $s0, 88($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 68($t0) #loading param_local_print_at_Edge_internal_16
sw, $s0 4($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 24 ($a1)
jalr $a2
addi, $sp, $sp, 8
sw $s0, 60($sp) #Saving result on local_print_at_Edge_internal_14
lw $t3, 88($sp) #getting instance self 

lw, $t3, 88($sp) #getting instance self 
lw, $t1, 12($t3)  #getting offset weight 
sw, $t1, 84($sp)   
lw $s4,88($sp)
move $t0, $sp #call to function out_int
addi, $sp, $sp, -8
lw, $s0, 88($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 84($t0) #loading param_local_print_at_Edge_internal_20
sw, $s0 4($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 28 ($a1)
jalr $a2
addi, $sp, $sp, 8
sw $s0, 80($sp) #Saving result on local_print_at_Edge_internal_19

lw $s0, 80($sp)
lw $ra, ($sp)
addi $sp, $sp,88
jr $ra

init_EList:
addi, $sp, $sp, -8
sw $ra, ($sp)

la $t1, void_data
sw $t1, 4($sp)

lw, $t1, 4($sp)   
lw, $t3, 8($sp)  
sw, $t1, 4($t3)   

lw $s0, 8($sp)
lw $ra, ($sp)
addi $sp, $sp,8
jr $ra

function_isNil_at_EList:
addi, $sp, $sp, -12
sw $ra, ($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 8($sp)

addi, $t1, $zero, 1
sw, $t1, 4($sp)
lw $s4,8($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 8($t0) #loading param_local_isNil_at_EList_internal_1
sw, $s0 0($sp) #setting param for function call
lw, $s0, 4($t0) #loading param_local_isNil_at_EList_internal_0
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 8($sp) #Saving result on local_isNil_at_EList_internal_1

lw $s0, 8($sp)
lw $ra, ($sp)
addi $sp, $sp,12
jr $ra

function_head_at_EList:
addi, $sp, $sp, -12
sw $ra, ($sp)
lw $s4,12($sp)
move $t0, $sp #call to function abort
addi, $sp, $sp, -4
lw, $s0, 12($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 12 ($a1)
jalr $a2
addi, $sp, $sp, 4
sw $s0, 4($sp) #Saving result on local_head_at_EList_internal_0
lw $t3, 12($sp) #getting instance self 

lw, $t3, 12($sp) #getting instance self 
lw, $t1, 4($t3)  #getting offset car 
sw, $t1, 8($sp)   

lw $s0, 8($sp)
lw $ra, ($sp)
addi $sp, $sp,12
jr $ra

function_tail_at_EList:
addi, $sp, $sp, -12
sw $ra, ($sp)
lw $s4,12($sp)
move $t0, $sp #call to function abort
addi, $sp, $sp, -4
lw, $s0, 12($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 12 ($a1)
jalr $a2
addi, $sp, $sp, 4
sw $s0, 4($sp) #Saving result on local_tail_at_EList_internal_0
lw $t3, 12($sp) #getting instance self 
sw $t3, 8($sp)

lw $s0, 8($sp)
lw $ra, ($sp)
addi $sp, $sp,12
jr $ra

function_cons_at_EList:
addi, $sp, $sp, -20
sw $ra, ($sp)
lw $t3, 20($sp) #getting instance self 
sw $t3, 8($sp)

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,ECons_methods
sw $t1, ($t3)
sw, $t3, 12($sp)
lw $s4,12($sp)
move $t0, $sp #call to function init_ECons
addi, $sp, $sp, -4
lw, $s0, 12($t0) #loading param_local_cons_at_EList_internal_2
sw, $s0 0($sp) #setting param for function call
jal init_ECons
addi, $sp, $sp, 4
sw $s0, 16($sp) #Saving result on local_cons_at_EList_internal_3
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -12
lw, $s0, 12($t0)
sw, $s0 0($sp)
lw, $s0, 24($t0)
sw, $s0 4($sp)
lw, $s0, 8($t0)
sw, $s0 8($sp)
lw $a0, 12($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 64($a1)#Function init:function_init_at_ECons
jalr $a2
addi, $sp, $sp, 12
sw $s0, 4($sp)

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,20
jr $ra

function_append_at_EList:
addi, $sp, $sp, -28
sw $ra, ($sp)
lw $s4,28($sp)
move $t0, $sp #call to function isNil
addi, $sp, $sp, -4
lw, $s0, 28($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 40 ($a1)
jalr $a2
addi, $sp, $sp, 4
sw $s0, 8($sp) #Saving result on local_append_at_EList_internal_1
lw $t0, 8($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label1
lw $s4,28($sp)
move $t0, $sp #call to function head
addi, $sp, $sp, -4
lw, $s0, 28($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 44 ($a1)
jalr $a2
addi, $sp, $sp, 4
sw $s0, 16($sp) #Saving result on local_append_at_EList_internal_3
lw $s4,28($sp)
move $t0, $sp #call to function tail
addi, $sp, $sp, -4
lw, $s0, 28($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 48 ($a1)
jalr $a2
addi, $sp, $sp, 4
sw $s0, 24($sp) #Saving result on local_append_at_EList_internal_5
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -8
lw, $s0, 24($t0)
sw, $s0 0($sp)
lw, $s0, 32($t0)
sw, $s0 4($sp)
lw $a0, 24($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 56($a1)#Function append:function_append_at_EList
jalr $a2
addi, $sp, $sp, 8
sw $s0, 20($sp)
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -8
lw, $s0, 20($t0)
sw, $s0 0($sp)
lw, $s0, 16($t0)
sw, $s0 4($sp)
lw $a0, 20($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 52($a1)#Function cons:function_cons_at_EList
jalr $a2
addi, $sp, $sp, 8
sw $s0, 12($sp)
lw $t1, 12($sp)
sw $t1, 4($sp)
j label2
label1:
lw $t1, 32($sp)
sw $t1, 4($sp)
label2:

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,28
jr $ra

function_print_at_EList:
addi, $sp, $sp, -24
sw $ra, ($sp)

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 12($sp)

la $t1, data_3
sw $t1, 16($sp)
lw $s4,16($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 16($t0) #loading param_local_print_at_EList_internal_3
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 20($sp) #Saving result on local_print_at_EList_internal_4
lw $s4,12($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 12($t0) #loading param_local_print_at_EList_internal_2
sw, $s0 0($sp) #setting param for function call
lw, $s0, 16($t0) #loading param_local_print_at_EList_internal_3
sw, $s0 4($sp) #setting param for function call
lw, $s0, 20($t0) #loading param_local_print_at_EList_internal_4
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 8($sp) #Saving result on local_print_at_EList_internal_1
lw $s4,24($sp)
move $t0, $sp #call to function out_string
addi, $sp, $sp, -8
lw, $s0, 24($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 12($t0) #loading param_local_print_at_EList_internal_2
sw, $s0 4($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 24 ($a1)
jalr $a2
addi, $sp, $sp, 8
sw $s0, 4($sp) #Saving result on local_print_at_EList_internal_0

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,24
jr $ra

init_VList:
addi, $sp, $sp, -8
sw $ra, ($sp)

la $t1, void_data
sw $t1, 4($sp)

lw, $t1, 4($sp)   
lw, $t3, 8($sp)  
sw, $t1, 4($t3)   

lw $s0, 8($sp)
lw $ra, ($sp)
addi $sp, $sp,8
jr $ra

function_isNil_at_VList:
addi, $sp, $sp, -12
sw $ra, ($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 8($sp)

addi, $t1, $zero, 1
sw, $t1, 4($sp)
lw $s4,8($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 8($t0) #loading param_local_isNil_at_VList_internal_1
sw, $s0 0($sp) #setting param for function call
lw, $s0, 4($t0) #loading param_local_isNil_at_VList_internal_0
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 8($sp) #Saving result on local_isNil_at_VList_internal_1

lw $s0, 8($sp)
lw $ra, ($sp)
addi $sp, $sp,12
jr $ra

function_head_at_VList:
addi, $sp, $sp, -12
sw $ra, ($sp)
lw $s4,12($sp)
move $t0, $sp #call to function abort
addi, $sp, $sp, -4
lw, $s0, 12($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 12 ($a1)
jalr $a2
addi, $sp, $sp, 4
sw $s0, 4($sp) #Saving result on local_head_at_VList_internal_0
lw $t3, 12($sp) #getting instance self 

lw, $t3, 12($sp) #getting instance self 
lw, $t1, 4($t3)  #getting offset car 
sw, $t1, 8($sp)   

lw $s0, 8($sp)
lw $ra, ($sp)
addi $sp, $sp,12
jr $ra

function_tail_at_VList:
addi, $sp, $sp, -12
sw $ra, ($sp)
lw $s4,12($sp)
move $t0, $sp #call to function abort
addi, $sp, $sp, -4
lw, $s0, 12($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 12 ($a1)
jalr $a2
addi, $sp, $sp, 4
sw $s0, 4($sp) #Saving result on local_tail_at_VList_internal_0
lw $t3, 12($sp) #getting instance self 
sw $t3, 8($sp)

lw $s0, 8($sp)
lw $ra, ($sp)
addi $sp, $sp,12
jr $ra

function_cons_at_VList:
addi, $sp, $sp, -20
sw $ra, ($sp)
lw $t3, 20($sp) #getting instance self 
sw $t3, 8($sp)

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,VCons_methods
sw $t1, ($t3)
sw, $t3, 12($sp)
lw $s4,12($sp)
move $t0, $sp #call to function init_VCons
addi, $sp, $sp, -4
lw, $s0, 12($t0) #loading param_local_cons_at_VList_internal_2
sw, $s0 0($sp) #setting param for function call
jal init_VCons
addi, $sp, $sp, 4
sw $s0, 16($sp) #Saving result on local_cons_at_VList_internal_3
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -12
lw, $s0, 12($t0)
sw, $s0 0($sp)
lw, $s0, 24($t0)
sw, $s0 4($sp)
lw, $s0, 8($t0)
sw, $s0 8($sp)
lw $a0, 12($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 60($a1)#Function init:function_init_at_VCons
jalr $a2
addi, $sp, $sp, 12
sw $s0, 4($sp)

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,20
jr $ra

function_print_at_VList:
addi, $sp, $sp, -24
sw $ra, ($sp)

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 12($sp)

la $t1, data_4
sw $t1, 16($sp)
lw $s4,16($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 16($t0) #loading param_local_print_at_VList_internal_3
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 20($sp) #Saving result on local_print_at_VList_internal_4
lw $s4,12($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 12($t0) #loading param_local_print_at_VList_internal_2
sw, $s0 0($sp) #setting param for function call
lw, $s0, 16($t0) #loading param_local_print_at_VList_internal_3
sw, $s0 4($sp) #setting param for function call
lw, $s0, 20($t0) #loading param_local_print_at_VList_internal_4
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 8($sp) #Saving result on local_print_at_VList_internal_1
lw $s4,24($sp)
move $t0, $sp #call to function out_string
addi, $sp, $sp, -8
lw, $s0, 24($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 12($t0) #loading param_local_print_at_VList_internal_2
sw, $s0 4($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 24 ($a1)
jalr $a2
addi, $sp, $sp, 8
sw $s0, 4($sp) #Saving result on local_print_at_VList_internal_0

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,24
jr $ra

init_Parse:
addi, $sp, $sp, -24
sw $ra, ($sp)

addi $a0, $zero, 4
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,BoolOp_methods
sw $t1, ($t3)
sw, $t3, 4($sp)
lw $s4,4($sp)
move $t0, $sp #call to function init_BoolOp
addi, $sp, $sp, -4
lw, $s0, 4($t0) #loading param_local_e_internal_0
sw, $s0 0($sp) #setting param for function call
jal init_BoolOp
addi, $sp, $sp, 4
sw $s0, 8($sp) #Saving result on local_e_internal_1

lw, $t1, 4($sp)   
lw, $t3, 24($sp)  
sw, $t1, 4($t3)   

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 12($sp)

la $t1, empty_str_data
sw $t1, 16($sp)

addi, $t1, $zero, 0
sw, $t1, 20($sp)
lw $s4,12($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 12($t0) #loading param_local_e_internal_2
sw, $s0 0($sp) #setting param for function call
lw, $s0, 16($t0) #loading param_local_e_internal_3
sw, $s0 4($sp) #setting param for function call
lw, $s0, 20($t0) #loading param_local_e_internal_4
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 12($sp) #Saving result on local_e_internal_2

lw, $t1, 12($sp)   
lw, $t3, 24($sp)  
sw, $t1, 8($t3)   

lw $s0, 24($sp)
lw $ra, ($sp)
addi $sp, $sp,24
jr $ra

function_read_input_at_Parse:
addi, $sp, $sp, -132
sw $ra, ($sp)

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Graph_methods
sw $t1, ($t3)
sw, $t3, 4($sp)
lw $s4,4($sp)
move $t0, $sp #call to function init_Graph
addi, $sp, $sp, -4
lw, $s0, 4($t0) #loading param_local_read_input_at_Parse_internal_0
sw, $s0 0($sp) #setting param for function call
jal init_Graph
addi, $sp, $sp, 4
sw $s0, 8($sp) #Saving result on local_read_input_at_Parse_internal_1
lw $t1, 4($sp)
sw $t1, 12($sp)
lw $s4,132($sp)
move $t0, $sp #call to function in_string
addi, $sp, $sp, -4
lw, $s0, 132($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 32 ($a1)
jalr $a2
addi, $sp, $sp, 4
sw $s0, 16($sp) #Saving result on local_read_input_at_Parse_internal_3
lw $t1, 16($sp)
sw $t1, 20($sp)
label3:

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 56($sp)

la $t1, data_5
sw $t1, 60($sp)
lw $s4,60($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 60($t0) #loading param_local_read_input_at_Parse_internal_14
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 64($sp) #Saving result on local_read_input_at_Parse_internal_15
lw $s4,56($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 56($t0) #loading param_local_read_input_at_Parse_internal_13
sw, $s0 0($sp) #setting param for function call
lw, $s0, 60($t0) #loading param_local_read_input_at_Parse_internal_14
sw, $s0 4($sp) #setting param for function call
lw, $s0, 64($t0) #loading param_local_read_input_at_Parse_internal_15
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 52($sp) #Saving result on local_read_input_at_Parse_internal_12

lw, $t3, 56($sp)
lw,$t1,4($t3) #Load String Adress Node
lw $a1,8($t3)
lw, $t3, 20($sp)
lw,$t2,4($t3)
lw $a2,8($t3)
jal String_comparison_fun
sw, $t3, 40($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 44($sp)
lw $s4,44($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 44($t0) #loading param_local_read_input_at_Parse_internal_10
sw, $s0 0($sp) #setting param for function call
lw, $s0, 40($t0) #loading param_local_read_input_at_Parse_internal_9
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 44($sp) #Saving result on local_read_input_at_Parse_internal_10

lw, $t3, 44($sp)
lw,$t1,4($t3) #Load Not Node
xor $t3,$t1,1
sw, $t3, 32($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 36($sp)
lw $s4,36($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 36($t0) #loading param_local_read_input_at_Parse_internal_8
sw, $s0 0($sp) #setting param for function call
lw, $s0, 32($t0) #loading param_local_read_input_at_Parse_internal_7
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 36($sp) #Saving result on local_read_input_at_Parse_internal_8

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 92($sp)

la $t1, data_6
sw $t1, 96($sp)
lw $s4,96($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 96($t0) #loading param_local_read_input_at_Parse_internal_23
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 100($sp) #Saving result on local_read_input_at_Parse_internal_24
lw $s4,92($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 92($t0) #loading param_local_read_input_at_Parse_internal_22
sw, $s0 0($sp) #setting param for function call
lw, $s0, 96($t0) #loading param_local_read_input_at_Parse_internal_23
sw, $s0 4($sp) #setting param for function call
lw, $s0, 100($t0) #loading param_local_read_input_at_Parse_internal_24
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 88($sp) #Saving result on local_read_input_at_Parse_internal_21

lw, $t3, 92($sp)
lw,$t1,4($t3) #Load String Adress Node
lw $a1,8($t3)
lw, $t3, 20($sp)
lw,$t2,4($t3)
lw $a2,8($t3)
jal String_comparison_fun
sw, $t3, 76($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 80($sp)
lw $s4,80($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 80($t0) #loading param_local_read_input_at_Parse_internal_19
sw, $s0 0($sp) #setting param for function call
lw, $s0, 76($t0) #loading param_local_read_input_at_Parse_internal_18
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 80($sp) #Saving result on local_read_input_at_Parse_internal_19

lw, $t3, 80($sp)
lw,$t1,4($t3) #Load Not Node
xor $t3,$t1,1
sw, $t3, 68($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 72($sp)
lw $s4,72($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 72($t0) #loading param_local_read_input_at_Parse_internal_17
sw, $s0 0($sp) #setting param for function call
lw, $s0, 68($t0) #loading param_local_read_input_at_Parse_internal_16
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 72($sp) #Saving result on local_read_input_at_Parse_internal_17
lw $t3, 132($sp) #getting instance self 

lw, $t3, 132($sp) #getting instance self 
lw, $t1, 4($t3)  #getting offset boolop 
sw, $t1, 104($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -12
lw, $s0, 104($t0)
sw, $s0 0($sp)
lw, $s0, 36($t0)
sw, $s0 4($sp)
lw, $s0, 72($t0)
sw, $s0 8($sp)
lw $a0, 104($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 24($a1)#Function and:function_and_at_BoolOp
jalr $a2
addi, $sp, $sp, 12
sw $s0, 28($sp)
lw $t0, 28($sp) #If Label
lw $t0, 4($t0)
beqz $t0 label4
lw $s4,132($sp)
move $t0, $sp #call to function parse_line
addi, $sp, $sp, -8
lw, $s0, 132($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 20($t0) #loading param_local_read_input_at_Parse_line_4
sw, $s0 4($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 44 ($a1)
jalr $a2
addi, $sp, $sp, 8
sw $s0, 112($sp) #Saving result on local_read_input_at_Parse_internal_27
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -8
lw, $s0, 12($t0)
sw, $s0 0($sp)
lw, $s0, 112($t0)
sw, $s0 4($sp)
lw $a0, 12($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 24($a1)#Function add_vertice:function_add_vertice_at_Graph
jalr $a2
addi, $sp, $sp, 8
sw $s0, 108($sp)
lw $s4,132($sp)
move $t0, $sp #call to function in_string
addi, $sp, $sp, -4
lw, $s0, 132($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 32 ($a1)
jalr $a2
addi, $sp, $sp, 4
sw $s0, 124($sp) #Saving result on local_read_input_at_Parse_internal_30
lw $t1, 124($sp)
sw $t1, 20($sp)
j label3
label4:

la $t1, void_data
sw $t1, 24($sp)

lw $s0, 12($sp)
lw $ra, ($sp)
addi $sp, $sp,132
jr $ra

function_parse_line_at_Parse:
addi, $sp, $sp, -124
sw $ra, ($sp)
lw $s4,124($sp)
move $t0, $sp #call to function a2i
addi, $sp, $sp, -8
lw, $s0, 124($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 128($t0) #loading param_param_s
sw, $s0 4($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 52 ($a1)
jalr $a2
addi, $sp, $sp, 8
sw $s0, 8($sp) #Saving result on local_parse_line_at_Parse_internal_1

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Vertice_methods
sw $t1, ($t3)
sw, $t3, 12($sp)
lw $s4,12($sp)
move $t0, $sp #call to function init_Vertice
addi, $sp, $sp, -4
lw, $s0, 12($t0) #loading param_local_parse_line_at_Parse_internal_2
sw, $s0 0($sp) #setting param for function call
jal init_Vertice
addi, $sp, $sp, 4
sw $s0, 16($sp) #Saving result on local_parse_line_at_Parse_internal_3
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -8
lw, $s0, 12($t0)
sw, $s0 0($sp)
lw, $s0, 8($t0)
sw, $s0 4($sp)
lw $a0, 12($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 48($a1)#Function init:function_init_at_Vertice
jalr $a2
addi, $sp, $sp, 8
sw $s0, 4($sp)
lw $t1, 4($sp)
sw $t1, 20($sp)
label5:
lw $t3, 124($sp) #getting instance self 

lw, $t3, 124($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset rest 
sw, $t1, 48($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 48($t0)
sw, $s0 0($sp)
lw $a0, 48($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 24($a1)#Function length:function_length_at_String
jalr $a2
addi, $sp, $sp, 4
sw $s0, 44($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 56($sp)

addi, $t1, $zero, 0
sw, $t1, 52($sp)
lw $s4,56($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 56($t0) #loading param_local_parse_line_at_Parse_internal_13
sw, $s0 0($sp) #setting param for function call
lw, $s0, 52($t0) #loading param_local_parse_line_at_Parse_internal_12
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 56($sp) #Saving result on local_parse_line_at_Parse_internal_13

lw, $t3, 56($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 44($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 36($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 40($sp)
lw $s4,40($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 40($t0) #loading param_local_parse_line_at_Parse_internal_9
sw, $s0 0($sp) #setting param for function call
lw, $s0, 36($t0) #loading param_local_parse_line_at_Parse_internal_8
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 40($sp) #Saving result on local_parse_line_at_Parse_internal_9

lw, $t3, 40($sp)
lw,$t1,4($t3) #Load Not Node
xor $t3,$t1,1
sw, $t3, 28($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 32($sp)
lw $s4,32($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 32($t0) #loading param_local_parse_line_at_Parse_internal_7
sw, $s0 0($sp) #setting param for function call
lw, $s0, 28($t0) #loading param_local_parse_line_at_Parse_internal_6
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 32($sp) #Saving result on local_parse_line_at_Parse_internal_7
lw $t0, 32($sp) #If Label
lw $t0, 4($t0)
beqz $t0 label6
lw $t3, 124($sp) #getting instance self 

lw, $t3, 124($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset rest 
sw, $t1, 64($sp)   
lw $s4,124($sp)
move $t0, $sp #call to function a2i
addi, $sp, $sp, -8
lw, $s0, 124($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 64($t0) #loading param_local_parse_line_at_Parse_internal_15
sw, $s0 4($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 52 ($a1)
jalr $a2
addi, $sp, $sp, 8
sw $s0, 60($sp) #Saving result on local_parse_line_at_Parse_internal_14
lw $t1, 60($sp)
sw $t1, 68($sp)
lw $t3, 124($sp) #getting instance self 

lw, $t3, 124($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset rest 
sw, $t1, 76($sp)   
lw $s4,124($sp)
move $t0, $sp #call to function a2i
addi, $sp, $sp, -8
lw, $s0, 124($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 76($t0) #loading param_local_parse_line_at_Parse_internal_18
sw, $s0 4($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 52 ($a1)
jalr $a2
addi, $sp, $sp, 8
sw $s0, 72($sp) #Saving result on local_parse_line_at_Parse_internal_17
lw $t1, 72($sp)
sw $t1, 80($sp)
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 20($t0)
sw, $s0 0($sp)
lw $a0, 20($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 44($a1)#Function number:function_number_at_Vertice
jalr $a2
addi, $sp, $sp, 4
sw $s0, 92($sp)

addi $a0, $zero, 16
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Edge_methods
sw $t1, ($t3)
sw, $t3, 108($sp)
lw $s4,108($sp)
move $t0, $sp #call to function init_Edge
addi, $sp, $sp, -4
lw, $s0, 108($t0) #loading param_local_parse_line_at_Parse_internal_26
sw, $s0 0($sp) #setting param for function call
jal init_Edge
addi, $sp, $sp, 4
sw $s0, 112($sp) #Saving result on local_parse_line_at_Parse_internal_27
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -16
lw, $s0, 108($t0)
sw, $s0 0($sp)
lw, $s0, 92($t0)
sw, $s0 4($sp)
lw, $s0, 68($t0)
sw, $s0 8($sp)
lw, $s0, 80($t0)
sw, $s0 12($sp)
lw $a0, 108($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 40($a1)#Function init:function_init_at_Edge
jalr $a2
addi, $sp, $sp, 16
sw $s0, 88($sp)
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -8
lw, $s0, 20($t0)
sw, $s0 0($sp)
lw, $s0, 88($t0)
sw, $s0 4($sp)
lw $a0, 20($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 52($a1)#Function add_out:function_add_out_at_Vertice
jalr $a2
addi, $sp, $sp, 8
sw $s0, 84($sp)
j label5
label6:

la $t1, void_data
sw $t1, 24($sp)

lw $s0, 20($sp)
lw $ra, ($sp)
addi $sp, $sp,124
jr $ra

function_c2i_at_Parse:
addi, $sp, $sp, -376
sw $ra, ($sp)

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 20($sp)

la $t1, data_7
sw $t1, 24($sp)
lw $s4,24($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 24($t0) #loading param_local_c2i_at_Parse_internal_5
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 28($sp) #Saving result on local_c2i_at_Parse_internal_6
lw $s4,20($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 20($t0) #loading param_local_c2i_at_Parse_internal_4
sw, $s0 0($sp) #setting param for function call
lw, $s0, 24($t0) #loading param_local_c2i_at_Parse_internal_5
sw, $s0 4($sp) #setting param for function call
lw, $s0, 28($t0) #loading param_local_c2i_at_Parse_internal_6
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 16($sp) #Saving result on local_c2i_at_Parse_internal_3

lw, $t3, 20($sp)
lw,$t1,4($t3) #Load String Adress Node
lw $a1,8($t3)
lw, $t3, 380($sp)
lw,$t2,4($t3)
lw $a2,8($t3)
jal String_comparison_fun
sw, $t3, 8($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 12($sp)
lw $s4,12($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 12($t0) #loading param_local_c2i_at_Parse_internal_2
sw, $s0 0($sp) #setting param for function call
lw, $s0, 8($t0) #loading param_local_c2i_at_Parse_internal_1
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 12($sp) #Saving result on local_c2i_at_Parse_internal_2
lw $t0, 12($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label7

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 48($sp)

la $t1, data_8
sw $t1, 52($sp)
lw $s4,52($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 52($t0) #loading param_local_c2i_at_Parse_internal_12
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 56($sp) #Saving result on local_c2i_at_Parse_internal_13
lw $s4,48($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 48($t0) #loading param_local_c2i_at_Parse_internal_11
sw, $s0 0($sp) #setting param for function call
lw, $s0, 52($t0) #loading param_local_c2i_at_Parse_internal_12
sw, $s0 4($sp) #setting param for function call
lw, $s0, 56($t0) #loading param_local_c2i_at_Parse_internal_13
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 44($sp) #Saving result on local_c2i_at_Parse_internal_10

lw, $t3, 48($sp)
lw,$t1,4($t3) #Load String Adress Node
lw $a1,8($t3)
lw, $t3, 380($sp)
lw,$t2,4($t3)
lw $a2,8($t3)
jal String_comparison_fun
sw, $t3, 36($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 40($sp)
lw $s4,40($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 40($t0) #loading param_local_c2i_at_Parse_internal_9
sw, $s0 0($sp) #setting param for function call
lw, $s0, 36($t0) #loading param_local_c2i_at_Parse_internal_8
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 40($sp) #Saving result on local_c2i_at_Parse_internal_9
lw $t0, 40($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label9

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 76($sp)

la $t1, data_9
sw $t1, 80($sp)
lw $s4,80($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 80($t0) #loading param_local_c2i_at_Parse_internal_19
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 84($sp) #Saving result on local_c2i_at_Parse_internal_20
lw $s4,76($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 76($t0) #loading param_local_c2i_at_Parse_internal_18
sw, $s0 0($sp) #setting param for function call
lw, $s0, 80($t0) #loading param_local_c2i_at_Parse_internal_19
sw, $s0 4($sp) #setting param for function call
lw, $s0, 84($t0) #loading param_local_c2i_at_Parse_internal_20
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 72($sp) #Saving result on local_c2i_at_Parse_internal_17

lw, $t3, 76($sp)
lw,$t1,4($t3) #Load String Adress Node
lw $a1,8($t3)
lw, $t3, 380($sp)
lw,$t2,4($t3)
lw $a2,8($t3)
jal String_comparison_fun
sw, $t3, 64($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 68($sp)
lw $s4,68($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 68($t0) #loading param_local_c2i_at_Parse_internal_16
sw, $s0 0($sp) #setting param for function call
lw, $s0, 64($t0) #loading param_local_c2i_at_Parse_internal_15
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 68($sp) #Saving result on local_c2i_at_Parse_internal_16
lw $t0, 68($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label11

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 104($sp)

la $t1, data_10
sw $t1, 108($sp)
lw $s4,108($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 108($t0) #loading param_local_c2i_at_Parse_internal_26
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 112($sp) #Saving result on local_c2i_at_Parse_internal_27
lw $s4,104($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 104($t0) #loading param_local_c2i_at_Parse_internal_25
sw, $s0 0($sp) #setting param for function call
lw, $s0, 108($t0) #loading param_local_c2i_at_Parse_internal_26
sw, $s0 4($sp) #setting param for function call
lw, $s0, 112($t0) #loading param_local_c2i_at_Parse_internal_27
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 100($sp) #Saving result on local_c2i_at_Parse_internal_24

lw, $t3, 104($sp)
lw,$t1,4($t3) #Load String Adress Node
lw $a1,8($t3)
lw, $t3, 380($sp)
lw,$t2,4($t3)
lw $a2,8($t3)
jal String_comparison_fun
sw, $t3, 92($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 96($sp)
lw $s4,96($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 96($t0) #loading param_local_c2i_at_Parse_internal_23
sw, $s0 0($sp) #setting param for function call
lw, $s0, 92($t0) #loading param_local_c2i_at_Parse_internal_22
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 96($sp) #Saving result on local_c2i_at_Parse_internal_23
lw $t0, 96($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label13

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 132($sp)

la $t1, data_11
sw $t1, 136($sp)
lw $s4,136($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 136($t0) #loading param_local_c2i_at_Parse_internal_33
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 140($sp) #Saving result on local_c2i_at_Parse_internal_34
lw $s4,132($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 132($t0) #loading param_local_c2i_at_Parse_internal_32
sw, $s0 0($sp) #setting param for function call
lw, $s0, 136($t0) #loading param_local_c2i_at_Parse_internal_33
sw, $s0 4($sp) #setting param for function call
lw, $s0, 140($t0) #loading param_local_c2i_at_Parse_internal_34
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 128($sp) #Saving result on local_c2i_at_Parse_internal_31

lw, $t3, 132($sp)
lw,$t1,4($t3) #Load String Adress Node
lw $a1,8($t3)
lw, $t3, 380($sp)
lw,$t2,4($t3)
lw $a2,8($t3)
jal String_comparison_fun
sw, $t3, 120($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 124($sp)
lw $s4,124($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 124($t0) #loading param_local_c2i_at_Parse_internal_30
sw, $s0 0($sp) #setting param for function call
lw, $s0, 120($t0) #loading param_local_c2i_at_Parse_internal_29
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 124($sp) #Saving result on local_c2i_at_Parse_internal_30
lw $t0, 124($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label15

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 160($sp)

la $t1, data_12
sw $t1, 164($sp)
lw $s4,164($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 164($t0) #loading param_local_c2i_at_Parse_internal_40
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 168($sp) #Saving result on local_c2i_at_Parse_internal_41
lw $s4,160($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 160($t0) #loading param_local_c2i_at_Parse_internal_39
sw, $s0 0($sp) #setting param for function call
lw, $s0, 164($t0) #loading param_local_c2i_at_Parse_internal_40
sw, $s0 4($sp) #setting param for function call
lw, $s0, 168($t0) #loading param_local_c2i_at_Parse_internal_41
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 156($sp) #Saving result on local_c2i_at_Parse_internal_38

lw, $t3, 160($sp)
lw,$t1,4($t3) #Load String Adress Node
lw $a1,8($t3)
lw, $t3, 380($sp)
lw,$t2,4($t3)
lw $a2,8($t3)
jal String_comparison_fun
sw, $t3, 148($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 152($sp)
lw $s4,152($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 152($t0) #loading param_local_c2i_at_Parse_internal_37
sw, $s0 0($sp) #setting param for function call
lw, $s0, 148($t0) #loading param_local_c2i_at_Parse_internal_36
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 152($sp) #Saving result on local_c2i_at_Parse_internal_37
lw $t0, 152($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label17

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 188($sp)

la $t1, data_13
sw $t1, 192($sp)
lw $s4,192($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 192($t0) #loading param_local_c2i_at_Parse_internal_47
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 196($sp) #Saving result on local_c2i_at_Parse_internal_48
lw $s4,188($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 188($t0) #loading param_local_c2i_at_Parse_internal_46
sw, $s0 0($sp) #setting param for function call
lw, $s0, 192($t0) #loading param_local_c2i_at_Parse_internal_47
sw, $s0 4($sp) #setting param for function call
lw, $s0, 196($t0) #loading param_local_c2i_at_Parse_internal_48
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 184($sp) #Saving result on local_c2i_at_Parse_internal_45

lw, $t3, 188($sp)
lw,$t1,4($t3) #Load String Adress Node
lw $a1,8($t3)
lw, $t3, 380($sp)
lw,$t2,4($t3)
lw $a2,8($t3)
jal String_comparison_fun
sw, $t3, 176($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 180($sp)
lw $s4,180($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 180($t0) #loading param_local_c2i_at_Parse_internal_44
sw, $s0 0($sp) #setting param for function call
lw, $s0, 176($t0) #loading param_local_c2i_at_Parse_internal_43
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 180($sp) #Saving result on local_c2i_at_Parse_internal_44
lw $t0, 180($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label19

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 216($sp)

la $t1, data_14
sw $t1, 220($sp)
lw $s4,220($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 220($t0) #loading param_local_c2i_at_Parse_internal_54
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 224($sp) #Saving result on local_c2i_at_Parse_internal_55
lw $s4,216($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 216($t0) #loading param_local_c2i_at_Parse_internal_53
sw, $s0 0($sp) #setting param for function call
lw, $s0, 220($t0) #loading param_local_c2i_at_Parse_internal_54
sw, $s0 4($sp) #setting param for function call
lw, $s0, 224($t0) #loading param_local_c2i_at_Parse_internal_55
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 212($sp) #Saving result on local_c2i_at_Parse_internal_52

lw, $t3, 216($sp)
lw,$t1,4($t3) #Load String Adress Node
lw $a1,8($t3)
lw, $t3, 380($sp)
lw,$t2,4($t3)
lw $a2,8($t3)
jal String_comparison_fun
sw, $t3, 204($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 208($sp)
lw $s4,208($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 208($t0) #loading param_local_c2i_at_Parse_internal_51
sw, $s0 0($sp) #setting param for function call
lw, $s0, 204($t0) #loading param_local_c2i_at_Parse_internal_50
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 208($sp) #Saving result on local_c2i_at_Parse_internal_51
lw $t0, 208($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label21

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 244($sp)

la $t1, data_15
sw $t1, 248($sp)
lw $s4,248($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 248($t0) #loading param_local_c2i_at_Parse_internal_61
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 252($sp) #Saving result on local_c2i_at_Parse_internal_62
lw $s4,244($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 244($t0) #loading param_local_c2i_at_Parse_internal_60
sw, $s0 0($sp) #setting param for function call
lw, $s0, 248($t0) #loading param_local_c2i_at_Parse_internal_61
sw, $s0 4($sp) #setting param for function call
lw, $s0, 252($t0) #loading param_local_c2i_at_Parse_internal_62
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 240($sp) #Saving result on local_c2i_at_Parse_internal_59

lw, $t3, 244($sp)
lw,$t1,4($t3) #Load String Adress Node
lw $a1,8($t3)
lw, $t3, 380($sp)
lw,$t2,4($t3)
lw $a2,8($t3)
jal String_comparison_fun
sw, $t3, 232($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 236($sp)
lw $s4,236($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 236($t0) #loading param_local_c2i_at_Parse_internal_58
sw, $s0 0($sp) #setting param for function call
lw, $s0, 232($t0) #loading param_local_c2i_at_Parse_internal_57
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 236($sp) #Saving result on local_c2i_at_Parse_internal_58
lw $t0, 236($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label23

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 272($sp)

la $t1, data_16
sw $t1, 276($sp)
lw $s4,276($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 276($t0) #loading param_local_c2i_at_Parse_internal_68
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 280($sp) #Saving result on local_c2i_at_Parse_internal_69
lw $s4,272($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 272($t0) #loading param_local_c2i_at_Parse_internal_67
sw, $s0 0($sp) #setting param for function call
lw, $s0, 276($t0) #loading param_local_c2i_at_Parse_internal_68
sw, $s0 4($sp) #setting param for function call
lw, $s0, 280($t0) #loading param_local_c2i_at_Parse_internal_69
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 268($sp) #Saving result on local_c2i_at_Parse_internal_66

lw, $t3, 272($sp)
lw,$t1,4($t3) #Load String Adress Node
lw $a1,8($t3)
lw, $t3, 380($sp)
lw,$t2,4($t3)
lw $a2,8($t3)
jal String_comparison_fun
sw, $t3, 260($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 264($sp)
lw $s4,264($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 264($t0) #loading param_local_c2i_at_Parse_internal_65
sw, $s0 0($sp) #setting param for function call
lw, $s0, 260($t0) #loading param_local_c2i_at_Parse_internal_64
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 264($sp) #Saving result on local_c2i_at_Parse_internal_65
lw $t0, 264($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label25
lw $s4,376($sp)
move $t0, $sp #call to function abort
addi, $sp, $sp, -4
lw, $s0, 376($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 12 ($a1)
jalr $a2
addi, $sp, $sp, 4
sw $s0, 284($sp) #Saving result on local_c2i_at_Parse_internal_70

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 292($sp)

addi, $t1, $zero, 0
sw, $t1, 288($sp)
lw $s4,292($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 292($t0) #loading param_local_c2i_at_Parse_internal_72
sw, $s0 0($sp) #setting param for function call
lw, $s0, 288($t0) #loading param_local_c2i_at_Parse_internal_71
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 292($sp) #Saving result on local_c2i_at_Parse_internal_72
lw $t1, 292($sp)
sw $t1, 256($sp)
j label26
label25:

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 300($sp)

addi, $t1, $zero, 9
sw, $t1, 296($sp)
lw $s4,300($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 300($t0) #loading param_local_c2i_at_Parse_internal_74
sw, $s0 0($sp) #setting param for function call
lw, $s0, 296($t0) #loading param_local_c2i_at_Parse_internal_73
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 300($sp) #Saving result on local_c2i_at_Parse_internal_74
lw $t1, 300($sp)
sw $t1, 256($sp)
label26:
lw $t1, 256($sp)
sw $t1, 228($sp)
j label24
label23:

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 308($sp)

addi, $t1, $zero, 8
sw, $t1, 304($sp)
lw $s4,308($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 308($t0) #loading param_local_c2i_at_Parse_internal_76
sw, $s0 0($sp) #setting param for function call
lw, $s0, 304($t0) #loading param_local_c2i_at_Parse_internal_75
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 308($sp) #Saving result on local_c2i_at_Parse_internal_76
lw $t1, 308($sp)
sw $t1, 228($sp)
label24:
lw $t1, 228($sp)
sw $t1, 200($sp)
j label22
label21:

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 316($sp)

addi, $t1, $zero, 7
sw, $t1, 312($sp)
lw $s4,316($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 316($t0) #loading param_local_c2i_at_Parse_internal_78
sw, $s0 0($sp) #setting param for function call
lw, $s0, 312($t0) #loading param_local_c2i_at_Parse_internal_77
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 316($sp) #Saving result on local_c2i_at_Parse_internal_78
lw $t1, 316($sp)
sw $t1, 200($sp)
label22:
lw $t1, 200($sp)
sw $t1, 172($sp)
j label20
label19:

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 324($sp)

addi, $t1, $zero, 6
sw, $t1, 320($sp)
lw $s4,324($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 324($t0) #loading param_local_c2i_at_Parse_internal_80
sw, $s0 0($sp) #setting param for function call
lw, $s0, 320($t0) #loading param_local_c2i_at_Parse_internal_79
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 324($sp) #Saving result on local_c2i_at_Parse_internal_80
lw $t1, 324($sp)
sw $t1, 172($sp)
label20:
lw $t1, 172($sp)
sw $t1, 144($sp)
j label18
label17:

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 332($sp)

addi, $t1, $zero, 5
sw, $t1, 328($sp)
lw $s4,332($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 332($t0) #loading param_local_c2i_at_Parse_internal_82
sw, $s0 0($sp) #setting param for function call
lw, $s0, 328($t0) #loading param_local_c2i_at_Parse_internal_81
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 332($sp) #Saving result on local_c2i_at_Parse_internal_82
lw $t1, 332($sp)
sw $t1, 144($sp)
label18:
lw $t1, 144($sp)
sw $t1, 116($sp)
j label16
label15:

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 340($sp)

addi, $t1, $zero, 4
sw, $t1, 336($sp)
lw $s4,340($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 340($t0) #loading param_local_c2i_at_Parse_internal_84
sw, $s0 0($sp) #setting param for function call
lw, $s0, 336($t0) #loading param_local_c2i_at_Parse_internal_83
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 340($sp) #Saving result on local_c2i_at_Parse_internal_84
lw $t1, 340($sp)
sw $t1, 116($sp)
label16:
lw $t1, 116($sp)
sw $t1, 88($sp)
j label14
label13:

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 348($sp)

addi, $t1, $zero, 3
sw, $t1, 344($sp)
lw $s4,348($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 348($t0) #loading param_local_c2i_at_Parse_internal_86
sw, $s0 0($sp) #setting param for function call
lw, $s0, 344($t0) #loading param_local_c2i_at_Parse_internal_85
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 348($sp) #Saving result on local_c2i_at_Parse_internal_86
lw $t1, 348($sp)
sw $t1, 88($sp)
label14:
lw $t1, 88($sp)
sw $t1, 60($sp)
j label12
label11:

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 356($sp)

addi, $t1, $zero, 2
sw, $t1, 352($sp)
lw $s4,356($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 356($t0) #loading param_local_c2i_at_Parse_internal_88
sw, $s0 0($sp) #setting param for function call
lw, $s0, 352($t0) #loading param_local_c2i_at_Parse_internal_87
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 356($sp) #Saving result on local_c2i_at_Parse_internal_88
lw $t1, 356($sp)
sw $t1, 60($sp)
label12:
lw $t1, 60($sp)
sw $t1, 32($sp)
j label10
label9:

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 364($sp)

addi, $t1, $zero, 1
sw, $t1, 360($sp)
lw $s4,364($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 364($t0) #loading param_local_c2i_at_Parse_internal_90
sw, $s0 0($sp) #setting param for function call
lw, $s0, 360($t0) #loading param_local_c2i_at_Parse_internal_89
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 364($sp) #Saving result on local_c2i_at_Parse_internal_90
lw $t1, 364($sp)
sw $t1, 32($sp)
label10:
lw $t1, 32($sp)
sw $t1, 4($sp)
j label8
label7:

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 372($sp)

addi, $t1, $zero, 0
sw, $t1, 368($sp)
lw $s4,372($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 372($t0) #loading param_local_c2i_at_Parse_internal_92
sw, $s0 0($sp) #setting param for function call
lw, $s0, 368($t0) #loading param_local_c2i_at_Parse_internal_91
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 372($sp) #Saving result on local_c2i_at_Parse_internal_92
lw $t1, 372($sp)
sw $t1, 4($sp)
label8:

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,376
jr $ra

function_a2i_at_Parse:
addi, $sp, $sp, -224
sw $ra, ($sp)
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 228($t0)
sw, $s0 0($sp)
lw $a0, 228($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 24($a1)#Function length:function_length_at_String
jalr $a2
addi, $sp, $sp, 4
sw $s0, 16($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 24($sp)

addi, $t1, $zero, 0
sw, $t1, 20($sp)
lw $s4,24($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 24($t0) #loading param_local_a2i_at_Parse_internal_5
sw, $s0 0($sp) #setting param for function call
lw, $s0, 20($t0) #loading param_local_a2i_at_Parse_internal_4
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 24($sp) #Saving result on local_a2i_at_Parse_internal_5

lw, $t3, 24($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 16($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 8($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 12($sp)
lw $s4,12($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 12($t0) #loading param_local_a2i_at_Parse_internal_2
sw, $s0 0($sp) #setting param for function call
lw, $s0, 8($t0) #loading param_local_a2i_at_Parse_internal_1
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 12($sp) #Saving result on local_a2i_at_Parse_internal_2
lw $t0, 12($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label27

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 48($sp)

addi, $t1, $zero, 0
sw, $t1, 44($sp)
lw $s4,48($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 48($t0) #loading param_local_a2i_at_Parse_internal_11
sw, $s0 0($sp) #setting param for function call
lw, $s0, 44($t0) #loading param_local_a2i_at_Parse_internal_10
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 48($sp) #Saving result on local_a2i_at_Parse_internal_11

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 56($sp)

addi, $t1, $zero, 1
sw, $t1, 52($sp)
lw $s4,56($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 56($t0) #loading param_local_a2i_at_Parse_internal_13
sw, $s0 0($sp) #setting param for function call
lw, $s0, 52($t0) #loading param_local_a2i_at_Parse_internal_12
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 56($sp) #Saving result on local_a2i_at_Parse_internal_13
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -12
lw, $s0, 228($t0)
sw, $s0 0($sp)
lw, $s0, 48($t0)
sw, $s0 4($sp)
lw, $s0, 56($t0)
sw, $s0 8($sp)
lw $a0, 228($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 32($a1)#Function substr:function_substr_at_String
jalr $a2
addi, $sp, $sp, 12
sw $s0, 40($sp)

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 64($sp)

la $t1, data_17
sw $t1, 68($sp)
lw $s4,68($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 68($t0) #loading param_local_a2i_at_Parse_internal_16
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 72($sp) #Saving result on local_a2i_at_Parse_internal_17
lw $s4,64($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 64($t0) #loading param_local_a2i_at_Parse_internal_15
sw, $s0 0($sp) #setting param for function call
lw, $s0, 68($t0) #loading param_local_a2i_at_Parse_internal_16
sw, $s0 4($sp) #setting param for function call
lw, $s0, 72($t0) #loading param_local_a2i_at_Parse_internal_17
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 60($sp) #Saving result on local_a2i_at_Parse_internal_14

lw, $t3, 64($sp)
lw,$t1,4($t3) #Load String Adress Node
lw $a1,8($t3)
lw, $t3, 40($sp)
lw,$t2,4($t3)
lw $a2,8($t3)
jal String_comparison_fun
sw, $t3, 32($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 36($sp)
lw $s4,36($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 36($t0) #loading param_local_a2i_at_Parse_internal_8
sw, $s0 0($sp) #setting param for function call
lw, $s0, 32($t0) #loading param_local_a2i_at_Parse_internal_7
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 36($sp) #Saving result on local_a2i_at_Parse_internal_8
lw $t0, 36($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label29

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 96($sp)

addi, $t1, $zero, 0
sw, $t1, 92($sp)
lw $s4,96($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 96($t0) #loading param_local_a2i_at_Parse_internal_23
sw, $s0 0($sp) #setting param for function call
lw, $s0, 92($t0) #loading param_local_a2i_at_Parse_internal_22
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 96($sp) #Saving result on local_a2i_at_Parse_internal_23

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 104($sp)

addi, $t1, $zero, 1
sw, $t1, 100($sp)
lw $s4,104($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 104($t0) #loading param_local_a2i_at_Parse_internal_25
sw, $s0 0($sp) #setting param for function call
lw, $s0, 100($t0) #loading param_local_a2i_at_Parse_internal_24
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 104($sp) #Saving result on local_a2i_at_Parse_internal_25
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -12
lw, $s0, 228($t0)
sw, $s0 0($sp)
lw, $s0, 96($t0)
sw, $s0 4($sp)
lw, $s0, 104($t0)
sw, $s0 8($sp)
lw $a0, 228($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 32($a1)#Function substr:function_substr_at_String
jalr $a2
addi, $sp, $sp, 12
sw $s0, 88($sp)

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 112($sp)

la $t1, data_18
sw $t1, 116($sp)
lw $s4,116($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 116($t0) #loading param_local_a2i_at_Parse_internal_28
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 120($sp) #Saving result on local_a2i_at_Parse_internal_29
lw $s4,112($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 112($t0) #loading param_local_a2i_at_Parse_internal_27
sw, $s0 0($sp) #setting param for function call
lw, $s0, 116($t0) #loading param_local_a2i_at_Parse_internal_28
sw, $s0 4($sp) #setting param for function call
lw, $s0, 120($t0) #loading param_local_a2i_at_Parse_internal_29
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 108($sp) #Saving result on local_a2i_at_Parse_internal_26

lw, $t3, 112($sp)
lw,$t1,4($t3) #Load String Adress Node
lw $a1,8($t3)
lw, $t3, 88($sp)
lw,$t2,4($t3)
lw $a2,8($t3)
jal String_comparison_fun
sw, $t3, 80($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 84($sp)
lw $s4,84($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 84($t0) #loading param_local_a2i_at_Parse_internal_20
sw, $s0 0($sp) #setting param for function call
lw, $s0, 80($t0) #loading param_local_a2i_at_Parse_internal_19
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 84($sp) #Saving result on local_a2i_at_Parse_internal_20
lw $t0, 84($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label31
lw $s4,224($sp)
move $t0, $sp #call to function a2i_aux
addi, $sp, $sp, -8
lw, $s0, 224($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 228($t0) #loading param_param_s
sw, $s0 4($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 56 ($a1)
jalr $a2
addi, $sp, $sp, 8
sw $s0, 124($sp) #Saving result on local_a2i_at_Parse_internal_30
lw $t1, 124($sp)
sw $t1, 76($sp)
j label32
label31:

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 140($sp)

addi, $t1, $zero, 1
sw, $t1, 136($sp)
lw $s4,140($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 140($t0) #loading param_local_a2i_at_Parse_internal_34
sw, $s0 0($sp) #setting param for function call
lw, $s0, 136($t0) #loading param_local_a2i_at_Parse_internal_33
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 140($sp) #Saving result on local_a2i_at_Parse_internal_34
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 228($t0)
sw, $s0 0($sp)
lw $a0, 228($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 24($a1)#Function length:function_length_at_String
jalr $a2
addi, $sp, $sp, 4
sw $s0, 156($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 164($sp)

addi, $t1, $zero, 1
sw, $t1, 160($sp)
lw $s4,164($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 164($t0) #loading param_local_a2i_at_Parse_internal_40
sw, $s0 0($sp) #setting param for function call
lw, $s0, 160($t0) #loading param_local_a2i_at_Parse_internal_39
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 164($sp) #Saving result on local_a2i_at_Parse_internal_40

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 148($sp)

lw, $t3, 164($sp)
lw,$t1,4($t3) #Load minus value
lw, $t3, 156($sp)
lw,$t2,4($t3) #Load minus value
sub $t3,$t2,$t1
sw, $t3, 144($sp)
lw $s4,148($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 148($t0) #loading param_local_a2i_at_Parse_internal_36
sw, $s0 0($sp) #setting param for function call
lw, $s0, 144($t0) #loading param_local_a2i_at_Parse_internal_35
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 148($sp) #Saving result on local_a2i_at_Parse_internal_36
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -12
lw, $s0, 228($t0)
sw, $s0 0($sp)
lw, $s0, 140($t0)
sw, $s0 4($sp)
lw, $s0, 148($t0)
sw, $s0 8($sp)
lw $a0, 228($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 32($a1)#Function substr:function_substr_at_String
jalr $a2
addi, $sp, $sp, 12
sw $s0, 132($sp)
lw $s4,224($sp)
move $t0, $sp #call to function a2i
addi, $sp, $sp, -8
lw, $s0, 224($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 132($t0) #loading param_local_a2i_at_Parse_internal_32
sw, $s0 4($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 52 ($a1)
jalr $a2
addi, $sp, $sp, 8
sw $s0, 128($sp) #Saving result on local_a2i_at_Parse_internal_31
lw $t1, 128($sp)
sw $t1, 76($sp)
label32:
lw $t1, 76($sp)
sw $t1, 28($sp)
j label30
label29:

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 188($sp)

addi, $t1, $zero, 1
sw, $t1, 184($sp)
lw $s4,188($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 188($t0) #loading param_local_a2i_at_Parse_internal_46
sw, $s0 0($sp) #setting param for function call
lw, $s0, 184($t0) #loading param_local_a2i_at_Parse_internal_45
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 188($sp) #Saving result on local_a2i_at_Parse_internal_46
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 228($t0)
sw, $s0 0($sp)
lw $a0, 228($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 24($a1)#Function length:function_length_at_String
jalr $a2
addi, $sp, $sp, 4
sw $s0, 204($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 212($sp)

addi, $t1, $zero, 1
sw, $t1, 208($sp)
lw $s4,212($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 212($t0) #loading param_local_a2i_at_Parse_internal_52
sw, $s0 0($sp) #setting param for function call
lw, $s0, 208($t0) #loading param_local_a2i_at_Parse_internal_51
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 212($sp) #Saving result on local_a2i_at_Parse_internal_52

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 196($sp)

lw, $t3, 212($sp)
lw,$t1,4($t3) #Load minus value
lw, $t3, 204($sp)
lw,$t2,4($t3) #Load minus value
sub $t3,$t2,$t1
sw, $t3, 192($sp)
lw $s4,196($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 196($t0) #loading param_local_a2i_at_Parse_internal_48
sw, $s0 0($sp) #setting param for function call
lw, $s0, 192($t0) #loading param_local_a2i_at_Parse_internal_47
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 196($sp) #Saving result on local_a2i_at_Parse_internal_48
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -12
lw, $s0, 228($t0)
sw, $s0 0($sp)
lw, $s0, 188($t0)
sw, $s0 4($sp)
lw, $s0, 196($t0)
sw, $s0 8($sp)
lw $a0, 228($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 32($a1)#Function substr:function_substr_at_String
jalr $a2
addi, $sp, $sp, 12
sw $s0, 180($sp)
lw $s4,224($sp)
move $t0, $sp #call to function a2i_aux
addi, $sp, $sp, -8
lw, $s0, 224($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 180($t0) #loading param_local_a2i_at_Parse_internal_44
sw, $s0 4($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 56 ($a1)
jalr $a2
addi, $sp, $sp, 8
sw $s0, 176($sp) #Saving result on local_a2i_at_Parse_internal_43

lw, $t3, 176($sp)
lw,$t1,4($t3) #Load Negate
neg $t3,$t1
sw, $t3, 168($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 172($sp)
lw $s4,172($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 172($t0) #loading param_local_a2i_at_Parse_internal_42
sw, $s0 0($sp) #setting param for function call
lw, $s0, 168($t0) #loading param_local_a2i_at_Parse_internal_41
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 172($sp) #Saving result on local_a2i_at_Parse_internal_42
lw $t1, 172($sp)
sw $t1, 28($sp)
label30:
lw $t1, 28($sp)
sw $t1, 4($sp)
j label28
label27:

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 220($sp)

addi, $t1, $zero, 0
sw, $t1, 216($sp)
lw $s4,220($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 220($t0) #loading param_local_a2i_at_Parse_internal_54
sw, $s0 0($sp) #setting param for function call
lw, $s0, 216($t0) #loading param_local_a2i_at_Parse_internal_53
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 220($sp) #Saving result on local_a2i_at_Parse_internal_54
lw $t1, 220($sp)
sw $t1, 4($sp)
label28:

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,224
jr $ra

function_a2i_aux_at_Parse:
addi, $sp, $sp, -400
sw $ra, ($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 8($sp)

addi, $t1, $zero, 0
sw, $t1, 4($sp)
lw $s4,8($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 8($t0) #loading param_local_a2i_aux_at_Parse_internal_1
sw, $s0 0($sp) #setting param for function call
lw, $s0, 4($t0) #loading param_local_a2i_aux_at_Parse_internal_0
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 8($sp) #Saving result on local_a2i_aux_at_Parse_internal_1
lw $t1, 8($sp)
sw $t1, 12($sp)
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 404($t0)
sw, $s0 0($sp)
lw $a0, 404($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 24($a1)#Function length:function_length_at_String
jalr $a2
addi, $sp, $sp, 4
sw $s0, 16($sp)
lw $t1, 16($sp)
sw $t1, 20($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 28($sp)

addi, $t1, $zero, 0
sw, $t1, 24($sp)
lw $s4,28($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 28($t0) #loading param_local_a2i_aux_at_Parse_internal_6
sw, $s0 0($sp) #setting param for function call
lw, $s0, 24($t0) #loading param_local_a2i_aux_at_Parse_internal_5
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 28($sp) #Saving result on local_a2i_aux_at_Parse_internal_6
lw $t1, 28($sp)
sw $t1, 32($sp)
label33:

lw, $t3, 32($sp)
lw,$t1,4($t3) #Load Less 
lw, $t3, 20($sp)
lw,$t2,4($t3)
jal Less_comparison
sw, $t3, 40($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 44($sp)
lw $s4,44($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 44($t0) #loading param_local_a2i_aux_at_Parse_internal_10
sw, $s0 0($sp) #setting param for function call
lw, $s0, 40($t0) #loading param_local_a2i_aux_at_Parse_internal_9
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 44($sp) #Saving result on local_a2i_aux_at_Parse_internal_10
lw $t0, 44($sp) #If Label
lw $t0, 4($t0)
beqz $t0 label34

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 68($sp)

addi, $t1, $zero, 1
sw, $t1, 64($sp)
lw $s4,68($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 68($t0) #loading param_local_a2i_aux_at_Parse_internal_16
sw, $s0 0($sp) #setting param for function call
lw, $s0, 64($t0) #loading param_local_a2i_aux_at_Parse_internal_15
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 68($sp) #Saving result on local_a2i_aux_at_Parse_internal_16
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -12
lw, $s0, 404($t0)
sw, $s0 0($sp)
lw, $s0, 32($t0)
sw, $s0 4($sp)
lw, $s0, 68($t0)
sw, $s0 8($sp)
lw $a0, 404($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 32($a1)#Function substr:function_substr_at_String
jalr $a2
addi, $sp, $sp, 12
sw $s0, 56($sp)
lw $t1, 56($sp)
sw $t1, 72($sp)

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 96($sp)

la $t1, data_19
sw $t1, 100($sp)
lw $s4,100($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 100($t0) #loading param_local_a2i_aux_at_Parse_internal_24
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 104($sp) #Saving result on local_a2i_aux_at_Parse_internal_25
lw $s4,96($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 96($t0) #loading param_local_a2i_aux_at_Parse_internal_23
sw, $s0 0($sp) #setting param for function call
lw, $s0, 100($t0) #loading param_local_a2i_aux_at_Parse_internal_24
sw, $s0 4($sp) #setting param for function call
lw, $s0, 104($t0) #loading param_local_a2i_aux_at_Parse_internal_25
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 92($sp) #Saving result on local_a2i_aux_at_Parse_internal_22

lw, $t3, 96($sp)
lw,$t1,4($t3) #Load String Adress Node
lw $a1,8($t3)
lw, $t3, 72($sp)
lw,$t2,4($t3)
lw $a2,8($t3)
jal String_comparison_fun
sw, $t3, 80($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 84($sp)
lw $s4,84($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 84($t0) #loading param_local_a2i_aux_at_Parse_internal_20
sw, $s0 0($sp) #setting param for function call
lw, $s0, 80($t0) #loading param_local_a2i_aux_at_Parse_internal_19
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 84($sp) #Saving result on local_a2i_aux_at_Parse_internal_20
lw $t0, 84($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label35

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 128($sp)

la $t1, data_20
sw $t1, 132($sp)
lw $s4,132($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 132($t0) #loading param_local_a2i_aux_at_Parse_internal_32
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 136($sp) #Saving result on local_a2i_aux_at_Parse_internal_33
lw $s4,128($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 128($t0) #loading param_local_a2i_aux_at_Parse_internal_31
sw, $s0 0($sp) #setting param for function call
lw, $s0, 132($t0) #loading param_local_a2i_aux_at_Parse_internal_32
sw, $s0 4($sp) #setting param for function call
lw, $s0, 136($t0) #loading param_local_a2i_aux_at_Parse_internal_33
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 124($sp) #Saving result on local_a2i_aux_at_Parse_internal_30

lw, $t3, 128($sp)
lw,$t1,4($t3) #Load String Adress Node
lw $a1,8($t3)
lw, $t3, 72($sp)
lw,$t2,4($t3)
lw $a2,8($t3)
jal String_comparison_fun
sw, $t3, 112($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 116($sp)
lw $s4,116($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 116($t0) #loading param_local_a2i_aux_at_Parse_internal_28
sw, $s0 0($sp) #setting param for function call
lw, $s0, 112($t0) #loading param_local_a2i_aux_at_Parse_internal_27
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 116($sp) #Saving result on local_a2i_aux_at_Parse_internal_28
lw $t0, 116($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label37

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 164($sp)

addi, $t1, $zero, 10
sw, $t1, 160($sp)
lw $s4,164($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 164($t0) #loading param_local_a2i_aux_at_Parse_internal_40
sw, $s0 0($sp) #setting param for function call
lw, $s0, 160($t0) #loading param_local_a2i_aux_at_Parse_internal_39
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 164($sp) #Saving result on local_a2i_aux_at_Parse_internal_40

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 152($sp)

lw, $t3, 164($sp)
lw,$t1,4($t3) #Load Star value
lw, $t3, 12($sp)
lw,$t2,4($t3) #Load Star value
mul $t3,$t1,$t2
sw, $t3, 148($sp)
lw $s4,152($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 152($t0) #loading param_local_a2i_aux_at_Parse_internal_37
sw, $s0 0($sp) #setting param for function call
lw, $s0, 148($t0) #loading param_local_a2i_aux_at_Parse_internal_36
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 152($sp) #Saving result on local_a2i_aux_at_Parse_internal_37

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 184($sp)

addi, $t1, $zero, 1
sw, $t1, 180($sp)
lw $s4,184($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 184($t0) #loading param_local_a2i_aux_at_Parse_internal_45
sw, $s0 0($sp) #setting param for function call
lw, $s0, 180($t0) #loading param_local_a2i_aux_at_Parse_internal_44
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 184($sp) #Saving result on local_a2i_aux_at_Parse_internal_45
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -12
lw, $s0, 404($t0)
sw, $s0 0($sp)
lw, $s0, 32($t0)
sw, $s0 4($sp)
lw, $s0, 184($t0)
sw, $s0 8($sp)
lw $a0, 404($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 32($a1)#Function substr:function_substr_at_String
jalr $a2
addi, $sp, $sp, 12
sw $s0, 172($sp)
lw $s4,400($sp)
move $t0, $sp #call to function c2i
addi, $sp, $sp, -8
lw, $s0, 400($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 172($t0) #loading param_local_a2i_aux_at_Parse_internal_42
sw, $s0 4($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 48 ($a1)
jalr $a2
addi, $sp, $sp, 8
sw $s0, 168($sp) #Saving result on local_a2i_aux_at_Parse_internal_41

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 144($sp)

lw, $t3, 168($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 152($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 140($sp)
lw $s4,144($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 144($t0) #loading param_local_a2i_aux_at_Parse_internal_35
sw, $s0 0($sp) #setting param for function call
lw, $s0, 140($t0) #loading param_local_a2i_aux_at_Parse_internal_34
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 144($sp) #Saving result on local_a2i_aux_at_Parse_internal_35
lw $t1, 144($sp)
sw $t1, 12($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 204($sp)

addi, $t1, $zero, 1
sw, $t1, 200($sp)
lw $s4,204($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 204($t0) #loading param_local_a2i_aux_at_Parse_internal_50
sw, $s0 0($sp) #setting param for function call
lw, $s0, 200($t0) #loading param_local_a2i_aux_at_Parse_internal_49
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 204($sp) #Saving result on local_a2i_aux_at_Parse_internal_50

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 192($sp)

lw, $t3, 204($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 32($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 188($sp)
lw $s4,192($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 192($t0) #loading param_local_a2i_aux_at_Parse_internal_47
sw, $s0 0($sp) #setting param for function call
lw, $s0, 188($t0) #loading param_local_a2i_aux_at_Parse_internal_46
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 192($sp) #Saving result on local_a2i_aux_at_Parse_internal_47
lw $t1, 192($sp)
sw $t1, 32($sp)

lw, $t3, 20($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 32($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 212($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 216($sp)
lw $s4,216($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 216($t0) #loading param_local_a2i_aux_at_Parse_internal_53
sw, $s0 0($sp) #setting param for function call
lw, $s0, 212($t0) #loading param_local_a2i_aux_at_Parse_internal_52
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 216($sp) #Saving result on local_a2i_aux_at_Parse_internal_53
lw $t0, 216($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label39

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 232($sp)

la $t1, data_21
sw $t1, 236($sp)
lw $s4,236($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 236($t0) #loading param_local_a2i_aux_at_Parse_internal_58
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 240($sp) #Saving result on local_a2i_aux_at_Parse_internal_59
lw $s4,232($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 232($t0) #loading param_local_a2i_aux_at_Parse_internal_57
sw, $s0 0($sp) #setting param for function call
lw, $s0, 236($t0) #loading param_local_a2i_aux_at_Parse_internal_58
sw, $s0 4($sp) #setting param for function call
lw, $s0, 240($t0) #loading param_local_a2i_aux_at_Parse_internal_59
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 228($sp) #Saving result on local_a2i_aux_at_Parse_internal_56
lw $t1, 232($sp)
sw $t1, 208($sp)
j label40
label39:

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 248($sp)

la $t1, data_22
sw $t1, 252($sp)
lw $s4,252($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 252($t0) #loading param_local_a2i_aux_at_Parse_internal_62
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 256($sp) #Saving result on local_a2i_aux_at_Parse_internal_63
lw $s4,248($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 248($t0) #loading param_local_a2i_aux_at_Parse_internal_61
sw, $s0 0($sp) #setting param for function call
lw, $s0, 252($t0) #loading param_local_a2i_aux_at_Parse_internal_62
sw, $s0 4($sp) #setting param for function call
lw, $s0, 256($t0) #loading param_local_a2i_aux_at_Parse_internal_63
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 244($sp) #Saving result on local_a2i_aux_at_Parse_internal_60

lw, $t1, 248($sp)   
lw, $t3, 400($sp)  
sw, $t1, 8($t3)   
lw $t1, 248($sp)
sw $t1, 208($sp)
label40:
lw $t1, 208($sp)
sw $t1, 108($sp)
j label38
label37:

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 280($sp)

addi, $t1, $zero, 1
sw, $t1, 276($sp)
lw $s4,280($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 280($t0) #loading param_local_a2i_aux_at_Parse_internal_69
sw, $s0 0($sp) #setting param for function call
lw, $s0, 276($t0) #loading param_local_a2i_aux_at_Parse_internal_68
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 280($sp) #Saving result on local_a2i_aux_at_Parse_internal_69

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 268($sp)

lw, $t3, 280($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 32($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 264($sp)
lw $s4,268($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 268($t0) #loading param_local_a2i_aux_at_Parse_internal_66
sw, $s0 0($sp) #setting param for function call
lw, $s0, 264($t0) #loading param_local_a2i_aux_at_Parse_internal_65
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 268($sp) #Saving result on local_a2i_aux_at_Parse_internal_66
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 404($t0)
sw, $s0 0($sp)
lw $a0, 404($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 24($a1)#Function length:function_length_at_String
jalr $a2
addi, $sp, $sp, 4
sw $s0, 308($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 300($sp)

lw, $t3, 32($sp)
lw,$t1,4($t3) #Load minus value
lw, $t3, 308($sp)
lw,$t2,4($t3) #Load minus value
sub $t3,$t2,$t1
sw, $t3, 296($sp)
lw $s4,300($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 300($t0) #loading param_local_a2i_aux_at_Parse_internal_74
sw, $s0 0($sp) #setting param for function call
lw, $s0, 296($t0) #loading param_local_a2i_aux_at_Parse_internal_73
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 300($sp) #Saving result on local_a2i_aux_at_Parse_internal_74

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 320($sp)

addi, $t1, $zero, 1
sw, $t1, 316($sp)
lw $s4,320($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 320($t0) #loading param_local_a2i_aux_at_Parse_internal_79
sw, $s0 0($sp) #setting param for function call
lw, $s0, 316($t0) #loading param_local_a2i_aux_at_Parse_internal_78
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 320($sp) #Saving result on local_a2i_aux_at_Parse_internal_79

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 288($sp)

lw, $t3, 320($sp)
lw,$t1,4($t3) #Load minus value
lw, $t3, 300($sp)
lw,$t2,4($t3) #Load minus value
sub $t3,$t2,$t1
sw, $t3, 284($sp)
lw $s4,288($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 288($t0) #loading param_local_a2i_aux_at_Parse_internal_71
sw, $s0 0($sp) #setting param for function call
lw, $s0, 284($t0) #loading param_local_a2i_aux_at_Parse_internal_70
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 288($sp) #Saving result on local_a2i_aux_at_Parse_internal_71
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -12
lw, $s0, 404($t0)
sw, $s0 0($sp)
lw, $s0, 268($t0)
sw, $s0 4($sp)
lw, $s0, 288($t0)
sw, $s0 8($sp)
lw $a0, 404($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 32($a1)#Function substr:function_substr_at_String
jalr $a2
addi, $sp, $sp, 12
sw $s0, 260($sp)

lw, $t1, 260($sp)   
lw, $t3, 400($sp)  
sw, $t1, 8($t3)   
lw $t1, 20($sp)
sw $t1, 32($sp)
lw $t1, 20($sp)
sw $t1, 108($sp)
label38:
lw $t1, 108($sp)
sw $t1, 76($sp)
j label36
label35:

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 348($sp)

addi, $t1, $zero, 1
sw, $t1, 344($sp)
lw $s4,348($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 348($t0) #loading param_local_a2i_aux_at_Parse_internal_86
sw, $s0 0($sp) #setting param for function call
lw, $s0, 344($t0) #loading param_local_a2i_aux_at_Parse_internal_85
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 348($sp) #Saving result on local_a2i_aux_at_Parse_internal_86

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 336($sp)

lw, $t3, 348($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 32($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 332($sp)
lw $s4,336($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 336($t0) #loading param_local_a2i_aux_at_Parse_internal_83
sw, $s0 0($sp) #setting param for function call
lw, $s0, 332($t0) #loading param_local_a2i_aux_at_Parse_internal_82
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 336($sp) #Saving result on local_a2i_aux_at_Parse_internal_83
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 404($t0)
sw, $s0 0($sp)
lw $a0, 404($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 24($a1)#Function length:function_length_at_String
jalr $a2
addi, $sp, $sp, 4
sw $s0, 376($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 368($sp)

lw, $t3, 32($sp)
lw,$t1,4($t3) #Load minus value
lw, $t3, 376($sp)
lw,$t2,4($t3) #Load minus value
sub $t3,$t2,$t1
sw, $t3, 364($sp)
lw $s4,368($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 368($t0) #loading param_local_a2i_aux_at_Parse_internal_91
sw, $s0 0($sp) #setting param for function call
lw, $s0, 364($t0) #loading param_local_a2i_aux_at_Parse_internal_90
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 368($sp) #Saving result on local_a2i_aux_at_Parse_internal_91

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 388($sp)

addi, $t1, $zero, 1
sw, $t1, 384($sp)
lw $s4,388($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 388($t0) #loading param_local_a2i_aux_at_Parse_internal_96
sw, $s0 0($sp) #setting param for function call
lw, $s0, 384($t0) #loading param_local_a2i_aux_at_Parse_internal_95
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 388($sp) #Saving result on local_a2i_aux_at_Parse_internal_96

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 356($sp)

lw, $t3, 388($sp)
lw,$t1,4($t3) #Load minus value
lw, $t3, 368($sp)
lw,$t2,4($t3) #Load minus value
sub $t3,$t2,$t1
sw, $t3, 352($sp)
lw $s4,356($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 356($t0) #loading param_local_a2i_aux_at_Parse_internal_88
sw, $s0 0($sp) #setting param for function call
lw, $s0, 352($t0) #loading param_local_a2i_aux_at_Parse_internal_87
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 356($sp) #Saving result on local_a2i_aux_at_Parse_internal_88
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -12
lw, $s0, 404($t0)
sw, $s0 0($sp)
lw, $s0, 336($t0)
sw, $s0 4($sp)
lw, $s0, 356($t0)
sw, $s0 8($sp)
lw $a0, 404($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 32($a1)#Function substr:function_substr_at_String
jalr $a2
addi, $sp, $sp, 12
sw $s0, 328($sp)

lw, $t1, 328($sp)   
lw, $t3, 400($sp)  
sw, $t1, 8($t3)   
lw $t1, 20($sp)
sw $t1, 32($sp)
lw $t1, 20($sp)
sw $t1, 76($sp)
label36:
j label33
label34:

la $t1, void_data
sw $t1, 36($sp)

lw $s0, 12($sp)
lw $ra, ($sp)
addi $sp, $sp,400
jr $ra

init_BoolOp:
addi, $sp, $sp, -4
sw $ra, ($sp)

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,4
jr $ra

function_and_at_BoolOp:
addi, $sp, $sp, -16
sw $ra, ($sp)
lw $t0, 20($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label41

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 12($sp)

addi, $t1, $zero, 0
sw, $t1, 8($sp)
lw $s4,12($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 12($t0) #loading param_local_and_at_BoolOp_internal_2
sw, $s0 0($sp) #setting param for function call
lw, $s0, 8($t0) #loading param_local_and_at_BoolOp_internal_1
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 12($sp) #Saving result on local_and_at_BoolOp_internal_2
lw $t1, 12($sp)
sw $t1, 4($sp)
j label42
label41:
lw $t1, 24($sp)
sw $t1, 4($sp)
label42:

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,16
jr $ra

function_or_at_BoolOp:
addi, $sp, $sp, -16
sw $ra, ($sp)
lw $t0, 20($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label43
lw $t1, 24($sp)
sw $t1, 4($sp)
j label44
label43:

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 12($sp)

addi, $t1, $zero, 1
sw, $t1, 8($sp)
lw $s4,12($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 12($t0) #loading param_local_or_at_BoolOp_internal_2
sw, $s0 0($sp) #setting param for function call
lw, $s0, 8($t0) #loading param_local_or_at_BoolOp_internal_1
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 12($sp) #Saving result on local_or_at_BoolOp_internal_2
lw $t1, 12($sp)
sw $t1, 4($sp)
label44:

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,16
jr $ra

init_ECons:
addi, $sp, $sp, -12
sw $ra, ($sp)

la $t1, void_data
sw $t1, 4($sp)

lw, $t1, 4($sp)   
lw, $t3, 12($sp)  
sw, $t1, 4($t3)   

la $t1, void_data
sw $t1, 8($sp)

lw, $t1, 8($sp)   
lw, $t3, 12($sp)  
sw, $t1, 8($t3)   

lw $s0, 12($sp)
lw $ra, ($sp)
addi $sp, $sp,12
jr $ra

function_isNil_at_ECons:
addi, $sp, $sp, -12
sw $ra, ($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 8($sp)

addi, $t1, $zero, 0
sw, $t1, 4($sp)
lw $s4,8($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 8($t0) #loading param_local_isNil_at_ECons_internal_1
sw, $s0 0($sp) #setting param for function call
lw, $s0, 4($t0) #loading param_local_isNil_at_ECons_internal_0
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 8($sp) #Saving result on local_isNil_at_ECons_internal_1

lw $s0, 8($sp)
lw $ra, ($sp)
addi $sp, $sp,12
jr $ra

function_head_at_ECons:
addi, $sp, $sp, -8
sw $ra, ($sp)
lw $t3, 8($sp) #getting instance self 

lw, $t3, 8($sp) #getting instance self 
lw, $t1, 4($t3)  #getting offset car 
sw, $t1, 4($sp)   

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,8
jr $ra

function_tail_at_ECons:
addi, $sp, $sp, -8
sw $ra, ($sp)
lw $t3, 8($sp) #getting instance self 

lw, $t3, 8($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset cdr 
sw, $t1, 4($sp)   

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,8
jr $ra

function_init_at_ECons:
addi, $sp, $sp, -8
sw $ra, ($sp)

lw, $t1, 12($sp)   
lw, $t3, 8($sp)  
sw, $t1, 4($t3)   

lw, $t1, 16($sp)   
lw, $t3, 8($sp)  
sw, $t1, 8($t3)   
lw $t3, 8($sp) #getting instance self 
sw $t3, 4($sp)

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,8
jr $ra

function_print_at_ECons:
addi, $sp, $sp, -20
sw $ra, ($sp)
lw $t3, 20($sp) #getting instance self 

lw, $t3, 20($sp) #getting instance self 
lw, $t1, 4($t3)  #getting offset car 
sw, $t1, 8($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 8($t0)
sw, $s0 0($sp)
lw $a0, 8($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 44($a1)#Function print:function_print_at_Edge
jalr $a2
addi, $sp, $sp, 4
sw $s0, 4($sp)
lw $t3, 20($sp) #getting instance self 

lw, $t3, 20($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset cdr 
sw, $t1, 16($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 16($t0)
sw, $s0 0($sp)
lw $a0, 16($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 60($a1)#Function print:function_print_at_EList
jalr $a2
addi, $sp, $sp, 4
sw $s0, 12($sp)

lw $s0, 12($sp)
lw $ra, ($sp)
addi $sp, $sp,20
jr $ra

init_VCons:
addi, $sp, $sp, -12
sw $ra, ($sp)

la $t1, void_data
sw $t1, 4($sp)

lw, $t1, 4($sp)   
lw, $t3, 12($sp)  
sw, $t1, 4($t3)   

la $t1, void_data
sw $t1, 8($sp)

lw, $t1, 8($sp)   
lw, $t3, 12($sp)  
sw, $t1, 8($t3)   

lw $s0, 12($sp)
lw $ra, ($sp)
addi $sp, $sp,12
jr $ra

function_isNil_at_VCons:
addi, $sp, $sp, -12
sw $ra, ($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 8($sp)

addi, $t1, $zero, 0
sw, $t1, 4($sp)
lw $s4,8($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 8($t0) #loading param_local_isNil_at_VCons_internal_1
sw, $s0 0($sp) #setting param for function call
lw, $s0, 4($t0) #loading param_local_isNil_at_VCons_internal_0
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 8($sp) #Saving result on local_isNil_at_VCons_internal_1

lw $s0, 8($sp)
lw $ra, ($sp)
addi $sp, $sp,12
jr $ra

function_head_at_VCons:
addi, $sp, $sp, -8
sw $ra, ($sp)
lw $t3, 8($sp) #getting instance self 

lw, $t3, 8($sp) #getting instance self 
lw, $t1, 4($t3)  #getting offset car 
sw, $t1, 4($sp)   

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,8
jr $ra

function_tail_at_VCons:
addi, $sp, $sp, -8
sw $ra, ($sp)
lw $t3, 8($sp) #getting instance self 

lw, $t3, 8($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset cdr 
sw, $t1, 4($sp)   

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,8
jr $ra

function_init_at_VCons:
addi, $sp, $sp, -8
sw $ra, ($sp)

lw, $t1, 12($sp)   
lw, $t3, 8($sp)  
sw, $t1, 4($t3)   

lw, $t1, 16($sp)   
lw, $t3, 8($sp)  
sw, $t1, 8($t3)   
lw $t3, 8($sp) #getting instance self 
sw $t3, 4($sp)

lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp,8
jr $ra

function_print_at_VCons:
addi, $sp, $sp, -20
sw $ra, ($sp)
lw $t3, 20($sp) #getting instance self 

lw, $t3, 20($sp) #getting instance self 
lw, $t1, 4($t3)  #getting offset car 
sw, $t1, 8($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 8($t0)
sw, $s0 0($sp)
lw $a0, 8($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 56($a1)#Function print:function_print_at_Vertice
jalr $a2
addi, $sp, $sp, 4
sw $s0, 4($sp)
lw $t3, 20($sp) #getting instance self 

lw, $t3, 20($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset cdr 
sw, $t1, 16($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 16($t0)
sw, $s0 0($sp)
lw $a0, 16($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 56($a1)#Function print:function_print_at_VList
jalr $a2
addi, $sp, $sp, 4
sw $s0, 12($sp)

lw $s0, 12($sp)
lw $ra, ($sp)
addi $sp, $sp,20
jr $ra

init_Main:
addi, $sp, $sp, -28
sw $ra, ($sp)

addi $a0, $zero, 4
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,BoolOp_methods
sw $t1, ($t3)
sw, $t3, 4($sp)
lw $s4,4($sp)
move $t0, $sp #call to function init_BoolOp
addi, $sp, $sp, -4
lw, $s0, 4($t0) #loading param_local__internal_0
sw, $s0 0($sp) #setting param for function call
jal init_BoolOp
addi, $sp, $sp, 4
sw $s0, 8($sp) #Saving result on local__internal_1

lw, $t1, 4($sp)   
lw, $t3, 28($sp)  
sw, $t1, 4($t3)   

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 12($sp)

la $t1, empty_str_data
sw $t1, 16($sp)

addi, $t1, $zero, 0
sw, $t1, 20($sp)
lw $s4,12($sp)
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 12($t0) #loading param_local__internal_2
sw, $s0 0($sp) #setting param for function call
lw, $s0, 16($t0) #loading param_local__internal_3
sw, $s0 4($sp) #setting param for function call
lw, $s0, 20($t0) #loading param_local__internal_4
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 12($sp) #Saving result on local__internal_2

lw, $t1, 12($sp)   
lw, $t3, 28($sp)  
sw, $t1, 8($t3)   
lw $s4,28($sp)
move $t0, $sp #call to function read_input
addi, $sp, $sp, -4
lw, $s0, 28($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw $a1, ($s4)
lw $a2, 40 ($a1)
jalr $a2
addi, $sp, $sp, 4
sw $s0, 24($sp) #Saving result on local__internal_5

lw, $t1, 24($sp)   
lw, $t3, 28($sp)  
sw, $t1, 12($t3)   

lw $s0, 28($sp)
lw $ra, ($sp)
addi $sp, $sp,28
jr $ra

function_main_at_Main:
addi, $sp, $sp, -20
sw $ra, ($sp)
lw $t3, 20($sp) #getting instance self 

lw, $t3, 20($sp) #getting instance self 
lw, $t1, 12($t3)  #getting offset g 
sw, $t1, 8($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 8($t0)
sw, $s0 0($sp)
lw $a0, 8($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 32($a1)#Function print_V:function_print_V_at_Graph
jalr $a2
addi, $sp, $sp, 4
sw $s0, 4($sp)
lw $t3, 20($sp) #getting instance self 

lw, $t3, 20($sp) #getting instance self 
lw, $t1, 12($t3)  #getting offset g 
sw, $t1, 16($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 16($t0)
sw, $s0 0($sp)
lw $a0, 16($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 28($a1)#Function print_E:function_print_E_at_Graph
jalr $a2
addi, $sp, $sp, 4
sw $s0, 12($sp)

lw $s0, 12($sp)
lw $ra, ($sp)
addi $sp, $sp,20
jr $ra
