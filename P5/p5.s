	AREA datos, DATA, READWRITE
vector 	DCD  7,8,3,4,5,1,3,4,5,7
tamanio EQU 10

pila SPACE 200
topila

	AREA prog, CODE, READONLY 
	ENTRY 
        ldr sp, =topila 
		ldr r0, =vector 
		mov r1,#tamanio

		push {r0,r1}
		bl SBR_ORDENA
		pop {r0,r1}

fin b fin

SBR_ORDENA 
		push {r0,r2-r4,lr}

		ldr r2,[sp, #20] 
		ldr r0,[sp, #16]     

		sub r4,r2,#1
		mov r3,#0

		push {r3,r4}
		bl SBR_QSORT
		pop {r3,r4}
		pop {r0,r2-r4,pc}

SBR_QSORT
	   push {r1-r9,lr}

	   ldr r8,[sp, #4] ; izquierda
	   ldr r9,[sp, #8] ; derecha 

	   mov r2,r9  ; j
	   mov r3,r8  ;	i 

	   add r4,r9,r8
	   add r5,r4,lsr #1

	   ldr r4,[r0,r5,lsl #2]

dowhile
   	   b   buc 

buc1   add r3,r3,#1 

buc    ldr r6,[r0,r3,lsl #2] 
   	   cmp r4,r6
	   bge buc1

	   b bucc
  
bucb  sub r2,r2,#1

bucc  ldr r7,[r0,r2,lsl #2]
      cmp r4,r7
	  ble bucb

	  cmp r3,r2 
	  ble salto

	  str r6,[r0,r2,lsl #2]
	  str r7,[r0,r3,lsl #2]

	  add r2,r2,#1
	  sub r3,r3,#1

salto cmp r3,r2
      ble dowhile

	  cmp r8,r2 
	  bge salto2

	  mov r1,r8

	  push {r1, r2}
	  bl SBR_QSORT
	  pop {r1, r2}

salto2 cmp r3,r9
	    bge salto3

	   push {r3,r9} 
	   bl SBR_QSORT
	   pop {r3, r9}

salto3 pop {r1-r9,pc}
    END
