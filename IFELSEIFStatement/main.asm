TITLE Introduction to the lexixal rules
Include Irvine32.inc

.data
grade SDWORD 75
result SBYTE ? 
alpha BYTE 'A'
beta BYTE 'B'
cee  BYTE 'C'

.code
main PROC
;int grade = 75;
;char result;
;
;if (grade >= 90) {
;    result = 'A';
;}
;else if (grade >= 75) {
;    result = 'B';
;}
;else {
;    result = 'C';
;}

cmp grade,90d
jl L1
	mov al, alpha
	mov result,al
	jmp exit1
L1:
cmp grade,75d
jl L2
	mov al,beta
	mov result,al
	jmp exit1
L2:
	mov al,cee
	mov result,al
exit1:

exit
main ENDP
END main 