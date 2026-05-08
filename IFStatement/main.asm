TITLE Introduction to the lexixal rules
Include Irvine32.inc

.data
a SDWORD 15
b SDWORD 10

.code
main PROC

;int a = 5;    GREATER / LESS 
;int b = 10;

;if (a < b) {
;    a = a + 1;
;}

mov ebx ,b
cmp a,ebx  ; a-ebx
jge L1
inc a
L1: 






exit
main ENDP
END main 