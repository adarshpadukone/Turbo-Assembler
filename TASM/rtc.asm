.model tiny

.code


org 100h
begin:jmp init_port

oldip dw 00h
oldcs dw 00h

res_port:push ax
	 push bx
	 push cx
	 push dx
	 push si
	 push di
 	 push ss
	 push es
	 push ds

mov ax,0b800h   ; base Address of Video Ram 
mov es,ax
mov di,844h      ; Cursor Position
mov ah,02h
int 1ah         ; ch-hr, cl-min, dh-sec
mov bx,cx

mov cl,04h
mov ah,bh
and ah,0fh
and bh,0f0h
shr bh,cl

add bh,30h
mov byte ptr es:[di],bh
add di,02h

add ah,30h
mov byte ptr es:[di],ah
add di,02h
mov al,':'
mov byte ptr es:[di],al

add di,02h
mov bh,bl
mov ah,bh
and ah,0fh
and bh,0f0h
shr bh,cl

add bh,30h
mov byte ptr es:[di],bh
add di,02h
add ah,30h
mov byte ptr es:[di],ah
add di,02h
mov al,':'
mov byte ptr es:[di],al
add di,02h
mov bh,dh
mov ah,bh
and ah,0fh
and bh,0f0h
shr bh,cl

add bh,30h
mov byte ptr es:[di],bh
add di,02h
add ah,30h
mov byte ptr es:[di],ah
add di,02h
pop ds
pop es
pop ss
pop di
pop si
pop dx
pop cx
pop bx
pop ax
jmp dword ptr cs:oldip

init_port:mov ah,35h   ; Get Interrupt Address
	  mov al,08		; s/w interrupt of MS-DOS forRTC
	  int 21h

mov word ptr cs:oldip,bx
mov word ptr cs:oldcs,es      


mov ah,25h        ; Set Interrupt Address
mov al,08
mov dx,offset res_port
int 21h


mov ah,31h         ; Make Program Resident 
mov dx,offset init_port
int 21h




end begin
 
	
