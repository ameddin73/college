# File:		add_ascii_numbers.asm
# Author:	K. Reek
# Contributors:	P. White, W. Carithers
#	        Alexandre Meddin	
#
# Updates:
#		3/2004	M. Reek, named constants
#		10/2007 W. Carithers, alignment
#		09/2009 W. Carithers, separate assembly
#
# Description:	Add two ASCII numbers and store the result in ASCII.
#
# Arguments:	a0: address of parameter block.  The block consists of
#		four words that contain (in this order):
#
#			address of first input string
#			address of second input string
#			address where result should be stored
#			length of the strings and result buffer
#
#		(There is actually other data after this in the
#		parameter block, but it is not relevant to this routine.)
#
# Returns:	The result of the addition, in the buffer specified by
#		the parameter block.
#

	.globl	add_ascii_numbers

add_ascii_numbers:
A_FRAMESIZE = 40

#
# Save registers ra and s0 - s7 on the stack.
#
	addi 	$sp, $sp, -A_FRAMESIZE
	sw 	$ra, -4+A_FRAMESIZE($sp)
	sw 	$s7, 28($sp)
	sw 	$s6, 24($sp)
	sw 	$s5, 20($sp)
	sw 	$s4, 16($sp)
	sw 	$s3, 12($sp)
	sw 	$s2, 8($sp)
	sw 	$s1, 4($sp)
	sw 	$s0, 0($sp)
	
# ##### BEGIN STUDENT CODE BLOCK 1 #####

        lw      $s0, 12($a0)    # s0 = string length
        lw      $s1, 0($a0)     # s1 = string 1
        lw      $s2, 4($a0)     # s2 = string 2
        lw      $s3, 8($a0)     # s3 - result
        li      $s7, 10
        li      $t2, 48

        move    $t0, $s0        # move to back
        addi    $t0, -1
        add     $s1, $s1, $t0
        add     $s2, $s2, $t0
        add     $s3, $s3, $t0

        sb      $t2, 0($s3)     #clear buffer

loop:
        beq     $s0, $zero, done
        li      $t0, 1          # check if last in buffer
        beq     $s0, $t0, end_buffer
        sb      $t2, -1($s3)    # clear buffer
end_buffer:
        lb      $s4, 0($s1)     # s4 = char (string 1)
        lb      $s5, 0($s2)     # s5 = char (string 2)
        addi    $s4, -48        # convert to decimal
        addi    $s5, -48
        add     $t0, $s4, $s5   # addition formula
        move    $t1, $t0
        addi    $t1, -10
        bltz    $t1, one_digit
        div     $t0, $s7        # seperate digits
        li      $t7, 1          # check if final digit
        beq     $s0, $t7, final
        lb      $t5, -1($s3)    # add carry
        addi    $t5, 1
        sb      $t5, -1($s3)
final:
        mfhi    $t1             # store remainder
        lb      $t5, 0($s3)
        add     $t5, $t5, $t1
        sb      $t5, 0($s3)
        j       two_digit
one_digit:
        li      $t7, 9          # check for second carry
        bne     $t0, $t7, sec_carry
        li      $t7, 48
        lb      $t6, 0($s3)
        beq     $t6, $t7, sec_carry
        sb      $t7, 0($s3) 
        lb      $t5, -1($s3)    # add carry
        addi    $t5, 1
        sb      $t5, -1($s3)
        j       two_digit
sec_carry:
        lb      $t5, 0($s3)
        add     $t5, $t5, $t0
        sb      $t5, 0($s3)
two_digit:
        addi    $s1, -1          # increment
        addi    $s2, -1
        addi    $s3, -1
        addi    $s0, -1
        j       loop
done:

        la      $t0, 8($a0)     # return result
        sw      $s3, 0($t0)

# ###### END STUDENT CODE BLOCK 1 ######

#
# Restore registers ra and s0 - s7 from the stack.
#
	lw 	$ra, -4+A_FRAMESIZE($sp)
	lw 	$s7, 28($sp)
	lw 	$s6, 24($sp)
	lw 	$s5, 20($sp)
	lw 	$s4, 16($sp)
	lw 	$s3, 12($sp)
	lw 	$s2, 8($sp)
	lw 	$s1, 4($sp)
	lw 	$s0, 0($sp)
	addi 	$sp, $sp, A_FRAMESIZE

	jr	$ra			# Return to the caller.
