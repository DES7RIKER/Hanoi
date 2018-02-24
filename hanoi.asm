# Practice 1
# MOISES ISAIAS LOPEZ RIZO 697253
# ELIAS GASPAR ARELLANO    704205
.data 
.text

ori $s0, $s0, 12 # 'n' Number of disks

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
ori  $s5, $t0, 0x0000    	# Set pointer to initial position
###########################

Expand:	      
###########################
lw $t1, ($s6)         
beq $t1, $zero, continue	# If the initial value of the second tower is not zero
addi $s6, $s6, 32     		# it means that tower 1(initial) invaded addresses of tower 2, 
addi $s7, $s7, 64     		# so it is necessary to move base pointers of tower 2 and 3.
j Expand              
continue:                
###########################

