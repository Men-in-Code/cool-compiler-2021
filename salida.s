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

data10000: .asciiz "\n"

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

type_Main: .asciiz "Main"
Main_methods:
.word 24
.word type_Main
.word IO_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object
.word function_out_string_at_IO
.word function_out_int_at_IO
.word function_in_string_at_IO
.word function_in_int_at_IO
.word function_main_at_Main


#DATA_STR
empty_str_data: .asciiz ""
void_data: .word 0
aux_input_string: .space 1028

data_0: .asciiz "2 is trivially prime.\n"
data_1: .asciiz " is prime.\n"
data_2: .asciiz "continue"
data_3: .asciiz "halt"
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

function_internalcopy:
loop_InternalcopyNode:
beqz $a2,end_loop_Internalcopy
lw $a1, ($t1)
sw $a1, ($t2)
addi $t1,$t1,4
addi $t2,$t2,4
subu $a2,$a2,4
j loop_InternalcopyNode
end_loop_Internalcopy:
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

addi $a0, $zero, 24
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Main_methods
sw $t1, ($t3)
sw, $t3, 4($sp)
move $t0, $sp #call to function init_Main
addi, $sp, $sp, -4
lw, $s0, 4($t0) #loading param_local__internal_0
sw, $s0 0($sp) #setting param for function call
jal init_Main
addi, $sp, $sp, 4
sw $s0, 4($sp) #Saving result on local__internal_0
move $t0, $sp #call to function main
addi, $sp, $sp, -4
lw, $s0, 4($t0) #loading param_local__internal_0
sw, $s0 0($sp) #setting param for function call
jal function_main_at_Main
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
la $a0, data10000
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
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 8($t0) #loading param_local_concat_at_String_internal_1
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 12($sp) #Saving result on local_concat_at_String_internal_2
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
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 8($t0) #loading param_local_substr_at_String_internal_1
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 12($sp) #Saving result on local_substr_at_String_internal_2
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

init_Main:
addi, $sp, $sp, -364
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
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 16($t0) #loading param_local__internal_3
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 20($sp) #Saving result on local__internal_4
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
sw $s0, 8($sp) #Saving result on local__internal_1
move $t0, $sp #call to function out_string
addi, $sp, $sp, -8
lw, $s0, 364($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 12($t0) #loading param_local__internal_2
sw, $s0 4($sp) #setting param for function call
jal function_out_string_at_IO
addi, $sp, $sp, 8
sw $s0, 4($sp) #Saving result on local__internal_0

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 28($sp)

addi, $t1, $zero, 2
sw, $t1, 24($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 28($t0) #loading param_local__internal_6
sw, $s0 0($sp) #setting param for function call
lw, $s0, 24($t0) #loading param_local__internal_5
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 28($sp) #Saving result on local__internal_6

lw, $t1, 28($sp)   
lw, $t3, 364($sp)  
sw, $t1, 4($t3)   
lw $t3, 364($sp) #getting instance self 

lw, $t3, 364($sp) #getting instance self 
lw, $t1, 4($t3)  #getting offset out 
sw, $t1, 32($sp)   

lw, $t1, 32($sp)   
lw, $t3, 364($sp)  
sw, $t1, 8($t3)   

addi, $t1, $zero, 0
sw, $t1, 36($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 40($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 40($t0) #loading param_local__internal_9
sw, $s0 0($sp) #setting param for function call
lw, $s0, 36($t0) #loading param_local__internal_8
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 40($sp) #Saving result on local__internal_9

lw, $t1, 40($sp)   
lw, $t3, 364($sp)  
sw, $t1, 12($t3)   

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 48($sp)

addi, $t1, $zero, 500
sw, $t1, 44($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 48($t0) #loading param_local__internal_11
sw, $s0 0($sp) #setting param for function call
lw, $s0, 44($t0) #loading param_local__internal_10
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 48($sp) #Saving result on local__internal_11

lw, $t1, 48($sp)   
lw, $t3, 364($sp)  
sw, $t1, 16($t3)   
label1:

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 60($sp)

addi, $t1, $zero, 1
sw, $t1, 56($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 60($t0) #loading param_local__internal_14
sw, $s0 0($sp) #setting param for function call
lw, $s0, 56($t0) #loading param_local__internal_13
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 60($sp) #Saving result on local__internal_14
lw $t0, 60($sp) #If Label
lw $t0, 4($t0)
beqz $t0 label2
lw $t3, 364($sp) #getting instance self 

lw, $t3, 364($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset testee 
sw, $t1, 72($sp)   

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 80($sp)

addi, $t1, $zero, 1
sw, $t1, 76($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 80($t0) #loading param_local__internal_19
sw, $s0 0($sp) #setting param for function call
lw, $s0, 76($t0) #loading param_local__internal_18
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 80($sp) #Saving result on local__internal_19

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 68($sp)

lw, $t3, 80($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 72($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 64($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 68($t0) #loading param_local__internal_16
sw, $s0 0($sp) #setting param for function call
lw, $s0, 64($t0) #loading param_local__internal_15
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 68($sp) #Saving result on local__internal_16

lw, $t1, 68($sp)   
lw, $t3, 364($sp)  
sw, $t1, 8($t3)   

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 88($sp)

addi, $t1, $zero, 2
sw, $t1, 84($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 88($t0) #loading param_local__internal_21
sw, $s0 0($sp) #setting param for function call
lw, $s0, 84($t0) #loading param_local__internal_20
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 88($sp) #Saving result on local__internal_21

lw, $t1, 88($sp)   
lw, $t3, 364($sp)  
sw, $t1, 12($t3)   
label3:
lw $t3, 364($sp) #getting instance self 

lw, $t3, 364($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset testee 
sw, $t1, 108($sp)   
lw $t3, 364($sp) #getting instance self 

lw, $t3, 364($sp) #getting instance self 
lw, $t1, 12($t3)  #getting offset divisor 
sw, $t1, 120($sp)   
lw $t3, 364($sp) #getting instance self 

lw, $t3, 364($sp) #getting instance self 
lw, $t1, 12($t3)  #getting offset divisor 
sw, $t1, 124($sp)   

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 116($sp)

lw, $t3, 124($sp)
lw,$t1,4($t3) #Load Star value
lw, $t3, 120($sp)
lw,$t2,4($t3) #Load Star value
mul $t3,$t1,$t2
sw, $t3, 112($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 116($t0) #loading param_local__internal_28
sw, $s0 0($sp) #setting param for function call
lw, $s0, 112($t0) #loading param_local__internal_27
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 116($sp) #Saving result on local__internal_28

lw, $t3, 108($sp)
lw,$t1,4($t3) #Load Less 
lw, $t3, 116($sp)
lw,$t2,4($t3)
jal Less_comparison
sw, $t3, 100($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 104($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 104($t0) #loading param_local__internal_25
sw, $s0 0($sp) #setting param for function call
lw, $s0, 100($t0) #loading param_local__internal_24
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 104($sp) #Saving result on local__internal_25
lw $t0, 104($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label5
lw $t3, 364($sp) #getting instance self 

lw, $t3, 364($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset testee 
sw, $t1, 152($sp)   
lw $t3, 364($sp) #getting instance self 

lw, $t3, 364($sp) #getting instance self 
lw, $t1, 12($t3)  #getting offset divisor 
sw, $t1, 164($sp)   
lw $t3, 364($sp) #getting instance self 

lw, $t3, 364($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset testee 
sw, $t1, 176($sp)   
lw $t3, 364($sp) #getting instance self 

lw, $t3, 364($sp) #getting instance self 
lw, $t1, 12($t3)  #getting offset divisor 
sw, $t1, 180($sp)   

lw, $t3, 180($sp)
lw,$t1,4($t3) #Load Div value
lw, $t3, 176($sp)
lw,$t2,4($t3) #Load Div value
beqz $t1 error_div_by_zero
div $t3,$t2,$t1
sw, $t3, 168($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 172($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 172($t0) #loading param_local__internal_42
sw, $s0 0($sp) #setting param for function call
lw, $s0, 168($t0) #loading param_local__internal_41
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 172($sp) #Saving result on local__internal_42

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 160($sp)

lw, $t3, 172($sp)
lw,$t1,4($t3) #Load Star value
lw, $t3, 164($sp)
lw,$t2,4($t3) #Load Star value
mul $t3,$t1,$t2
sw, $t3, 156($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 160($t0) #loading param_local__internal_39
sw, $s0 0($sp) #setting param for function call
lw, $s0, 156($t0) #loading param_local__internal_38
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 160($sp) #Saving result on local__internal_39

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 144($sp)

lw, $t3, 160($sp)
lw,$t1,4($t3) #Load minus value
lw, $t3, 152($sp)
lw,$t2,4($t3) #Load minus value
sub $t3,$t2,$t1
sw, $t3, 140($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 144($t0) #loading param_local__internal_35
sw, $s0 0($sp) #setting param for function call
lw, $s0, 140($t0) #loading param_local__internal_34
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 144($sp) #Saving result on local__internal_35

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 188($sp)

addi, $t1, $zero, 0
sw, $t1, 184($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 188($t0) #loading param_local__internal_46
sw, $s0 0($sp) #setting param for function call
lw, $s0, 184($t0) #loading param_local__internal_45
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 188($sp) #Saving result on local__internal_46

lw, $t3, 188($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 144($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 132($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 136($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 136($t0) #loading param_local__internal_33
sw, $s0 0($sp) #setting param for function call
lw, $s0, 132($t0) #loading param_local__internal_32
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 136($sp) #Saving result on local__internal_33
lw $t0, 136($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label7

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 196($sp)

addi, $t1, $zero, 1
sw, $t1, 192($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 196($t0) #loading param_local__internal_48
sw, $s0 0($sp) #setting param for function call
lw, $s0, 192($t0) #loading param_local__internal_47
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 196($sp) #Saving result on local__internal_48
lw $t1, 196($sp)
sw $t1, 128($sp)
j label8
label7:

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 204($sp)

addi, $t1, $zero, 0
sw, $t1, 200($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 204($t0) #loading param_local__internal_50
sw, $s0 0($sp) #setting param for function call
lw, $s0, 200($t0) #loading param_local__internal_49
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 204($sp) #Saving result on local__internal_50
lw $t1, 204($sp)
sw $t1, 128($sp)
label8:
lw $t1, 128($sp)
sw $t1, 96($sp)
j label6
label5:

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 212($sp)

addi, $t1, $zero, 0
sw, $t1, 208($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 212($t0) #loading param_local__internal_52
sw, $s0 0($sp) #setting param for function call
lw, $s0, 208($t0) #loading param_local__internal_51
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 212($sp) #Saving result on local__internal_52
lw $t1, 212($sp)
sw $t1, 96($sp)
label6:
lw $t0, 96($sp) #If Label
lw $t0, 4($t0)
beqz $t0 label4
lw $t3, 364($sp) #getting instance self 

lw, $t3, 364($sp) #getting instance self 
lw, $t1, 12($t3)  #getting offset divisor 
sw, $t1, 224($sp)   

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 232($sp)

addi, $t1, $zero, 1
sw, $t1, 228($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 232($t0) #loading param_local__internal_57
sw, $s0 0($sp) #setting param for function call
lw, $s0, 228($t0) #loading param_local__internal_56
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 232($sp) #Saving result on local__internal_57

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 220($sp)

lw, $t3, 232($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 224($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 216($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 220($t0) #loading param_local__internal_54
sw, $s0 0($sp) #setting param for function call
lw, $s0, 216($t0) #loading param_local__internal_53
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 220($sp) #Saving result on local__internal_54

lw, $t1, 220($sp)   
lw, $t3, 364($sp)  
sw, $t1, 12($t3)   
j label3
label4:

la $t1, void_data
sw $t1, 92($sp)
lw $t3, 364($sp) #getting instance self 

lw, $t3, 364($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset testee 
sw, $t1, 248($sp)   
lw $t3, 364($sp) #getting instance self 

lw, $t3, 364($sp) #getting instance self 
lw, $t1, 12($t3)  #getting offset divisor 
sw, $t1, 260($sp)   
lw $t3, 364($sp) #getting instance self 

lw, $t3, 364($sp) #getting instance self 
lw, $t1, 12($t3)  #getting offset divisor 
sw, $t1, 264($sp)   

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 256($sp)

lw, $t3, 264($sp)
lw,$t1,4($t3) #Load Star value
lw, $t3, 260($sp)
lw,$t2,4($t3) #Load Star value
mul $t3,$t1,$t2
sw, $t3, 252($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 256($t0) #loading param_local__internal_63
sw, $s0 0($sp) #setting param for function call
lw, $s0, 252($t0) #loading param_local__internal_62
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 256($sp) #Saving result on local__internal_63

lw, $t3, 248($sp)
lw,$t1,4($t3) #Load Less 
lw, $t3, 256($sp)
lw,$t2,4($t3)
jal Less_comparison
sw, $t3, 240($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 244($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 244($t0) #loading param_local__internal_60
sw, $s0 0($sp) #setting param for function call
lw, $s0, 240($t0) #loading param_local__internal_59
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 244($sp) #Saving result on local__internal_60
lw $t0, 244($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label9

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 272($sp)

addi, $t1, $zero, 0
sw, $t1, 268($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 272($t0) #loading param_local__internal_67
sw, $s0 0($sp) #setting param for function call
lw, $s0, 268($t0) #loading param_local__internal_66
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 272($sp) #Saving result on local__internal_67
lw $t1, 272($sp)
sw $t1, 236($sp)
j label10
label9:
lw $t3, 364($sp) #getting instance self 

lw, $t3, 364($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset testee 
sw, $t1, 276($sp)   

lw, $t1, 276($sp)   
lw, $t3, 364($sp)  
sw, $t1, 4($t3)   
lw $t3, 364($sp) #getting instance self 

lw, $t3, 364($sp) #getting instance self 
lw, $t1, 4($t3)  #getting offset out 
sw, $t1, 284($sp)   
move $t0, $sp #call to function out_int
addi, $sp, $sp, -8
lw, $s0, 364($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 284($t0) #loading param_local__internal_70
sw, $s0 4($sp) #setting param for function call
jal function_out_int_at_IO
addi, $sp, $sp, 8
sw $s0, 280($sp) #Saving result on local__internal_69

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 296($sp)

la $t1, data_1
sw $t1, 300($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 300($t0) #loading param_local__internal_74
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 304($sp) #Saving result on local__internal_75
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 296($t0) #loading param_local__internal_73
sw, $s0 0($sp) #setting param for function call
lw, $s0, 300($t0) #loading param_local__internal_74
sw, $s0 4($sp) #setting param for function call
lw, $s0, 304($t0) #loading param_local__internal_75
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 292($sp) #Saving result on local__internal_72
move $t0, $sp #call to function out_string
addi, $sp, $sp, -8
lw, $s0, 364($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 296($t0) #loading param_local__internal_73
sw, $s0 4($sp) #setting param for function call
jal function_out_string_at_IO
addi, $sp, $sp, 8
sw $s0, 288($sp) #Saving result on local__internal_71
lw $t1, 288($sp)
sw $t1, 236($sp)
label10:
lw $t3, 364($sp) #getting instance self 

lw, $t3, 364($sp) #getting instance self 
lw, $t1, 16($t3)  #getting offset stop 
sw, $t1, 320($sp)   
lw $t3, 364($sp) #getting instance self 

lw, $t3, 364($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset testee 
sw, $t1, 324($sp)   

lw, $t3, 320($sp)
lw,$t1,4($t3) #Load Less Equal
lw, $t3, 324($sp)
lw,$t2,4($t3)
jal LessEqual_comparison
sw, $t3, 312($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bool_methods
sw $t1, ($t3)
sw, $t3, 316($sp)
move $t0, $sp #call to function init_Bool
addi, $sp, $sp, -8
lw, $s0, 316($t0) #loading param_local__internal_78
sw, $s0 0($sp) #setting param for function call
lw, $s0, 312($t0) #loading param_local__internal_77
sw, $s0 4($sp) #setting param for function call
jal init_Bool
addi, $sp, $sp, 8
sw $s0, 316($sp) #Saving result on local__internal_78
lw $t0, 316($sp) #Goto If Label
lw $t0, 4($t0) #Load Bool Value
beq $t0, 1, label11

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 332($sp)

la $t1, data_2
sw $t1, 336($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 336($t0) #loading param_local__internal_83
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 340($sp) #Saving result on local__internal_84
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 332($t0) #loading param_local__internal_82
sw, $s0 0($sp) #setting param for function call
lw, $s0, 336($t0) #loading param_local__internal_83
sw, $s0 4($sp) #setting param for function call
lw, $s0, 340($t0) #loading param_local__internal_84
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 328($sp) #Saving result on local__internal_81
lw $t1, 332($sp)
sw $t1, 308($sp)
j label12
label11:

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 352($sp)

la $t1, data_3
sw $t1, 356($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 356($t0) #loading param_local__internal_88
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 360($sp) #Saving result on local__internal_89
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 352($t0) #loading param_local__internal_87
sw, $s0 0($sp) #setting param for function call
lw, $s0, 356($t0) #loading param_local__internal_88
sw, $s0 4($sp) #setting param for function call
lw, $s0, 360($t0) #loading param_local__internal_89
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 348($sp) #Saving result on local__internal_86
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 352($t0)
sw, $s0 0($sp)
lw $a0, 352($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 12($a1)#Function abort:function_abort_at_Object
jalr $a2
addi, $sp, $sp, 4
sw $s0, 344($sp)
lw $t1, 344($sp)
sw $t1, 308($sp)
label12:
j label1
label2:

la $t1, void_data
sw $t1, 52($sp)

lw, $t1, 52($sp)   
lw, $t3, 364($sp)  
sw, $t1, 20($t3)   

lw $s0, 364($sp)
lw $ra, ($sp)
addi $sp, $sp,364
jr $ra

function_main_at_Main:
addi, $sp, $sp, -12
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
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 8($t0) #loading param_local_main_at_Main_internal_1
sw, $s0 0($sp) #setting param for function call
lw, $s0, 4($t0) #loading param_local_main_at_Main_internal_0
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 8($sp) #Saving result on local_main_at_Main_internal_1

lw $s0, 8($sp)
lw $ra, ($sp)
addi $sp, $sp,12
jr $ra
