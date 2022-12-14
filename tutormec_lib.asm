;Imprime mensaje en pantalla pedido por el programa
%macro imprimir 1
    mov si, %1            
    mov ah, 0x0E          
    %%loop	lodsb                  
        or al, al               
        jz %%end                 
        int 0x10              
        jmp %%loop               
    %%end:
%endmacro

%macro tutormec 0
    ;Imprimir interfaz
    call printStr
    ;Espera la entrada del usuario
    entrada buffer
    xor bx, bx
    ;Imprime mensaje de error en caso de error
    imprimir mensaje_error
    call limpiar_pantalla
    ;Genera un loop hasta que el usuario presione la tecla correcta
    jmp start
%endmacro

;Guarda el caracter que ingreso el user, funciona junto a "entrada"
%macro caracter_de_entrada 1
    mov ah, 0x0
	int 0x16
	mov [%1] , al
%endmacro

;Compara los caracteres de entrada con los posibles correctos
%macro comparador 1
    ;Compara el caracter con la letra 'u'
    mov cl, 'u'
    cmp [bx], cl
    JE correcto
    ;Compara el caracter con la letra 'p'
    mov cl, 'p'
    cmp [bx], cl
    JE correcto
    ;Compara el caracter con la letra 'x'
    mov cl, 'x'
    cmp [bx], cl
    JE correcto
%endmacro

;Recibe el input del usuario y lo guarda en una variable, llama a comparar e imprime la tecla en pantalla
%macro entrada 1
    %%read_string: 
        mov bx, %1
    %%start_process:
        cmp cx,10
        jz %%end_read
        caracter_de_entrada bx 
        imprimir bx 
        ;Llama al comparador para verificar si la tecla es correcta
        comparador bx
        inc bx
        inc cx
    %%end_read:

%endmacro

;Salto de linea basico
%macro salto_linea 0
    mov al, 0x0A
    int 10h
    mov al, 0x0D
    int 10h
%endmacro
