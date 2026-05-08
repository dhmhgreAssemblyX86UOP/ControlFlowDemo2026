TITLE Introduction to the lexixal rules
Include Irvine32.inc

.data
a SDWORD 15
b SDWORD 22
c1 SDWORD 18
result SDWORD 0

.code
main PROC
;int a = 15;
;int b = 22;
;int c = 18;
;int result = 0;

;if (a < b && c != b) {
;    result = 1;
;}
;L1else if (b >= c || a == 15) {
;L3    result = 2;
;}
;L2else if (c <= a && b > 10) {
;    result = 3;
;}
;else {
;L4    result = -1;
;}
;exit
mov ebx,b
mov ecx,c1
cmp a,ebx
jge L1
cmp c1,ebx
je L1
	mov result,1
	jmp exit1
L1:
cmp ebx,c1
jge L3
cmp a,15 
jne L2
L3:
	mov result,2
	jmp exit1
L2:
cmp ecx,a
jg L4
cmp ebx,10
jle L4
	mov result,3
	jmp exit1
L4:
	mov result,-1
exit1:

exit
main ENDP
END main 