TITLE 
;Exercise description

;This exercise asks students to translate a simple C program into x86 MASM Assembly. The program processes an array of integer values, applies a scoring rule to each value using a separate function, and then returns the total score.

;For each array element:

;if value >= limit:
;else:
 ;   subtract penalty
;
;if result < 0:
;    set result to 0

;The exercise is designed to practice:

;function calls,
;stack-based parameter passing,
;activation records using EBP,
;local variables,
;if-else control structures,
;for loops,
;array indexing,
;simple arithmetic using only addition and subtraction.
;Multiplication and division instructions are not allowed.
Include Irvine32.inc
;int scoreValue(int x, int limit, int bonus, int penalty)
;{
;    int result;
;
;   if (x >= limit)
;    {
;        result = x + bonus;
;    }
;    else
;    {
;        result = x - penalty;
;    }
;
;    if (result < 0)
;    {
;        result = 0;
;    }
;
;    return result;
;}

;int totalScore(int values[], int n, int limit, int bonus, int penalty)
;{
;   int i;
;    int total;
;    int currentScore;
;
;    total = 0;
;
;    for (i = 0; i < n; i = i + 1)
;    {
;       currentScore = scoreValue(values[i], limit, bonus, penalty);
;        total = total + currentScore;
;    }
;
;    return total;
;}

;int main()
;{
;    int values[5] = { 3, 7, 10, 2, 8 };
;    int result;
;
;    result = totalScore(values, 5, 6, 4, 2);
;
;    return result;
;}
.data
message1 BYTE "The score is: ",0



.code
;  ----------------- Function scoreValue -----------------
scoreValue PROC
; Inputs : EBP+8 = x, EBP+12 = limit, EBP+16 = bonus, EBP+20 = penalty 
; Outputs : EBX = scoreValue(x, limit, bonus, penalty)
;----------------------------------------------------------
push ebp
mov ebp,esp	
push eax
push ecx
push edx
push esi
push edi

;    int result;
;
;   if (x >= limit)
;    {
;        result = x + bonus;
;    }
;    else
;    {
;        result = x - penalty;
;    }
;
;    if (result < 0)
;    {
;        result = 0;
;    }
;
;    return result;

mov eax,[ebp+8] ; eax = x
cmp eax,[ebp+12] ; compare x with limit  x >= limit
jl L1 ; if x < limit jump to L1
	mov ebx,eax
	add ebx,[ebp+16] ; result = x + bonus
	jmp L2
L1: ;else
	mov ebx,eax
	sub ebx,[ebp+20] ; result = x - penalty
L2:

cmp ebx,0 ; compare result with 0  result < 0
jge L3 ; if result >= 0 jump to L3
	mov ebx,0 ; result = 0
L3:

pop edi
pop esi
pop edx
pop ecx
pop eax
mov esp,ebp
pop ebp
ret 16
scoreValue ENDP

;  ----------------- Function totalScore -----------------
totalScore PROC
; Inputs : EBP+8 = values, EBP+12 = n, EBP+16 = limit, EBP+20 = bonus, EBP+24 = penalty
; Outputs : EAX = totalScore(values, n, limit, bonus, penalty)
;----------------------------------------------------------
push ebp
mov ebp,esp
push ebx
push ecx
push edx
push esi
push edi


;   int i;
;    int total;
;    int currentScore;
;
;    total = 0;
;
;    for (i = 0; i < n; i = i + 1)
;    {
;       currentScore = scoreValue(values[i], limit, bonus, penalty);
;        total = total + currentScore;
;    }
;
;    return total;

;   int i;
;    int total;
;    int currentScore;
;
;    total = 0;
mov eax,0d ; total = 0
mov ecx,[ebp+12] ; n
mov esi,0 ; i = 0 
mov edi,[ebp+8] ; edi holds the base address of values
; ebx holds the current scope returned from scoreValue

L1:
;       currentScore = scoreValue(values[i], limit, bonus, penalty);
	mov ebx,[ebp+24] ; ebx = penalty
	push ebx ; push penalty
	mov ebx,[ebp+20] ; ebx = bonus
	push ebx ; push bonus
    mov ebx,[ebp+16] ; ebx = limit
	push ebx ; push limit
	mov ebx,[edi+esi*4] ; ebx = values[i]
	push ebx
	call scoreValue

	; total = total + currentScore;
	add eax,ebx ; total = total + currentScore
	inc esi ; i = i + 1
loop L1

	;    return total;
	; eax already holds total


pop edi
pop esi
pop edx
pop ecx
pop ebx
mov esp,ebp
pop ebp
ret 20
totalScore ENDP


main PROC
push ebp
mov ebp,esp
sub esp,24
pushad
;    int values[5] = { 3, 7, 10, 2, 8 };
;    int result;
mov [ebp-4],DWORD PTR 8
mov [ebp-8],DWORD PTR 2
mov [ebp-12],DWORD PTR 10
mov [ebp-16],DWORD PTR 7
mov [ebp-20],DWORD PTR 3
mov [ebp-24],DWORD PTR 0

;    result = totalScore(values, 5, 6, 4, 2);
; 5= n, 6=limit, 4=bonus, 2=penalty
push DWORD PTR 2  ; EBP+24
push DWORD PTR 4  ; EBP+20
push DWORD PTR 6  ; EBP+16
push DWORD PTR 5  ; EBP+12
lea  esi,[ebp-20]
push esi		  ; EBP+8 
call totalScore


mov edx, OFFSET message1
call WriteString
call WriteInt
call Crlf


exit
main ENDP
END main 