	AREA datos, DATA
	 pila SPACE 100
	 toppila	
	AREA codigo, CODE, READONLY
  ENTRY
	ldr sp, =toppila
	sub sp,sp,#4 ;reservamos en la pila para resultado
	mov r0,#3 ;calculamos factorial de n=3
	PUSH {r0} ;guardamos parámetro n en la pila
	bl factorial ;llamamos a la subrutina
	add sp,sp,#4 ;actualizamos la pila para acceder
	POP {r0} ;al resultado
	fin b fin
  END
;continua

factorial push{fp,lr} ;almacenamos @retorno y fp viejo
	mov fp,sp ;marcamos fp al tope actual pila
	push{r0,r1} ;salvar registros usados
	ldr r0,[fp,#8] ;leemos primer parámetro
	cmp r0,#1
	beq finsub ; n = 1?
	sub r1,r0,#1 ;no, volver a llamar
	sub sp,sp,#4 ;haciendo sitio para el resultado
	push{r1} ;y apilando el parámetro
	bl factorial
	add sp,sp,#4 ;recuperar pila y resultado F(n-1)
	pop{r1}
	mul r0,r1,r0 ;y multiplicarlo por “n”
finsub
	str r0,[fp,#12] ;almacenamos resultado
	pop{r0,r1,fp,pc} ;restaurar registros y return

 