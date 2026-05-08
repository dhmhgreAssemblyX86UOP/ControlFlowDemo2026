TITLE Introduction to the lexixal rules
Include Irvine32.inc

.data
x SDWORD 12
y SDWORD 5
result SDWORD 0

.code
main PROC
;int x = 12;
;int y = 5;
;int result = 0;
;
;if (x > 10) {
;    if (y < 10) {
;        result = x + y;
;    }
;    else {
;       result = x - y;
;    }
;}
;else {
;   result = -1;
;}
; exit1

cmp x,10
jle L1
cmp y,10
jge L2
   mov eax,x
   add eax,y
   mov result ,eax
   jmp exit1
L2:
   mov eax,x
   sub eax,y
   mov result ,eax
   jmp exit1	
L1:
	mov result ,-1
exit1:

exit
main ENDP
END main 