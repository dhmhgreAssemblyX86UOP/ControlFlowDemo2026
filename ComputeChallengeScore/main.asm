TITLE computeChallengeScore
Include Irvine32.inc

;int adjustValue(int x, int low, int high)
;{
;    int result;
;
;    if (x < 0)
;    {
;        return -1;
;    }
;
;    if (x < low)
;    {
;        result = 0;
;    }
;    else if (x > high)
;    {
;        result = high;
;    }
;    else
;    {
;        result = x;
;    }
;
;    if (result > 0)
;    {
;        if ((result & 1) == 0)
;        {
;            result = result - 1;
;        }
;        else
;        {
;            result = result + 1;
;        }
;    }
;
;    return result;
;}
;
;int computeChallengeScore(int values[], int n, int low, int high, int stopValue)
;{
;    int i;	    ESI
;    int total;  EAX
;   int raw;     EBX   
;   int adjusted; EDX
;   high -> ECX
;   values -> EDI
;   total = 0;
;
;   for (i = 0; i < n; i = i + 1)
;   {
;       raw = values[i];
;
;       if (raw == stopValue)
;       {
;           break;
;       }
;
;       adjusted = adjustValue(raw, low, high);
;
;       if (adjusted < 0)
;       {
;            continue;
;        }
;
;        if (adjusted == 0)
;        {
;            total = total - 1;
;        }
;        else
;        {
;            total = total + adjusted;
;
;            if (adjusted >= high)
;            {
;                total = total + 1;
;            }
;        }
;    }
;
;    return total;
;}
;
;int main()
;{
;    int values[7] = { 3, 12, -5, 2, 7, 99, 8 };
;    int result;
;
;    result = computeChallengeScore(values, 7, 3, 9, 99);
;
;    return result;
;}

.data
;    int values[7] = { 3, 12, -5, 2, 7, 99, 8 };
;    int result;
values SDWORD 3, 12, -5, 2, 7, 99, 8 
result SDWORD ?

message1 BYTE "The score is: ",0

.code
;  ----------------- Function adjustValue -----------------
adjustValue PROC
; Inputs : EBP+8 = x, EBP+12 = low, EBP+16 = high
; Output : EAX = result
; Registers used : EAX = result, EBX = x, ECX = low, EDX = high
; -------------------------------------------------------------------
push ebp 
mov ebp, esp
push ebx 
push ecx
push edx
push esi
push edi





pop edi
pop esi 
pop edx
pop ecx
pop ebx
mov esp,ebp
pop ebp
ret 12
adjustValue ENDP




; ------------------ Function computeChallengeScore -----------------
computeChallengeScore PROC
; Inputs : EBP+8 = values, EBP+12 = n, EBP+16 = low, EBP+20 = high, EBP+24 = stopValue
; Output : EAX = total score
; Registers used : ESI = i, EBX = raw, EDX = adjusted, ECX = high, EDI = values
; -------------------------------------------------------------------
push ebp
mov ebp, esp
sub esp,8 ; space for local variables if needed
push ebx 
push ecx
push edx
push esi
push edi
mov eax, [ebp+24] ; eax = stopValue
mov [ebp-4], eax ; store stopValue in local variable if needed
mov eax, [ebp+16] ; eax = low
mov [ebp-8], eax ; store low in local variable if needed

;    int i;	    ESI
;    int total;  EAX
;   int raw;     EBX   
;   int adjusted; EDX
;   high -> ECX
;   values -> EDI
;   total = 0;
;

mov eax,0 ; total = 0
mov ecx,[ebp+20] ; ecx = high
mov edi,[ebp+8] ; edi = values
mov esi,0 ; i = 0
jmp L1
;   for (i = 0; i < n; i = i + 1)
; body of for loop
L2:


;       raw = values[i];
	mov ebx,[edi+esi*4] ; ebx = values[i]
;
;       if (raw == stopValue)
	cmp ebx,[ebp+24] ; compare raw with stopValue
	jne L3
;       {
;           break;
		   jmp EXIT1

;       }
L3:

	push eax ; save total on stack before calling adjustValue *****


;       adjusted = adjustValue(raw, low, high);
	push ecx ; push high
	mov eax,[ebp-8] ; eax = low
	push eax
	push ebx ; push raw
	call adjustValue
	mov edx, eax ; edx = adjusted

	pop eax ; restore total from stack ********


;       if (adjusted < 0)
	cmp edx,0 ; compare adjusted with 0
	jge L4
;       {
;            continue;
		   jmp L5
;        }
L4:

;        if (adjusted == 0)
	cmp edx,0 ; compare adjusted with 0
	jne L6
;        {
;            total = total - 1;
           dec eax;
		   jmp L5
;        }

	L6:

;        else
;        {
;            total = total + adjusted;
		   add eax,edx
;
;            if (adjusted >= high)
		   cmp eax,ecx
		   jl L5
;            {
;                total = total + 1;
			   inc eax
;            }
;        }

	


L5:
; step of for loop
inc esi
; finalization condition of for loop
L1:
cmp esi,[ebp+12] ; compare i with n
jl L2

EXIT1:
pop edi
pop esi 
pop edx
pop ecx
pop ebx
mov esp,ebp
pop ebp
ret 20
computeChallengeScore ENDP

main PROC

;    result = computeChallengeScore(values, 7, 3, 9, 99);
push SDWORD PTR 99
push SDWORD PTR 9
push SDWORD PTR 3
push SDWORD PTR 7
push OFFSET values
call computeChallengeScore

mov edx, OFFSET message1
call WriteString
call WriteInt
call CRLF

exit
main ENDP
END main 