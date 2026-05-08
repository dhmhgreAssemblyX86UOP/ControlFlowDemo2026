TITLE Introduction to the lexixal rules
Include Irvine32.inc

.data
a SDWORD 4
b SDWORD 8
max SDWORD ?

.code
main PROC
;int a = 4;
;int b = 8;
;int max;
;
;if (a > b) {
;    max = a;
;}
;else {
;    max = b;
;}

mov ebx,b
cmp a,ebx
jle L1
  mov eax,a
  mov max,eax
  jmp exit1
L1:
  mov max,ebx
exit1:

exit
main ENDP
END main 