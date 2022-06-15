#fasm#
  
 xor si,si
 mov bx,-127
 mov ax,len
 whileLoop: 
    xor cx,cx
    mov cl,[vector + si]
    
    
    cmp bx,cx
    jg  endWhile
    mov bl,[vector + si]  ; max value
    mov di,si             ; max value position 
    jmp endWhile  
    

endWhile:
inc si
cmp ax,si
jne whileLoop
finish:
cmp bl,111
je pEnd



mov ah,09h
mov dx,StringMaxValue
int 21h 

or bl,bl
js negNumber
 jmp printStrings
negNumber:
not bl
add bl,1b 
mov ah,09h
mov dx,NegString
int 21h 

printStrings:
xor cx,cx
mov cl,bl
mov bx,String
lea ax,[StringEnd - 1]
call to_str
mov dx,ax
mov ah,09h
int 21h  
  
  
mov ah,09h
mov dx,StringMaxValuePos
int 21h
inc di
mov bx,StringPosition
lea ax,[StringPositionEnd-1]
mov cx,di
call to_str 
mov dx,ax
mov ah,09h
int 21h

pEnd:
ret       
        
to_str:
  push di
  std                   
  mov	di,ax
  mov	ax,cx     

  mov	cx,10          
  Repeata:
  xor	dx,dx         
  div	cx            
                                      
  xchg	ax,dx         
  add	al,'0'         
  stosb                 
  xchg	ax,dx      
  or	ax,ax        
  jne	Repeata
		
  mov ax,bx

  pop di
  ret        
 
 NegString db '-','$'
 
 StringMaxValue    db 'Max Value: ','$'
 StringMaxValuePos db ' Max Value Pos: ','$'
 
 String		db	5 dup (?),'$'  
 StringEnd	=	$-1
 
 StringPosition db 5 dup(?),'$'
 StringPositionEnd = $ - 1
 
 vector db -16,-10,-16,-16,-25,-16,-19
 len = $ -  vector