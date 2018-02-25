# Practice 1
# MOISES ISAIAS LOPEZ RIZO 697253
# ELIAS GASPAR ARELLANO    704205
.data 
.text
#########################################	Main	#########################################
	ori $s0, $s0, 8 		# 'n' Number of disks (It is a requirement that $s0 contains N)

# POINTERS TO TOWERS
###########################
	ori $t0, $t0, 0x1001 		# Loads higher bytes of memory address
	sll $t0, $t0, 16     		# Moves higher bytes of memory to left
	ori $s5, $t0, 0x0000 		# Initial tower
	ori $s6, $t0, 0x0020 		# Aux tower
	ori $s7, $t0, 0x0040 		# Final tower
###########################

	or $t1, $t1, $s0	  	# Get number of disks

Initialize:
###########################
	sw $t1, ($s5)             	# Stores disk N into initial tower
	addi $s5, $s5, 4          	# Tower pointer increase
	add $t1, $t1, -1          	# Disk N-1 
	bne $t1, $zero, Initialize	#
###########################

	addi  $t2, $s5, -4    		# Saves pointer to last disk in Initial tower
	ori $s5, $t0, 0x0000		# Returns pointer to the beginning of Initial tower

Expand:	      
###########################
	lw $t1, ($s6)         
	beq $t1, $zero, continue	# If the initial value of the second tower is not zero
	addi $s6, $s6, 32     		# it means that tower 1(initial) invaded addresses of tower 2, 
	addi $s7, $s7, 64     		# so it is necessary to move base pointers of tower 2 and 3.
	j Expand                             
###########################

continue: 
	add $a0, $zero, $s0		# Prepare arguments to call Hanoi
	add $a1, $zero, $t2		# $a1, $a2, $a3 store the address of the last disk stacked in them
	add $a2, $zero, $s6
	add $a3, $zero, $s7
	jal Hanoi
	j exit
#########################################    End Main	#########################################
#########################################    Functions	#########################################
# $a0 = n, $a1 = ini, $a2 = aux, $a3 = end
Hanoi:
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a0, 4($sp)

	# Base case
	bne $a0, 1, else
	
	# Move ini to end
	# When you load data you need to ask if address has something inside it, if not, you decrement address + offset condition
	lw $t0, 0($a1)
	sw $zero, 0($a1)
	beq $a1, $s5, noDec
	beq $a1, $s6, noDec
	beq $a1, $s7, noDec
	addi $a1, $a1, -4
noDec:	# When you store data you don't want to overwrite information, if address has something inside it, you increment address
	lw $t1, 0($a3)
	beq $t1, $zero, write
	addi $a3, $a3, 4
write:	sw $t0, 0($a3)
	j return
	
else:	
	addi $a0, $a0, -1		# N - 1

	add $t0, $zero, $a2		# Save aux in a temporal register
	add $a2, $zero, $a3		# Aux <- End
	add $a3, $zero, $t0		# End <- Aux 
	jal Hanoi			# Thus Hanoi is called in this way: Hanoi(n-1, ini, end, aux)
	add $t0, $zero, $a2		# Save aux in a temporal register
	add $a2, $zero, $a3		# Aux <- End
	add $a3, $zero, $t0		# End <- Aux 
	
		# Move ini to end
	# When you load data you need to ask if address has something inside it, if not, you decrement address + offset condition
	lw $t0, 0($a1)
	sw $zero, 0($a1)
	beq $a1, $s5, noDec2
	beq $a1, $s6, noDec2
	beq $a1, $s7, noDec2
	addi $a1, $a1, -4
noDec2:	# When you store data you don't want to overwrite information, if address has something inside it, you increment address
	lw $t1, 0($a3)
	beq $t1, $zero, write2
	addi $a3, $a3, 4
write2:	sw $t0, 0($a3)
	
	# N is already decremented
	add $t0, $zero, $a2		# Save aux in a temporal register
	add $a2, $zero, $a1		# Aux <- Ini
	add $a1, $zero, $t0		# Ini <- Aux 
	jal Hanoi			# Thus Hanoi is called in this way: Hanoi(n-1, aux, ini, fin)
	add $t0, $zero, $a2		# Save aux in a temporal register
	add $a2, $zero, $a1		# Aux <- Ini
	add $a1, $zero, $t0		# Ini <- Aux 

return: 
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
	jr $ra
	
######################################### End Functions	#########################################
exit:



