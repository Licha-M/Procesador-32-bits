	.file	"test.C"
	.text
	.globl	"?argumentos@@YAHHHHHHHHH@Z"    ; -- Begin function ?argumentos@@YAHHHHHHHHH@Z
	.type	"?argumentos@@YAHHHHHHHHH@Z",@function
"?argumentos@@YAHHHHHHHHH@Z":           ; @"?argumentos@@YAHHHHHHHHH@Z"
; %bb.0:                                ; %entry
	ADI R14, 4
	ADD R1, R2, R1
	ADD R1, R3, R1
	ADD R1, R4, R1
	ADD R1, R5, R1
	ADD R1, R6, R1
	ADD R1, R7, R1
	ADD R14, R0, R2
	SLT ADI R2, 0
	INT LOD R2, R2, 0
	ADD R1, R2, R1
	ADI R1, 28
	ADI R14, -4
	RET
.Lfunc_end0:
	.size	"?argumentos@@YAHHHHHHHHH@Z", .Lfunc_end0-"?argumentos@@YAHHHHHHHHH@Z"
                                        ; -- End function
	.globl	"?fibonacci@@YAHH@Z"            ; -- Begin function ?fibonacci@@YAHH@Z
	.type	"?fibonacci@@YAHH@Z",@function
"?fibonacci@@YAHH@Z":                   ; @"?fibonacci@@YAHH@Z"
; %bb.0:                                ; %entry
	SLT ADD R1, R0, R2
	LDI R3, 0
	LDI R1, 2
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB1_3)
	SLT ADI R15, %lo(.LBB1_3)
	BRH C, R15
	H LDI R15, %hi(.LBB1_1)
	SLT ADI R15, %lo(.LBB1_1)
	JMP R15
.LBB1_1:                                ; %if.end3.preheader
	LDI R4, 1
.LBB1_2:                                ; %if.end3
                                        ; =>This Inner Loop Header: Depth=1
	SLT ADD R2, R0, R1
	ADI R1, -1
	H LDI R15, %hi("?fibonacci@@YAHH@Z")
	SLT ADI R15, %lo("?fibonacci@@YAHH@Z")
	CAL R15
	ADD R1, R3, R3
	ADI R2, -2
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB1_2)
	SLT ADI R15, %lo(.LBB1_2)
	BRH C, R15
	H LDI R15, %hi(.LBB1_3)
	SLT ADI R15, %lo(.LBB1_3)
	JMP R15
.LBB1_3:                                ; %return
	ADD R2, R3, R1
	RET
.Lfunc_end1:
	.size	"?fibonacci@@YAHH@Z", .Lfunc_end1-"?fibonacci@@YAHH@Z"
                                        ; -- End function
	.globl	"?test_complex_switch@@YAHH@Z"  ; -- Begin function ?test_complex_switch@@YAHH@Z
	.type	"?test_complex_switch@@YAHH@Z",@function
"?test_complex_switch@@YAHH@Z":         ; @"?test_complex_switch@@YAHH@Z"
; %bb.0:                                ; %entry
	SLT ADD R1, R0, R2
	LDI R3, 2
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB2_3)
	SLT ADI R15, %lo(.LBB2_3)
	BRH N, R15
	H LDI R15, %hi(.LBB2_1)
	SLT ADI R15, %lo(.LBB2_1)
	JMP R15
.LBB2_3:                                ; %entry
	LDI R1, 3
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB2_7)
	SLT ADI R15, %lo(.LBB2_7)
	BRH EQ, R15
	H LDI R15, %hi(.LBB2_4)
	SLT ADI R15, %lo(.LBB2_4)
	JMP R15
.LBB2_4:                                ; %entry
	LDI R1, 100
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB2_8)
	SLT ADI R15, %lo(.LBB2_8)
	BRH EQ, R15
	H LDI R15, %hi(.LBB2_5)
	SLT ADI R15, %lo(.LBB2_5)
	JMP R15
.LBB2_5:                                ; %entry
	LDI R1, 500
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB2_9)
	SLT ADI R15, %lo(.LBB2_9)
	BRH EQ, R15
	H LDI R15, %hi(.LBB2_10)
	SLT ADI R15, %lo(.LBB2_10)
	JMP R15
.LBB2_9:                                ; %sw.bb4
	LDI R1, 5000
	H LDI R15, %hi(.LBB2_11)
	SLT ADI R15, %lo(.LBB2_11)
	JMP R15
.LBB2_1:                                ; %entry
	LDI R1, 10
	LDI R4, 1
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB2_11)
	SLT ADI R15, %lo(.LBB2_11)
	BRH EQ, R15
	H LDI R15, %hi(.LBB2_2)
	SLT ADI R15, %lo(.LBB2_2)
	JMP R15
.LBB2_2:                                ; %entry
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB2_6)
	SLT ADI R15, %lo(.LBB2_6)
	BRH EQ, R15
	H LDI R15, %hi(.LBB2_10)
	SLT ADI R15, %lo(.LBB2_10)
	JMP R15
.LBB2_6:                                ; %sw.bb1
	LDI R1, 20
	H LDI R15, %hi(.LBB2_11)
	SLT ADI R15, %lo(.LBB2_11)
	JMP R15
.LBB2_7:                                ; %sw.bb2
	LDI R1, 30
	H LDI R15, %hi(.LBB2_11)
	SLT ADI R15, %lo(.LBB2_11)
	JMP R15
.LBB2_8:                                ; %sw.bb3
	LDI R1, 400
	H LDI R15, %hi(.LBB2_11)
	SLT ADI R15, %lo(.LBB2_11)
	JMP R15
.LBB2_10:                               ; %sw.default
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
.LBB2_11:                               ; %return
	RET
.Lfunc_end2:
	.size	"?test_complex_switch@@YAHH@Z", .Lfunc_end2-"?test_complex_switch@@YAHH@Z"
                                        ; -- End function
	.globl	"?test_nested_loops@@YAHH@Z"    ; -- Begin function ?test_nested_loops@@YAHH@Z
	.type	"?test_nested_loops@@YAHH@Z",@function
"?test_nested_loops@@YAHH@Z":           ; @"?test_nested_loops@@YAHH@Z"
; %bb.0:                                ; %entry
	LDI R2, 0
	LDI R3, 1
	SUB R1, R3, R0
	H LDI R15, %hi(.LBB3_2)
	SLT ADI R15, %lo(.LBB3_2)
	BRH N, R15
	H LDI R15, %hi(.LBB3_1)
	SLT ADI R15, %lo(.LBB3_1)
	JMP R15
.LBB3_1:                                ; %for.cond.preheader.preheader
	SLT ADD R1, R0, R2
	ADI R2, -2
	SLT ADD R1, R0, R4
	ADI R4, -1
	MUL R4, R2, R2
	RSH R2, R3, R2
	ADD R1, R2, R1
	LDI R2, 10
	MUL R1, R2, R2
	ADI R2, -10
.LBB3_2:                                ; %while.end
	SLT ADD R2, R0, R1
	RET
.Lfunc_end3:
	.size	"?test_nested_loops@@YAHH@Z", .Lfunc_end3-"?test_nested_loops@@YAHH@Z"
                                        ; -- End function
	.globl	"?test_multidim_array@@YAHHH@Z" ; -- Begin function ?test_multidim_array@@YAHHH@Z
	.type	"?test_multidim_array@@YAHHH@Z",@function
"?test_multidim_array@@YAHHH@Z":        ; @"?test_multidim_array@@YAHHH@Z"
; %bb.0:                                ; %entry
	SLT ADD R1, R0, R3
	LDI R1, 0
	LDI R4, 2
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB4_3)
	SLT ADI R15, %lo(.LBB4_3)
	BRH C, R15
	H LDI R15, %hi(.LBB4_1)
	SLT ADI R15, %lo(.LBB4_1)
	JMP R15
.LBB4_1:                                ; %entry
	LDI R5, 3
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB4_3)
	SLT ADI R15, %lo(.LBB4_3)
	BRH C, R15
	H LDI R15, %hi(.LBB4_2)
	SLT ADI R15, %lo(.LBB4_2)
	JMP R15
.LBB4_2:                                ; %if.then
	LSH R2, R4, R1
	LDI R2, 4
	LSH R3, R2, R2
	ADD R2, R1, R1
	LDI R2, 0
	H LDI R2, ".L__const.?test_multidim_array@@YAHHH@Z.matriz"
	SLT ADI R2, ".L__const.?test_multidim_array@@YAHHH@Z.matriz"
	ADD R1, R2, R1
	INT LOD R1, R1, 0
.LBB4_3:                                ; %cleanup
	RET
.Lfunc_end4:
	.size	"?test_multidim_array@@YAHHH@Z", .Lfunc_end4-"?test_multidim_array@@YAHHH@Z"
                                        ; -- End function
	.globl	"?procesar_struct@@YAHUBigData@@@Z" ; -- Begin function ?procesar_struct@@YAHUBigData@@@Z
	.type	"?procesar_struct@@YAHUBigData@@@Z",@function
"?procesar_struct@@YAHUBigData@@@Z":    ; @"?procesar_struct@@YAHUBigData@@@Z"
; %bb.0:                                ; %entry
	INT LOD R1, R2, 12
	INT LOD R1, R3, 4
	ADD R3, R2, R2
	INT LOD R1, R3, 8
	INT LOD R1, R4, 0
	ADD R4, R3, R3
	ADD R3, R2, R2
	INT LOD R1, R1, 16
	ADD R2, R1, R1
	RET
.Lfunc_end5:
	.size	"?procesar_struct@@YAHUBigData@@@Z", .Lfunc_end5-"?procesar_struct@@YAHUBigData@@@Z"
                                        ; -- End function
	.globl	"?test_struct_by_value@@YAHXZ"  ; -- Begin function ?test_struct_by_value@@YAHXZ
	.type	"?test_struct_by_value@@YAHXZ",@function
"?test_struct_by_value@@YAHXZ":         ; @"?test_struct_by_value@@YAHXZ"
; %bb.0:                                ; %entry
	LDI R1, 150
	RET
.Lfunc_end6:
	.size	"?test_struct_by_value@@YAHXZ", .Lfunc_end6-"?test_struct_by_value@@YAHXZ"
                                        ; -- End function
	.globl	"?test_pointer_arithmetic@@YAHPEAHH@Z" ; -- Begin function ?test_pointer_arithmetic@@YAHPEAHH@Z
	.type	"?test_pointer_arithmetic@@YAHPEAHH@Z",@function
"?test_pointer_arithmetic@@YAHPEAHH@Z": ; @"?test_pointer_arithmetic@@YAHPEAHH@Z"
; %bb.0:                                ; %entry
	ADI R14, 48
	INT STR R14, R8, 20
	INT STR R14, R9, 16
	INT STR R14, R10, 12
	INT STR R14, R11, 8
	INT STR R14, R12, 4
	INT STR R14, R13, 0
	LDI R3, 0
	LDI R4, 1
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB7_8)
	SLT ADI R15, %lo(.LBB7_8)
	BRH N, R15
	H LDI R15, %hi(.LBB7_1)
	SLT ADI R15, %lo(.LBB7_1)
	JMP R15
.LBB7_1:                                ; %for.body.preheader
	LDI R5, 0
	LDI R4, 8
	SLT ADD R5, R0, R3
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB7_7)
	SLT ADI R15, %lo(.LBB7_7)
	BRH C, R15
	H LDI R15, %hi(.LBB7_2)
	SLT ADI R15, %lo(.LBB7_2)
	JMP R15
.LBB7_2:                                ; %vector.ph
	LDI R3, 0
	H LDI R3, 32768
	SLT ADI R3, -8
	INT STR R14, R2, 40
	AND R2, R3, R2
	LDI R3, 2
	INT STR R14, R2, 36
	LSH R2, R3, R2
	ADD R1, R2, R2
	INT STR R14, R2, 44
	SLT ADD R5, R0, R3
	SLT ADD R5, R0, R11
	SLT ADD R5, R0, R10
	INT STR R14, R5, 24
	SLT ADD R5, R0, R12
	SLT ADD R5, R0, R9
	SLT ADD R5, R0, R6
	SLT ADD R5, R0, R13
	SLT ADD R5, R0, R7
	SLT ADD R5, R0, R4
	SLT ADD R3, R0, R8
	SLT ADD R5, R0, R2
.LBB7_3:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
	ADI R8, 8
	SLT ADD R2, R0, R5
	INT STR R14, R8, 28
	SUB R8, R3, R0
	H LDI R15, %hi(.LBB7_4)
	SLT ADI R15, %lo(.LBB7_4)
	BRH C, R15
.LBB7_4:                                ; %vector.body
                                        ;   in Loop: Header=BB7_3 Depth=1
	LDI R5, 1
.LBB7_5:                                ; %vector.body
                                        ;   in Loop: Header=BB7_3 Depth=1
	LDI R2, 2
	LSH R3, R2, R3
	ADD R1, R3, R3
	ADD R11, R5, R11
	INT LOD R3, R5, 28
	ADD R5, R4, R4
	INT LOD R3, R5, 24
	ADD R5, R7, R7
	INT LOD R3, R5, 20
	ADD R5, R13, R13
	INT LOD R14, R2, 36
	INT LOD R14, R8, 28
	XOR R8, R2, R5
	NOR R5, R5, R5
	NOR R11, R11, R2
	NOR R5, R2, R2
	INT STR R14, R2, 32
	INT LOD R3, R2, 16
	ADD R2, R6, R6
	INT LOD R3, R2, 12
	ADD R2, R9, R9
	INT LOD R3, R2, 8
	ADD R2, R12, R12
	INT LOD R3, R2, 4
	INT LOD R14, R5, 24
	ADD R2, R5, R5
	INT STR R14, R5, 24
	INT LOD R3, R2, 0
	ADD R2, R10, R10
	SLT ADD R8, R0, R3
	LDI R2, 0
	INT LOD R14, R5, 32
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB7_3)
	SLT ADI R15, %lo(.LBB7_3)
	BRH NE, R15
	H LDI R15, %hi(.LBB7_6)
	SLT ADI R15, %lo(.LBB7_6)
	JMP R15
.LBB7_6:                                ; %middle.block
	ADD R6, R10, R1
	ADD R7, R12, R2
	ADD R1, R2, R1
	INT LOD R14, R2, 24
	ADD R13, R2, R2
	ADD R4, R9, R3
	ADD R2, R3, R2
	ADD R1, R2, R3
	INT LOD R14, R2, 40
	INT LOD R14, R5, 36
	XOR R5, R2, R6
	LDI R4, 0
	INT LOD R14, R1, 44
	SUB R6, R4, R0
	H LDI R15, %hi(.LBB7_8)
	SLT ADI R15, %lo(.LBB7_8)
	BRH EQ, R15
	H LDI R15, %hi(.LBB7_7)
	SLT ADI R15, %lo(.LBB7_7)
	JMP R15
.LBB7_7:                                ; %for.body.preheader11
	SUB R2, R5, R2
	LDI R4, 0
	H LDI R15, %hi(.LBB7_9)
	SLT ADI R15, %lo(.LBB7_9)
	JMP R15
.LBB7_9:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	INT LOD R1, R5, 0
	ADD R5, R3, R3
	ADI R1, 4
	ADI R2, -1
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB7_8)
	SLT ADI R15, %lo(.LBB7_8)
	BRH EQ, R15
	H LDI R15, %hi(.LBB7_9)
	SLT ADI R15, %lo(.LBB7_9)
	JMP R15
.LBB7_8:                                ; %for.cond.cleanup
	SLT ADD R3, R0, R1
	INT LOD R14, R13, 0
	INT LOD R14, R12, 4
	INT LOD R14, R11, 8
	INT LOD R14, R10, 12
	INT LOD R14, R9, 16
	INT LOD R14, R8, 20
	ADI R14, -48
	RET
.Lfunc_end7:
	.size	"?test_pointer_arithmetic@@YAHPEAHH@Z", .Lfunc_end7-"?test_pointer_arithmetic@@YAHPEAHH@Z"
                                        ; -- End function
	.globl	main                            ; -- Begin function main
	.type	main,@function
main:                                   ; @main
; %bb.0:                                ; %entry
	LDI R1, 0
	H LDI R1, 4660
	SLT ADI R1, 22136
	RET
.Lfunc_end8:
	.size	main, .Lfunc_end8-main
                                        ; -- End function
	.type	".L__const.?test_multidim_array@@YAHHH@Z.matriz",@object ; @"__const.?test_multidim_array@@YAHHH@Z.matriz"
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
".L__const.?test_multidim_array@@YAHHH@Z.matriz":
	.long	1                               ; 0x1
	.long	2                               ; 0x2
	.long	3                               ; 0x3
	.long	4                               ; 0x4
	.long	5                               ; 0x5
	.long	6                               ; 0x6
	.long	7                               ; 0x7
	.long	8                               ; 0x8
	.long	9                               ; 0x9
	.long	10                              ; 0xa
	.long	11                              ; 0xb
	.long	12                              ; 0xc
	.size	".L__const.?test_multidim_array@@YAHHH@Z.matriz", 48

	.ident	"clang version 24.0.0git (https://github.com/llvm/llvm-project.git 48378de650fc590d905377ec09fddce008c69f73)"
	.section	".note.GNU-stack","",@progbits
