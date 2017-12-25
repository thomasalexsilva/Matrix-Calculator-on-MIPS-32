		
		
		
#; here lies the data section... sorry for the portuguese terms :/		
		.data
		.space 32
ms0:	.asciiz "Type the operation type below \n\n\t->(+)Sum\n\t->(-)Subtraction\n\t->(*)Multiplication\n\t->(/)Division\n\t->(e)Exit\n Option:"
		.space 32
ms1:	.asciiz "e"
		.space 32
ms2:	.asciiz "Type the first number\n"
		.space 32
ms3:	.asciiz "The result is...\t"
ms4:	.asciiz "\n\n\n[PROGRAM EXECUTED WITH SUCSSESS]"
pulalinha:	.asciiz "\n\n"		#;'pulalinh' stands for 'jumpline'
confsoma:	.asciiz "You've chosen sum\n"
confsub:	.asciiz "You've chosen subtraction\n"
confmul:	.asciiz "You've chosen multiplication\n"
confdiv:	.asciiz "You've chosen division\n"
n1:		.space 201
num1:	.word 0 0 0 0 0 0 0 0 0
		.space 32
soma:	.byte '+'
subb:	.byte '-'
multip:	.byte '*'
divi:	.byte '/'
armaz:	.space 32
		.space 32
		
		#;HERE COMES THE COMMAND SECTION, PLEASE REVISE THE MIPS 32 SYSTEM CALLS SO THAT YOU CAN HAVE ANY CHANCE OF UNDERSTANDING IT...
		#;MAY THE '.ASM' BE WITH YOU, YOUNG FELLOW... MAY YOUR COFFEE NEVER END WILE READIN' THIS CODE
		
		

		.text
main:	li $t3, 0
		li $t2, 0  	
#;here comes the main loop
loop:	
	#;menu
		#;the fist message is loaded
		la $a0, ms0($0)
		li $v0, 4
		syscall
        la $a0,n1
		#;{	this line cleans the register 'al', and debug the code with a problem i had. you might load any big-medium value in this register, in easy terms, it kinda stands for the buffer lenth.
        li $a1,201 
		#;}
        li $v0,8            
        syscall 
		
		
	#;comparison of the caracter you typed with the following char values: '+', '-', '*'. '/'
		lb $t1, 0($a0)
        lb $t2,soma
        bne $t1,$t2,fimsoma
        la $a0,confsoma
        li $v0,4
        syscall
		jal dados
		jal sum
		j fimoperacoes
		
fimsoma:		#; in english i'd be something like 'end_of_the_sum'
		lb $t1, 0($a0)
        lb $t2,subb
        bne $t1,$t2,fimsub
        la $a0,confsub
        li $v0,4
        syscall
		jal dados
		jal subt
		j fimoperacoes
		
fimsub:			#; in english i'd be something like 'end_of_the_subtraction'
		lb $t1, 0($a0)
        lb $t2,multip
        bne $t1,$t2,fimmul
        la $a0,confmul
        li $v0,4
        syscall
		jal dados
		jal multi
		j fimoperacoes
		
fimmul:			#; in english i'd be something like 'end_of_the_multiplication'
		lb $t1, 0($a0)
        lb $t2,divi
        bne $t1,$t2,fimdiv
        la $a0,confdiv
        li $v0,4
        syscall
		jal dados
		jal divis
		j fimoperacoes
		
fimdiv:			#; in english i'd be something like 'end_of_the_division'
		lb $t1, 0($a0)
        lb $t2,ms1
        bne $t1,$t2,fimoperacoes
		j fimprog #;jumps to the end of the program
		
fimoperacoes:	#; in english i'd be something like 'end_of_the_operations'
	#;jumps a line and returns to the loop
		la $a0, pulalinha($0)
		li $v0, 4
		syscall
		j loop	
		
fimprog:		#; Here lies the system call that ends up the program
		la $a0, ms4($0)
		li $v0, 4
		syscall
		li $v0, 10
		syscall
		
		#the functions used lie below...
		
			
dados:	#;this is the number readin' loop. here comes the data taking from the user :D
	#;first number
		la $a0, ms2($0)
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		move $t2,$v0
	#;second number
		la $a0, ms2($0)
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		move $t3,$v0
		jr $ra
sum:
		add $t3, $t2, $t3
		la $a0, ms3($0)
		li $v0, 4
		syscall
		move $a0, $t3
		li $v0, 1
		syscall
		jr $ra
	
subt:
		sub $t3, $t2, $t3
		la $a0, ms3($0)
		li $v0, 4
		syscall
		move $a0, $t3
		li $v0, 1
		syscall
		jr $ra
multi:
		mul $t3, $t2, $t3
		la $a0, ms3($0)
		li $v0, 4
		syscall
		move $a0, $t3
		li $v0, 1
		syscall
		jr $ra
		
divis:	li $t4, 4
		li $t8, 8
		sw $t2, num1($t4)
		sw $t3, num1($t8)
		lwc1 $f0, num1($t4)
		cvt.s.w $f2, $f0
		lwc1 $f0, num1($t8)
		cvt.s.w $f3, $f0
		div.s $f3, $f2, $f3
		la $a0, ms3($0)
		li $v0, 4
		syscall
		swc1 $f3, num1($12)
		lwc1 $f12, num1($12)
		li $v0, 2
		syscall
		jr $ra

		
		

