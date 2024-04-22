    AREA datos, DATA, READWRITE
vector  DCD  7,8,3,4,5,1
long    EQU 6
contarA DCD 0
vector2 DCD 4, 9, 2, 6, 1
long2   EQU 5
contarB DCD 0
pila SPACE 48 
toPila

    AREA prog, CODE, READONLY
    ENTRY

	ldr sp, =toPila

	ldr r5, = vector 
	mov r6,#long
	mov r8,#4

	sub sp,sp, #4
	push{r5,r6}

	bl sbr_burbuja

	pop{r5,r6}
	pop{r2}


	ldr r3, = contarA 
	str r2, [r3]

	ldr r5, = vector2
	mov r6, #long2

	sub sp, sp, #4
	push{r5,r6}
	bl sbr_insercion
	
	pop{r5,r6}
	pop{r2}

	ldr r3, = contarB 
	str r2, [r3]

fin     B fin

sbr_burbuja

	    push{r0-r6}

		ldr r0, [sp,#28]
		ldr r1, [sp,#32]

        mov     r5, #1         
buc_i   mov     r6, #0     
      
buc     ldr    r3, [r0, r5,lsl #2]   
        ldr    r4, [r0, r6,lsl #2]  
  
        cmp     r3, r4         
        bge     noCambiar       

        str    r4, [r0, r5,lsl #2]    
        str    r3, [r0, r6,lsl #2]    

noCambiar
        add     r6, r6, #1     
        cmp     r6,r5      
        blt     buc           
		
        add     r5, r5, #1     
        cmp     r5, r1    
        blt     buc_i
		mul     r2, r5, r6
		str     r2, [sp,#36]

		pop{r0-r6}
	    mov pc, lr

           
sbr_insercion
	 push{r4,r5,r6,r7,r8}
	 ldr r3, [sp, #20]
	 ldr r1, [sp, #24]

 	 mov r6, #1		  ;r0 = r6 
	 mov r7, #0
	 
buc1 ldr r8, [r3, r6, lsl #2] 
	 sub r7, r6, #1

	 b comp

buc2 add r4, r7, #1
	 str r5, [r3, r4, lsl #2]

	 sub r7, r7, #1

comp cmp r7, #0
	 blt buc3

	 ldr r5, [r3, r7, lsl #2]
	 cmp r5, r8
	 bgt buc2

buc3 add r4, r7, #1
	 str r8, [r3, r4, lsl #2]

	 add r6, r6, #1
	 cmp r6, r1
	 blt buc1

	 mul r2, r6, r7
	 str r2, [sp,#28]

	 pop{r4,r5,r6,r7,r8}
	 mov pc, lr               

    END