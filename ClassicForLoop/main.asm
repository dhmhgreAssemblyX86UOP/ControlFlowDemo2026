TITLE Introduction to the lexixal rules
Include Irvine32.inc

.data
evenCount SDWORD 0
oddCount SDWORD 0

message1 BYTE "Odd Numbers:",0
message2 BYTE "Even Numbers:",0

.code
main PROC
;int evenCount = 0;
;int oddCount = 0;
;
;for (int i = 0; i <= 20; i++) {
;
;    if (i % 2 == 0) {
;        evenCount++;
;    }
;    else {
;        oddCount++;
;    }
;
;}
mov ecx,0 ; ecx stores i
L1:
; body
	mov ebx,00000001h
	test ecx,ebx
	jnz L2
		inc evenCount
		jmp L3
	L2:
		inc oddCount
	L3:

; step
inc ecx
; finalization
cmp ecx,20
jle L1 

mov edx,OFFSET message1
call WriteString
mov eax,oddCount
call WriteInt

call crlf
mov edx,OFFSET message2
call WriteString
mov eax,evenCount
call WriteInt





exit
main ENDP
END main 