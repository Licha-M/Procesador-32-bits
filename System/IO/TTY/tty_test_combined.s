	.file	"tty_test.c"
	.text
	.globl	main                            ; -- Begin function main
	.type	main,@function
main:                                   ; @main
; %bb.0:                                ; %entry
	SLT ADI R14, 8
	INT STR R14, R8, -4
	LDI R1, 0
	H LDI R1, 49153
	SLT ADI R1, -16384
	LDI R2, 0
	H LDI R2, 57345
	SLT ADI R2, -32744
	INT STR R2, R1, 0
	LDI R1, 0
	H LDI R1, 1
	SLT ADI R1, 256
	LDI R2, 0
	H LDI R2, 57345
	SLT ADI R2, -32752
	INT STR R2, R1, 0
	LDI R1, 3
	LDI R2, 0
	H LDI R2, 57345
	SLT ADI R2, -32764
	INT STR R2, R1, 0
	LDI R2, 0
	H LDI R2, 49152
	SLT ADI R2, 0
	LDI R3, 0
	H LDI R3, 57360
	SLT ADI R3, 16
	INT STR R3, R2, 0
	LDI R5, 0
	H LDI R5, 57360
	SLT ADI R5, 4
	INT STR R5, R1, 0
	LDI R3, 0
	H LDI R3, 57360
	SLT ADI R3, 36
	INT LOD R3, R4, 0
	LDI R3, 0
	H LDI R3, 57360
	SLT ADI R3, 0
	ADD R4, R3, R6
	INT LOD R6, R3, 0
	LDI R7, 255
	AND R3, R7, R7
	LDI R8, 5
	LDI R3, 1
	SUB R7, R8, R0
	H LDI R15, %hi(.LBB0_2)
	SLT ADI R15, %lo(.LBB0_2)
	BRH NE, R15
; %bb.1:                                ; %if.then
	INT LOD R6, R7, 0
	LDI R8, 13
	RSH R7, R8, R7
	LDI R8, 112
	AND R7, R8, R7
	NOR R7, R3, R7
	NOR R7, R7, R7
	INT STR R6, R7, 0
	ADD R4, R5, R5
	LDI R6, 0
	H LDI R6, 65248
	SLT ADI R6, 44
	INT STR R5, R6, 0
	LDI R5, 0
	H LDI R5, 57360
	SLT ADI R5, 8
	ADD R4, R5, R4
	LDI R5, 126
	INT STR R4, R5, 0
.LBB0_2:                                ; %if.end
	LDI R5, 72
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, 4
	INT STR R4, R5, 0
	LDI R5, 0
	H LDI R5, 49152
	SLT ADI R5, 12
	INT STR R5, R3, 0
	INT STR R2, R3, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	LDI R6, 111
	INT STR R4, R6, 0
	INT STR R5, R3, 0
	INT STR R2, R3, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	LDI R7, 108
	INT STR R4, R7, 0
	INT STR R5, R3, 0
	INT STR R2, R3, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	LDI R7, 97
	INT STR R4, R7, 0
	INT STR R5, R3, 0
	INT STR R2, R3, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	LDI R7, 32
	INT STR R4, R7, 0
	INT STR R5, R3, 0
	INT STR R2, R3, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	LDI R7, 77
	INT STR R4, R7, 0
	INT STR R5, R3, 0
	INT STR R2, R3, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	LDI R7, 117
	INT STR R4, R7, 0
	INT STR R5, R3, 0
	INT STR R2, R3, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	LDI R7, 110
	INT STR R4, R7, 0
	INT STR R5, R3, 0
	INT STR R2, R3, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	LDI R7, 100
	INT STR R4, R7, 0
	INT STR R5, R3, 0
	INT STR R2, R3, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	INT STR R4, R6, 0
	INT STR R5, R3, 0
	INT STR R2, R3, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	LDI R6, 33
	INT STR R4, R6, 0
	INT STR R5, R1, 0
	INT STR R2, R3, 0
	;APP
	HLT
	;NO_APP
	LDI R1, 0
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        ; -- End function
	.ident	"clang version 24.0.0git (https://github.com/Licha-M/llvm-project-ISA32-LM.git c98f7ba0fedefda52a42da5440b50bcb3b3ca4ee)"
	.section	".note.GNU-stack","",@progbits
