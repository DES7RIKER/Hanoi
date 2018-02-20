#Practica 1
#MOISES ISAIAS LOPEZ RIZO 697253
#ELIAS GASPAR ARELLANO    704205
.data 
.text

ori $a3, $a3, 8 # 'n' cantidad de discos requeridos

#SE DECLARAN LOS APUNTADORES A LAS COLUMNAS
######################
ori $t0, $t0, 0x1001 #Carga parte alta
sll $t0, $t0, 16     #Recorrer a la parte alta
ori $s5, $t0, 0x0000 #Torre Inicial
ori $s6, $t0, 0x0020 #Torre Auxiliar 
ori $s7, $t0, 0x0040 #Torre Final
######################

InitTower:
#########################
sw $a3, ($s5)           #inicializa las torres 
addi $s5, $s5, 4        #
add $a3, $a3, -1        #
bne $a3, $zero,InitTower#
ori $s5, $t0, 0x0000    #regresa al valor de la base
#########################

Expandir:	      
#######################
lw $a0, ($s6)         #
beq $a0, $zero, jump1 # si el valor inicial de la segunda 
addi $s6, $s6, 32     # torre no es 0 (por que es de mas 
addi $s7, $s7, 64     # de 8 e invadio la segunda torre)
j Expandir            # recorre las torres 2 y 3
jump1:                #
#######################


# en este punto puede iniciar la funcion recurciva 
# se tienen los discos ya pocicionados en la tore inicial y se decalararon los apuntadores a las baces de las torres en s5,s6,s7



