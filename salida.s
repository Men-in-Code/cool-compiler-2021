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

type_Bazz: .asciiz "Bazz"
Bazz_methods:
.word 16
.word type_Bazz
.word IO_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object
.word function_out_string_at_IO
.word function_out_int_at_IO
.word function_in_string_at_IO
.word function_in_int_at_IO
.word function_printh_at_Bazz
.word function_doh_at_Bazz

type_Main: .asciiz "Main"
Main_methods:
.word 20
.word type_Main
.word Object_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object
.word function_main_at_Main

type_Foo: .asciiz "Foo"
Foo_methods:
.word 24
.word type_Foo
.word Bazz_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object
.word function_out_string_at_IO
.word function_out_int_at_IO
.word function_in_string_at_IO
.word function_in_int_at_IO
.word function_printh_at_Bazz
.word function_doh_at_Foo

type_Razz: .asciiz "Razz"
Razz_methods:
.word 32
.word type_Razz
.word Foo_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object
.word function_out_string_at_IO
.word function_out_int_at_IO
.word function_in_string_at_IO
.word function_in_int_at_IO
.word function_printh_at_Bazz
.word function_doh_at_Foo

type_Bar: .asciiz "Bar"
Bar_methods:
.word 40
.word type_Bar
.word Razz_methods
.word function_abort_at_Object
.word function_type_name_at_Object
.word function_copy_at_Object
.word function_out_string_at_IO
.word function_out_int_at_IO
.word function_in_string_at_IO
.word function_in_int_at_IO
.word function_printh_at_Bazz
.word function_doh_at_Foo


#DATA_STR
empty_str_data: .asciiz ""
void_data: .word 0
aux_input_string: .space 1028

data_0: .asciiz "do nothing"
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

addi $a0, $zero, 20
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

init_Bazz:
addi, $sp, $sp, -80
sw $ra, ($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 8($sp)

addi, $t1, $zero, 1
sw, $t1, 4($sp)
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
lw, $t3, 80($sp)  
sw, $t1, 4($t3)   
lw $t3, 80($sp) #getting instance self 
sw $t3, 28($sp)

lw $t1,28($sp) 
la $t3, void_data
beq $t1, $t3, error_expr_void
lw $v1, ($t1) #Adress Method
li $s0,0
li $s1, 2147483647
move $t1,$v1
la $t2,Bazz_methods
jal calculateDistance
move $t1,$v1
la $t2,Razz_methods
jal calculateDistance
move $t1,$v1
la $t2,Foo_methods
jal calculateDistance
move $t1,$v1
la $t2,Bar_methods
jal calculateDistance

beqz $s0, error_branch
sw $s0, 16($sp)

la $t1, Bazz_methods
sw $t1, 24($sp)

lw, $t3, 24($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 16($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 20($sp)
lw $t0, 20($sp) #Goto If Label
beq $t0, 1, label2

la $t1, Razz_methods
sw $t1, 24($sp)

lw, $t3, 24($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 16($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 20($sp)
lw $t0, 20($sp) #Goto If Label
beq $t0, 1, label3

la $t1, Foo_methods
sw $t1, 24($sp)

lw, $t3, 24($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 16($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 20($sp)
lw $t0, 20($sp) #Goto If Label
beq $t0, 1, label4

la $t1, Bar_methods
sw $t1, 24($sp)

lw, $t3, 24($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 16($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 20($sp)
lw $t0, 20($sp) #Goto If Label
beq $t0, 1, label5
label2:
lw $t1, 28($sp)
sw $t1, 32($sp)

addi $a0, $zero, 24
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Foo_methods
sw $t1, ($t3)
sw, $t3, 36($sp)
move $t0, $sp #call to function init_Foo
addi, $sp, $sp, -4
lw, $s0, 36($t0) #loading param_local__internal_8
sw, $s0 0($sp) #setting param for function call
jal init_Foo
addi, $sp, $sp, 4
sw $s0, 40($sp) #Saving result on local__internal_9
lw $t1, 36($sp)
sw $t1, 12($sp)
j label1
label3:
lw $t1, 28($sp)
sw $t1, 44($sp)

addi $a0, $zero, 40
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bar_methods
sw $t1, ($t3)
sw, $t3, 48($sp)
move $t0, $sp #call to function init_Bar
addi, $sp, $sp, -4
lw, $s0, 48($t0) #loading param_local__internal_11
sw, $s0 0($sp) #setting param for function call
jal init_Bar
addi, $sp, $sp, 4
sw $s0, 52($sp) #Saving result on local__internal_12
lw $t1, 48($sp)
sw $t1, 12($sp)
j label1
label4:
lw $t1, 28($sp)
sw $t1, 56($sp)

addi $a0, $zero, 32
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Razz_methods
sw $t1, ($t3)
sw, $t3, 60($sp)
move $t0, $sp #call to function init_Razz
addi, $sp, $sp, -4
lw, $s0, 60($t0) #loading param_local__internal_14
sw, $s0 0($sp) #setting param for function call
jal init_Razz
addi, $sp, $sp, 4
sw $s0, 64($sp) #Saving result on local__internal_15
lw $t1, 60($sp)
sw $t1, 12($sp)
j label1
label5:
lw $t1, 28($sp)
sw $t1, 68($sp)
lw $t1, 68($sp)
sw $t1, 12($sp)
j label1
label1:

lw, $t1, 12($sp)   
lw, $t3, 80($sp)  
sw, $t1, 8($t3)   
move $t0, $sp #call to function printh
addi, $sp, $sp, -4
lw, $s0, 80($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
jal function_printh_at_Bazz
addi, $sp, $sp, 4
sw $s0, 76($sp) #Saving result on local__internal_18

lw, $t1, 76($sp)   
lw, $t3, 80($sp)  
sw, $t1, 12($t3)   

lw $s0, 80($sp)
lw $ra, ($sp)
addi $sp, $sp,80
jr $ra

function_printh_at_Bazz:
addi, $sp, $sp, -20
sw $ra, ($sp)
lw $t3, 20($sp) #getting instance self 

lw, $t3, 20($sp) #getting instance self 
lw, $t1, 4($t3)  #getting offset h 
sw, $t1, 8($sp)   
move $t0, $sp #call to function out_int
addi, $sp, $sp, -8
lw, $s0, 20($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
lw, $s0, 8($t0) #loading param_local_printh_at_Bazz_internal_1
sw, $s0 4($sp) #setting param for function call
jal function_out_int_at_IO
addi, $sp, $sp, 8
sw $s0, 4($sp) #Saving result on local_printh_at_Bazz_internal_0

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 16($sp)

addi, $t1, $zero, 0
sw, $t1, 12($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 16($t0) #loading param_local_printh_at_Bazz_internal_3
sw, $s0 0($sp) #setting param for function call
lw, $s0, 12($t0) #loading param_local_printh_at_Bazz_internal_2
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 16($sp) #Saving result on local_printh_at_Bazz_internal_3

lw $s0, 16($sp)
lw $ra, ($sp)
addi $sp, $sp,20
jr $ra

function_doh_at_Bazz:
addi, $sp, $sp, -36
sw $ra, ($sp)
lw $t3, 36($sp) #getting instance self 

lw, $t3, 36($sp) #getting instance self 
lw, $t1, 4($t3)  #getting offset h 
sw, $t1, 4($sp)   
lw $t1, 4($sp)
sw $t1, 8($sp)
lw $t3, 36($sp) #getting instance self 

lw, $t3, 36($sp) #getting instance self 
lw, $t1, 4($t3)  #getting offset h 
sw, $t1, 20($sp)   

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 28($sp)

addi, $t1, $zero, 1
sw, $t1, 24($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 28($t0) #loading param_local_doh_at_Bazz_internal_6
sw, $s0 0($sp) #setting param for function call
lw, $s0, 24($t0) #loading param_local_doh_at_Bazz_internal_5
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 28($sp) #Saving result on local_doh_at_Bazz_internal_6

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 16($sp)

lw, $t3, 28($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 20($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 12($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 16($t0) #loading param_local_doh_at_Bazz_internal_3
sw, $s0 0($sp) #setting param for function call
lw, $s0, 12($t0) #loading param_local_doh_at_Bazz_internal_2
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 16($sp) #Saving result on local_doh_at_Bazz_internal_3

lw, $t1, 16($sp)   
lw, $t3, 36($sp)  
sw, $t1, 4($t3)   

lw $s0, 8($sp)
lw $ra, ($sp)
addi $sp, $sp,36
jr $ra

init_Main:
addi, $sp, $sp, -36
sw $ra, ($sp)

addi $a0, $zero, 16
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bazz_methods
sw $t1, ($t3)
sw, $t3, 4($sp)
move $t0, $sp #call to function init_Bazz
addi, $sp, $sp, -4
lw, $s0, 4($t0) #loading param_local__internal_0
sw, $s0 0($sp) #setting param for function call
jal init_Bazz
addi, $sp, $sp, 4
sw $s0, 8($sp) #Saving result on local__internal_1

lw, $t1, 4($sp)   
lw, $t3, 36($sp)  
sw, $t1, 4($t3)   

addi $a0, $zero, 24
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Foo_methods
sw $t1, ($t3)
sw, $t3, 12($sp)
move $t0, $sp #call to function init_Foo
addi, $sp, $sp, -4
lw, $s0, 12($t0) #loading param_local__internal_2
sw, $s0 0($sp) #setting param for function call
jal init_Foo
addi, $sp, $sp, 4
sw $s0, 16($sp) #Saving result on local__internal_3

lw, $t1, 12($sp)   
lw, $t3, 36($sp)  
sw, $t1, 8($t3)   

addi $a0, $zero, 32
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Razz_methods
sw $t1, ($t3)
sw, $t3, 20($sp)
move $t0, $sp #call to function init_Razz
addi, $sp, $sp, -4
lw, $s0, 20($t0) #loading param_local__internal_4
sw, $s0 0($sp) #setting param for function call
jal init_Razz
addi, $sp, $sp, 4
sw $s0, 24($sp) #Saving result on local__internal_5

lw, $t1, 20($sp)   
lw, $t3, 36($sp)  
sw, $t1, 12($t3)   

addi $a0, $zero, 40
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bar_methods
sw $t1, ($t3)
sw, $t3, 28($sp)
move $t0, $sp #call to function init_Bar
addi, $sp, $sp, -4
lw, $s0, 28($t0) #loading param_local__internal_6
sw, $s0 0($sp) #setting param for function call
jal init_Bar
addi, $sp, $sp, 4
sw $s0, 32($sp) #Saving result on local__internal_7

lw, $t1, 28($sp)   
lw, $t3, 36($sp)  
sw, $t1, 16($t3)   

lw $s0, 36($sp)
lw $ra, ($sp)
addi $sp, $sp,36
jr $ra

function_main_at_Main:
addi, $sp, $sp, -20
sw $ra, ($sp)

addi $a0, $zero, 12
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,String_methods
sw $t1, ($t3)
sw, $t3, 8($sp)

la $t1, data_0
sw $t1, 12($sp)
move $t0, $sp #call to function init_length
addi, $sp, $sp, -4
lw, $s0, 12($t0) #loading param_local_main_at_Main_internal_2
sw, $s0 0($sp) #setting param for function call
jal init_length
addi, $sp, $sp, 4
sw $s0, 16($sp) #Saving result on local_main_at_Main_internal_3
move $t0, $sp #call to function init_String
addi, $sp, $sp, -12
lw, $s0, 8($t0) #loading param_local_main_at_Main_internal_1
sw, $s0 0($sp) #setting param for function call
lw, $s0, 12($t0) #loading param_local_main_at_Main_internal_2
sw, $s0 4($sp) #setting param for function call
lw, $s0, 16($t0) #loading param_local_main_at_Main_internal_3
sw, $s0 8($sp) #setting param for function call
jal init_String
addi, $sp, $sp, 12
sw $s0, 4($sp) #Saving result on local_main_at_Main_internal_0

lw $s0, 8($sp)
lw $ra, ($sp)
addi $sp, $sp,20
jr $ra

init_Foo:
addi, $sp, $sp, -180
sw $ra, ($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 8($sp)

addi, $t1, $zero, 1
sw, $t1, 4($sp)
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
lw, $t3, 180($sp)  
sw, $t1, 4($t3)   
lw $t3, 180($sp) #getting instance self 
sw $t3, 28($sp)

lw $t1,28($sp) 
la $t3, void_data
beq $t1, $t3, error_expr_void
lw $v1, ($t1) #Adress Method
li $s0,0
li $s1, 2147483647
move $t1,$v1
la $t2,Bazz_methods
jal calculateDistance
move $t1,$v1
la $t2,Razz_methods
jal calculateDistance
move $t1,$v1
la $t2,Foo_methods
jal calculateDistance
move $t1,$v1
la $t2,Bar_methods
jal calculateDistance

beqz $s0, error_branch
sw $s0, 16($sp)

la $t1, Bazz_methods
sw $t1, 24($sp)

lw, $t3, 24($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 16($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 20($sp)
lw $t0, 20($sp) #Goto If Label
beq $t0, 1, label7

la $t1, Razz_methods
sw $t1, 24($sp)

lw, $t3, 24($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 16($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 20($sp)
lw $t0, 20($sp) #Goto If Label
beq $t0, 1, label8

la $t1, Foo_methods
sw $t1, 24($sp)

lw, $t3, 24($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 16($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 20($sp)
lw $t0, 20($sp) #Goto If Label
beq $t0, 1, label9

la $t1, Bar_methods
sw $t1, 24($sp)

lw, $t3, 24($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 16($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 20($sp)
lw $t0, 20($sp) #Goto If Label
beq $t0, 1, label10
label7:
lw $t1, 28($sp)
sw $t1, 32($sp)

addi $a0, $zero, 24
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Foo_methods
sw $t1, ($t3)
sw, $t3, 36($sp)
move $t0, $sp #call to function init_Foo
addi, $sp, $sp, -4
lw, $s0, 36($t0) #loading param_local__internal_8
sw, $s0 0($sp) #setting param for function call
jal init_Foo
addi, $sp, $sp, 4
sw $s0, 40($sp) #Saving result on local__internal_9
lw $t1, 36($sp)
sw $t1, 12($sp)
j label6
label8:
lw $t1, 28($sp)
sw $t1, 44($sp)

addi $a0, $zero, 40
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bar_methods
sw $t1, ($t3)
sw, $t3, 48($sp)
move $t0, $sp #call to function init_Bar
addi, $sp, $sp, -4
lw, $s0, 48($t0) #loading param_local__internal_11
sw, $s0 0($sp) #setting param for function call
jal init_Bar
addi, $sp, $sp, 4
sw $s0, 52($sp) #Saving result on local__internal_12
lw $t1, 48($sp)
sw $t1, 12($sp)
j label6
label9:
lw $t1, 28($sp)
sw $t1, 56($sp)

addi $a0, $zero, 32
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Razz_methods
sw $t1, ($t3)
sw, $t3, 60($sp)
move $t0, $sp #call to function init_Razz
addi, $sp, $sp, -4
lw, $s0, 60($t0) #loading param_local__internal_14
sw, $s0 0($sp) #setting param for function call
jal init_Razz
addi, $sp, $sp, 4
sw $s0, 64($sp) #Saving result on local__internal_15
lw $t1, 60($sp)
sw $t1, 12($sp)
j label6
label10:
lw $t1, 28($sp)
sw $t1, 68($sp)
lw $t1, 68($sp)
sw $t1, 12($sp)
j label6
label6:

lw, $t1, 12($sp)   
lw, $t3, 180($sp)  
sw, $t1, 8($t3)   
move $t0, $sp #call to function printh
addi, $sp, $sp, -4
lw, $s0, 180($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
jal function_printh_at_Bazz
addi, $sp, $sp, 4
sw $s0, 76($sp) #Saving result on local__internal_18

lw, $t1, 76($sp)   
lw, $t3, 180($sp)  
sw, $t1, 12($t3)   
lw $t3, 180($sp) #getting instance self 
sw $t3, 96($sp)

lw $t1,96($sp) 
la $t3, void_data
beq $t1, $t3, error_expr_void
lw $v1, ($t1) #Adress Method
li $s0,0
li $s1, 2147483647
move $t1,$v1
la $t2,Razz_methods
jal calculateDistance
move $t1,$v1
la $t2,Foo_methods
jal calculateDistance
move $t1,$v1
la $t2,Bar_methods
jal calculateDistance

beqz $s0, error_branch
sw $s0, 84($sp)

la $t1, Razz_methods
sw $t1, 92($sp)

lw, $t3, 92($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 84($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 88($sp)
lw $t0, 88($sp) #Goto If Label
beq $t0, 1, label12

la $t1, Foo_methods
sw $t1, 92($sp)

lw, $t3, 92($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 84($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 88($sp)
lw $t0, 88($sp) #Goto If Label
beq $t0, 1, label13

la $t1, Bar_methods
sw $t1, 92($sp)

lw, $t3, 92($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 84($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 88($sp)
lw $t0, 88($sp) #Goto If Label
beq $t0, 1, label14
label12:
lw $t1, 96($sp)
sw $t1, 100($sp)

addi $a0, $zero, 40
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bar_methods
sw $t1, ($t3)
sw, $t3, 104($sp)
move $t0, $sp #call to function init_Bar
addi, $sp, $sp, -4
lw, $s0, 104($t0) #loading param_local__internal_25
sw, $s0 0($sp) #setting param for function call
jal init_Bar
addi, $sp, $sp, 4
sw $s0, 108($sp) #Saving result on local__internal_26
lw $t1, 104($sp)
sw $t1, 80($sp)
j label11
label13:
lw $t1, 96($sp)
sw $t1, 112($sp)

addi $a0, $zero, 32
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Razz_methods
sw $t1, ($t3)
sw, $t3, 116($sp)
move $t0, $sp #call to function init_Razz
addi, $sp, $sp, -4
lw, $s0, 116($t0) #loading param_local__internal_28
sw, $s0 0($sp) #setting param for function call
jal init_Razz
addi, $sp, $sp, 4
sw $s0, 120($sp) #Saving result on local__internal_29
lw $t1, 116($sp)
sw $t1, 80($sp)
j label11
label14:
lw $t1, 96($sp)
sw $t1, 124($sp)
lw $t1, 124($sp)
sw $t1, 80($sp)
j label11
label11:

lw, $t1, 80($sp)   
lw, $t3, 180($sp)  
sw, $t1, 16($t3)   
lw $t3, 180($sp) #getting instance self 

lw, $t3, 180($sp) #getting instance self 
lw, $t1, 16($t3)  #getting offset a 
sw, $t1, 160($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 160($t0)
sw, $s0 0($sp)
lw $a0, 160($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 44($a1)#Function doh:function_doh_at_Foo
jalr $a2
addi, $sp, $sp, 4
sw $s0, 156($sp)
lw $t3, 180($sp) #getting instance self 

lw, $t3, 180($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset g 
sw, $t1, 168($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 168($t0)
sw, $s0 0($sp)
lw $a0, 168($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 44($a1)#Function doh:function_doh_at_Foo
jalr $a2
addi, $sp, $sp, 4
sw $s0, 164($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 152($sp)

lw, $t3, 164($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 156($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 148($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 152($t0) #loading param_local__internal_37
sw, $s0 0($sp) #setting param for function call
lw, $s0, 148($t0) #loading param_local__internal_36
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 152($sp) #Saving result on local__internal_37
move $t0, $sp #call to function doh
addi, $sp, $sp, -4
lw, $s0, 180($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
jal function_doh_at_Foo
addi, $sp, $sp, 4
sw $s0, 172($sp) #Saving result on local__internal_42

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 144($sp)

lw, $t3, 172($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 152($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
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
move $t0, $sp #call to function printh
addi, $sp, $sp, -4
lw, $s0, 180($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
jal function_printh_at_Bazz
addi, $sp, $sp, 4
sw $s0, 176($sp) #Saving result on local__internal_43

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 136($sp)

lw, $t3, 176($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 144($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 132($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 136($t0) #loading param_local__internal_33
sw, $s0 0($sp) #setting param for function call
lw, $s0, 132($t0) #loading param_local__internal_32
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 136($sp) #Saving result on local__internal_33

lw, $t1, 136($sp)   
lw, $t3, 180($sp)  
sw, $t1, 20($t3)   

lw $s0, 180($sp)
lw $ra, ($sp)
addi $sp, $sp,180
jr $ra

function_doh_at_Foo:
addi, $sp, $sp, -36
sw $ra, ($sp)
lw $t3, 36($sp) #getting instance self 

lw, $t3, 36($sp) #getting instance self 
lw, $t1, 4($t3)  #getting offset h 
sw, $t1, 4($sp)   
lw $t1, 4($sp)
sw $t1, 8($sp)
lw $t3, 36($sp) #getting instance self 

lw, $t3, 36($sp) #getting instance self 
lw, $t1, 4($t3)  #getting offset h 
sw, $t1, 20($sp)   

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
lw, $s0, 28($t0) #loading param_local_doh_at_Foo_internal_6
sw, $s0 0($sp) #setting param for function call
lw, $s0, 24($t0) #loading param_local_doh_at_Foo_internal_5
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 28($sp) #Saving result on local_doh_at_Foo_internal_6

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 16($sp)

lw, $t3, 28($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 20($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 12($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 16($t0) #loading param_local_doh_at_Foo_internal_3
sw, $s0 0($sp) #setting param for function call
lw, $s0, 12($t0) #loading param_local_doh_at_Foo_internal_2
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 16($sp) #Saving result on local_doh_at_Foo_internal_3

lw, $t1, 16($sp)   
lw, $t3, 36($sp)  
sw, $t1, 4($t3)   

lw $s0, 8($sp)
lw $ra, ($sp)
addi $sp, $sp,36
jr $ra

init_Razz:
addi, $sp, $sp, -284
sw $ra, ($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 8($sp)

addi, $t1, $zero, 1
sw, $t1, 4($sp)
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
lw, $t3, 284($sp)  
sw, $t1, 4($t3)   
lw $t3, 284($sp) #getting instance self 
sw $t3, 28($sp)

lw $t1,28($sp) 
la $t3, void_data
beq $t1, $t3, error_expr_void
lw $v1, ($t1) #Adress Method
li $s0,0
li $s1, 2147483647
move $t1,$v1
la $t2,Bazz_methods
jal calculateDistance
move $t1,$v1
la $t2,Razz_methods
jal calculateDistance
move $t1,$v1
la $t2,Foo_methods
jal calculateDistance
move $t1,$v1
la $t2,Bar_methods
jal calculateDistance

beqz $s0, error_branch
sw $s0, 16($sp)

la $t1, Bazz_methods
sw $t1, 24($sp)

lw, $t3, 24($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 16($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 20($sp)
lw $t0, 20($sp) #Goto If Label
beq $t0, 1, label16

la $t1, Razz_methods
sw $t1, 24($sp)

lw, $t3, 24($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 16($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 20($sp)
lw $t0, 20($sp) #Goto If Label
beq $t0, 1, label17

la $t1, Foo_methods
sw $t1, 24($sp)

lw, $t3, 24($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 16($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 20($sp)
lw $t0, 20($sp) #Goto If Label
beq $t0, 1, label18

la $t1, Bar_methods
sw $t1, 24($sp)

lw, $t3, 24($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 16($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 20($sp)
lw $t0, 20($sp) #Goto If Label
beq $t0, 1, label19
label16:
lw $t1, 28($sp)
sw $t1, 32($sp)

addi $a0, $zero, 24
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Foo_methods
sw $t1, ($t3)
sw, $t3, 36($sp)
move $t0, $sp #call to function init_Foo
addi, $sp, $sp, -4
lw, $s0, 36($t0) #loading param_local__internal_8
sw, $s0 0($sp) #setting param for function call
jal init_Foo
addi, $sp, $sp, 4
sw $s0, 40($sp) #Saving result on local__internal_9
lw $t1, 36($sp)
sw $t1, 12($sp)
j label15
label17:
lw $t1, 28($sp)
sw $t1, 44($sp)

addi $a0, $zero, 40
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bar_methods
sw $t1, ($t3)
sw, $t3, 48($sp)
move $t0, $sp #call to function init_Bar
addi, $sp, $sp, -4
lw, $s0, 48($t0) #loading param_local__internal_11
sw, $s0 0($sp) #setting param for function call
jal init_Bar
addi, $sp, $sp, 4
sw $s0, 52($sp) #Saving result on local__internal_12
lw $t1, 48($sp)
sw $t1, 12($sp)
j label15
label18:
lw $t1, 28($sp)
sw $t1, 56($sp)

addi $a0, $zero, 32
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Razz_methods
sw $t1, ($t3)
sw, $t3, 60($sp)
move $t0, $sp #call to function init_Razz
addi, $sp, $sp, -4
lw, $s0, 60($t0) #loading param_local__internal_14
sw, $s0 0($sp) #setting param for function call
jal init_Razz
addi, $sp, $sp, 4
sw $s0, 64($sp) #Saving result on local__internal_15
lw $t1, 60($sp)
sw $t1, 12($sp)
j label15
label19:
lw $t1, 28($sp)
sw $t1, 68($sp)
lw $t1, 68($sp)
sw $t1, 12($sp)
j label15
label15:

lw, $t1, 12($sp)   
lw, $t3, 284($sp)  
sw, $t1, 8($t3)   
move $t0, $sp #call to function printh
addi, $sp, $sp, -4
lw, $s0, 284($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
jal function_printh_at_Bazz
addi, $sp, $sp, 4
sw $s0, 76($sp) #Saving result on local__internal_18

lw, $t1, 76($sp)   
lw, $t3, 284($sp)  
sw, $t1, 12($t3)   
lw $t3, 284($sp) #getting instance self 
sw $t3, 96($sp)

lw $t1,96($sp) 
la $t3, void_data
beq $t1, $t3, error_expr_void
lw $v1, ($t1) #Adress Method
li $s0,0
li $s1, 2147483647
move $t1,$v1
la $t2,Razz_methods
jal calculateDistance
move $t1,$v1
la $t2,Foo_methods
jal calculateDistance
move $t1,$v1
la $t2,Bar_methods
jal calculateDistance

beqz $s0, error_branch
sw $s0, 84($sp)

la $t1, Razz_methods
sw $t1, 92($sp)

lw, $t3, 92($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 84($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 88($sp)
lw $t0, 88($sp) #Goto If Label
beq $t0, 1, label21

la $t1, Foo_methods
sw $t1, 92($sp)

lw, $t3, 92($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 84($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 88($sp)
lw $t0, 88($sp) #Goto If Label
beq $t0, 1, label22

la $t1, Bar_methods
sw $t1, 92($sp)

lw, $t3, 92($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 84($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 88($sp)
lw $t0, 88($sp) #Goto If Label
beq $t0, 1, label23
label21:
lw $t1, 96($sp)
sw $t1, 100($sp)

addi $a0, $zero, 40
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bar_methods
sw $t1, ($t3)
sw, $t3, 104($sp)
move $t0, $sp #call to function init_Bar
addi, $sp, $sp, -4
lw, $s0, 104($t0) #loading param_local__internal_25
sw, $s0 0($sp) #setting param for function call
jal init_Bar
addi, $sp, $sp, 4
sw $s0, 108($sp) #Saving result on local__internal_26
lw $t1, 104($sp)
sw $t1, 80($sp)
j label20
label22:
lw $t1, 96($sp)
sw $t1, 112($sp)

addi $a0, $zero, 32
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Razz_methods
sw $t1, ($t3)
sw, $t3, 116($sp)
move $t0, $sp #call to function init_Razz
addi, $sp, $sp, -4
lw, $s0, 116($t0) #loading param_local__internal_28
sw, $s0 0($sp) #setting param for function call
jal init_Razz
addi, $sp, $sp, 4
sw $s0, 120($sp) #Saving result on local__internal_29
lw $t1, 116($sp)
sw $t1, 80($sp)
j label20
label23:
lw $t1, 96($sp)
sw $t1, 124($sp)
lw $t1, 124($sp)
sw $t1, 80($sp)
j label20
label20:

lw, $t1, 80($sp)   
lw, $t3, 284($sp)  
sw, $t1, 16($t3)   
lw $t3, 284($sp) #getting instance self 

lw, $t3, 284($sp) #getting instance self 
lw, $t1, 16($t3)  #getting offset a 
sw, $t1, 160($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 160($t0)
sw, $s0 0($sp)
lw $a0, 160($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 44($a1)#Function doh:function_doh_at_Foo
jalr $a2
addi, $sp, $sp, 4
sw $s0, 156($sp)
lw $t3, 284($sp) #getting instance self 

lw, $t3, 284($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset g 
sw, $t1, 168($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 168($t0)
sw, $s0 0($sp)
lw $a0, 168($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 44($a1)#Function doh:function_doh_at_Foo
jalr $a2
addi, $sp, $sp, 4
sw $s0, 164($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 152($sp)

lw, $t3, 164($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 156($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 148($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 152($t0) #loading param_local__internal_37
sw, $s0 0($sp) #setting param for function call
lw, $s0, 148($t0) #loading param_local__internal_36
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 152($sp) #Saving result on local__internal_37
move $t0, $sp #call to function doh
addi, $sp, $sp, -4
lw, $s0, 284($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
jal function_doh_at_Foo
addi, $sp, $sp, 4
sw $s0, 172($sp) #Saving result on local__internal_42

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 144($sp)

lw, $t3, 172($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 152($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
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
move $t0, $sp #call to function printh
addi, $sp, $sp, -4
lw, $s0, 284($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
jal function_printh_at_Bazz
addi, $sp, $sp, 4
sw $s0, 176($sp) #Saving result on local__internal_43

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 136($sp)

lw, $t3, 176($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 144($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 132($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 136($t0) #loading param_local__internal_33
sw, $s0 0($sp) #setting param for function call
lw, $s0, 132($t0) #loading param_local__internal_32
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 136($sp) #Saving result on local__internal_33

lw, $t1, 136($sp)   
lw, $t3, 284($sp)  
sw, $t1, 20($t3)   
lw $t3, 284($sp) #getting instance self 
sw $t3, 196($sp)

lw $t1,196($sp) 
la $t3, void_data
beq $t1, $t3, error_expr_void
lw $v1, ($t1) #Adress Method
li $s0,0
li $s1, 2147483647
move $t1,$v1
la $t2,Razz_methods
jal calculateDistance
move $t1,$v1
la $t2,Bar_methods
jal calculateDistance

beqz $s0, error_branch
sw $s0, 184($sp)

la $t1, Razz_methods
sw $t1, 192($sp)

lw, $t3, 192($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 184($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 188($sp)
lw $t0, 188($sp) #Goto If Label
beq $t0, 1, label25

la $t1, Bar_methods
sw $t1, 192($sp)

lw, $t3, 192($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 184($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 188($sp)
lw $t0, 188($sp) #Goto If Label
beq $t0, 1, label26
label25:
lw $t1, 196($sp)
sw $t1, 200($sp)

addi $a0, $zero, 40
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bar_methods
sw $t1, ($t3)
sw, $t3, 204($sp)
move $t0, $sp #call to function init_Bar
addi, $sp, $sp, -4
lw, $s0, 204($t0) #loading param_local__internal_50
sw, $s0 0($sp) #setting param for function call
jal init_Bar
addi, $sp, $sp, 4
sw $s0, 208($sp) #Saving result on local__internal_51
lw $t1, 204($sp)
sw $t1, 180($sp)
j label24
label26:
lw $t1, 196($sp)
sw $t1, 212($sp)
lw $t1, 212($sp)
sw $t1, 180($sp)
j label24
label24:

lw, $t1, 180($sp)   
lw, $t3, 284($sp)  
sw, $t1, 24($t3)   
lw $t3, 284($sp) #getting instance self 

lw, $t3, 284($sp) #getting instance self 
lw, $t1, 16($t3)  #getting offset a 
sw, $t1, 256($sp)   
move $t0, $sp #Dynamic_Parent_Call
addi, $sp, $sp, -4
lw, $s0, 256($t0)
sw, $s0 0($sp)
la $t1, void_data
beq $v0, $t1, error_call_void
la $a1, Bazz_methods
lw $a2, 44($a1) #FunctionToCall function_doh_at_Bazz
jalr $a2
addi, $sp, $sp, 4
sw $s0, 252($sp)
lw $t3, 284($sp) #getting instance self 

lw, $t3, 284($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset g 
sw, $t1, 264($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 264($t0)
sw, $s0 0($sp)
lw $a0, 264($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 44($a1)#Function doh:function_doh_at_Foo
jalr $a2
addi, $sp, $sp, 4
sw $s0, 260($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 248($sp)

lw, $t3, 260($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 252($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 244($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 248($t0) #loading param_local__internal_61
sw, $s0 0($sp) #setting param for function call
lw, $s0, 244($t0) #loading param_local__internal_60
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 248($sp) #Saving result on local__internal_61
lw $t3, 284($sp) #getting instance self 

lw, $t3, 284($sp) #getting instance self 
lw, $t1, 24($t3)  #getting offset e 
sw, $t1, 272($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 272($t0)
sw, $s0 0($sp)
lw $a0, 272($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 44($a1)#Function doh:function_doh_at_Foo
jalr $a2
addi, $sp, $sp, 4
sw $s0, 268($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 240($sp)

lw, $t3, 268($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 248($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 236($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 240($t0) #loading param_local__internal_59
sw, $s0 0($sp) #setting param for function call
lw, $s0, 236($t0) #loading param_local__internal_58
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 240($sp) #Saving result on local__internal_59
move $t0, $sp #call to function doh
addi, $sp, $sp, -4
lw, $s0, 284($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
jal function_doh_at_Foo
addi, $sp, $sp, 4
sw $s0, 276($sp) #Saving result on local__internal_68

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 232($sp)

lw, $t3, 276($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 240($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 228($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 232($t0) #loading param_local__internal_57
sw, $s0 0($sp) #setting param for function call
lw, $s0, 228($t0) #loading param_local__internal_56
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 232($sp) #Saving result on local__internal_57
move $t0, $sp #call to function printh
addi, $sp, $sp, -4
lw, $s0, 284($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
jal function_printh_at_Bazz
addi, $sp, $sp, 4
sw $s0, 280($sp) #Saving result on local__internal_69

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 224($sp)

lw, $t3, 280($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 232($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 220($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 224($t0) #loading param_local__internal_55
sw, $s0 0($sp) #setting param for function call
lw, $s0, 220($t0) #loading param_local__internal_54
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 224($sp) #Saving result on local__internal_55

lw, $t1, 224($sp)   
lw, $t3, 284($sp)  
sw, $t1, 28($t3)   

lw $s0, 284($sp)
lw $ra, ($sp)
addi $sp, $sp,284
jr $ra

init_Bar:
addi, $sp, $sp, -292
sw $ra, ($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 8($sp)

addi, $t1, $zero, 1
sw, $t1, 4($sp)
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
lw, $t3, 292($sp)  
sw, $t1, 4($t3)   
lw $t3, 292($sp) #getting instance self 
sw $t3, 28($sp)

lw $t1,28($sp) 
la $t3, void_data
beq $t1, $t3, error_expr_void
lw $v1, ($t1) #Adress Method
li $s0,0
li $s1, 2147483647
move $t1,$v1
la $t2,Bazz_methods
jal calculateDistance
move $t1,$v1
la $t2,Razz_methods
jal calculateDistance
move $t1,$v1
la $t2,Foo_methods
jal calculateDistance
move $t1,$v1
la $t2,Bar_methods
jal calculateDistance

beqz $s0, error_branch
sw $s0, 16($sp)

la $t1, Bazz_methods
sw $t1, 24($sp)

lw, $t3, 24($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 16($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 20($sp)
lw $t0, 20($sp) #Goto If Label
beq $t0, 1, label28

la $t1, Razz_methods
sw $t1, 24($sp)

lw, $t3, 24($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 16($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 20($sp)
lw $t0, 20($sp) #Goto If Label
beq $t0, 1, label29

la $t1, Foo_methods
sw $t1, 24($sp)

lw, $t3, 24($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 16($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 20($sp)
lw $t0, 20($sp) #Goto If Label
beq $t0, 1, label30

la $t1, Bar_methods
sw $t1, 24($sp)

lw, $t3, 24($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 16($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 20($sp)
lw $t0, 20($sp) #Goto If Label
beq $t0, 1, label31
label28:
lw $t1, 28($sp)
sw $t1, 32($sp)

addi $a0, $zero, 24
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Foo_methods
sw $t1, ($t3)
sw, $t3, 36($sp)
move $t0, $sp #call to function init_Foo
addi, $sp, $sp, -4
lw, $s0, 36($t0) #loading param_local__internal_8
sw, $s0 0($sp) #setting param for function call
jal init_Foo
addi, $sp, $sp, 4
sw $s0, 40($sp) #Saving result on local__internal_9
lw $t1, 36($sp)
sw $t1, 12($sp)
j label27
label29:
lw $t1, 28($sp)
sw $t1, 44($sp)

addi $a0, $zero, 40
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bar_methods
sw $t1, ($t3)
sw, $t3, 48($sp)
move $t0, $sp #call to function init_Bar
addi, $sp, $sp, -4
lw, $s0, 48($t0) #loading param_local__internal_11
sw, $s0 0($sp) #setting param for function call
jal init_Bar
addi, $sp, $sp, 4
sw $s0, 52($sp) #Saving result on local__internal_12
lw $t1, 48($sp)
sw $t1, 12($sp)
j label27
label30:
lw $t1, 28($sp)
sw $t1, 56($sp)

addi $a0, $zero, 32
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Razz_methods
sw $t1, ($t3)
sw, $t3, 60($sp)
move $t0, $sp #call to function init_Razz
addi, $sp, $sp, -4
lw, $s0, 60($t0) #loading param_local__internal_14
sw, $s0 0($sp) #setting param for function call
jal init_Razz
addi, $sp, $sp, 4
sw $s0, 64($sp) #Saving result on local__internal_15
lw $t1, 60($sp)
sw $t1, 12($sp)
j label27
label31:
lw $t1, 28($sp)
sw $t1, 68($sp)
lw $t1, 68($sp)
sw $t1, 12($sp)
j label27
label27:

lw, $t1, 12($sp)   
lw, $t3, 292($sp)  
sw, $t1, 8($t3)   
move $t0, $sp #call to function printh
addi, $sp, $sp, -4
lw, $s0, 292($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
jal function_printh_at_Bazz
addi, $sp, $sp, 4
sw $s0, 76($sp) #Saving result on local__internal_18

lw, $t1, 76($sp)   
lw, $t3, 292($sp)  
sw, $t1, 12($t3)   
lw $t3, 292($sp) #getting instance self 
sw $t3, 96($sp)

lw $t1,96($sp) 
la $t3, void_data
beq $t1, $t3, error_expr_void
lw $v1, ($t1) #Adress Method
li $s0,0
li $s1, 2147483647
move $t1,$v1
la $t2,Razz_methods
jal calculateDistance
move $t1,$v1
la $t2,Foo_methods
jal calculateDistance
move $t1,$v1
la $t2,Bar_methods
jal calculateDistance

beqz $s0, error_branch
sw $s0, 84($sp)

la $t1, Razz_methods
sw $t1, 92($sp)

lw, $t3, 92($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 84($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 88($sp)
lw $t0, 88($sp) #Goto If Label
beq $t0, 1, label33

la $t1, Foo_methods
sw $t1, 92($sp)

lw, $t3, 92($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 84($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 88($sp)
lw $t0, 88($sp) #Goto If Label
beq $t0, 1, label34

la $t1, Bar_methods
sw $t1, 92($sp)

lw, $t3, 92($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 84($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 88($sp)
lw $t0, 88($sp) #Goto If Label
beq $t0, 1, label35
label33:
lw $t1, 96($sp)
sw $t1, 100($sp)

addi $a0, $zero, 40
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bar_methods
sw $t1, ($t3)
sw, $t3, 104($sp)
move $t0, $sp #call to function init_Bar
addi, $sp, $sp, -4
lw, $s0, 104($t0) #loading param_local__internal_25
sw, $s0 0($sp) #setting param for function call
jal init_Bar
addi, $sp, $sp, 4
sw $s0, 108($sp) #Saving result on local__internal_26
lw $t1, 104($sp)
sw $t1, 80($sp)
j label32
label34:
lw $t1, 96($sp)
sw $t1, 112($sp)

addi $a0, $zero, 32
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Razz_methods
sw $t1, ($t3)
sw, $t3, 116($sp)
move $t0, $sp #call to function init_Razz
addi, $sp, $sp, -4
lw, $s0, 116($t0) #loading param_local__internal_28
sw, $s0 0($sp) #setting param for function call
jal init_Razz
addi, $sp, $sp, 4
sw $s0, 120($sp) #Saving result on local__internal_29
lw $t1, 116($sp)
sw $t1, 80($sp)
j label32
label35:
lw $t1, 96($sp)
sw $t1, 124($sp)
lw $t1, 124($sp)
sw $t1, 80($sp)
j label32
label32:

lw, $t1, 80($sp)   
lw, $t3, 292($sp)  
sw, $t1, 16($t3)   
lw $t3, 292($sp) #getting instance self 

lw, $t3, 292($sp) #getting instance self 
lw, $t1, 16($t3)  #getting offset a 
sw, $t1, 160($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 160($t0)
sw, $s0 0($sp)
lw $a0, 160($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 44($a1)#Function doh:function_doh_at_Foo
jalr $a2
addi, $sp, $sp, 4
sw $s0, 156($sp)
lw $t3, 292($sp) #getting instance self 

lw, $t3, 292($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset g 
sw, $t1, 168($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 168($t0)
sw, $s0 0($sp)
lw $a0, 168($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 44($a1)#Function doh:function_doh_at_Foo
jalr $a2
addi, $sp, $sp, 4
sw $s0, 164($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 152($sp)

lw, $t3, 164($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 156($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 148($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 152($t0) #loading param_local__internal_37
sw, $s0 0($sp) #setting param for function call
lw, $s0, 148($t0) #loading param_local__internal_36
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 152($sp) #Saving result on local__internal_37
move $t0, $sp #call to function doh
addi, $sp, $sp, -4
lw, $s0, 292($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
jal function_doh_at_Foo
addi, $sp, $sp, 4
sw $s0, 172($sp) #Saving result on local__internal_42

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 144($sp)

lw, $t3, 172($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 152($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
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
move $t0, $sp #call to function printh
addi, $sp, $sp, -4
lw, $s0, 292($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
jal function_printh_at_Bazz
addi, $sp, $sp, 4
sw $s0, 176($sp) #Saving result on local__internal_43

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 136($sp)

lw, $t3, 176($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 144($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 132($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 136($t0) #loading param_local__internal_33
sw, $s0 0($sp) #setting param for function call
lw, $s0, 132($t0) #loading param_local__internal_32
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 136($sp) #Saving result on local__internal_33

lw, $t1, 136($sp)   
lw, $t3, 292($sp)  
sw, $t1, 20($t3)   
lw $t3, 292($sp) #getting instance self 
sw $t3, 196($sp)

lw $t1,196($sp) 
la $t3, void_data
beq $t1, $t3, error_expr_void
lw $v1, ($t1) #Adress Method
li $s0,0
li $s1, 2147483647
move $t1,$v1
la $t2,Razz_methods
jal calculateDistance
move $t1,$v1
la $t2,Bar_methods
jal calculateDistance

beqz $s0, error_branch
sw $s0, 184($sp)

la $t1, Razz_methods
sw $t1, 192($sp)

lw, $t3, 192($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 184($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 188($sp)
lw $t0, 188($sp) #Goto If Label
beq $t0, 1, label37

la $t1, Bar_methods
sw $t1, 192($sp)

lw, $t3, 192($sp)
lw,$t1,4($t3) #Load Equal Node
lw, $t3, 184($sp)
lw,$t2,4($t3)
jal Equals_comparison
sw, $t3, 188($sp)
lw $t0, 188($sp) #Goto If Label
beq $t0, 1, label38
label37:
lw $t1, 196($sp)
sw $t1, 200($sp)

addi $a0, $zero, 40
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Bar_methods
sw $t1, ($t3)
sw, $t3, 204($sp)
move $t0, $sp #call to function init_Bar
addi, $sp, $sp, -4
lw, $s0, 204($t0) #loading param_local__internal_50
sw, $s0 0($sp) #setting param for function call
jal init_Bar
addi, $sp, $sp, 4
sw $s0, 208($sp) #Saving result on local__internal_51
lw $t1, 204($sp)
sw $t1, 180($sp)
j label36
label38:
lw $t1, 196($sp)
sw $t1, 212($sp)
lw $t1, 212($sp)
sw $t1, 180($sp)
j label36
label36:

lw, $t1, 180($sp)   
lw, $t3, 292($sp)  
sw, $t1, 24($t3)   
lw $t3, 292($sp) #getting instance self 

lw, $t3, 292($sp) #getting instance self 
lw, $t1, 16($t3)  #getting offset a 
sw, $t1, 256($sp)   
move $t0, $sp #Dynamic_Parent_Call
addi, $sp, $sp, -4
lw, $s0, 256($t0)
sw, $s0 0($sp)
la $t1, void_data
beq $v0, $t1, error_call_void
la $a1, Bazz_methods
lw $a2, 44($a1) #FunctionToCall function_doh_at_Bazz
jalr $a2
addi, $sp, $sp, 4
sw $s0, 252($sp)
lw $t3, 292($sp) #getting instance self 

lw, $t3, 292($sp) #getting instance self 
lw, $t1, 8($t3)  #getting offset g 
sw, $t1, 264($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 264($t0)
sw, $s0 0($sp)
lw $a0, 264($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 44($a1)#Function doh:function_doh_at_Foo
jalr $a2
addi, $sp, $sp, 4
sw $s0, 260($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 248($sp)

lw, $t3, 260($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 252($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 244($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 248($t0) #loading param_local__internal_61
sw, $s0 0($sp) #setting param for function call
lw, $s0, 244($t0) #loading param_local__internal_60
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 248($sp) #Saving result on local__internal_61
lw $t3, 292($sp) #getting instance self 

lw, $t3, 292($sp) #getting instance self 
lw, $t1, 24($t3)  #getting offset e 
sw, $t1, 272($sp)   
move $t0, $sp #Dynamic Call
addi, $sp, $sp, -4
lw, $s0, 272($t0)
sw, $s0 0($sp)
lw $a0, 272($t0)
la $t1, void_data
beq $a0, $t1, error_call_void
lw $a1, ($a0) #Loading_Adress
lw $a2, 44($a1)#Function doh:function_doh_at_Foo
jalr $a2
addi, $sp, $sp, 4
sw $s0, 268($sp)

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 240($sp)

lw, $t3, 268($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 248($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 236($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 240($t0) #loading param_local__internal_59
sw, $s0 0($sp) #setting param for function call
lw, $s0, 236($t0) #loading param_local__internal_58
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 240($sp) #Saving result on local__internal_59
move $t0, $sp #call to function doh
addi, $sp, $sp, -4
lw, $s0, 292($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
jal function_doh_at_Foo
addi, $sp, $sp, 4
sw $s0, 276($sp) #Saving result on local__internal_68

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 232($sp)

lw, $t3, 276($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 240($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 228($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 232($t0) #loading param_local__internal_57
sw, $s0 0($sp) #setting param for function call
lw, $s0, 228($t0) #loading param_local__internal_56
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 232($sp) #Saving result on local__internal_57
move $t0, $sp #call to function printh
addi, $sp, $sp, -4
lw, $s0, 292($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
jal function_printh_at_Bazz
addi, $sp, $sp, 4
sw $s0, 280($sp) #Saving result on local__internal_69

addi $a0, $zero, 8
li, $v0, 9
syscall
blt, $sp, $v0,error_heap
move, $t3, $v0
la $t1,Int_methods
sw $t1, ($t3)
sw, $t3, 224($sp)

lw, $t3, 280($sp)
lw,$t1,4($t3) #Load sum value
lw, $t3, 232($sp)
lw,$t2,4($t3) #Load sum value
add $t3,$t1,$t2
sw, $t3, 220($sp)
move $t0, $sp #call to function init_Int
addi, $sp, $sp, -8
lw, $s0, 224($t0) #loading param_local__internal_55
sw, $s0 0($sp) #setting param for function call
lw, $s0, 220($t0) #loading param_local__internal_54
sw, $s0 4($sp) #setting param for function call
jal init_Int
addi, $sp, $sp, 8
sw $s0, 224($sp) #Saving result on local__internal_55

lw, $t1, 224($sp)   
lw, $t3, 292($sp)  
sw, $t1, 28($t3)   
move $t0, $sp #call to function doh
addi, $sp, $sp, -4
lw, $s0, 292($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
jal function_doh_at_Foo
addi, $sp, $sp, 4
sw $s0, 284($sp) #Saving result on local__internal_70

lw, $t1, 284($sp)   
lw, $t3, 292($sp)  
sw, $t1, 32($t3)   
move $t0, $sp #call to function printh
addi, $sp, $sp, -4
lw, $s0, 292($t0) #loading param_self
sw, $s0 0($sp) #setting param for function call
jal function_printh_at_Bazz
addi, $sp, $sp, 4
sw $s0, 288($sp) #Saving result on local__internal_71

lw, $t1, 288($sp)   
lw, $t3, 292($sp)  
sw, $t1, 36($t3)   

lw $s0, 292($sp)
lw $ra, ($sp)
addi $sp, $sp,292
jr $ra
