TITLE Introduction to the lexixal rules
Include Irvine32.inc

.data
total SDWORD 0

.code
main PROC
;int i;
;int j;
;int total = 0;

;for (i = 0; i < 5; i++) {

;    j = 0;

;    while (j < 3) {

;       if ((i + j) % 2 == 0) {
;            total = total + (i + j);
;        }
;        else {
;            total = total - (i + j);
;        }
;
;        j++;
;    }
;
;}

;initialization
mov ecx,0     ; ecx stores i
L1:;body

;while_initialization
mov edx,0     ; edx stores j
L2:;while_body

;if-else
;       if ((i + j) % 2 == 0) {
;            total = total + (i + j);
;        }
;        else {
;            total = total - (i + j);
;        }
;
;        j++;
mov eax,ecx ; eax = i
add eax,edx ; eax = i + j
mov ebx,00000001h
test eax,ebx
jnz L3
 add eax,total ; eax = total + (i + j)
 jmp L4
L3:
 sub eax,total ; eax = total - (i + j)	
L4:
 mov total,eax ; total = eax
 inc edx ; j++







;while_finalization
cmp edx,3
jl L3


;step
inc ecx
;finalization
cmp ecx,5
jl L1





exit
main ENDP
END main 