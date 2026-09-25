	.file	"tests.c"
	.text
	.globl	t01_alu_basic                   ; -- Begin function t01_alu_basic
	.type	t01_alu_basic,@function
t01_alu_basic:                          ; @t01_alu_basic
; %bb.0:                                ; %entry
	ADI R14, 12
	ADD R14, R0, R2
	SLT ADD R2, R0, R1
	SLT ADI R1, -8
	LDI R3, 240
	INT STR R1, R3, 0
	SLT ADI R2, -4
	LDI R3, 60
	INT STR R2, R3, 0
	INT LOD R1, R3, 0
	INT LOD R2, R4, 0
	ADD R3, R4, R3
	LDI R4, 0
	H LDI R4, g_t01_add
	SLT ADI R4, g_t01_add
	INT STR R4, R3, 0
	INT LOD R1, R3, 0
	INT LOD R2, R4, 0
	SUB R3, R4, R3
	LDI R4, 0
	H LDI R4, g_t01_sub
	SLT ADI R4, g_t01_sub
	INT STR R4, R3, 0
	INT LOD R1, R3, 0
	INT LOD R2, R4, 0
	AND R3, R4, R3
	LDI R4, 0
	H LDI R4, g_t01_and
	SLT ADI R4, g_t01_and
	INT STR R4, R3, 0
	INT LOD R1, R3, 0
	INT LOD R2, R4, 0
	NOR R3, R4, R3
	NOR R3, R3, R3
	LDI R4, 0
	H LDI R4, g_t01_or
	SLT ADI R4, g_t01_or
	INT STR R4, R3, 0
	INT LOD R1, R3, 0
	INT LOD R2, R2, 0
	XOR R3, R2, R2
	LDI R3, 0
	H LDI R3, g_t01_xor
	SLT ADI R3, g_t01_xor
	INT STR R3, R2, 0
	INT LOD R1, R2, 0
	LDI R3, 3
	LSH R2, R3, R2
	LDI R3, 0
	H LDI R3, g_t01_shl
	SLT ADI R3, g_t01_shl
	INT STR R3, R2, 0
	INT LOD R1, R1, 0
	LDI R2, 2
	RSH R1, R2, R1
	LDI R2, 0
	H LDI R2, g_t01_shr_logical
	SLT ADI R2, g_t01_shr_logical
	INT STR R2, R1, 0
	ADI R14, -12
	RET
.Lfunc_end0:
	.size	t01_alu_basic, .Lfunc_end0-t01_alu_basic
                                        ; -- End function
	.globl	t02_shift_arith_and_mask        ; -- Begin function t02_shift_arith_and_mask
	.type	t02_shift_arith_and_mask,@function
t02_shift_arith_and_mask:               ; @t02_shift_arith_and_mask
; %bb.0:                                ; %entry
	ADI R14, 8
	ADD R14, R0, R1
	SLT ADI R1, -4
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -32
	INT STR R1, R2, 0
	INT LOD R1, R3, 0
	LDI R2, 2
	RSH R3, R2, R4
	LDI R5, 1
	RSH R3, R5, R5
	LDI R6, 0
	H LDI R6, 16384
	SLT ADI R6, 0
	AND R5, R6, R5
	SUB R4, R5, R4
	LDI R5, 0
	SUB R2, R5, R0
	H LDI R15, %hi(.LBB1_1)
	SLT ADI R15, %lo(.LBB1_1)
	BRH EQ, R15
.LBB1_1:                                ; %entry
	SLT ADD R3, R0, R4
.LBB1_2:                                ; %entry
	LDI R3, 0
	H LDI R3, g_t02_sar
	SLT ADI R3, g_t02_sar
	INT STR R3, R4, 0
	INT LOD R1, R3, 0
	RSH R3, R2, R3
	LDI R4, 0
	H LDI R4, g_t02_shr_logical
	SLT ADI R4, g_t02_shr_logical
	INT STR R4, R3, 0
	INT LOD R1, R3, 0
	LSH R3, R2, R3
	LDI R4, 0
	H LDI R4, g_t02_shl_by2
	SLT ADI R4, g_t02_shl_by2
	INT STR R4, R3, 0
	INT LOD R1, R1, 0
	LSH R1, R2, R1
	LDI R2, 0
	H LDI R2, g_t02_shl_by34
	SLT ADI R2, g_t02_shl_by34
	INT STR R2, R1, 0
	ADI R14, -8
	RET
.Lfunc_end1:
	.size	t02_shift_arith_and_mask, .Lfunc_end1-t02_shift_arith_and_mask
                                        ; -- End function
	.globl	t03_mem_widths                  ; -- Begin function t03_mem_widths
	.type	t03_mem_widths,@function
t03_mem_widths:                         ; @t03_mem_widths
; %bb.0:                                ; %entry
	ADI R14, 4
	LDI R1, 170
	LDI R2, 0
	H LDI R2, t03_buffer+3
	SLT ADI R2, t03_buffer+3
	CHAR STR R2, R1, 0
	LDI R1, 187
	LDI R3, 0
	H LDI R3, t03_buffer+2
	SLT ADI R3, t03_buffer+2
	CHAR STR R3, R1, 0
	LDI R1, 0
	H LDI R1, t03_buffer
	SLT ADI R1, t03_buffer
	LDI R4, 204
	CHAR STR R1, R4, 1
	LDI R4, 221
	CHAR STR R1, R4, 0
	LDI R4, 0
	H LDI R4, g_t03_full32
	SLT ADI R4, g_t03_full32
	LDI R5, 0
	H LDI R5, 43708
	SLT ADI R5, -13091
	INT STR R4, R5, 0
	CHAR LOD R1, R4, 0
	LDI R5, 0
	H LDI R5, g_t03_byte0
	SLT ADI R5, g_t03_byte0
	CHAR STR R5, R4, 0
	LDI R4, 0
	H LDI R4, t03_buffer+1
	SLT ADI R4, t03_buffer+1
	CHAR LOD R4, R4, 0
	LDI R5, 8
	LSH R4, R5, R4
	CHAR LOD R1, R6, 0
	NOR R4, R6, R4
	NOR R4, R4, R4
	LDI R6, 0
	H LDI R6, g_t03_half0
	SLT ADI R6, g_t03_half0
	SHORT STR R6, R4, 0
	CHAR LOD R3, R3, 0
	LDI R4, 16
	LSH R3, R4, R3
	CHAR LOD R2, R2, 0
	LDI R4, 24
	LSH R2, R4, R2
	NOR R2, R3, R2
	NOR R2, R2, R2
	CHAR LOD R1, R3, 1
	LSH R3, R5, R3
	CHAR LOD R1, R1, 0
	NOR R3, R1, R1
	NOR R1, R1, R1
	NOR R2, R1, R1
	NOR R1, R1, R1
	LDI R2, 0
	H LDI R2, g_t03_word0
	SLT ADI R2, g_t03_word0
	INT STR R2, R1, 0
	ADI R14, -4
	RET
.Lfunc_end2:
	.size	t03_mem_widths, .Lfunc_end2-t03_mem_widths
                                        ; -- End function
	.globl	t04_cmp_signed_vs_unsigned      ; -- Begin function t04_cmp_signed_vs_unsigned
	.type	t04_cmp_signed_vs_unsigned,@function
t04_cmp_signed_vs_unsigned:             ; @t04_cmp_signed_vs_unsigned
; %bb.0:                                ; %entry
	ADI R14, 16
	ADD R14, R0, R1
	SLT ADD R1, R0, R4
	SLT ADI R4, -12
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -1
	INT STR R4, R3, 0
	SLT ADD R1, R0, R2
	SLT ADI R2, -8
	INT STR R2, R3, 0
	SLT ADI R1, -4
	LDI R3, 1
	INT STR R1, R3, 0
	INT LOD R4, R6, 0
	INT LOD R1, R7, 0
	LDI R4, 0
	SLT ADD R4, R0, R5
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB3_1)
	SLT ADI R15, %lo(.LBB3_1)
	BRH N, R15
.LBB3_1:                                ; %entry
	SLT ADD R3, R0, R5
.LBB3_2:                                ; %entry
	LDI R6, 0
	H LDI R6, g_t04_cmp_signed
	SLT ADI R6, g_t04_cmp_signed
	INT STR R6, R5, 0
	INT LOD R2, R2, 0
	INT LOD R1, R1, 0
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB3_3)
	SLT ADI R15, %lo(.LBB3_3)
	BRH C, R15
.LBB3_3:                                ; %entry
	SLT ADD R3, R0, R4
.LBB3_4:                                ; %entry
	LDI R1, 0
	H LDI R1, g_t04_cmp_unsigned
	SLT ADI R1, g_t04_cmp_unsigned
	INT STR R1, R4, 0
	ADI R14, -16
	RET
.Lfunc_end3:
	.size	t04_cmp_signed_vs_unsigned, .Lfunc_end3-t04_cmp_signed_vs_unsigned
                                        ; -- End function
	.globl	t05_loop_small_fixed            ; -- Begin function t05_loop_small_fixed
	.type	t05_loop_small_fixed,@function
t05_loop_small_fixed:                   ; @t05_loop_small_fixed
; %bb.0:                                ; %entry
	ADI R14, 12
	ADD R14, R0, R1
	SLT ADD R1, R0, R2
	SLT ADI R2, -8
	LDI R3, 0
	INT STR R2, R3, 0
	SLT ADI R1, -4
	INT STR R1, R3, 0
	H LDI R15, %hi(.LBB4_1)
	SLT ADI R15, %lo(.LBB4_1)
	JMP R15
.LBB4_1:                                ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	ADD R14, R0, R1
	SLT ADI R1, -4
	INT LOD R1, R1, 0
	LDI R2, 3
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB4_4)
	SLT ADI R15, %lo(.LBB4_4)
	BRH C, R15
	H LDI R15, %hi(.LBB4_2)
	SLT ADI R15, %lo(.LBB4_2)
	JMP R15
.LBB4_2:                                ; %for.body
                                        ;   in Loop: Header=BB4_1 Depth=1
	ADD R14, R0, R1
	SLT ADD R1, R0, R2
	SLT ADI R2, -4
	INT LOD R2, R2, 0
	MUL R2, R2, R2
	SLT ADI R1, -8
	INT LOD R1, R3, 0
	ADD R3, R2, R2
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB4_3)
	SLT ADI R15, %lo(.LBB4_3)
	JMP R15
.LBB4_3:                                ; %for.inc
                                        ;   in Loop: Header=BB4_1 Depth=1
	ADD R14, R0, R1
	SLT ADI R1, -4
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB4_1)
	SLT ADI R15, %lo(.LBB4_1)
	JMP R15
.LBB4_4:                                ; %for.end
	ADD R14, R0, R1
	SLT ADI R1, -8
	INT LOD R1, R1, 0
	LDI R2, 0
	H LDI R2, g_t05_sum
	SLT ADI R2, g_t05_sum
	INT STR R2, R1, 0
	ADI R14, -12
	RET
.Lfunc_end4:
	.size	t05_loop_small_fixed, .Lfunc_end4-t05_loop_small_fixed
                                        ; -- End function
	.globl	t06_loop_large                  ; -- Begin function t06_loop_large
	.type	t06_loop_large,@function
t06_loop_large:                         ; @t06_loop_large
; %bb.0:                                ; %entry
	ADI R14, 12
	ADD R14, R0, R1
	SLT ADD R1, R0, R2
	SLT ADI R2, -8
	LDI R3, 0
	INT STR R2, R3, 0
	SLT ADI R1, -4
	INT STR R1, R3, 0
	H LDI R15, %hi(.LBB5_1)
	SLT ADI R15, %lo(.LBB5_1)
	JMP R15
.LBB5_1:                                ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	ADD R14, R0, R1
	SLT ADI R1, -4
	INT LOD R1, R1, 0
	LDI R2, 999
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB5_4)
	SLT ADI R15, %lo(.LBB5_4)
	BRH C, R15
	H LDI R15, %hi(.LBB5_2)
	SLT ADI R15, %lo(.LBB5_2)
	JMP R15
.LBB5_2:                                ; %for.body
                                        ;   in Loop: Header=BB5_1 Depth=1
	ADD R14, R0, R1
	SLT ADD R1, R0, R2
	SLT ADI R2, -4
	INT LOD R2, R2, 0
	SLT ADI R1, -8
	INT LOD R1, R3, 0
	ADD R3, R2, R2
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB5_3)
	SLT ADI R15, %lo(.LBB5_3)
	JMP R15
.LBB5_3:                                ; %for.inc
                                        ;   in Loop: Header=BB5_1 Depth=1
	ADD R14, R0, R1
	SLT ADI R1, -4
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB5_1)
	SLT ADI R15, %lo(.LBB5_1)
	JMP R15
.LBB5_4:                                ; %for.end
	ADD R14, R0, R1
	SLT ADI R1, -8
	INT LOD R1, R1, 0
	LDI R2, 0
	H LDI R2, g_t06_sum
	SLT ADI R2, g_t06_sum
	INT STR R2, R1, 0
	ADI R14, -12
	RET
.Lfunc_end5:
	.size	t06_loop_large, .Lfunc_end5-t06_loop_large
                                        ; -- End function
	.globl	t07_nested_loop_with_break      ; -- Begin function t07_nested_loop_with_break
	.type	t07_nested_loop_with_break,@function
t07_nested_loop_with_break:             ; @t07_nested_loop_with_break
; %bb.0:                                ; %entry
	ADI R14, 16
	ADD R14, R0, R1
	SLT ADD R1, R0, R2
	SLT ADI R2, -12
	LDI R3, 0
	INT STR R2, R3, 0
	SLT ADI R1, -8
	INT STR R1, R3, 0
	H LDI R15, %hi(.LBB6_1)
	SLT ADI R15, %lo(.LBB6_1)
	JMP R15
.LBB6_1:                                ; %for.cond
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB6_3 Depth 2
	ADD R14, R0, R1
	SLT ADI R1, -8
	INT LOD R1, R1, 0
	LDI R2, 3
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB6_12)
	SLT ADI R15, %lo(.LBB6_12)
	BRH N, R15
	H LDI R15, %hi(.LBB6_2)
	SLT ADI R15, %lo(.LBB6_2)
	JMP R15
.LBB6_2:                                ; %for.body
                                        ;   in Loop: Header=BB6_1 Depth=1
	ADD R14, R0, R1
	SLT ADI R1, -4
	LDI R2, 0
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB6_3)
	SLT ADI R15, %lo(.LBB6_3)
	JMP R15
.LBB6_3:                                ; %for.cond1
                                        ;   Parent Loop BB6_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ADD R14, R0, R1
	SLT ADI R1, -4
	INT LOD R1, R1, 0
	LDI R2, 7
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB6_9)
	SLT ADI R15, %lo(.LBB6_9)
	BRH N, R15
	H LDI R15, %hi(.LBB6_4)
	SLT ADI R15, %lo(.LBB6_4)
	JMP R15
.LBB6_4:                                ; %for.body3
                                        ;   in Loop: Header=BB6_3 Depth=2
	ADD R14, R0, R1
	SLT ADI R1, -8
	INT LOD R1, R1, 0
	LDI R2, 2
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB6_7)
	SLT ADI R15, %lo(.LBB6_7)
	BRH NE, R15
	H LDI R15, %hi(.LBB6_5)
	SLT ADI R15, %lo(.LBB6_5)
	JMP R15
.LBB6_5:                                ; %land.lhs.true
                                        ;   in Loop: Header=BB6_3 Depth=2
	ADD R14, R0, R1
	SLT ADI R1, -4
	INT LOD R1, R1, 0
	LDI R2, 3
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB6_7)
	SLT ADI R15, %lo(.LBB6_7)
	BRH NE, R15
	H LDI R15, %hi(.LBB6_6)
	SLT ADI R15, %lo(.LBB6_6)
	JMP R15
.LBB6_6:                                ; %if.then
                                        ;   in Loop: Header=BB6_1 Depth=1
	H LDI R15, %hi(.LBB6_10)
	SLT ADI R15, %lo(.LBB6_10)
	JMP R15
.LBB6_7:                                ; %if.end
                                        ;   in Loop: Header=BB6_3 Depth=2
	ADD R14, R0, R1
	SLT ADD R1, R0, R2
	SLT ADI R2, -8
	INT LOD R2, R2, 0
	LDI R3, 3
	LSH R2, R3, R2
	SLT ADD R1, R0, R3
	SLT ADI R3, -4
	INT LOD R3, R3, 0
	ADD R2, R3, R2
	SLT ADI R1, -12
	INT LOD R1, R3, 0
	LDI R4, 2
	LSH R3, R4, R3
	LDI R4, 0
	H LDI R4, g_t07_array
	SLT ADI R4, g_t07_array
	ADD R3, R4, R3
	INT STR R3, R2, 0
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB6_8)
	SLT ADI R15, %lo(.LBB6_8)
	JMP R15
.LBB6_8:                                ; %for.inc
                                        ;   in Loop: Header=BB6_3 Depth=2
	ADD R14, R0, R1
	SLT ADI R1, -4
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB6_3)
	SLT ADI R15, %lo(.LBB6_3)
	JMP R15
.LBB6_9:                                ; %for.end.loopexit
                                        ;   in Loop: Header=BB6_1 Depth=1
	H LDI R15, %hi(.LBB6_10)
	SLT ADI R15, %lo(.LBB6_10)
	JMP R15
.LBB6_10:                               ; %for.end
                                        ;   in Loop: Header=BB6_1 Depth=1
	H LDI R15, %hi(.LBB6_11)
	SLT ADI R15, %lo(.LBB6_11)
	JMP R15
.LBB6_11:                               ; %for.inc7
                                        ;   in Loop: Header=BB6_1 Depth=1
	ADD R14, R0, R1
	SLT ADI R1, -8
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB6_1)
	SLT ADI R15, %lo(.LBB6_1)
	JMP R15
.LBB6_12:                               ; %for.end9
	ADD R14, R0, R1
	SLT ADI R1, -12
	INT LOD R1, R1, 0
	LDI R2, 0
	H LDI R2, g_t07_count
	SLT ADI R2, g_t07_count
	INT STR R2, R1, 0
	ADI R14, -16
	RET
.Lfunc_end6:
	.size	t07_nested_loop_with_break, .Lfunc_end6-t07_nested_loop_with_break
                                        ; -- End function
	.globl	t08_call_7args                  ; -- Begin function t08_call_7args
	.type	t08_call_7args,@function
t08_call_7args:                         ; @t08_call_7args
; %bb.0:                                ; %entry
	ADI R14, 4
	LDI R1, 11
	LDI R2, 22
	LDI R3, 33
	LDI R4, 44
	LDI R5, 55
	LDI R6, 66
	LDI R7, 77
	H LDI R15, %hi(t08_callee)
	SLT ADI R15, %lo(t08_callee)
	CAL R15
	ADI R14, -4
	RET
.Lfunc_end7:
	.size	t08_call_7args, .Lfunc_end7-t08_call_7args
                                        ; -- End function
	.type	t08_callee,@function            ; -- Begin function t08_callee
t08_callee:                             ; @t08_callee
; %bb.0:                                ; %entry
	ADI R14, 40
	INT STR R14, R8, -32
	INT STR R14, R9, -36
	ADD R14, R0, R8
	SLT ADD R8, R0, R9
	SLT ADI R9, -28
	INT STR R9, R1, 0
	SLT ADD R8, R0, R1
	SLT ADI R1, -24
	INT STR R1, R2, 0
	SLT ADD R8, R0, R2
	SLT ADI R2, -20
	INT STR R2, R3, 0
	SLT ADD R8, R0, R3
	SLT ADI R3, -16
	INT STR R3, R4, 0
	SLT ADD R8, R0, R4
	SLT ADI R4, -12
	INT STR R4, R5, 0
	SLT ADD R8, R0, R5
	SLT ADI R5, -8
	INT STR R5, R6, 0
	SLT ADI R8, -4
	INT STR R8, R7, 0
	INT LOD R9, R6, 0
	LDI R7, 0
	H LDI R7, g_t08_args
	SLT ADI R7, g_t08_args
	INT STR R7, R6, 0
	INT LOD R1, R1, 0
	LDI R6, 0
	H LDI R6, g_t08_args+4
	SLT ADI R6, g_t08_args+4
	INT STR R6, R1, 0
	INT LOD R2, R1, 0
	LDI R2, 0
	H LDI R2, g_t08_args+8
	SLT ADI R2, g_t08_args+8
	INT STR R2, R1, 0
	INT LOD R3, R1, 0
	LDI R2, 0
	H LDI R2, g_t08_args+12
	SLT ADI R2, g_t08_args+12
	INT STR R2, R1, 0
	INT LOD R4, R1, 0
	LDI R2, 0
	H LDI R2, g_t08_args+16
	SLT ADI R2, g_t08_args+16
	INT STR R2, R1, 0
	INT LOD R5, R1, 0
	LDI R2, 0
	H LDI R2, g_t08_args+20
	SLT ADI R2, g_t08_args+20
	INT STR R2, R1, 0
	INT LOD R8, R1, 0
	LDI R2, 0
	H LDI R2, g_t08_args+24
	SLT ADI R2, g_t08_args+24
	INT STR R2, R1, 0
	INT LOD R14, R9, -36
	INT LOD R14, R8, -32
	ADI R14, -40
	RET
.Lfunc_end8:
	.size	t08_callee, .Lfunc_end8-t08_callee
                                        ; -- End function
	.globl	t09_call_8args                  ; -- Begin function t09_call_8args
	.type	t09_call_8args,@function
t09_call_8args:                         ; @t09_call_8args
; %bb.0:                                ; %entry
	ADI R14, 8
	LDI R1, 137
	INT STR R14, R1, 0
	LDI R1, 101
	LDI R2, 103
	LDI R3, 107
	LDI R4, 109
	LDI R5, 113
	LDI R6, 127
	LDI R7, 131
	H LDI R15, %hi(t09_callee)
	SLT ADI R15, %lo(t09_callee)
	CAL R15
	ADI R14, -8
	RET
.Lfunc_end9:
	.size	t09_call_8args, .Lfunc_end9-t09_call_8args
                                        ; -- End function
	.type	t09_callee,@function            ; -- Begin function t09_callee
t09_callee:                             ; @t09_callee
; %bb.0:                                ; %entry
	ADI R14, 44
	INT STR R14, R8, -32
	INT STR R14, R9, -36
	INT STR R14, R10, -40
	ADD R14, R0, R9
	SLT ADD R9, R0, R8
	SLT ADI R8, -44
	SLT ADD R9, R0, R10
	SLT ADI R10, -28
	INT STR R10, R1, 0
	SLT ADD R9, R0, R1
	SLT ADI R1, -24
	INT STR R1, R2, 0
	SLT ADD R9, R0, R2
	SLT ADI R2, -20
	INT STR R2, R3, 0
	SLT ADD R9, R0, R3
	SLT ADI R3, -16
	INT STR R3, R4, 0
	SLT ADD R9, R0, R4
	SLT ADI R4, -12
	INT STR R4, R5, 0
	SLT ADD R9, R0, R5
	SLT ADI R5, -8
	INT STR R5, R6, 0
	SLT ADI R9, -4
	INT STR R9, R7, 0
	INT LOD R10, R6, 0
	LDI R7, 0
	H LDI R7, g_t09_args
	SLT ADI R7, g_t09_args
	INT STR R7, R6, 0
	INT LOD R1, R1, 0
	LDI R6, 0
	H LDI R6, g_t09_args+4
	SLT ADI R6, g_t09_args+4
	INT STR R6, R1, 0
	INT LOD R2, R1, 0
	LDI R2, 0
	H LDI R2, g_t09_args+8
	SLT ADI R2, g_t09_args+8
	INT STR R2, R1, 0
	INT LOD R3, R1, 0
	LDI R2, 0
	H LDI R2, g_t09_args+12
	SLT ADI R2, g_t09_args+12
	INT STR R2, R1, 0
	INT LOD R4, R1, 0
	LDI R2, 0
	H LDI R2, g_t09_args+16
	SLT ADI R2, g_t09_args+16
	INT STR R2, R1, 0
	INT LOD R5, R1, 0
	LDI R2, 0
	H LDI R2, g_t09_args+20
	SLT ADI R2, g_t09_args+20
	INT STR R2, R1, 0
	INT LOD R9, R1, 0
	LDI R2, 0
	H LDI R2, g_t09_args+24
	SLT ADI R2, g_t09_args+24
	INT STR R2, R1, 0
	INT LOD R8, R1, 0
	LDI R2, 0
	H LDI R2, g_t09_args+28
	SLT ADI R2, g_t09_args+28
	INT STR R2, R1, 0
	INT LOD R14, R10, -40
	INT LOD R14, R9, -36
	INT LOD R14, R8, -32
	ADI R14, -44
	RET
.Lfunc_end10:
	.size	t09_callee, .Lfunc_end10-t09_callee
                                        ; -- End function
	.globl	t10_recursion_factorial         ; -- Begin function t10_recursion_factorial
	.type	t10_recursion_factorial,@function
t10_recursion_factorial:                ; @t10_recursion_factorial
; %bb.0:                                ; %entry
	ADI R14, 4
	LDI R1, 5
	H LDI R15, %hi(t10_factorial)
	SLT ADI R15, %lo(t10_factorial)
	CAL R15
	LDI R2, 0
	H LDI R2, g_t10_fact5
	SLT ADI R2, g_t10_fact5
	INT STR R2, R1, 0
	LDI R1, 10
	H LDI R15, %hi(t10_factorial)
	SLT ADI R15, %lo(t10_factorial)
	CAL R15
	LDI R2, 0
	H LDI R2, g_t10_fact10
	SLT ADI R2, g_t10_fact10
	INT STR R2, R1, 0
	ADI R14, -4
	RET
.Lfunc_end11:
	.size	t10_recursion_factorial, .Lfunc_end11-t10_recursion_factorial
                                        ; -- End function
	.type	t10_factorial,@function         ; -- Begin function t10_factorial
t10_factorial:                          ; @t10_factorial
; %bb.0:                                ; %entry
	ADI R14, 20
	INT STR R14, R8, -12
	INT STR R14, R9, -16
	ADD R14, R0, R2
	SLT ADI R2, -4
	INT STR R2, R1, 0
	INT LOD R2, R1, 0
	LDI R2, 1
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB12_2)
	SLT ADI R15, %lo(.LBB12_2)
	BRH C, R15
	H LDI R15, %hi(.LBB12_1)
	SLT ADI R15, %lo(.LBB12_1)
	JMP R15
.LBB12_1:                               ; %if.then
	ADD R14, R0, R1
	SLT ADI R1, -8
	LDI R2, 1
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB12_3)
	SLT ADI R15, %lo(.LBB12_3)
	JMP R15
.LBB12_2:                               ; %if.end
	ADD R14, R0, R8
	SLT ADD R8, R0, R1
	SLT ADI R1, -4
	INT LOD R1, R9, 0
	SLT ADD R9, R0, R1
	ADI R1, -1
	H LDI R15, %hi(t10_factorial)
	SLT ADI R15, %lo(t10_factorial)
	CAL R15
	MUL R9, R1, R1
	SLT ADI R8, -8
	INT STR R8, R1, 0
	H LDI R15, %hi(.LBB12_3)
	SLT ADI R15, %lo(.LBB12_3)
	JMP R15
.LBB12_3:                               ; %return
	ADD R14, R0, R1
	SLT ADI R1, -8
	INT LOD R1, R1, 0
	INT LOD R14, R9, -16
	INT LOD R14, R8, -12
	ADI R14, -20
	RET
.Lfunc_end12:
	.size	t10_factorial, .Lfunc_end12-t10_factorial
                                        ; -- End function
	.globl	t11_mutual_recursion            ; -- Begin function t11_mutual_recursion
	.type	t11_mutual_recursion,@function
t11_mutual_recursion:                   ; @t11_mutual_recursion
; %bb.0:                                ; %entry
	ADI R14, 8
	INT STR R14, R8, -4
	LDI R8, 10
	SLT ADD R8, R0, R1
	H LDI R15, %hi(t11_is_even)
	SLT ADI R15, %lo(t11_is_even)
	CAL R15
	LDI R2, 0
	H LDI R2, g_t11_is_even_10
	SLT ADI R2, g_t11_is_even_10
	INT STR R2, R1, 0
	SLT ADD R8, R0, R1
	H LDI R15, %hi(t11_is_odd)
	SLT ADI R15, %lo(t11_is_odd)
	CAL R15
	LDI R2, 0
	H LDI R2, g_t11_is_odd_10
	SLT ADI R2, g_t11_is_odd_10
	INT STR R2, R1, 0
	INT LOD R14, R8, -4
	ADI R14, -8
	RET
.Lfunc_end13:
	.size	t11_mutual_recursion, .Lfunc_end13-t11_mutual_recursion
                                        ; -- End function
	.type	t11_is_even,@function           ; -- Begin function t11_is_even
t11_is_even:                            ; @t11_is_even
; %bb.0:                                ; %entry
	ADI R14, 16
	INT STR R14, R8, -12
	ADD R14, R0, R2
	SLT ADI R2, -4
	INT STR R2, R1, 0
	INT LOD R2, R1, 0
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB14_2)
	SLT ADI R15, %lo(.LBB14_2)
	BRH NE, R15
	H LDI R15, %hi(.LBB14_1)
	SLT ADI R15, %lo(.LBB14_1)
	JMP R15
.LBB14_1:                               ; %if.then
	ADD R14, R0, R1
	SLT ADI R1, -8
	LDI R2, 1
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB14_3)
	SLT ADI R15, %lo(.LBB14_3)
	JMP R15
.LBB14_2:                               ; %if.end
	ADD R14, R0, R8
	SLT ADD R8, R0, R1
	SLT ADI R1, -4
	INT LOD R1, R1, 0
	ADI R1, -1
	H LDI R15, %hi(t11_is_odd)
	SLT ADI R15, %lo(t11_is_odd)
	CAL R15
	SLT ADI R8, -8
	INT STR R8, R1, 0
	H LDI R15, %hi(.LBB14_3)
	SLT ADI R15, %lo(.LBB14_3)
	JMP R15
.LBB14_3:                               ; %return
	ADD R14, R0, R1
	SLT ADI R1, -8
	INT LOD R1, R1, 0
	INT LOD R14, R8, -12
	ADI R14, -16
	RET
.Lfunc_end14:
	.size	t11_is_even, .Lfunc_end14-t11_is_even
                                        ; -- End function
	.type	t11_is_odd,@function            ; -- Begin function t11_is_odd
t11_is_odd:                             ; @t11_is_odd
; %bb.0:                                ; %entry
	ADI R14, 16
	INT STR R14, R8, -12
	ADD R14, R0, R2
	SLT ADI R2, -4
	INT STR R2, R1, 0
	INT LOD R2, R1, 0
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB15_2)
	SLT ADI R15, %lo(.LBB15_2)
	BRH NE, R15
	H LDI R15, %hi(.LBB15_1)
	SLT ADI R15, %lo(.LBB15_1)
	JMP R15
.LBB15_1:                               ; %if.then
	ADD R14, R0, R1
	SLT ADI R1, -8
	LDI R2, 0
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB15_3)
	SLT ADI R15, %lo(.LBB15_3)
	JMP R15
.LBB15_2:                               ; %if.end
	ADD R14, R0, R8
	SLT ADD R8, R0, R1
	SLT ADI R1, -4
	INT LOD R1, R1, 0
	ADI R1, -1
	H LDI R15, %hi(t11_is_even)
	SLT ADI R15, %lo(t11_is_even)
	CAL R15
	SLT ADI R8, -8
	INT STR R8, R1, 0
	H LDI R15, %hi(.LBB15_3)
	SLT ADI R15, %lo(.LBB15_3)
	JMP R15
.LBB15_3:                               ; %return
	ADD R14, R0, R1
	SLT ADI R1, -8
	INT LOD R1, R1, 0
	INT LOD R14, R8, -12
	ADI R14, -16
	RET
.Lfunc_end15:
	.size	t11_is_odd, .Lfunc_end15-t11_is_odd
                                        ; -- End function
	.globl	t12_escaping_local_array        ; -- Begin function t12_escaping_local_array
	.type	t12_escaping_local_array,@function
t12_escaping_local_array:               ; @t12_escaping_local_array
; %bb.0:                                ; %entry
	ADI R14, 20
	INT STR R14, R8, -16
	ADD R14, R0, R8
	SLT ADI R8, -12
	SLT ADD R8, R0, R1
	H LDI R15, %hi(t12_helper)
	SLT ADI R15, %lo(t12_helper)
	CAL R15
	INT LOD R8, R1, 0
	INT LOD R8, R2, 4
	ADD R1, R2, R1
	INT LOD R8, R2, 8
	ADD R1, R2, R1
	LDI R2, 0
	H LDI R2, g_t12_sum
	SLT ADI R2, g_t12_sum
	INT STR R2, R1, 0
	INT LOD R14, R8, -16
	ADI R14, -20
	RET
.Lfunc_end16:
	.size	t12_escaping_local_array, .Lfunc_end16-t12_escaping_local_array
                                        ; -- End function
	.type	t12_helper,@function            ; -- Begin function t12_helper
t12_helper:                             ; @t12_helper
; %bb.0:                                ; %entry
	ADI R14, 8
	ADD R14, R0, R2
	SLT ADI R2, -4
	INT STR R2, R1, 0
	INT LOD R2, R1, 0
	LDI R3, 1
	INT STR R1, R3, 0
	INT LOD R2, R1, 0
	LDI R3, 2
	INT STR R1, R3, 4
	INT LOD R2, R1, 0
	LDI R2, 3
	INT STR R1, R2, 8
	ADI R14, -8
	RET
.Lfunc_end17:
	.size	t12_helper, .Lfunc_end17-t12_helper
                                        ; -- End function
	.type	g_t14_initialized,@object       ; @g_t14_initialized
	.data
	.globl	g_t14_initialized
	.p2align	2, 0x0
g_t14_initialized:
	.long	4660                            ; 0x1234
	.size	g_t14_initialized, 4

	.type	g_t01_add,@object               ; @g_t01_add
	.section	.bss,"aw",@nobits
	.globl	g_t01_add
	.p2align	2, 0x0
g_t01_add:
	.long	0                               ; 0x0
	.size	g_t01_add, 4

	.type	g_t01_sub,@object               ; @g_t01_sub
	.globl	g_t01_sub
	.p2align	2, 0x0
g_t01_sub:
	.long	0                               ; 0x0
	.size	g_t01_sub, 4

	.type	g_t01_and,@object               ; @g_t01_and
	.globl	g_t01_and
	.p2align	2, 0x0
g_t01_and:
	.long	0                               ; 0x0
	.size	g_t01_and, 4

	.type	g_t01_or,@object                ; @g_t01_or
	.globl	g_t01_or
	.p2align	2, 0x0
g_t01_or:
	.long	0                               ; 0x0
	.size	g_t01_or, 4

	.type	g_t01_xor,@object               ; @g_t01_xor
	.globl	g_t01_xor
	.p2align	2, 0x0
g_t01_xor:
	.long	0                               ; 0x0
	.size	g_t01_xor, 4

	.type	g_t01_shl,@object               ; @g_t01_shl
	.globl	g_t01_shl
	.p2align	2, 0x0
g_t01_shl:
	.long	0                               ; 0x0
	.size	g_t01_shl, 4

	.type	g_t01_shr_logical,@object       ; @g_t01_shr_logical
	.globl	g_t01_shr_logical
	.p2align	2, 0x0
g_t01_shr_logical:
	.long	0                               ; 0x0
	.size	g_t01_shr_logical, 4

	.type	g_t02_sar,@object               ; @g_t02_sar
	.globl	g_t02_sar
	.p2align	2, 0x0
g_t02_sar:
	.long	0                               ; 0x0
	.size	g_t02_sar, 4

	.type	g_t02_shr_logical,@object       ; @g_t02_shr_logical
	.globl	g_t02_shr_logical
	.p2align	2, 0x0
g_t02_shr_logical:
	.long	0                               ; 0x0
	.size	g_t02_shr_logical, 4

	.type	g_t02_shl_by2,@object           ; @g_t02_shl_by2
	.globl	g_t02_shl_by2
	.p2align	2, 0x0
g_t02_shl_by2:
	.long	0                               ; 0x0
	.size	g_t02_shl_by2, 4

	.type	g_t02_shl_by34,@object          ; @g_t02_shl_by34
	.globl	g_t02_shl_by34
	.p2align	2, 0x0
g_t02_shl_by34:
	.long	0                               ; 0x0
	.size	g_t02_shl_by34, 4

	.type	t03_buffer,@object              ; @t03_buffer
	.local	t03_buffer
	.comm	t03_buffer,4,1
	.type	g_t03_full32,@object            ; @g_t03_full32
	.globl	g_t03_full32
	.p2align	2, 0x0
g_t03_full32:
	.long	0                               ; 0x0
	.size	g_t03_full32, 4

	.type	g_t03_byte0,@object             ; @g_t03_byte0
	.globl	g_t03_byte0
g_t03_byte0:
	.byte	0                               ; 0x0
	.size	g_t03_byte0, 1

	.type	g_t03_half0,@object             ; @g_t03_half0
	.globl	g_t03_half0
	.p2align	1, 0x0
g_t03_half0:
	.short	0                               ; 0x0
	.size	g_t03_half0, 2

	.type	g_t03_word0,@object             ; @g_t03_word0
	.globl	g_t03_word0
	.p2align	2, 0x0
g_t03_word0:
	.long	0                               ; 0x0
	.size	g_t03_word0, 4

	.type	g_t04_cmp_signed,@object        ; @g_t04_cmp_signed
	.globl	g_t04_cmp_signed
	.p2align	2, 0x0
g_t04_cmp_signed:
	.long	0                               ; 0x0
	.size	g_t04_cmp_signed, 4

	.type	g_t04_cmp_unsigned,@object      ; @g_t04_cmp_unsigned
	.globl	g_t04_cmp_unsigned
	.p2align	2, 0x0
g_t04_cmp_unsigned:
	.long	0                               ; 0x0
	.size	g_t04_cmp_unsigned, 4

	.type	g_t05_sum,@object               ; @g_t05_sum
	.globl	g_t05_sum
	.p2align	2, 0x0
g_t05_sum:
	.long	0                               ; 0x0
	.size	g_t05_sum, 4

	.type	g_t06_sum,@object               ; @g_t06_sum
	.globl	g_t06_sum
	.p2align	2, 0x0
g_t06_sum:
	.long	0                               ; 0x0
	.size	g_t06_sum, 4

	.type	g_t07_array,@object             ; @g_t07_array
	.globl	g_t07_array
	.p2align	2, 0x0
g_t07_array:
	.zero	128
	.size	g_t07_array, 128

	.type	g_t07_count,@object             ; @g_t07_count
	.globl	g_t07_count
	.p2align	2, 0x0
g_t07_count:
	.long	0                               ; 0x0
	.size	g_t07_count, 4

	.type	g_t10_fact5,@object             ; @g_t10_fact5
	.globl	g_t10_fact5
	.p2align	2, 0x0
g_t10_fact5:
	.long	0                               ; 0x0
	.size	g_t10_fact5, 4

	.type	g_t10_fact10,@object            ; @g_t10_fact10
	.globl	g_t10_fact10
	.p2align	2, 0x0
g_t10_fact10:
	.long	0                               ; 0x0
	.size	g_t10_fact10, 4

	.type	g_t11_is_even_10,@object        ; @g_t11_is_even_10
	.globl	g_t11_is_even_10
	.p2align	2, 0x0
g_t11_is_even_10:
	.long	0                               ; 0x0
	.size	g_t11_is_even_10, 4

	.type	g_t11_is_odd_10,@object         ; @g_t11_is_odd_10
	.globl	g_t11_is_odd_10
	.p2align	2, 0x0
g_t11_is_odd_10:
	.long	0                               ; 0x0
	.size	g_t11_is_odd_10, 4

	.type	g_t12_sum,@object               ; @g_t12_sum
	.globl	g_t12_sum
	.p2align	2, 0x0
g_t12_sum:
	.long	0                               ; 0x0
	.size	g_t12_sum, 4

	.type	g_t08_args,@object              ; @g_t08_args
	.globl	g_t08_args
	.p2align	2, 0x0
g_t08_args:
	.zero	28
	.size	g_t08_args, 28

	.type	g_t09_args,@object              ; @g_t09_args
	.globl	g_t09_args
	.p2align	2, 0x0
g_t09_args:
	.zero	32
	.size	g_t09_args, 32

	.type	g_t13_div_normal,@object        ; @g_t13_div_normal
	.globl	g_t13_div_normal
	.p2align	2, 0x0
g_t13_div_normal:
	.long	0                               ; 0x0
	.size	g_t13_div_normal, 4

	.type	g_t13_mod_normal,@object        ; @g_t13_mod_normal
	.globl	g_t13_mod_normal
	.p2align	2, 0x0
g_t13_mod_normal:
	.long	0                               ; 0x0
	.size	g_t13_mod_normal, 4

	.type	g_t13_div_by_zero,@object       ; @g_t13_div_by_zero
	.globl	g_t13_div_by_zero
	.p2align	2, 0x0
g_t13_div_by_zero:
	.long	0                               ; 0x0
	.size	g_t13_div_by_zero, 4

	.type	g_t13_sdiv_by_zero_neg,@object  ; @g_t13_sdiv_by_zero_neg
	.globl	g_t13_sdiv_by_zero_neg
	.p2align	2, 0x0
g_t13_sdiv_by_zero_neg:
	.long	0                               ; 0x0
	.size	g_t13_sdiv_by_zero_neg, 4

	.ident	"clang version 24.0.0git (https://github.com/Licha-M/llvm-project-ISA32-LM.git e3f583d506af1169c029f963d2b9aac5b2ff0cbb)"
	.section	".note.GNU-stack","",@progbits
