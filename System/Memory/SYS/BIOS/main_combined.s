	.file	"llvm-link"
	.text
	.globl	final                           ; -- Begin function final
	.type	final,@function
final:                                  ; @final
; %bb.0:
	SLT ADI R14, 4
.LBB0_1:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB0_1)
	SLT ADI R15, %lo(.LBB0_1)
	JMP R15
.Lfunc_end0:
	.size	final, .Lfunc_end0-final
                                        ; -- End function
	.globl	initGlobalVars                  ; -- Begin function initGlobalVars
	.type	initGlobalVars,@function
initGlobalVars:                         ; @initGlobalVars
; %bb.0:
	SLT ADI R14, 28
	INT STR R14, R8, -12
	INT STR R14, R9, -16
	INT STR R14, R10, -20
	INT STR R14, R11, -24
	LDI R8, 0
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT STR R1, R8, 0
	ADD R14, R0, R10
	SLT ADD R10, R0, R9
	SLT ADI R9, -8
	INT STR R9, R8, 0
	SLT ADI R10, -4
	INT STR R10, R8, 0
	LDI R1, 4096
	LDI R3, 1
	SLT ADD R8, R0, R2
	SLT ADD R10, R0, R4
	H LDI R15, %hi(allocatePages)
	SLT ADI R15, %lo(allocatePages)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB1_2)
	SLT ADI R15, %lo(.LBB1_2)
	BRH EQ, R15
.LBB1_1:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB1_1)
	SLT ADI R15, %lo(.LBB1_1)
	JMP R15
.LBB1_2:
	LDI R3, 1
	SLT ADD R8, R0, R1
	SLT ADD R8, R0, R2
	SLT ADD R9, R0, R4
	H LDI R15, %hi(allocatePages)
	SLT ADI R15, %lo(allocatePages)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB1_4)
	SLT ADI R15, %lo(.LBB1_4)
	BRH EQ, R15
.LBB1_3:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB1_3)
	SLT ADI R15, %lo(.LBB1_3)
	JMP R15
.LBB1_4:
	LDI R2, 28
	LDI R11, 0
	H LDI R11, Globals
	SLT ADI R11, Globals
	SLT ADD R8, R0, R1
	LDI R3, 0
	H LDI R3, Globals
	SLT ADI R3, Globals
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB1_6)
	SLT ADI R15, %lo(.LBB1_6)
	BRH EQ, R15
.LBB1_5:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB1_5)
	SLT ADI R15, %lo(.LBB1_5)
	JMP R15
.LBB1_6:
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 4
	INT LOD R1, R1, 0
	INT LOD R11, R2, 0
	INT STR R2, R1, 16
	INT LOD R10, R1, 0
	INT LOD R11, R2, 0
	INT STR R2, R1, 20
	INT LOD R9, R1, 0
	INT LOD R11, R2, 0
	INT STR R2, R1, 24
	INT LOD R11, R1, 0
	INT STR R1, R8, 0
	INT LOD R11, R1, 0
	INT STR R1, R8, 8
	INT LOD R11, R1, 0
	INT STR R1, R8, 12
	INT LOD R11, R1, 0
	CHAR STR R1, R8, 4
	INT LOD R14, R11, -24
	INT LOD R14, R10, -20
	INT LOD R14, R9, -16
	INT LOD R14, R8, -12
	SLT ADI R14, -28
	RET
.Lfunc_end1:
	.size	initGlobalVars, .Lfunc_end1-initGlobalVars
                                        ; -- End function
	.globl	main                            ; -- Begin function main
	.type	main,@function
main:                                   ; @main
; %bb.0:
	SLT ADI R14, 8
	INT STR R14, R8, -4
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 0
	INT LOD R1, R1, 0
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB2_1)
	SLT ADI R15, %lo(.LBB2_1)
	BRH EQ, R15
; %bb.2:
	H LDI R15, %hi(initGlobalVars)
	SLT ADI R15, %lo(initGlobalVars)
	CAL R15
	H LDI R15, %hi(initLAPIC)
	SLT ADI R15, %lo(initLAPIC)
	CAL R15
	H LDI R15, %hi(PCIe_Bus_Enumeration)
	SLT ADI R15, %lo(PCIe_Bus_Enumeration)
	CAL R15
	H LDI R15, %hi(displaySearch)
	SLT ADI R15, %lo(displaySearch)
	CAL R15
	LDI R8, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB2_3)
	SLT ADI R15, %lo(.LBB2_3)
	BRH EQ, R15
; %bb.4:
	H LDI R15, %hi(nvmSearch)
	SLT ADI R15, %lo(nvmSearch)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB2_5)
	SLT ADI R15, %lo(.LBB2_5)
	BRH EQ, R15
; %bb.7:
	H LDI R15, %hi(keyboardSearch)
	SLT ADI R15, %lo(keyboardSearch)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB2_8)
	SLT ADI R15, %lo(.LBB2_8)
	BRH EQ, R15
; %bb.9:
	H LDI R15, %hi(BiosShell)
	SLT ADI R15, %lo(BiosShell)
	CAL R15
	H LDI R15, %hi(.LBB2_10)
	SLT ADI R15, %lo(.LBB2_10)
	JMP R15
.LBB2_1:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB2_1)
	SLT ADI R15, %lo(.LBB2_1)
	JMP R15
.LBB2_3:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB2_3)
	SLT ADI R15, %lo(.LBB2_3)
	JMP R15
.LBB2_5:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str
	SLT ADI R1, .L.str
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB2_6:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB2_6)
	SLT ADI R15, %lo(.LBB2_6)
	JMP R15
.LBB2_8:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.1
	SLT ADI R1, .L.str.1
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB2_10:
	LDI R1, 0
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        ; -- End function
	.globl	bootInit                        ; -- Begin function bootInit
	.type	bootInit,@function
bootInit:                               ; @bootInit
; %bb.0:
	SLT ADI R14, 12
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	LDI R2, 0
	H LDI R2, bootSelected
	SLT ADI R2, bootSelected
	INT STR R2, R1, 0
	LDI R8, 0
	LDI R1, 0
	H LDI R1, bootCount
	SLT ADI R1, bootCount
	INT STR R1, R8, 0
	LDI R9, 0
	H LDI R9, bootEntries
	SLT ADI R9, bootEntries
	INT STR R9, R8, 0
	LDI R1, 4
	LDI R2, 2176
	LDI R3, 0
	H LDI R3, bootEntries
	SLT ADI R3, bootEntries
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB3_2)
	SLT ADI R15, %lo(.LBB3_2)
	BRH NE, R15
; %bb.1:
	INT LOD R9, R1, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB3_3)
	SLT ADI R15, %lo(.LBB3_3)
	BRH NE, R15
.LBB3_2:
	INT STR R9, R8, 0
	LDI R8, 0
	H LDI R8, 0
	SLT ADI R8, -1
.LBB3_3:
	SLT ADD R8, R0, R1
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -12
	RET
.Lfunc_end3:
	.size	bootInit, .Lfunc_end3-bootInit
                                        ; -- End function
	.globl	bootScanDisk                    ; -- Begin function bootScanDisk
	.type	bootScanDisk,@function
bootScanDisk:                           ; @bootScanDisk
; %bb.0:
	SLT ADI R14, 312
	INT STR R14, R8, -288
	INT STR R14, R9, -292
	INT STR R14, R10, -296
	INT STR R14, R11, -300
	INT STR R14, R12, -304
	INT STR R14, R13, -308
	SLT ADD R1, R0, R9
	LDI R1, 0
	H LDI R1, bootEntries
	SLT ADI R1, bootEntries
	INT LOD R1, R1, 0
	LDI R12, 0
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB4_29)
	SLT ADI R15, %lo(.LBB4_29)
	BRH EQ, R15
; %bb.1:
	ADD R14, R0, R8
	SLT ADD R8, R0, R10
	SLT ADI R10, -284
	SLT ADD R10, R0, R1
	SLT ADD R9, R0, R2
	LDI R3, 0
	H LDI R3, .L.str.2
	SLT ADI R3, .L.str.2
	H LDI R15, %hi(fs_mount_label)
	SLT ADI R15, %lo(fs_mount_label)
	CAL R15
	SLT ADD R1, R0, R2
	SLT ADD R12, R0, R1
	SUB R2, R12, R0
	H LDI R15, %hi(.LBB4_32)
	SLT ADI R15, %lo(.LBB4_32)
	BRH NE, R15
; %bb.2:
	SLT ADD R8, R0, R3
	SLT ADI R3, -196
	INT STR R14, R10, -28
	SLT ADD R10, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.1.3
	SLT ADI R2, .L.str.1.3
	INT STR R14, R3, -24
	H LDI R15, %hi(fs_opendir)
	SLT ADI R15, %lo(fs_opendir)
	CAL R15
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB4_30)
	SLT ADI R15, %lo(.LBB4_30)
	BRH NE, R15
; %bb.3:
	INT STR R14, R8, -32
	INT STR R14, R9, -4
	LDI R1, 0
	H LDI R1, bootCount
	SLT ADI R1, bootCount
	INT LOD R1, R1, 0
	LDI R11, 31
	INT STR R14, R12, -8
	INT LOD R14, R9, -24
	SUB R11, R1, R0
	H LDI R15, %hi(.LBB4_31)
	SLT ADI R15, %lo(.LBB4_31)
	BRH C, R15
; %bb.4:
	INT LOD R14, R13, -32
	SLT ADD R13, R0, R1
	SLT ADI R1, -132
	INT STR R14, R1, -20
	ADI R1, 1
	INT STR R14, R1, -16
	SLT ADI R13, -180
	LDI R8, 0
	H LDI R8, bootCount
	SLT ADI R8, bootCount
	INT STR R14, R12, -8
	INT STR R14, R13, -12
	H LDI R15, %hi(.LBB4_7)
	SLT ADI R15, %lo(.LBB4_7)
	JMP R15
.LBB4_5:                                ;   in Loop: Header=BB4_7 Depth=1
	SLT ADD R10, R0, R11
.LBB4_6:                                ;   in Loop: Header=BB4_7 Depth=1
	INT LOD R8, R1, 0
	SUB R11, R1, R0
	H LDI R15, %hi(.LBB4_31)
	SLT ADI R15, %lo(.LBB4_31)
	BRH C, R15
.LBB4_7:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_13 Depth 2
                                        ;       Child Loop BB4_15 Depth 3
	SLT ADD R11, R0, R10
	SLT ADD R9, R0, R1
	SLT ADD R13, R0, R2
	H LDI R15, %hi(fs_readdir)
	SLT ADI R15, %lo(fs_readdir)
	CAL R15
	LDI R2, 1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB4_31)
	SLT ADI R15, %lo(.LBB4_31)
	BRH N, R15
; %bb.8:                                ;   in Loop: Header=BB4_7 Depth=1
	CHAR LOD R13, R1, 32
	LDI R2, 2
	AND R1, R2, R1
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB4_5)
	SLT ADI R15, %lo(.LBB4_5)
	BRH EQ, R15
; %bb.9:                                ;   in Loop: Header=BB4_7 Depth=1
	SLT ADD R13, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.2.4
	SLT ADI R2, .L.str.2.4
	LDI R3, 13
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB4_5)
	SLT ADI R15, %lo(.LBB4_5)
	BRH EQ, R15
; %bb.10:                               ;   in Loop: Header=BB4_7 Depth=1
	SLT ADD R13, R0, R2
	INT LOD R14, R13, -20
	LDI R1, 47
	CHAR STR R13, R1, 0
	INT LOD R14, R1, -16
	SLT ADD R10, R0, R11
	SLT ADD R11, R0, R3
	H LDI R15, %hi(strncpy)
	SLT ADI R15, %lo(strncpy)
	CAL R15
	CHAR STR R13, R12, 32
	INT LOD R14, R9, -32
	SLT ADI R9, -96
	INT LOD R14, R1, -28
	SLT ADD R13, R0, R2
	SLT ADD R9, R0, R3
	H LDI R15, %hi(fs_opendir)
	SLT ADI R15, %lo(fs_opendir)
	CAL R15
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB4_28)
	SLT ADI R15, %lo(.LBB4_28)
	BRH NE, R15
; %bb.11:                               ;   in Loop: Header=BB4_7 Depth=1
	INT LOD R8, R1, 0
	SUB R11, R1, R0
	H LDI R15, %hi(.LBB4_28)
	SLT ADI R15, %lo(.LBB4_28)
	BRH C, R15
; %bb.12:                               ; %.preheader
                                        ;   in Loop: Header=BB4_7 Depth=1
	INT LOD R14, R13, -12
.LBB4_13:                               ;   Parent Loop BB4_7 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB4_15 Depth 3
	INT LOD R14, R1, -28
	H LDI R15, %hi(.LBB4_15)
	SLT ADI R15, %lo(.LBB4_15)
	JMP R15
.LBB4_14:                               ;   in Loop: Header=BB4_15 Depth=3
	INT LOD R8, R1, 0
	LDI R2, 32
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB4_26)
	SLT ADI R15, %lo(.LBB4_26)
	BRH NC, R15
.LBB4_15:                               ;   Parent Loop BB4_7 Depth=1
                                        ;     Parent Loop BB4_13 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	INT LOD R14, R11, -32
	SLT ADI R11, -80
	SLT ADD R9, R0, R1
	SLT ADD R11, R0, R2
	H LDI R15, %hi(fs_readdir)
	SLT ADI R15, %lo(fs_readdir)
	CAL R15
	LDI R2, 1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB4_26)
	SLT ADI R15, %lo(.LBB4_26)
	BRH N, R15
; %bb.16:                               ;   in Loop: Header=BB4_15 Depth=3
	CHAR LOD R11, R1, 32
	LDI R2, 2
	AND R1, R2, R1
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB4_14)
	SLT ADI R15, %lo(.LBB4_14)
	BRH NE, R15
; %bb.17:                               ;   in Loop: Header=BB4_15 Depth=3
	INT LOD R11, R1, 40
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB4_14)
	SLT ADI R15, %lo(.LBB4_14)
	BRH EQ, R15
; %bb.18:                               ;   in Loop: Header=BB4_15 Depth=3
	SLT ADD R11, R0, R1
	H LDI R15, %hi(strlen)
	SLT ADI R15, %lo(strlen)
	CAL R15
	LDI R2, 5
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB4_14)
	SLT ADI R15, %lo(.LBB4_14)
	BRH C, R15
; %bb.19:                               ;   in Loop: Header=BB4_15 Depth=3
	ADD R11, R1, R1
	CHAR LOD R1, R2, -4
	LDI R3, 46
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB4_14)
	SLT ADI R15, %lo(.LBB4_14)
	BRH NE, R15
; %bb.20:                               ;   in Loop: Header=BB4_15 Depth=3
	CHAR LOD R1, R2, -3
	LDI R3, 223
	AND R2, R3, R2
	LDI R3, 66
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB4_14)
	SLT ADI R15, %lo(.LBB4_14)
	BRH NE, R15
; %bb.21:                               ;   in Loop: Header=BB4_15 Depth=3
	CHAR LOD R1, R2, -2
	LDI R3, 223
	AND R2, R3, R2
	LDI R3, 73
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB4_14)
	SLT ADI R15, %lo(.LBB4_14)
	BRH NE, R15
; %bb.22:                               ;   in Loop: Header=BB4_15 Depth=3
	CHAR LOD R1, R1, -1
	LDI R2, 223
	AND R1, R2, R1
	LDI R2, 78
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB4_14)
	SLT ADI R15, %lo(.LBB4_14)
	BRH NE, R15
; %bb.23:                               ;   in Loop: Header=BB4_13 Depth=2
	LDI R3, 0
	H LDI R3, bootCount
	SLT ADI R3, bootCount
	INT LOD R3, R1, 0
	SLT ADD R1, R0, R2
	ADI R2, 1
	INT STR R3, R2, 0
	LDI R2, 68
	MUL R1, R2, R1
	LDI R2, 0
	H LDI R2, bootEntries
	SLT ADI R2, bootEntries
	INT LOD R2, R2, 0
	ADD R2, R1, R8
	INT LOD R14, R1, -4
	INT STR R8, R1, 0
	SLT ADD R8, R0, R1
	ADI R1, 4
	SLT ADD R13, R0, R2
	SLT ADD R10, R0, R3
	H LDI R15, %hi(strncpy)
	SLT ADI R15, %lo(strncpy)
	CAL R15
	CHAR STR R8, R12, 35
	SLT ADD R8, R0, R1
	ADI R1, 36
	SLT ADD R11, R0, R2
	LDI R11, 31
	SLT ADD R11, R0, R3
	H LDI R15, %hi(strncpy)
	SLT ADI R15, %lo(strncpy)
	CAL R15
	CHAR STR R8, R12, 67
	INT LOD R14, R1, -8
	ADI R1, 1
	INT STR R14, R1, -8
	LDI R8, 0
	H LDI R8, bootCount
	SLT ADI R8, bootCount
	LDI R1, 0
	H LDI R1, bootCount
	SLT ADI R1, bootCount
	INT LOD R1, R1, 0
	INT LOD R14, R2, -28
	LDI R2, 32
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB4_13)
	SLT ADI R15, %lo(.LBB4_13)
	BRH C, R15
; %bb.24:                               ;   in Loop: Header=BB4_7 Depth=1
	INT LOD R14, R9, -24
	H LDI R15, %hi(.LBB4_6)
	SLT ADI R15, %lo(.LBB4_6)
	JMP R15
.LBB4_28:                               ;   in Loop: Header=BB4_7 Depth=1
	INT LOD R14, R13, -12
	INT LOD R14, R9, -24
	H LDI R15, %hi(.LBB4_6)
	SLT ADI R15, %lo(.LBB4_6)
	JMP R15
.LBB4_26:                               ;   in Loop: Header=BB4_7 Depth=1
	INT LOD R14, R1, -28
	SLT ADD R10, R0, R11
	INT LOD R14, R9, -24
	H LDI R15, %hi(.LBB4_6)
	SLT ADI R15, %lo(.LBB4_6)
	JMP R15
.LBB4_29:
	SLT ADD R12, R0, R1
	H LDI R15, %hi(.LBB4_32)
	SLT ADI R15, %lo(.LBB4_32)
	JMP R15
.LBB4_30:
	INT STR R14, R12, -8
.LBB4_31:
	INT LOD R14, R1, -28
	H LDI R15, %hi(fs_unmount)
	SLT ADI R15, %lo(fs_unmount)
	CAL R15
	INT LOD R14, R1, -8
.LBB4_32:
	INT LOD R14, R13, -308
	INT LOD R14, R12, -304
	INT LOD R14, R11, -300
	INT LOD R14, R10, -296
	INT LOD R14, R9, -292
	INT LOD R14, R8, -288
	SLT ADI R14, -312
	RET
.Lfunc_end4:
	.size	bootScanDisk, .Lfunc_end4-bootScanDisk
                                        ; -- End function
	.globl	bootRun                         ; -- Begin function bootRun
	.type	bootRun,@function
bootRun:                                ; @bootRun
; %bb.0:
	SLT ADI R14, 276
	INT STR R14, R8, -252
	INT STR R14, R9, -256
	INT STR R14, R10, -260
	INT STR R14, R11, -264
	INT STR R14, R12, -268
	INT STR R14, R13, -272
	LDI R2, 0
	H LDI R2, bootCount
	SLT ADI R2, bootCount
	INT LOD R2, R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB5_3)
	SLT ADI R15, %lo(.LBB5_3)
	BRH NC, R15
; %bb.1:
	LDI R2, 68
	MUL R1, R2, R12
	LDI R1, 0
	H LDI R1, bootEntries
	SLT ADI R1, bootEntries
	INT LOD R1, R13, 0
	ADD R13, R12, R9
	INT LOD R9, R2, 0
	ADD R14, R0, R10
	SLT ADD R10, R0, R8
	SLT ADI R8, -248
	SLT ADD R8, R0, R1
	LDI R3, 0
	H LDI R3, .L.str.2
	SLT ADI R3, .L.str.2
	H LDI R15, %hi(fs_mount_label)
	SLT ADI R15, %lo(fs_mount_label)
	CAL R15
	LDI R11, 0
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB5_4)
	SLT ADI R15, %lo(.LBB5_4)
	BRH EQ, R15
; %bb.2:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -2
	H LDI R15, %hi(.LBB5_14)
	SLT ADI R15, %lo(.LBB5_14)
	JMP R15
.LBB5_3:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	H LDI R15, %hi(.LBB5_14)
	SLT ADI R15, %lo(.LBB5_14)
	JMP R15
.LBB5_4:
	INT STR R14, R10, -12
	SLT ADI R10, -160
	LDI R2, 47
	CHAR STR R10, R2, 0
	CHAR LOD R9, R4, 4
	SUB R4, R11, R0
	H LDI R15, %hi(.LBB5_8)
	SLT ADI R15, %lo(.LBB5_8)
	BRH EQ, R15
; %bb.5:                                ; %.preheader1
	ADD R12, R13, R3
	SLT ADD R10, R0, R5
	ADI R5, 1
	ADI R3, 5
	SLT ADD R11, R0, R1
.LBB5_6:                                ; =>This Inner Loop Header: Depth=1
	ADD R5, R1, R6
	CHAR STR R6, R4, 0
	ADD R3, R1, R4
	ADI R1, 1
	CHAR LOD R4, R4, 0
	SUB R4, R11, R0
	H LDI R15, %hi(.LBB5_6)
	SLT ADI R15, %lo(.LBB5_6)
	BRH NE, R15
; %bb.7:                                ; %.loopexit2
	ADI R1, 1
	H LDI R15, %hi(.LBB5_9)
	SLT ADI R15, %lo(.LBB5_9)
	JMP R15
.LBB5_8:
	LDI R1, 1
.LBB5_9:
	ADD R10, R1, R3
	CHAR STR R3, R2, 0
	ADI R1, 1
	CHAR LOD R9, R3, 36
	SUB R3, R11, R0
	H LDI R15, %hi(.LBB5_12)
	SLT ADI R15, %lo(.LBB5_12)
	BRH EQ, R15
; %bb.10:                               ; %.preheader
	ADD R12, R13, R2
	ADI R2, 37
.LBB5_11:                               ; =>This Inner Loop Header: Depth=1
	ADD R10, R1, R4
	CHAR STR R4, R3, 0
	ADI R1, 1
	CHAR LOD R2, R3, 0
	ADI R2, 1
	SUB R3, R11, R0
	H LDI R15, %hi(.LBB5_11)
	SLT ADI R15, %lo(.LBB5_11)
	BRH NE, R15
.LBB5_12:
	ADD R10, R1, R1
	CHAR STR R1, R11, 0
	INT LOD R14, R13, -12
	SLT ADI R13, -92
	SLT ADD R8, R0, R1
	SLT ADD R10, R0, R2
	SLT ADD R13, R0, R3
	H LDI R15, %hi(fs_stat)
	SLT ADI R15, %lo(fs_stat)
	CAL R15
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB5_15)
	SLT ADI R15, %lo(.LBB5_15)
	BRH EQ, R15
.LBB5_13:
	SLT ADD R8, R0, R1
	H LDI R15, %hi(fs_unmount)
	SLT ADI R15, %lo(fs_unmount)
	CAL R15
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -3
.LBB5_14:
	INT LOD R14, R13, -272
	INT LOD R14, R12, -268
	INT LOD R14, R11, -264
	INT LOD R14, R10, -260
	INT LOD R14, R9, -256
	INT LOD R14, R8, -252
	SLT ADI R14, -276
	RET
.LBB5_15:
	CHAR LOD R13, R1, 32
	LDI R2, 2
	AND R1, R2, R1
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB5_13)
	SLT ADI R15, %lo(.LBB5_13)
	BRH NE, R15
; %bb.16:
	INT LOD R13, R1, 40
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB5_13)
	SLT ADI R15, %lo(.LBB5_13)
	BRH EQ, R15
; %bb.17:
	ADI R1, 4095
	LDI R2, 12
	RSH R1, R2, R9
	INT LOD R14, R12, -12
	SLT ADI R12, -44
	INT STR R12, R11, 0
	LDI R2, 7
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	SLT ADD R9, R0, R3
	SLT ADD R12, R0, R4
	H LDI R15, %hi(allocatePages)
	SLT ADI R15, %lo(allocatePages)
	CAL R15
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB5_21)
	SLT ADI R15, %lo(.LBB5_21)
	BRH NE, R15
; %bb.18:
	INT LOD R12, R1, 0
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB5_21)
	SLT ADI R15, %lo(.LBB5_21)
	BRH EQ, R15
; %bb.19:
	INT STR R14, R9, -8
	INT LOD R14, R9, -12
	SLT ADD R9, R0, R1
	SLT ADI R1, -16
	INT STR R14, R1, -4
	INT STR R1, R11, 0
	SLT ADI R9, -40
	SLT ADD R8, R0, R1
	SLT ADD R10, R0, R2
	SLT ADD R9, R0, R3
	H LDI R15, %hi(fs_open)
	SLT ADI R15, %lo(fs_open)
	CAL R15
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB5_22)
	SLT ADI R15, %lo(.LBB5_22)
	BRH EQ, R15
; %bb.20:
	SLT ADD R8, R0, R1
	H LDI R15, %hi(fs_unmount)
	SLT ADI R15, %lo(fs_unmount)
	CAL R15
	H LDI R15, %hi(.LBB5_25)
	SLT ADI R15, %lo(.LBB5_25)
	JMP R15
.LBB5_21:
	SLT ADD R8, R0, R1
	H LDI R15, %hi(fs_unmount)
	SLT ADI R15, %lo(fs_unmount)
	CAL R15
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -4
	H LDI R15, %hi(.LBB5_14)
	SLT ADI R15, %lo(.LBB5_14)
	JMP R15
.LBB5_22:
	INT LOD R13, R3, 40
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	INT LOD R14, R10, -4
	SLT ADD R10, R0, R4
	H LDI R15, %hi(fs_read)
	SLT ADI R15, %lo(fs_read)
	CAL R15
	SLT ADD R1, R0, R9
	SLT ADD R8, R0, R1
	H LDI R15, %hi(fs_unmount)
	SLT ADI R15, %lo(fs_unmount)
	CAL R15
	SUB R9, R11, R0
	H LDI R15, %hi(.LBB5_25)
	SLT ADI R15, %lo(.LBB5_25)
	BRH NE, R15
; %bb.23:
	INT LOD R13, R1, 40
	INT LOD R10, R2, 0
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB5_25)
	SLT ADI R15, %lo(.LBB5_25)
	BRH NE, R15
; %bb.24:
	INT LOD R12, R1, 0
	CAL R1
	LDI R8, 0
	H LDI R15, %hi(.LBB5_26)
	SLT ADI R15, %lo(.LBB5_26)
	JMP R15
.LBB5_25:
	LDI R8, 0
	H LDI R8, 0
	SLT ADI R8, -3
.LBB5_26:
	INT LOD R14, R1, -8
	SLT ADD R12, R0, R2
	H LDI R15, %hi(freePages)
	SLT ADI R15, %lo(freePages)
	CAL R15
	SLT ADD R8, R0, R1
	H LDI R15, %hi(.LBB5_14)
	SLT ADI R15, %lo(.LBB5_14)
	JMP R15
.Lfunc_end5:
	.size	bootRun, .Lfunc_end5-bootRun
                                        ; -- End function
	.globl	keyboard_IRQHandler             ; -- Begin function keyboard_IRQHandler
	.type	keyboard_IRQHandler,@function
keyboard_IRQHandler:                    ; @keyboard_IRQHandler
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R2, R0, R1
	LDI R2, 0
	H LDI R2, kq
	SLT ADI R2, kq
	INT LOD R2, R2, 0
	LDI R3, 0
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB6_3)
	SLT ADI R15, %lo(.LBB6_3)
	BRH EQ, R15
; %bb.1:
	LDI R3, 0
	H LDI R3, kb_registers
	SLT ADI R3, kb_registers
	INT LOD R3, R4, 0
	INT LOD R4, R3, 4
	LDI R5, 2
	INT STR R4, R5, 0
	SLT ADD R2, R0, R4
	ADI R4, 64
	CHAR LOD R4, R4, 0
	ADI R4, 1
	LDI R5, 63
	AND R4, R5, R4
	CHAR LOD R2, R5, 65
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB6_3)
	SLT ADI R15, %lo(.LBB6_3)
	BRH EQ, R15
; %bb.2:
	CHAR LOD R2, R5, 64
	ADD R2, R5, R2
	CHAR STR R2, R3, 0
	LDI R2, 0
	H LDI R2, kq
	SLT ADI R2, kq
	INT LOD R2, R2, 0
	CHAR STR R2, R4, 64
.LBB6_3:
	SLT ADI R14, -4
	RET
.Lfunc_end6:
	.size	keyboard_IRQHandler, .Lfunc_end6-keyboard_IRQHandler
                                        ; -- End function
	.globl	keyboardSearch                  ; -- Begin function keyboardSearch
	.type	keyboardSearch,@function
keyboardSearch:                         ; @keyboardSearch
; %bb.0:
	SLT ADI R14, 28
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	INT STR R14, R13, -24
	LDI R1, 0
	H LDI R1, 9
	SLT ADI R1, 0
	H LDI R15, %hi(searchFirst)
	SLT ADI R15, %lo(searchFirst)
	CAL R15
	LDI R8, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB7_5)
	SLT ADI R15, %lo(.LBB7_5)
	BRH N, R15
; %bb.1:
	LDI R9, 20
	MUL R1, R9, R1
	LDI R2, 0
	H LDI R2, mapa
	SLT ADI R2, mapa
	INT LOD R2, R2, 0
	ADD R2, R1, R1
	CHAR LOD R1, R12, 16
	CHAR LOD R1, R11, 17
	CHAR LOD R1, R10, 18
	LDI R1, 5
	LDI R2, 66
	LDI R13, 0
	H LDI R13, kq
	SLT ADI R13, kq
	LDI R3, 0
	H LDI R3, kq
	SLT ADI R3, kq
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB7_3)
	SLT ADI R15, %lo(.LBB7_3)
	BRH NE, R15
; %bb.2:
	INT LOD R13, R1, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB7_3)
	SLT ADI R15, %lo(.LBB7_3)
	BRH EQ, R15
; %bb.4:
	CHAR STR R1, R8, 64
	CHAR STR R1, R8, 65
	LSH R12, R9, R1
	LDI R2, 15
	LSH R11, R2, R2
	NOR R2, R1, R1
	LDI R2, 12
	LSH R10, R2, R2
	NOR R1, R1, R1
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 4
	NOR R1, R2, R2
	NOR R2, R2, R2
	LDI R8, 1
	INT STR R2, R8, 0
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 16
	NOR R1, R2, R2
	NOR R2, R2, R2
	INT LOD R2, R2, 0
	LDI R9, 0
	H LDI R9, kb_registers
	SLT ADI R9, kb_registers
	INT STR R9, R2, 0
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 0
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 126
	LDI R3, 0
	H LDI R3, keyboard_IRQHandler
	SLT ADI R3, keyboard_IRQHandler
	H LDI R15, %hi(initMSI)
	SLT ADI R15, %lo(initMSI)
	CAL R15
	INT LOD R9, R1, 0
	INT STR R1, R8, 0
	H LDI R15, %hi(.LBB7_5)
	SLT ADI R15, %lo(.LBB7_5)
	JMP R15
.LBB7_3:
	LDI R8, 0
	LDI R1, 0
	H LDI R1, .L.str.3
	SLT ADI R1, .L.str.3
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB7_5:
	SLT ADD R8, R0, R1
	INT LOD R14, R13, -24
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -28
	RET
.Lfunc_end7:
	.size	keyboardSearch, .Lfunc_end7-keyboardSearch
                                        ; -- End function
	.globl	readInput                       ; -- Begin function readInput
	.type	readInput,@function
readInput:                              ; @readInput
; %bb.0:
	SLT ADI R14, 36
	INT STR R14, R8, -12
	INT STR R14, R9, -16
	INT STR R14, R10, -20
	INT STR R14, R11, -24
	INT STR R14, R12, -28
	INT STR R14, R13, -32
	LDI R10, 0
	H LDI R10, 0
	SLT ADI R10, -1
	LDI R6, 0
	INT STR R14, R1, -4
	SUB R1, R6, R0
	H LDI R15, %hi(.LBB8_24)
	SLT ADI R15, %lo(.LBB8_24)
	BRH EQ, R15
; %bb.1:
	LDI R9, 1
	SUB R2, R9, R0
	H LDI R15, %hi(.LBB8_24)
	SLT ADI R15, %lo(.LBB8_24)
	BRH N, R15
; %bb.2:
	LDI R1, 0
	H LDI R1, kq
	SLT ADI R1, kq
	INT LOD R1, R1, 0
	SUB R1, R6, R0
	H LDI R15, %hi(.LBB8_24)
	SLT ADI R15, %lo(.LBB8_24)
	BRH EQ, R15
; %bb.3:
	INT LOD R14, R1, -4
	CHAR STR R1, R6, 0
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R3, 4
	AND R1, R3, R1
	SUB R1, R6, R0
	H LDI R15, %hi(.LBB8_5)
	SLT ADI R15, %lo(.LBB8_5)
	BRH NE, R15
; %bb.4:
	LDI R1, 0
	H LDI R1, .L.str.9
	SLT ADI R1, .L.str.9
	H LDI R15, %hi(.LBB8_23)
	SLT ADI R15, %lo(.LBB8_23)
	JMP R15
.LBB8_5:
	ADI R2, -1
	INT STR R14, R2, -8
	LDI R13, 0
	H LDI R13, kq
	SLT ADI R13, kq
	LDI R7, 63
	LDI R5, 12
	LDI R8, 10
	SLT ADD R6, R0, R1
	SLT ADD R6, R0, R10
	H LDI R15, %hi(.LBB8_7)
	SLT ADI R15, %lo(.LBB8_7)
	JMP R15
.LBB8_6:                                ;   in Loop: Header=BB8_7 Depth=1
	;APP
	HLT
	;NO_APP
.LBB8_7:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB8_8 Depth 2
	INT LOD R13, R2, 0
	CHAR LOD R2, R3, 65
	CHAR LOD R2, R2, 64
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB8_6)
	SLT ADI R15, %lo(.LBB8_6)
	BRH EQ, R15
.LBB8_8:                                ;   Parent Loop BB8_7 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	INT LOD R13, R2, 0
	CHAR LOD R2, R3, 65
	CHAR LOD R2, R4, 64
	SLT ADD R9, R0, R12
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB8_10)
	SLT ADI R15, %lo(.LBB8_10)
	BRH NE, R15
; %bb.9:                                ;   in Loop: Header=BB8_8 Depth=2
	SLT ADD R6, R0, R12
.LBB8_10:                               ;   in Loop: Header=BB8_8 Depth=2
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB8_19)
	SLT ADI R15, %lo(.LBB8_19)
	BRH EQ, R15
; %bb.11:                               ;   in Loop: Header=BB8_8 Depth=2
	CHAR LOD R2, R3, 65
	ADD R2, R3, R3
	CHAR LOD R3, R11, 0
	SLT ADD R2, R0, R3
	ADI R3, 65
	CHAR LOD R3, R4, 0
	ADI R4, 1
	AND R4, R7, R4
	CHAR STR R2, R4, 65
	SUB R5, R11, R0
	H LDI R15, %hi(.LBB8_25)
	SLT ADI R15, %lo(.LBB8_25)
	BRH N, R15
; %bb.12:                               ;   in Loop: Header=BB8_8 Depth=2
	LDI R4, 8
	SUB R11, R4, R0
	H LDI R15, %hi(.LBB8_37)
	SLT ADI R15, %lo(.LBB8_37)
	BRH EQ, R15
; %bb.13:                               ;   in Loop: Header=BB8_8 Depth=2
	SUB R11, R8, R0
	H LDI R15, %hi(.LBB8_14)
	SLT ADI R15, %lo(.LBB8_14)
	BRH NE, R15
	H LDI R15, %hi(.LBB8_27)
	SLT ADI R15, %lo(.LBB8_27)
	JMP R15
.LBB8_25:                               ;   in Loop: Header=BB8_8 Depth=2
	LDI R4, 127
	SUB R11, R4, R0
	H LDI R15, %hi(.LBB8_26)
	SLT ADI R15, %lo(.LBB8_26)
	BRH NE, R15
.LBB8_37:                               ;   in Loop: Header=BB8_8 Depth=2
	SUB R10, R9, R0
	H LDI R15, %hi(.LBB8_17)
	SLT ADI R15, %lo(.LBB8_17)
	BRH N, R15
; %bb.38:                               ;   in Loop: Header=BB8_8 Depth=2
	SLT ADD R9, R0, R13
	SLT ADD R8, R0, R9
	SLT ADD R10, R0, R8
	ADI R8, -1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB8_41)
	SLT ADI R15, %lo(.LBB8_41)
	BRH NN, R15
; %bb.39:                               ;   in Loop: Header=BB8_8 Depth=2
	SLT ADD R8, R0, R10
	H LDI R15, %hi(.LBB8_40)
	SLT ADI R15, %lo(.LBB8_40)
	JMP R15
.LBB8_41:                               ;   in Loop: Header=BB8_8 Depth=2
	LDI R1, 0
	H LDI R1, .L.str.1.7
	SLT ADI R1, .L.str.1.7
	SLT ADD R13, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R5, 12
	LDI R7, 63
	LDI R6, 0
	SLT ADD R8, R0, R10
	SLT ADD R8, R0, R1
.LBB8_40:                               ;   in Loop: Header=BB8_8 Depth=2
	SLT ADD R9, R0, R8
	SLT ADD R13, R0, R9
	LDI R13, 0
	H LDI R13, kq
	SLT ADI R13, kq
	H LDI R15, %hi(.LBB8_17)
	SLT ADI R15, %lo(.LBB8_17)
	JMP R15
.LBB8_26:                               ;   in Loop: Header=BB8_8 Depth=2
	LDI R4, 13
	SUB R11, R4, R0
	H LDI R15, %hi(.LBB8_27)
	SLT ADI R15, %lo(.LBB8_27)
	BRH EQ, R15
.LBB8_14:                               ;   in Loop: Header=BB8_8 Depth=2
	SLT ADD R11, R0, R2
	ADI R2, -32
	LDI R3, 255
	AND R2, R3, R2
	LDI R3, 94
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB8_17)
	SLT ADI R15, %lo(.LBB8_17)
	BRH C, R15
; %bb.15:                               ;   in Loop: Header=BB8_8 Depth=2
	INT LOD R14, R2, -8
	SUB R10, R2, R0
	H LDI R15, %hi(.LBB8_17)
	SLT ADI R15, %lo(.LBB8_17)
	BRH NN, R15
; %bb.16:                               ;   in Loop: Header=BB8_8 Depth=2
	INT LOD R14, R2, -4
	ADD R2, R10, R2
	CHAR STR R2, R11, 0
	ADI R10, 1
.LBB8_17:                               ;   in Loop: Header=BB8_8 Depth=2
	LDI R2, 13
	SUB R11, R2, R0
	H LDI R15, %hi(.LBB8_19)
	SLT ADI R15, %lo(.LBB8_19)
	BRH EQ, R15
; %bb.18:                               ;   in Loop: Header=BB8_8 Depth=2
	SUB R11, R8, R0
	H LDI R15, %hi(.LBB8_8)
	SLT ADI R15, %lo(.LBB8_8)
	BRH NE, R15
	H LDI R15, %hi(.LBB8_19)
	SLT ADI R15, %lo(.LBB8_19)
	JMP R15
.LBB8_27:                               ;   in Loop: Header=BB8_7 Depth=1
	SLT ADD R9, R0, R4
	SUB R11, R8, R0
	H LDI R15, %hi(.LBB8_29)
	SLT ADI R15, %lo(.LBB8_29)
	BRH EQ, R15
; %bb.28:                               ;   in Loop: Header=BB8_7 Depth=1
	SLT ADD R6, R0, R4
.LBB8_29:                               ;   in Loop: Header=BB8_7 Depth=1
	SLT ADD R9, R0, R5
	LDI R12, 13
	SUB R11, R12, R0
	H LDI R15, %hi(.LBB8_31)
	SLT ADI R15, %lo(.LBB8_31)
	BRH EQ, R15
; %bb.30:                               ;   in Loop: Header=BB8_7 Depth=1
	SLT ADD R6, R0, R5
.LBB8_31:                               ;   in Loop: Header=BB8_7 Depth=1
	SUB R11, R12, R0
	H LDI R15, %hi(.LBB8_32)
	SLT ADI R15, %lo(.LBB8_32)
	BRH NE, R15
; %bb.33:                               ;   in Loop: Header=BB8_7 Depth=1
	CHAR LOD R2, R4, 65
	CHAR LOD R2, R5, 64
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB8_34)
	SLT ADI R15, %lo(.LBB8_34)
	BRH EQ, R15
; %bb.35:                               ;   in Loop: Header=BB8_7 Depth=1
	CHAR LOD R2, R4, 65
	ADD R2, R4, R4
	CHAR LOD R4, R4, 0
	SUB R4, R8, R0
	H LDI R15, %hi(.LBB8_34)
	SLT ADI R15, %lo(.LBB8_34)
	BRH NE, R15
; %bb.36:                               ;   in Loop: Header=BB8_7 Depth=1
	CHAR LOD R3, R3, 0
	ADI R3, 1
	AND R3, R7, R3
	CHAR STR R2, R3, 65
.LBB8_34:                               ;   in Loop: Header=BB8_7 Depth=1
	SLT ADD R9, R0, R12
	LDI R5, 12
.LBB8_19:                               ;   in Loop: Header=BB8_7 Depth=1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB8_21)
	SLT ADI R15, %lo(.LBB8_21)
	BRH NN, R15
.LBB8_20:                               ;   in Loop: Header=BB8_7 Depth=1
	INT LOD R14, R3, -4
	ADD R3, R10, R2
	CHAR STR R2, R6, 0
	ADD R3, R1, R1
	SLT ADD R6, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R5, 12
	LDI R7, 63
	LDI R6, 0
	SLT ADD R10, R0, R1
.LBB8_21:                               ;   in Loop: Header=BB8_7 Depth=1
	AND R12, R9, R2
	SUB R2, R6, R0
	H LDI R15, %hi(.LBB8_7)
	SLT ADI R15, %lo(.LBB8_7)
	BRH EQ, R15
	H LDI R15, %hi(.LBB8_22)
	SLT ADI R15, %lo(.LBB8_22)
	JMP R15
.LBB8_32:                               ;   in Loop: Header=BB8_7 Depth=1
	NOR R4, R5, R2
	NOR R2, R2, R12
	LDI R5, 12
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB8_20)
	SLT ADI R15, %lo(.LBB8_20)
	BRH N, R15
	H LDI R15, %hi(.LBB8_21)
	SLT ADI R15, %lo(.LBB8_21)
	JMP R15
.LBB8_22:
	INT LOD R14, R1, -4
	ADD R1, R10, R1
	LDI R2, 0
	CHAR STR R1, R2, 0
	LDI R1, 0
	H LDI R1, .L.str.2.8
	SLT ADI R1, .L.str.2.8
.LBB8_23:
	LDI R2, 0
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB8_24:
	SLT ADD R10, R0, R1
	INT LOD R14, R13, -32
	INT LOD R14, R12, -28
	INT LOD R14, R11, -24
	INT LOD R14, R10, -20
	INT LOD R14, R9, -16
	INT LOD R14, R8, -12
	SLT ADI R14, -36
	RET
.Lfunc_end8:
	.size	readInput, .Lfunc_end8-readInput
                                        ; -- End function
	.globl	nvmSearch                       ; -- Begin function nvmSearch
	.type	nvmSearch,@function
nvmSearch:                              ; @nvmSearch
; %bb.0:
	SLT ADI R14, 172
	INT STR R14, R8, -148
	INT STR R14, R9, -152
	INT STR R14, R10, -156
	INT STR R14, R11, -160
	INT STR R14, R12, -164
	INT STR R14, R13, -168
	ADD R14, R0, R9
	SLT ADD R9, R0, R11
	SLT ADI R11, -140
	LDI R1, 0
	H LDI R1, 1
	SLT ADI R1, 2050
	SLT ADD R11, R0, R2
	H LDI R15, %hi(search)
	SLT ADI R15, %lo(search)
	CAL R15
	LDI R2, 0
	H LDI R2, Globals
	SLT ADI R2, Globals
	INT LOD R2, R3, 0
	INT STR R3, R1, 12
	INT LOD R2, R1, 0
	INT LOD R1, R1, 12
	LDI R4, 0
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB9_18)
	SLT ADI R15, %lo(.LBB9_18)
	BRH EQ, R15
; %bb.1:
	INT LOD R2, R1, 0
	INT LOD R1, R1, 12
	LDI R2, 40
	MUL R1, R2, R2
	LDI R1, 4
	LDI R8, 0
	H LDI R8, nvmDevs
	SLT ADI R8, nvmDevs
	LDI R3, 0
	H LDI R3, nvmDevs
	SLT ADI R3, nvmDevs
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB9_3)
	SLT ADI R15, %lo(.LBB9_3)
	BRH NE, R15
; %bb.2:
	INT LOD R8, R1, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB9_3)
	SLT ADI R15, %lo(.LBB9_3)
	BRH EQ, R15
; %bb.4:
	H LDI R15, %hi(bootInit)
	SLT ADI R15, %lo(bootInit)
	CAL R15
	LDI R4, 0
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB9_6)
	SLT ADI R15, %lo(.LBB9_6)
	BRH EQ, R15
; %bb.5:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.1.13
	SLT ADI R1, .L.str.1.13
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R4, 0
.LBB9_6:
	LDI R2, 0
	H LDI R2, Globals
	SLT ADI R2, Globals
	INT LOD R2, R1, 0
	INT LOD R1, R1, 12
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB9_18)
	SLT ADI R15, %lo(.LBB9_18)
	BRH EQ, R15
; %bb.7:                                ; %.preheader
	LDI R12, 125
	SLT ADI R9, -144
	INT STR R14, R9, -4
	SLT ADD R4, R0, R13
	SLT ADD R4, R0, R8
	SLT ADD R4, R0, R3
	H LDI R15, %hi(.LBB9_8)
	SLT ADI R15, %lo(.LBB9_8)
	JMP R15
.LBB9_10:                               ;   in Loop: Header=BB9_8 Depth=1
	LDI R1, 0
	H LDI R1, .L.str.2.14
	SLT ADI R1, .L.str.2.14
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R4, 0
	SLT ADD R4, R0, R2
	INT LOD R14, R11, -12
	INT LOD R14, R3, -8
.LBB9_16:                               ;   in Loop: Header=BB9_8 Depth=1
	CHAR STR R10, R2, 20
	ADI R11, 4
	ADI R13, 40
	ADI R12, -1
	ADI R8, 1
	LDI R2, 0
	H LDI R2, Globals
	SLT ADI R2, Globals
	INT LOD R2, R1, 0
	INT LOD R1, R1, 12
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB9_17)
	SLT ADI R15, %lo(.LBB9_17)
	BRH NC, R15
.LBB9_8:                                ; =>This Inner Loop Header: Depth=1
	INT STR R14, R3, -8
	INT LOD R2, R1, 0
	INT STR R1, R8, 8
	LDI R1, 0
	H LDI R1, nvmDevs
	SLT ADI R1, nvmDevs
	INT LOD R1, R1, 0
	ADD R1, R13, R10
	INT STR R14, R11, -12
	INT LOD R11, R11, 0
	INT STR R10, R8, 24
	CHAR STR R10, R4, 12
	CHAR STR R10, R4, 20
	INT STR R10, R4, 16
	INT LOD R14, R9, -4
	INT STR R9, R4, 0
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	LDI R2, 5
	LDI R3, 1
	SLT ADD R9, R0, R4
	H LDI R15, %hi(allocatePages)
	SLT ADI R15, %lo(allocatePages)
	CAL R15
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB9_10)
	SLT ADI R15, %lo(.LBB9_10)
	BRH NE, R15
; %bb.9:                                ;   in Loop: Header=BB9_8 Depth=1
	INT LOD R9, R1, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB9_10)
	SLT ADI R15, %lo(.LBB9_10)
	BRH EQ, R15
; %bb.11:                               ;   in Loop: Header=BB9_8 Depth=1
	SLT ADD R1, R0, R2
	ADI R2, 2048
	INT STR R10, R2, 8
	INT STR R10, R1, 4
	LDI R3, 3
	INT STR R11, R3, 4
	INT LOD R11, R3, 16
	INT STR R10, R3, 0
	INT STR R3, R1, 4
	INT STR R3, R2, 8
	SLT ADD R11, R0, R1
	SLT ADD R12, R0, R2
	LDI R3, 0
	H LDI R3, nvm_IRQHandler
	SLT ADI R3, nvm_IRQHandler
	H LDI R15, %hi(initMSI)
	SLT ADI R15, %lo(initMSI)
	CAL R15
	INT LOD R10, R1, 0
	LDI R9, 1
	INT STR R1, R9, 0
	SLT ADD R8, R0, R1
	H LDI R15, %hi(bootScanDisk)
	SLT ADI R15, %lo(bootScanDisk)
	CAL R15
	LDI R4, 0
	SLT ADD R9, R0, R2
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB9_13)
	SLT ADI R15, %lo(.LBB9_13)
	BRH NE, R15
; %bb.12:                               ;   in Loop: Header=BB9_8 Depth=1
	SLT ADD R4, R0, R2
.LBB9_13:                               ;   in Loop: Header=BB9_8 Depth=1
	LDI R1, 255
	INT LOD R14, R5, -8
	AND R5, R1, R3
	SLT ADD R2, R0, R1
	INT LOD R14, R11, -12
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB9_15)
	SLT ADI R15, %lo(.LBB9_15)
	BRH EQ, R15
; %bb.14:                               ;   in Loop: Header=BB9_8 Depth=1
	SLT ADD R5, R0, R1
.LBB9_15:                               ;   in Loop: Header=BB9_8 Depth=1
	SLT ADD R1, R0, R3
	H LDI R15, %hi(.LBB9_16)
	SLT ADI R15, %lo(.LBB9_16)
	JMP R15
.LBB9_3:
	LDI R8, 0
	LDI R1, 0
	H LDI R1, .L.str.12
	SLT ADI R1, .L.str.12
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	SLT ADD R8, R0, R4
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT STR R1, R4, 12
	H LDI R15, %hi(.LBB9_18)
	SLT ADI R15, %lo(.LBB9_18)
	JMP R15
.LBB9_17:
	SLT ADD R3, R0, R4
.LBB9_18:
	LDI R1, 1
	AND R4, R1, R1
	INT LOD R14, R13, -168
	INT LOD R14, R12, -164
	INT LOD R14, R11, -160
	INT LOD R14, R10, -156
	INT LOD R14, R9, -152
	INT LOD R14, R8, -148
	SLT ADI R14, -172
	RET
.Lfunc_end9:
	.size	nvmSearch, .Lfunc_end9-nvmSearch
                                        ; -- End function
	.type	nvm_IRQHandler,@function        ; -- Begin function nvm_IRQHandler
nvm_IRQHandler:                         ; @nvm_IRQHandler
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R2, R0, R1
	LDI R2, 125
	SUB R2, R3, R2
	LDI R3, 0
	H LDI R3, Globals
	SLT ADI R3, Globals
	INT LOD R3, R3, 0
	INT LOD R3, R3, 12
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB10_4)
	SLT ADI R15, %lo(.LBB10_4)
	BRH NC, R15
; %bb.1:
	LDI R3, 0
	H LDI R3, nvmDevs
	SLT ADI R3, nvmDevs
	INT LOD R3, R3, 0
	LDI R4, 0
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB10_4)
	SLT ADI R15, %lo(.LBB10_4)
	BRH EQ, R15
; %bb.2:
	LDI R4, 40
	MUL R2, R4, R2
	ADD R3, R2, R2
	INT LOD R2, R3, 16
	LDI R4, 3
	LSH R3, R4, R4
	INT LOD R2, R5, 8
	ADD R5, R4, R4
	INT LOD R4, R4, 0
	LDI R5, 0
	H LDI R5, 256
	SLT ADI R5, -1
	AND R4, R5, R4
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB10_4)
	SLT ADI R15, %lo(.LBB10_4)
	BRH NE, R15
; %bb.3:
	LDI R3, 1
	CHAR STR R2, R3, 12
.LBB10_4:
	SLT ADI R14, -4
	RET
.Lfunc_end10:
	.size	nvm_IRQHandler, .Lfunc_end10-nvm_IRQHandler
                                        ; -- End function
	.globl	nvm_read_sectors                ; -- Begin function nvm_read_sectors
	.type	nvm_read_sectors,@function
nvm_read_sectors:                       ; @nvm_read_sectors
; %bb.0:
	SLT ADI R14, 20
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	LDI R5, 0
	H LDI R5, Globals
	SLT ADI R5, Globals
	INT LOD R5, R5, 0
	INT LOD R5, R5, 12
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB11_2)
	SLT ADI R15, %lo(.LBB11_2)
	BRH NC, R15
; %bb.1:
	LDI R5, 0
	H LDI R5, nvmDevs
	SLT ADI R5, nvmDevs
	INT LOD R5, R5, 0
	LDI R8, 0
	SUB R5, R8, R0
	H LDI R15, %hi(.LBB11_2)
	SLT ADI R15, %lo(.LBB11_2)
	BRH EQ, R15
; %bb.3:
	LDI R6, 40
	MUL R1, R6, R1
	ADD R5, R1, R1
	INT LOD R1, R6, 16
	;APP
	CYE SR8, R5
	;NO_APP
	;APP
	CYE SR8, R9
	;NO_APP
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -5
	AND R9, R7, R9
	;APP
	CYR R9, SR8
	;NO_APP
	LDI R9, 3
	LSH R6, R9, R9
	INT LOD R1, R10, 8
	ADD R10, R9, R9
	LDI R10, 0
	H LDI R10, 0
	SLT ADI R10, -1
	INT STR R9, R10, 0
	LDI R9, 4
	LSH R6, R9, R10
	INT LOD R1, R11, 4
	ADD R11, R10, R10
	CHAR STR R1, R8, 12
	INT STR R10, R4, 4
	INT STR R10, R2, 8
	INT STR R10, R3, 12
	INT STR R10, R6, 0
	LDI R2, 1
	INT LOD R1, R3, 0
	CHAR STR R3, R2, 12
	CHAR LOD R1, R3, 12
	SUB R3, R8, R0
	H LDI R15, %hi(.LBB11_5)
	SLT ADI R15, %lo(.LBB11_5)
	BRH NE, R15
.LBB11_4:                               ; =>This Inner Loop Header: Depth=1
	;APP
	CYE SR8, R3
	;NO_APP
	NOR R3, R9, R3
	NOR R3, R3, R3
	;APP
	CYR R3, SR8
	;NO_APP
	;APP
	HLT
	;NO_APP
	;APP
	CYE SR8, R3
	;NO_APP
	AND R3, R7, R3
	;APP
	CYR R3, SR8
	;NO_APP
	CHAR LOD R1, R3, 12
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB11_4)
	SLT ADI R15, %lo(.LBB11_4)
	BRH NE, R15
.LBB11_5:
	ADI R6, 1
	LDI R2, 127
	AND R6, R2, R2
	INT STR R1, R2, 16
	;APP
	CYR R5, SR8
	;NO_APP
	LDI R1, 0
	H LDI R15, %hi(.LBB11_6)
	SLT ADI R15, %lo(.LBB11_6)
	JMP R15
.LBB11_2:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.4
	SLT ADI R1, .L.str.4
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 2
.LBB11_6:
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -20
	RET
.Lfunc_end11:
	.size	nvm_read_sectors, .Lfunc_end11-nvm_read_sectors
                                        ; -- End function
	.globl	nvm_write_sectors               ; -- Begin function nvm_write_sectors
	.type	nvm_write_sectors,@function
nvm_write_sectors:                      ; @nvm_write_sectors
; %bb.0:
	SLT ADI R14, 20
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	LDI R5, 0
	H LDI R5, Globals
	SLT ADI R5, Globals
	INT LOD R5, R5, 0
	INT LOD R5, R5, 12
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB12_2)
	SLT ADI R15, %lo(.LBB12_2)
	BRH NC, R15
; %bb.1:
	LDI R5, 0
	H LDI R5, nvmDevs
	SLT ADI R5, nvmDevs
	INT LOD R5, R5, 0
	LDI R8, 0
	SUB R5, R8, R0
	H LDI R15, %hi(.LBB12_2)
	SLT ADI R15, %lo(.LBB12_2)
	BRH EQ, R15
; %bb.3:
	LDI R6, 40
	MUL R1, R6, R1
	ADD R5, R1, R1
	INT LOD R1, R6, 16
	;APP
	CYE SR8, R5
	;NO_APP
	;APP
	CYE SR8, R9
	;NO_APP
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -5
	AND R9, R7, R9
	;APP
	CYR R9, SR8
	;NO_APP
	LDI R9, 3
	LSH R6, R9, R9
	INT LOD R1, R10, 8
	ADD R10, R9, R9
	LDI R10, 0
	H LDI R10, 0
	SLT ADI R10, -1
	INT STR R9, R10, 0
	LDI R9, 4
	LSH R6, R9, R10
	INT LOD R1, R11, 4
	ADD R11, R10, R10
	CHAR STR R1, R8, 12
	INT STR R10, R4, 4
	INT STR R10, R2, 8
	INT STR R10, R3, 12
	LDI R2, 0
	H LDI R2, 256
	SLT ADI R2, 0
	NOR R6, R2, R2
	NOR R2, R2, R2
	INT STR R10, R2, 0
	LDI R2, 1
	INT LOD R1, R3, 0
	CHAR STR R3, R2, 12
	CHAR LOD R1, R3, 12
	SUB R3, R8, R0
	H LDI R15, %hi(.LBB12_5)
	SLT ADI R15, %lo(.LBB12_5)
	BRH NE, R15
.LBB12_4:                               ; =>This Inner Loop Header: Depth=1
	;APP
	CYE SR8, R3
	;NO_APP
	NOR R3, R9, R3
	NOR R3, R3, R3
	;APP
	CYR R3, SR8
	;NO_APP
	;APP
	HLT
	;NO_APP
	;APP
	CYE SR8, R3
	;NO_APP
	AND R3, R7, R3
	;APP
	CYR R3, SR8
	;NO_APP
	CHAR LOD R1, R3, 12
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB12_4)
	SLT ADI R15, %lo(.LBB12_4)
	BRH NE, R15
.LBB12_5:
	ADI R6, 1
	LDI R2, 127
	AND R6, R2, R2
	INT STR R1, R2, 16
	;APP
	CYR R5, SR8
	;NO_APP
	LDI R1, 0
	H LDI R15, %hi(.LBB12_6)
	SLT ADI R15, %lo(.LBB12_6)
	JMP R15
.LBB12_2:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.4
	SLT ADI R1, .L.str.4
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 2
.LBB12_6:
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -20
	RET
.Lfunc_end12:
	.size	nvm_write_sectors, .Lfunc_end12-nvm_write_sectors
                                        ; -- End function
	.globl	displaySearch                   ; -- Begin function displaySearch
	.type	displaySearch,@function
displaySearch:                          ; @displaySearch
; %bb.0:
	SLT ADI R14, 32
	INT STR R14, R8, -8
	INT STR R14, R9, -12
	INT STR R14, R10, -16
	INT STR R14, R11, -20
	INT STR R14, R12, -24
	INT STR R14, R13, -28
	LDI R1, 0
	H LDI R1, 7
	SLT ADI R1, 0
	H LDI R15, %hi(searchFirst)
	SLT ADI R15, %lo(searchFirst)
	CAL R15
	SLT ADD R1, R0, R8
	LDI R10, 0
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB13_4)
	SLT ADI R15, %lo(.LBB13_4)
	BRH N, R15
; %bb.1:
	LDI R1, 20
	MUL R8, R1, R1
	LDI R2, 0
	H LDI R2, mapa
	SLT ADI R2, mapa
	INT LOD R2, R2, 0
	ADD R2, R1, R1
	CHAR LOD R1, R11, 16
	CHAR LOD R1, R13, 17
	CHAR LOD R1, R12, 18
	LDI R1, 4
	LDI R2, 16
	LDI R3, 0
	H LDI R3, current_display
	SLT ADI R3, current_display
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB13_5)
	SLT ADI R15, %lo(.LBB13_5)
	BRH NE, R15
; %bb.2:
	ADD R14, R0, R9
	SLT ADI R9, -4
	LDI R1, 5
	LDI R2, 831
	SLT ADD R9, R0, R3
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB13_5)
	SLT ADI R15, %lo(.LBB13_5)
	BRH NE, R15
; %bb.3:
	INT LOD R9, R1, 0
	ADI R1, 63
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -64
	AND R1, R2, R1
	LDI R2, 0
	H LDI R2, display_queue
	SLT ADI R2, display_queue
	INT STR R2, R1, 0
	LDI R2, 20
	LSH R11, R2, R2
	LDI R3, 15
	LSH R13, R3, R3
	NOR R3, R2, R2
	LDI R3, 12
	LSH R12, R3, R3
	CHAR STR R1, R10, 64
	CHAR STR R1, R10, 65
	CHAR STR R1, R10, 66
	LDI R11, 0
	H LDI R11, current_display
	SLT ADI R11, current_display
	INT LOD R11, R1, 0
	CHAR STR R1, R10, 12
	NOR R2, R2, R2
	NOR R2, R3, R2
	NOR R2, R2, R2
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 4
	NOR R2, R3, R3
	NOR R3, R3, R3
	LDI R4, 3
	INT STR R3, R4, 0
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 16
	NOR R2, R3, R3
	NOR R3, R3, R3
	INT LOD R3, R3, 0
	INT STR R1, R3, 4
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 0
	NOR R2, R1, R1
	NOR R1, R1, R9
	LDI R2, 127
	SLT ADD R9, R0, R1
	LDI R3, 0
	H LDI R3, tty_IRQHandler
	SLT ADI R3, tty_IRQHandler
	H LDI R15, %hi(initMSI)
	SLT ADI R15, %lo(initMSI)
	CAL R15
	INT LOD R11, R1, 0
	LDI R2, 0
	H LDI R2, ttyWrite
	SLT ADI R2, ttyWrite
	INT STR R1, R2, 0
	INT STR R1, R9, 8
.LBB13_4:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	XOR R8, R1, R1
	LDI R2, 31
	RSH R1, R2, R1
	INT LOD R14, R13, -28
	INT LOD R14, R12, -24
	INT LOD R14, R11, -20
	INT LOD R14, R10, -16
	INT LOD R14, R9, -12
	INT LOD R14, R8, -8
	SLT ADI R14, -32
	RET
.LBB13_5:
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
.Lfunc_end13:
	.size	displaySearch, .Lfunc_end13-displaySearch
                                        ; -- End function
	.type	tty_IRQHandler,@function        ; -- Begin function tty_IRQHandler
tty_IRQHandler:                         ; @tty_IRQHandler
; %bb.0:
	SLT ADI R14, 8
	INT STR R14, R8, -4
	SLT ADD R2, R0, R1
	LDI R2, 0
	H LDI R2, display_queue
	SLT ADI R2, display_queue
	INT LOD R2, R2, 0
	SLT ADD R2, R0, R3
	ADI R3, 64
	CHAR LOD R3, R3, 0
	ADI R3, 1
	LDI R4, 3
	AND R3, R4, R3
	CHAR STR R2, R3, 64
	SLT ADD R2, R0, R3
	ADI R3, 66
	CHAR LOD R3, R3, 0
	ADI R3, -1
	CHAR STR R2, R3, 66
	CHAR LOD R2, R4, 66
	LDI R3, 0
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB14_1)
	SLT ADI R15, %lo(.LBB14_1)
	BRH NE, R15
; %bb.2:
	LDI R2, 0
	H LDI R2, current_display
	SLT ADI R2, current_display
	INT LOD R2, R2, 0
	CHAR STR R2, R3, 12
.LBB14_3:
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.LBB14_1:
	CHAR LOD R2, R3, 64
	LDI R4, 4
	LSH R3, R4, R3
	ADD R2, R3, R2
	SLT ADD R1, R0, R8
	SLT ADD R2, R0, R1
	H LDI R15, %hi(tty_execute_request)
	SLT ADI R15, %lo(tty_execute_request)
	CAL R15
	SLT ADD R8, R0, R1
	H LDI R15, %hi(.LBB14_3)
	SLT ADI R15, %lo(.LBB14_3)
	JMP R15
.Lfunc_end14:
	.size	tty_IRQHandler, .Lfunc_end14-tty_IRQHandler
                                        ; -- End function
	.type	ttyWrite,@function              ; -- Begin function ttyWrite
ttyWrite:                               ; @ttyWrite
; %bb.0:
	SLT ADI R14, 64
	INT STR R14, R8, -40
	INT STR R14, R9, -44
	INT STR R14, R10, -48
	INT STR R14, R11, -52
	INT STR R14, R12, -56
	INT STR R14, R13, -60
	SLT ADD R3, R0, R7
	SLT ADD R2, R0, R6
	SLT ADD R1, R0, R12
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	CHAR LOD R1, R1, 4
	LDI R2, 1
	INT STR R14, R6, -12
	INT STR R14, R7, -8
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB15_1)
	SLT ADI R15, %lo(.LBB15_1)
	BRH EQ, R15
; %bb.5:
	LDI R1, 0
	LDI R13, 3
	SLT ADD R2, R0, R3
	SUB R6, R13, R0
	H LDI R15, %hi(.LBB15_7)
	SLT ADI R15, %lo(.LBB15_7)
	BRH NE, R15
; %bb.6:
	SLT ADD R1, R0, R3
.LBB15_7:
	SUB R2, R7, R0
	H LDI R15, %hi(.LBB15_9)
	SLT ADI R15, %lo(.LBB15_9)
	BRH N, R15
; %bb.8:
	SLT ADD R1, R0, R2
.LBB15_9:
	AND R3, R2, R2
	LDI R3, 2
	RSH R6, R3, R3
	NOR R3, R2, R2
	NOR R2, R2, R2
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB15_10)
	SLT ADI R15, %lo(.LBB15_10)
	BRH EQ, R15
; %bb.20:
	ADD R14, R0, R1
	SLT ADI R1, -36
	INT STR R14, R1, -4
	INT STR R1, R12, 0
	LDI R4, 0
	LDI R1, 1
	LDI R5, 4
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB15_22)
	SLT ADI R15, %lo(.LBB15_22)
	BRH EQ, R15
; %bb.21:
	SLT ADD R4, R0, R1
.LBB15_22:
	LDI R3, 0
	H LDI R3, 65520
	SLT ADI R3, -1
	LDI R2, 1
	SUB R3, R12, R0
	H LDI R15, %hi(.LBB15_24)
	SLT ADI R15, %lo(.LBB15_24)
	BRH C, R15
; %bb.23:
	SLT ADD R4, R0, R2
.LBB15_24:
	AND R2, R1, R1
	LDI R8, 0
	H LDI R8, display_queue
	SLT ADI R8, display_queue
	LDI R2, 1
	AND R1, R2, R1
	INT STR R14, R1, -16
	SLT ADD R4, R0, R1
	H LDI R15, %hi(.LBB15_25)
	SLT ADI R15, %lo(.LBB15_25)
	JMP R15
.LBB15_33:                              ;   in Loop: Header=BB15_25 Depth=1
	INT LOD R4, R3, 12
	INT STR R2, R3, 8
	LDI R3, 2
.LBB15_36:                              ;   in Loop: Header=BB15_25 Depth=1
	INT STR R2, R3, 0
	LDI R4, 0
	LDI R5, 4
.LBB15_37:                              ;   in Loop: Header=BB15_25 Depth=1
	INT LOD R14, R2, -20
	;APP
	CYR R2, SR8
	;NO_APP
	LDI R3, 1
	AND R1, R3, R2
	SLT ADD R3, R0, R1
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB15_38)
	SLT ADI R15, %lo(.LBB15_38)
	BRH EQ, R15
.LBB15_25:                              ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB15_26 Depth 2
	INT LOD R8, R2, 0
	CHAR LOD R2, R2, 66
	SUB R2, R5, R0
	H LDI R15, %hi(.LBB15_27)
	SLT ADI R15, %lo(.LBB15_27)
	BRH C, R15
.LBB15_26:                              ;   Parent Loop BB15_25 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	;APP
	HLT
	;NO_APP
	INT LOD R8, R2, 0
	CHAR LOD R2, R2, 66
	SUB R13, R2, R0
	H LDI R15, %hi(.LBB15_26)
	SLT ADI R15, %lo(.LBB15_26)
	BRH C, R15
.LBB15_27:                              ;   in Loop: Header=BB15_25 Depth=1
	;APP
	CYE SR8, R2
	;NO_APP
	INT STR R14, R2, -20
	;APP
	CYE SR8, R2
	;NO_APP
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -5
	AND R2, R3, R2
	;APP
	CYR R2, SR8
	;NO_APP
	INT LOD R8, R11, 0
	CHAR LOD R11, R9, 65
	SLT ADD R12, R0, R10
	INT LOD R14, R2, -16
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB15_29)
	SLT ADI R15, %lo(.LBB15_29)
	BRH EQ, R15
; %bb.28:                               ;   in Loop: Header=BB15_25 Depth=1
	LDI R1, 7
	LSH R9, R1, R1
	ADD R11, R1, R12
	ADI R12, 128
	SLT ADD R12, R0, R1
	INT LOD R14, R2, -4
	H LDI R15, %hi(copy_to_bounce)
	SLT ADI R15, %lo(copy_to_bounce)
	CAL R15
	LDI R5, 4
	LDI R4, 0
	INT LOD R14, R7, -8
	INT LOD R14, R6, -12
	LDI R2, 1
	XOR R1, R2, R1
.LBB15_29:                              ;   in Loop: Header=BB15_25 Depth=1
	LSH R9, R5, R2
	ADD R11, R2, R2
	INT STR R2, R12, 0
	CHAR LOD R12, R3, 0
	INT STR R2, R7, 12
	INT STR R2, R6, 8
	CHAR STR R2, R3, 4
	ADI R9, 1
	AND R9, R13, R2
	CHAR STR R11, R2, 65
	SLT ADD R11, R0, R2
	ADI R2, 66
	CHAR LOD R2, R2, 0
	ADI R2, 1
	CHAR STR R11, R2, 66
	LDI R2, 0
	H LDI R2, current_display
	SLT ADI R2, current_display
	INT LOD R2, R2, 0
	CHAR LOD R2, R3, 12
	SLT ADD R10, R0, R12
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB15_37)
	SLT ADI R15, %lo(.LBB15_37)
	BRH NE, R15
; %bb.30:                               ;   in Loop: Header=BB15_25 Depth=1
	LDI R3, 1
	CHAR STR R2, R3, 12
	CHAR LOD R11, R3, 64
	LSH R3, R5, R3
	ADD R11, R3, R4
	INT LOD R2, R2, 4
	INT LOD R4, R3, 8
	SLT ADD R3, R0, R5
	ADI R5, -1
	SUB R13, R5, R0
	H LDI R15, %hi(.LBB15_35)
	SLT ADI R15, %lo(.LBB15_35)
	BRH C, R15
; %bb.31:                               ;   in Loop: Header=BB15_25 Depth=1
	LDI R9, 2
	LSH R5, R9, R5
	LDI R9, 0
	H LDI R9, .LJTI15_0
	SLT ADI R9, .LJTI15_0
	ADD R9, R5, R5
	INT LOD R5, R5, 0
	JMP R5
.LBB15_32:                              ;   in Loop: Header=BB15_25 Depth=1
	INT LOD R4, R3, 12
	INT STR R2, R3, 8
	CHAR LOD R4, R3, 4
	INT STR R2, R3, 4
	LDI R3, 1
	H LDI R15, %hi(.LBB15_36)
	SLT ADI R15, %lo(.LBB15_36)
	JMP R15
.LBB15_34:                              ;   in Loop: Header=BB15_25 Depth=1
	INT LOD R4, R3, 0
	INT STR R2, R3, 4
	LDI R3, 4
	H LDI R15, %hi(.LBB15_36)
	SLT ADI R15, %lo(.LBB15_36)
	JMP R15
.LBB15_35:                              ;   in Loop: Header=BB15_25 Depth=1
	LDI R3, 0
	H LDI R15, %hi(.LBB15_36)
	SLT ADI R15, %lo(.LBB15_36)
	JMP R15
.LBB15_10:
	LDI R2, 0
	H LDI R2, current_display
	SLT ADI R2, current_display
	INT LOD R2, R1, 0
	CHAR LOD R1, R1, 12
	LDI R3, 1
	SUB R1, R3, R0
	H LDI R15, %hi(.LBB15_13)
	SLT ADI R15, %lo(.LBB15_13)
	BRH NE, R15
; %bb.11:                               ; %.preheader
	LDI R1, 0
.LBB15_12:                              ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	INT LOD R2, R3, 0
	CHAR LOD R3, R3, 12
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB15_12)
	SLT ADI R15, %lo(.LBB15_12)
	BRH NE, R15
.LBB15_13:
	;APP
	CYE SR8, R1
	;NO_APP
	;APP
	CYE SR8, R3
	;NO_APP
	LDI R4, 0
	H LDI R4, 0
	SLT ADI R4, -5
	AND R3, R4, R3
	;APP
	CYR R3, SR8
	;NO_APP
	INT LOD R2, R2, 0
	INT LOD R2, R2, 4
	SLT ADD R6, R0, R3
	ADI R3, -1
	SUB R13, R3, R0
	H LDI R15, %hi(.LBB15_18)
	SLT ADI R15, %lo(.LBB15_18)
	BRH C, R15
; %bb.14:
	LDI R4, 2
	LSH R3, R4, R3
	LDI R4, 0
	H LDI R4, .LJTI15_1
	SLT ADI R4, .LJTI15_1
	ADD R4, R3, R3
	INT LOD R3, R3, 0
	JMP R3
.LBB15_15:
	CHAR LOD R12, R3, 0
	INT STR R2, R7, 8
	INT STR R2, R3, 4
	LDI R6, 1
	H LDI R15, %hi(.LBB15_19)
	SLT ADI R15, %lo(.LBB15_19)
	JMP R15
.LBB15_16:
	INT STR R2, R7, 8
	LDI R6, 2
	H LDI R15, %hi(.LBB15_19)
	SLT ADI R15, %lo(.LBB15_19)
	JMP R15
.LBB15_17:
	INT STR R2, R12, 4
	LDI R6, 4
	H LDI R15, %hi(.LBB15_19)
	SLT ADI R15, %lo(.LBB15_19)
	JMP R15
.LBB15_18:
	LDI R6, 0
.LBB15_19:
	INT STR R2, R6, 0
	;APP
	CYR R1, SR8
	;NO_APP
.LBB15_38:
	INT LOD R14, R13, -60
	INT LOD R14, R12, -56
	INT LOD R14, R11, -52
	INT LOD R14, R10, -48
	INT LOD R14, R9, -44
	INT LOD R14, R8, -40
	SLT ADI R14, -64
	RET
.LBB15_1:
	LDI R1, 0
	H LDI R1, 65520
	SLT ADI R1, 0
	SLT ADD R12, R0, R11
	SUB R12, R1, R0
	H LDI R15, %hi(.LBB15_4)
	SLT ADI R15, %lo(.LBB15_4)
	BRH C, R15
; %bb.2:
	LDI R1, 4
	SLT ADD R12, R0, R11
	SUB R6, R1, R0
	H LDI R15, %hi(.LBB15_4)
	SLT ADI R15, %lo(.LBB15_4)
	BRH NE, R15
; %bb.3:
	ADD R14, R0, R2
	SLT ADI R2, -36
	INT STR R2, R12, 0
	LDI R1, 0
	H LDI R1, display_queue
	SLT ADI R1, display_queue
	INT LOD R1, R11, 0
	ADI R11, 640
	SLT ADD R11, R0, R1
	H LDI R15, %hi(copy_to_bounce)
	SLT ADI R15, %lo(copy_to_bounce)
	CAL R15
	INT LOD R14, R7, -8
	INT LOD R14, R6, -12
.LBB15_4:
	ADD R14, R0, R1
	SLT ADI R1, -36
	INT STR R1, R11, 0
	CHAR LOD R12, R2, 0
	CHAR STR R1, R2, 4
	LDI R2, 0
	CHAR STR R1, R2, 5
	CHAR STR R1, R2, 6
	CHAR STR R1, R2, 7
	INT STR R1, R7, 12
	INT STR R1, R6, 8
	H LDI R15, %hi(tty_execute_request)
	SLT ADI R15, %lo(tty_execute_request)
	CAL R15
	H LDI R15, %hi(.LBB15_38)
	SLT ADI R15, %lo(.LBB15_38)
	JMP R15
.Lfunc_end15:
	.size	ttyWrite, .Lfunc_end15-ttyWrite
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
	.type	.LJTI15_0,@object
.LJTI15_0:
	.long	.LBB15_32
	.long	.LBB15_33
	.long	.LBB15_36
	.long	.LBB15_34
	.size	.LJTI15_0, 16
	.type	.LJTI15_1,@object
.LJTI15_1:
	.long	.LBB15_15
	.long	.LBB15_16
	.long	.LBB15_19
	.long	.LBB15_17
	.size	.LJTI15_1, 16
                                        ; -- End function
	.text
	.type	copy_to_bounce,@function        ; -- Begin function copy_to_bounce
copy_to_bounce:                         ; @copy_to_bounce
; %bb.0:
	SLT ADI R14, 4
	INT LOD R2, R3, 0
	INT LOD R3, R5, 0
	INT STR R1, R5, 0
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	BRH NE, R15
; %bb.1:
	INT LOD R3, R6, 4
	INT STR R1, R6, 4
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB16_2)
	SLT ADI R15, %lo(.LBB16_2)
	BRH NE, R15
; %bb.3:
	INT LOD R3, R5, 8
	INT STR R1, R5, 8
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB16_4)
	SLT ADI R15, %lo(.LBB16_4)
	BRH NE, R15
; %bb.5:
	INT LOD R3, R6, 12
	INT STR R1, R6, 12
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB16_6)
	SLT ADI R15, %lo(.LBB16_6)
	BRH NE, R15
; %bb.7:
	INT LOD R3, R5, 16
	INT STR R1, R5, 16
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB16_8)
	SLT ADI R15, %lo(.LBB16_8)
	BRH NE, R15
; %bb.9:
	INT LOD R3, R6, 20
	INT STR R1, R6, 20
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB16_10)
	SLT ADI R15, %lo(.LBB16_10)
	BRH NE, R15
; %bb.11:
	INT LOD R3, R5, 24
	INT STR R1, R5, 24
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB16_12)
	SLT ADI R15, %lo(.LBB16_12)
	BRH NE, R15
; %bb.13:
	INT LOD R3, R6, 28
	INT STR R1, R6, 28
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB16_14)
	SLT ADI R15, %lo(.LBB16_14)
	BRH NE, R15
; %bb.15:
	INT LOD R3, R5, 32
	INT STR R1, R5, 32
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB16_16)
	SLT ADI R15, %lo(.LBB16_16)
	BRH NE, R15
; %bb.17:
	INT LOD R3, R6, 36
	INT STR R1, R6, 36
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB16_18)
	SLT ADI R15, %lo(.LBB16_18)
	BRH NE, R15
; %bb.19:
	INT LOD R3, R5, 40
	INT STR R1, R5, 40
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB16_20)
	SLT ADI R15, %lo(.LBB16_20)
	BRH NE, R15
; %bb.21:
	INT LOD R3, R6, 44
	INT STR R1, R6, 44
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB16_22)
	SLT ADI R15, %lo(.LBB16_22)
	BRH NE, R15
; %bb.23:
	INT LOD R3, R5, 48
	INT STR R1, R5, 48
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB16_24)
	SLT ADI R15, %lo(.LBB16_24)
	BRH NE, R15
; %bb.25:
	INT LOD R3, R6, 52
	INT STR R1, R6, 52
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB16_26)
	SLT ADI R15, %lo(.LBB16_26)
	BRH NE, R15
; %bb.27:
	INT LOD R3, R5, 56
	INT STR R1, R5, 56
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB16_28)
	SLT ADI R15, %lo(.LBB16_28)
	BRH NE, R15
; %bb.29:
	INT LOD R3, R6, 60
	INT STR R1, R6, 60
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB16_30)
	SLT ADI R15, %lo(.LBB16_30)
	BRH NE, R15
; %bb.31:
	INT LOD R3, R5, 64
	INT STR R1, R5, 64
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB16_32)
	SLT ADI R15, %lo(.LBB16_32)
	BRH NE, R15
; %bb.33:
	INT LOD R3, R6, 68
	INT STR R1, R6, 68
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB16_34)
	SLT ADI R15, %lo(.LBB16_34)
	BRH NE, R15
; %bb.35:
	INT LOD R3, R5, 72
	INT STR R1, R5, 72
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB16_36)
	SLT ADI R15, %lo(.LBB16_36)
	BRH NE, R15
; %bb.37:
	INT LOD R3, R6, 76
	INT STR R1, R6, 76
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB16_38)
	SLT ADI R15, %lo(.LBB16_38)
	BRH NE, R15
; %bb.39:
	INT LOD R3, R5, 80
	INT STR R1, R5, 80
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB16_40)
	SLT ADI R15, %lo(.LBB16_40)
	BRH NE, R15
; %bb.41:
	INT LOD R3, R6, 84
	INT STR R1, R6, 84
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB16_42)
	SLT ADI R15, %lo(.LBB16_42)
	BRH NE, R15
; %bb.43:
	INT LOD R3, R5, 88
	INT STR R1, R5, 88
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB16_44)
	SLT ADI R15, %lo(.LBB16_44)
	BRH NE, R15
; %bb.45:
	INT LOD R3, R6, 92
	INT STR R1, R6, 92
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB16_46)
	SLT ADI R15, %lo(.LBB16_46)
	BRH NE, R15
; %bb.47:
	INT LOD R3, R5, 96
	INT STR R1, R5, 96
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB16_48)
	SLT ADI R15, %lo(.LBB16_48)
	BRH NE, R15
; %bb.49:
	INT LOD R3, R6, 100
	INT STR R1, R6, 100
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB16_50)
	SLT ADI R15, %lo(.LBB16_50)
	BRH NE, R15
; %bb.51:
	INT LOD R3, R5, 104
	INT STR R1, R5, 104
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB16_52)
	SLT ADI R15, %lo(.LBB16_52)
	BRH NE, R15
; %bb.53:
	INT LOD R3, R6, 108
	INT STR R1, R6, 108
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB16_54)
	SLT ADI R15, %lo(.LBB16_54)
	BRH NE, R15
; %bb.55:
	INT LOD R3, R5, 112
	INT STR R1, R5, 112
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB16_56)
	SLT ADI R15, %lo(.LBB16_56)
	BRH NE, R15
; %bb.57:
	INT LOD R3, R6, 116
	INT STR R1, R6, 116
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB16_58)
	SLT ADI R15, %lo(.LBB16_58)
	BRH NE, R15
; %bb.59:
	INT LOD R3, R4, 120
	INT STR R1, R4, 120
	LDI R5, 0
	H LDI R5, 257
	SLT ADI R5, 256
	SUB R5, R4, R5
	NOR R5, R4, R4
	NOR R4, R4, R4
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB16_60)
	SLT ADI R15, %lo(.LBB16_60)
	BRH NE, R15
; %bb.63:
	LDI R4, 0
	INT STR R1, R4, 124
	SLT ADD R4, R0, R1
	ADI R3, 124
	INT STR R2, R3, 0
	H LDI R15, %hi(.LBB16_62)
	SLT ADI R15, %lo(.LBB16_62)
	JMP R15
.LBB16_2:
	ADI R1, 4
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_4:
	ADI R1, 8
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_6:
	ADI R1, 12
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_8:
	ADI R1, 16
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_10:
	ADI R1, 20
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_12:
	ADI R1, 24
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_14:
	ADI R1, 28
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_16:
	ADI R1, 32
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_18:
	ADI R1, 36
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_20:
	ADI R1, 40
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_22:
	ADI R1, 44
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_24:
	ADI R1, 48
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_26:
	ADI R1, 52
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_28:
	ADI R1, 56
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_30:
	ADI R1, 60
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_32:
	ADI R1, 64
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_34:
	ADI R1, 68
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_36:
	ADI R1, 72
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_38:
	ADI R1, 76
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_40:
	ADI R1, 80
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_42:
	ADI R1, 84
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_44:
	ADI R1, 88
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_46:
	ADI R1, 92
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_48:
	ADI R1, 96
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_50:
	ADI R1, 100
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_52:
	ADI R1, 104
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_54:
	ADI R1, 108
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_56:
	ADI R1, 112
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_58:
	ADI R1, 116
	H LDI R15, %hi(.LBB16_61)
	SLT ADI R15, %lo(.LBB16_61)
	JMP R15
.LBB16_60:
	ADI R1, 120
.LBB16_61:
	LDI R2, 0
	INT STR R1, R2, 4
	LDI R1, 1
.LBB16_62:
	SLT ADI R14, -4
	RET
.Lfunc_end16:
	.size	copy_to_bounce, .Lfunc_end16-copy_to_bounce
                                        ; -- End function
	.type	tty_execute_request,@function   ; -- Begin function tty_execute_request
tty_execute_request:                    ; @tty_execute_request
; %bb.0:
	SLT ADI R14, 4
	LDI R2, 0
	H LDI R2, current_display
	SLT ADI R2, current_display
	INT LOD R2, R2, 0
	INT LOD R2, R2, 4
	INT LOD R1, R3, 8
	SLT ADD R3, R0, R4
	ADI R4, -1
	LDI R5, 3
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB17_5)
	SLT ADI R15, %lo(.LBB17_5)
	BRH C, R15
; %bb.1:
	LDI R5, 2
	LSH R4, R5, R4
	LDI R5, 0
	H LDI R5, .LJTI17_0
	SLT ADI R5, .LJTI17_0
	ADD R5, R4, R4
	INT LOD R4, R4, 0
	JMP R4
.LBB17_2:
	INT LOD R1, R3, 12
	INT STR R2, R3, 8
	CHAR LOD R1, R1, 4
	INT STR R2, R1, 4
	LDI R3, 1
	H LDI R15, %hi(.LBB17_6)
	SLT ADI R15, %lo(.LBB17_6)
	JMP R15
.LBB17_3:
	INT LOD R1, R1, 12
	INT STR R2, R1, 8
	LDI R3, 2
	H LDI R15, %hi(.LBB17_6)
	SLT ADI R15, %lo(.LBB17_6)
	JMP R15
.LBB17_4:
	INT LOD R1, R1, 0
	INT STR R2, R1, 4
	LDI R3, 4
	H LDI R15, %hi(.LBB17_6)
	SLT ADI R15, %lo(.LBB17_6)
	JMP R15
.LBB17_5:
	LDI R3, 0
.LBB17_6:
	INT STR R2, R3, 0
	SLT ADI R14, -4
	RET
.Lfunc_end17:
	.size	tty_execute_request, .Lfunc_end17-tty_execute_request
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
	.type	.LJTI17_0,@object
.LJTI17_0:
	.long	.LBB17_2
	.long	.LBB17_3
	.long	.LBB17_6
	.long	.LBB17_4
	.size	.LJTI17_0, 16
                                        ; -- End function
	.text
	.globl	biosClear                       ; -- Begin function biosClear
	.type	biosClear,@function
biosClear:                              ; @biosClear
; %bb.0:
	SLT ADI R14, 4
	LDI R1, 0
	H LDI R1, current_display
	SLT ADI R1, current_display
	INT LOD R1, R1, 0
	INT LOD R1, R4, 0
	LDI R2, 3
	LDI R1, 0
	SLT ADD R1, R0, R3
	CAL R4
	SLT ADI R14, -4
	RET
.Lfunc_end18:
	.size	biosClear, .Lfunc_end18-biosClear
                                        ; -- End function
	.globl	biosWrite                       ; -- Begin function biosWrite
	.type	biosWrite,@function
biosWrite:                              ; @biosWrite
; %bb.0:
	SLT ADI R14, 4
	CHAR LOD R1, R4, 0
	LDI R3, 1
	LDI R5, 8
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB19_1)
	SLT ADI R15, %lo(.LBB19_1)
	BRH EQ, R15
; %bb.2:
	SLT ADD R3, R0, R4
	H LDI R15, %hi(.LBB19_3)
	SLT ADI R15, %lo(.LBB19_3)
	JMP R15
.LBB19_1:
	LDI R4, 2
.LBB19_3:
	CHAR LOD R1, R6, 1
	LDI R5, 0
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB19_5)
	SLT ADI R15, %lo(.LBB19_5)
	BRH EQ, R15
; %bb.4:
	LDI R4, 4
.LBB19_5:
	NOR R2, R6, R6
	NOR R6, R6, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB19_7)
	SLT ADI R15, %lo(.LBB19_7)
	BRH EQ, R15
; %bb.6:
	SLT ADD R5, R0, R3
.LBB19_7:
	ADD R2, R3, R3
	LDI R2, 0
	H LDI R2, current_display
	SLT ADI R2, current_display
	INT LOD R2, R2, 0
	INT LOD R2, R5, 0
	SLT ADD R4, R0, R2
	CAL R5
	SLT ADI R14, -4
	RET
.Lfunc_end19:
	.size	biosWrite, .Lfunc_end19-biosWrite
                                        ; -- End function
	.globl	fs_gpt_list                     ; -- Begin function fs_gpt_list
	.type	fs_gpt_list,@function
fs_gpt_list:                            ; @fs_gpt_list
; %bb.0:
	SLT ADI R14, 124
	INT STR R14, R8, -100
	INT STR R14, R9, -104
	INT STR R14, R10, -108
	INT STR R14, R11, -112
	INT STR R14, R12, -116
	INT STR R14, R13, -120
	SLT ADD R4, R0, R9
	INT STR R14, R3, -92
	INT STR R14, R2, -88
	SLT ADD R1, R0, R12
	ADD R14, R0, R8
	SLT ADI R8, -96
	LDI R10, 0
	INT STR R8, R10, 0
	INT STR R9, R10, 0
	LDI R1, 4
	LDI R13, 512
	SLT ADD R13, R0, R2
	SLT ADD R8, R0, R3
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	LDI R11, 0
	H LDI R11, 0
	SLT ADI R11, -2
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_93)
	SLT ADI R15, %lo(.LBB20_93)
	BRH NE, R15
; %bb.1:
	INT LOD R8, R4, 0
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB20_93)
	SLT ADI R15, %lo(.LBB20_93)
	BRH EQ, R15
; %bb.2:
	LDI R2, 1
	SLT ADD R12, R0, R1
	SLT ADD R2, R0, R3
	H LDI R15, %hi(nvm_read_sectors)
	SLT ADI R15, %lo(nvm_read_sectors)
	CAL R15
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_4)
	SLT ADI R15, %lo(.LBB20_4)
	BRH EQ, R15
.LBB20_3:
	LDI R11, 0
	H LDI R11, 0
	SLT ADI R11, -1
	H LDI R15, %hi(.LBB20_92)
	SLT ADI R15, %lo(.LBB20_92)
	JMP R15
.LBB20_4:
	INT LOD R8, R3, 0
	CHAR LOD R3, R1, 0
	LDI R2, 69
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB20_91)
	SLT ADI R15, %lo(.LBB20_91)
	BRH NE, R15
; %bb.5:
	CHAR LOD R3, R1, 1
	LDI R2, 70
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB20_91)
	SLT ADI R15, %lo(.LBB20_91)
	BRH NE, R15
; %bb.6:
	CHAR LOD R3, R1, 2
	LDI R2, 73
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB20_91)
	SLT ADI R15, %lo(.LBB20_91)
	BRH NE, R15
; %bb.7:
	CHAR LOD R3, R1, 3
	LDI R2, 32
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB20_91)
	SLT ADI R15, %lo(.LBB20_91)
	BRH NE, R15
; %bb.8:
	CHAR LOD R3, R1, 4
	LDI R2, 80
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB20_91)
	SLT ADI R15, %lo(.LBB20_91)
	BRH NE, R15
; %bb.9:
	CHAR LOD R3, R1, 5
	LDI R2, 65
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB20_91)
	SLT ADI R15, %lo(.LBB20_91)
	BRH NE, R15
; %bb.10:
	CHAR LOD R3, R1, 6
	LDI R2, 82
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB20_91)
	SLT ADI R15, %lo(.LBB20_91)
	BRH NE, R15
; %bb.11:
	CHAR LOD R3, R1, 7
	LDI R2, 84
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB20_91)
	SLT ADI R15, %lo(.LBB20_91)
	BRH NE, R15
; %bb.12:
	CHAR LOD R3, R1, 13
	LDI R4, 8
	LSH R1, R4, R1
	CHAR LOD R3, R2, 12
	NOR R1, R2, R1
	CHAR LOD R3, R2, 14
	LDI R5, 16
	LSH R2, R5, R2
	NOR R1, R1, R1
	NOR R1, R2, R1
	NOR R1, R1, R1
	SLT ADD R3, R0, R2
	ADI R2, 15
	CHAR LOD R2, R2, 0
	LDI R6, 24
	LSH R2, R6, R2
	NOR R1, R2, R1
	NOR R1, R1, R7
	LDI R11, 0
	H LDI R11, 0
	SLT ADI R11, -3
	SLT ADD R7, R0, R1
	ADI R1, -513
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -421
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB20_92)
	SLT ADI R15, %lo(.LBB20_92)
	BRH C, R15
; %bb.13:
	INT STR R14, R7, -84
	CHAR LOD R3, R1, 86
	LSH R1, R5, R5
	CHAR LOD R3, R1, 85
	LSH R1, R4, R4
	SLT ADD R3, R0, R1
	ADI R1, 87
	CHAR LOD R1, R1, 0
	LSH R1, R6, R7
	CHAR LOD R3, R6, 84
	NOR R4, R6, R1
	NOR R1, R1, R1
	NOR R1, R5, R1
	NOR R1, R1, R1
	NOR R1, R7, R1
	NOR R1, R1, R2
	LDI R1, 128
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB20_92)
	SLT ADI R15, %lo(.LBB20_92)
	BRH C, R15
; %bb.14:
	INT STR R14, R7, -20
	INT STR R14, R6, -40
	INT STR R14, R4, -48
	INT STR R14, R5, -64
	CHAR LOD R3, R1, 73
	INT STR R14, R1, -16
	CHAR LOD R3, R1, 72
	INT STR R14, R1, -12
	CHAR LOD R3, R1, 89
	INT STR R14, R1, -36
	CHAR LOD R3, R1, 88
	INT STR R14, R1, -32
	CHAR LOD R3, R1, 81
	INT STR R14, R1, -80
	CHAR LOD R3, R1, 80
	INT STR R14, R1, -76
	CHAR LOD R3, R1, 90
	INT STR R14, R1, -28
	CHAR LOD R3, R1, 74
	INT STR R14, R1, -8
	CHAR LOD R3, R1, 82
	INT STR R14, R1, -68
	SLT ADD R3, R0, R1
	ADI R1, 83
	CHAR LOD R1, R1, 0
	INT STR R14, R1, -72
	SLT ADD R3, R0, R1
	ADI R1, 75
	CHAR LOD R1, R1, 0
	INT STR R14, R1, -4
	SLT ADD R3, R0, R1
	ADI R1, 91
	CHAR LOD R1, R1, 0
	INT STR R14, R1, -24
	SLT ADD R13, R0, R1
	INT STR R14, R2, -60
	INT LOD R14, R2, -60
	SLT ADD R3, R0, R11
	H LDI R15, %hi(__udivsi3)
	SLT ADI R15, %lo(__udivsi3)
	CAL R15
	SLT ADD R1, R0, R2
	INT LOD R14, R1, -60
	INT STR R14, R2, -56
	MUL R2, R1, R1
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB20_91)
	SLT ADI R15, %lo(.LBB20_91)
	BRH NE, R15
; %bb.15:
	CHAR LOD R11, R1, 26
	LDI R5, 16
	LSH R1, R5, R1
	CHAR LOD R11, R2, 25
	LDI R3, 8
	LSH R2, R3, R2
	CHAR LOD R11, R3, 24
	NOR R2, R3, R2
	NOR R2, R2, R2
	NOR R2, R1, R1
	SLT ADD R11, R0, R2
	ADI R2, 27
	CHAR LOD R2, R2, 0
	LDI R3, 24
	LSH R2, R3, R2
	NOR R1, R1, R1
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB20_91)
	SLT ADI R15, %lo(.LBB20_91)
	BRH NE, R15
; %bb.16:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	SLT ADD R11, R0, R2
	SLT ADD R5, R0, R3
	H LDI R15, %hi(crc32Update)
	SLT ADI R15, %lo(crc32Update)
	CAL R15
	LDI R3, 4
	LDI R2, 0
	H LDI R2, fs_gpt_list.zero
	SLT ADI R2, fs_gpt_list.zero
	H LDI R15, %hi(crc32Update)
	SLT ADI R15, %lo(crc32Update)
	CAL R15
	INT LOD R14, R3, -84
	ADI R3, -20
	SLT ADD R11, R0, R2
	ADI R2, 20
	H LDI R15, %hi(crc32Update)
	SLT ADI R15, %lo(crc32Update)
	CAL R15
	CHAR LOD R11, R2, 18
	LDI R3, 16
	LSH R2, R3, R2
	CHAR LOD R11, R3, 17
	LDI R4, 8
	LSH R3, R4, R3
	CHAR LOD R11, R4, 16
	NOR R3, R4, R3
	NOR R3, R3, R3
	NOR R3, R2, R2
	SLT ADD R11, R0, R4
	ADI R11, 19
	CHAR LOD R11, R3, 0
	LDI R5, 24
	LSH R3, R5, R3
	NOR R2, R2, R2
	NOR R2, R3, R2
	NOR R2, R2, R2
	XOR R2, R1, R1
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB20_91)
	SLT ADI R15, %lo(.LBB20_91)
	BRH NE, R15
; %bb.17:
	LDI R1, 8
	INT LOD R14, R2, -80
	LSH R2, R1, R1
	INT LOD R14, R2, -76
	NOR R1, R2, R1
	LDI R2, 16
	INT LOD R14, R3, -68
	LSH R3, R2, R2
	NOR R1, R1, R1
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 24
	INT LOD R14, R3, -72
	LSH R3, R2, R2
	NOR R1, R2, R1
	NOR R1, R1, R2
	INT LOD R14, R1, -60
	INT STR R14, R2, -52
	MUL R2, R1, R1
	INT STR R14, R1, -44
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_88)
	SLT ADI R15, %lo(.LBB20_88)
	BRH EQ, R15
; %bb.18:
	LDI R1, 8
	INT LOD R14, R2, -16
	LSH R2, R1, R1
	INT LOD R14, R2, -12
	NOR R1, R2, R1
	LDI R2, 16
	INT LOD R14, R3, -8
	LSH R3, R2, R2
	NOR R1, R1, R1
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 24
	INT LOD R14, R3, -4
	LSH R3, R2, R2
	NOR R1, R2, R1
	NOR R1, R1, R2
	INT LOD R14, R1, -64
	INT LOD R14, R3, -20
	ADD R3, R1, R1
	INT LOD R14, R3, -48
	ADD R1, R3, R1
	INT LOD R14, R3, -40
	ADD R1, R3, R1
	INT STR R14, R1, -48
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	INT STR R14, R1, -76
	INT STR R14, R10, -84
	LDI R11, 1
	H LDI R15, %hi(.LBB20_20)
	SLT ADI R15, %lo(.LBB20_20)
	JMP R15
.LBB20_19:                              ;   in Loop: Header=BB20_20 Depth=1
	INT STR R14, R5, -84
	INT LOD R14, R1, -44
	INT LOD R14, R2, -64
	SUB R1, R2, R1
	INT LOD R14, R2, -40
	ADI R2, 1
	INT STR R14, R1, -44
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_89)
	SLT ADI R15, %lo(.LBB20_89)
	BRH EQ, R15
.LBB20_20:                              ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB20_25 Depth 2
                                        ;     Child Loop BB20_43 Depth 2
                                        ;       Child Loop BB20_81 Depth 3
	SLT ADD R12, R0, R1
	INT STR R14, R2, -40
	SLT ADD R11, R0, R3
	H LDI R15, %hi(nvm_read_sectors)
	SLT ADI R15, %lo(nvm_read_sectors)
	CAL R15
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_3)
	SLT ADI R15, %lo(.LBB20_3)
	BRH NE, R15
; %bb.21:                               ;   in Loop: Header=BB20_20 Depth=1
	INT LOD R14, R1, -44
	INT STR R14, R1, -64
	INT LOD R14, R3, -76
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB20_23)
	SLT ADI R15, %lo(.LBB20_23)
	BRH C, R15
; %bb.22:                               ;   in Loop: Header=BB20_20 Depth=1
	INT STR R14, R13, -64
.LBB20_23:                              ;   in Loop: Header=BB20_20 Depth=1
	INT LOD R8, R4, 0
	SLT ADD R10, R0, R2
	INT STR R14, R4, -68
	H LDI R15, %hi(.LBB20_25)
	SLT ADI R15, %lo(.LBB20_25)
	JMP R15
.LBB20_24:                              ;   in Loop: Header=BB20_25 Depth=2
	LDI R4, 0
	H LDI R4, 7607
	SLT ADI R4, 4196
	INT LOD R14, R5, -80
	AND R5, R4, R4
	LDI R5, 0
	H LDI R5, 15214
	SLT ADI R5, 8392
	INT LOD R14, R6, -72
	AND R6, R5, R6
	XOR R6, R4, R4
	LDI R6, 4
	RSH R1, R6, R1
	XOR R1, R4, R1
	LDI R6, 0
	H LDI R6, 30428
	SLT ADI R6, 16784
	INT LOD R14, R4, -76
	AND R4, R6, R4
	LDI R5, 0
	H LDI R5, 60857
	SLT ADI R5, -31968
	AND R3, R5, R3
	XOR R3, R4, R3
	XOR R3, R1, R1
	LDI R3, 2
	RSH R1, R3, R1
	AND R7, R5, R3
	AND R11, R6, R4
	XOR R3, R4, R3
	XOR R3, R1, R3
	ADI R2, 1
	LDI R11, 1
	INT LOD R14, R4, -68
	INT LOD R14, R5, -84
	INT LOD R14, R1, -64
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB20_40)
	SLT ADI R15, %lo(.LBB20_40)
	BRH EQ, R15
.LBB20_25:                              ;   Parent Loop BB20_20 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ADD R4, R2, R1
	CHAR LOD R1, R1, 0
	XOR R3, R1, R3
	LDI R1, 30
	LSH R3, R1, R7
	LDI R4, 31
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB20_27)
	SLT ADI R15, %lo(.LBB20_27)
	BRH EQ, R15
; %bb.26:                               ;   in Loop: Header=BB20_25 Depth=2
	RSH R7, R4, R1
	LSH R1, R11, R4
	SUB R1, R4, R7
	LDI R4, 31
.LBB20_27:                              ;   in Loop: Header=BB20_25 Depth=2
	LDI R1, 29
	LSH R3, R1, R1
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB20_29)
	SLT ADI R15, %lo(.LBB20_29)
	BRH EQ, R15
; %bb.28:                               ;   in Loop: Header=BB20_25 Depth=2
	RSH R1, R4, R1
	LSH R1, R11, R4
	SUB R1, R4, R1
	INT STR R14, R1, -80
	LDI R4, 31
	H LDI R15, %hi(.LBB20_30)
	SLT ADI R15, %lo(.LBB20_30)
	JMP R15
.LBB20_29:                              ;   in Loop: Header=BB20_25 Depth=2
	INT STR R14, R1, -80
.LBB20_30:                              ;   in Loop: Header=BB20_25 Depth=2
	LDI R1, 27
	LSH R3, R1, R1
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB20_32)
	SLT ADI R15, %lo(.LBB20_32)
	BRH EQ, R15
; %bb.31:                               ;   in Loop: Header=BB20_25 Depth=2
	RSH R1, R4, R1
	LSH R1, R11, R5
	SUB R1, R5, R1
.LBB20_32:                              ;   in Loop: Header=BB20_25 Depth=2
	INT STR R14, R1, -76
	LDI R1, 28
	LSH R3, R1, R1
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB20_34)
	SLT ADI R15, %lo(.LBB20_34)
	BRH EQ, R15
; %bb.33:                               ;   in Loop: Header=BB20_25 Depth=2
	RSH R1, R4, R1
	LSH R1, R11, R6
	SUB R1, R6, R1
.LBB20_34:                              ;   in Loop: Header=BB20_25 Depth=2
	INT STR R14, R1, -72
	SLT ADD R4, R0, R5
	AND R3, R11, R1
	SUB R10, R1, R1
	LDI R6, 0
	H LDI R6, 60857
	SLT ADI R6, -31968
	AND R1, R6, R1
	SLT ADD R11, R0, R4
	RSH R3, R4, R11
	XOR R1, R11, R11
	AND R7, R6, R1
	RSH R11, R4, R7
	XOR R7, R1, R1
	LDI R6, 26
	LSH R1, R6, R7
	SUB R5, R10, R0
	H LDI R15, %hi(.LBB20_35)
	SLT ADI R15, %lo(.LBB20_35)
	BRH EQ, R15
; %bb.37:                               ;   in Loop: Header=BB20_25 Depth=2
	RSH R7, R5, R7
	LSH R7, R4, R4
	SUB R7, R4, R7
	LSH R11, R6, R11
	SUB R5, R10, R0
	H LDI R15, %hi(.LBB20_38)
	SLT ADI R15, %lo(.LBB20_38)
	BRH NE, R15
.LBB20_36:                              ;   in Loop: Header=BB20_25 Depth=2
	LSH R3, R6, R3
	SUB R5, R10, R0
	H LDI R15, %hi(.LBB20_24)
	SLT ADI R15, %lo(.LBB20_24)
	BRH EQ, R15
	H LDI R15, %hi(.LBB20_39)
	SLT ADI R15, %lo(.LBB20_39)
	JMP R15
.LBB20_35:                              ;   in Loop: Header=BB20_25 Depth=2
	LSH R11, R6, R11
	SUB R5, R10, R0
	H LDI R15, %hi(.LBB20_36)
	SLT ADI R15, %lo(.LBB20_36)
	BRH EQ, R15
.LBB20_38:                              ;   in Loop: Header=BB20_25 Depth=2
	LDI R4, 31
	RSH R11, R4, R4
	LDI R11, 1
	LSH R4, R11, R11
	SUB R4, R11, R11
	LDI R5, 31
	LSH R3, R6, R3
	SUB R5, R10, R0
	H LDI R15, %hi(.LBB20_24)
	SLT ADI R15, %lo(.LBB20_24)
	BRH EQ, R15
.LBB20_39:                              ;   in Loop: Header=BB20_25 Depth=2
	RSH R3, R5, R3
	LDI R4, 1
	LSH R3, R4, R4
	SUB R3, R4, R3
	H LDI R15, %hi(.LBB20_24)
	SLT ADI R15, %lo(.LBB20_24)
	JMP R15
.LBB20_40:                              ;   in Loop: Header=BB20_20 Depth=1
	INT LOD R14, R1, -60
	INT STR R14, R3, -76
	SUB R13, R1, R0
	H LDI R15, %hi(.LBB20_19)
	SLT ADI R15, %lo(.LBB20_19)
	BRH C, R15
; %bb.41:                               ;   in Loop: Header=BB20_20 Depth=1
	INT LOD R14, R7, -92
	INT LOD R14, R1, -52
	SUB R5, R1, R0
	H LDI R15, %hi(.LBB20_19)
	SLT ADI R15, %lo(.LBB20_19)
	BRH NC, R15
; %bb.42:                               ; %.preheader
                                        ;   in Loop: Header=BB20_20 Depth=1
	SLT ADD R4, R0, R2
	ADI R2, 57
	SLT ADD R10, R0, R3
.LBB20_43:                              ;   Parent Loop BB20_20 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB20_81 Depth 3
	INT STR R14, R5, -84
	INT LOD R14, R1, -60
	MUL R3, R1, R1
	ADD R4, R1, R5
	CHAR LOD R5, R1, 0
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_59)
	SLT ADI R15, %lo(.LBB20_59)
	BRH NE, R15
; %bb.44:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_59)
	SLT ADI R15, %lo(.LBB20_59)
	BRH NE, R15
; %bb.45:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 2
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_59)
	SLT ADI R15, %lo(.LBB20_59)
	BRH NE, R15
; %bb.46:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 3
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_59)
	SLT ADI R15, %lo(.LBB20_59)
	BRH NE, R15
; %bb.47:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 4
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_59)
	SLT ADI R15, %lo(.LBB20_59)
	BRH NE, R15
; %bb.48:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 5
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_59)
	SLT ADI R15, %lo(.LBB20_59)
	BRH NE, R15
; %bb.49:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 6
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_59)
	SLT ADI R15, %lo(.LBB20_59)
	BRH NE, R15
; %bb.50:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 7
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_59)
	SLT ADI R15, %lo(.LBB20_59)
	BRH NE, R15
; %bb.51:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 8
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_59)
	SLT ADI R15, %lo(.LBB20_59)
	BRH NE, R15
; %bb.52:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 9
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_59)
	SLT ADI R15, %lo(.LBB20_59)
	BRH NE, R15
; %bb.53:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 10
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_59)
	SLT ADI R15, %lo(.LBB20_59)
	BRH NE, R15
; %bb.54:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 11
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_59)
	SLT ADI R15, %lo(.LBB20_59)
	BRH NE, R15
; %bb.55:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 12
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_59)
	SLT ADI R15, %lo(.LBB20_59)
	BRH NE, R15
; %bb.56:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 13
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_59)
	SLT ADI R15, %lo(.LBB20_59)
	BRH NE, R15
; %bb.57:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 14
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_59)
	SLT ADI R15, %lo(.LBB20_59)
	BRH NE, R15
; %bb.58:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 15
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_86)
	SLT ADI R15, %lo(.LBB20_86)
	BRH EQ, R15
.LBB20_59:                              ;   in Loop: Header=BB20_43 Depth=2
	INT LOD R9, R1, 0
	SUB R1, R7, R0
	H LDI R15, %hi(.LBB20_86)
	SLT ADI R15, %lo(.LBB20_86)
	BRH NC, R15
; %bb.60:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R4, 36
	CHAR LOD R5, R6, 37
	NOR R6, R4, R4
	NOR R4, R4, R4
	CHAR LOD R5, R6, 38
	NOR R4, R6, R4
	NOR R4, R4, R4
	CHAR LOD R5, R6, 39
	NOR R4, R6, R6
	INT LOD R14, R4, -68
	NOR R6, R6, R6
	SUB R6, R10, R0
	H LDI R15, %hi(.LBB20_86)
	SLT ADI R15, %lo(.LBB20_86)
	BRH NE, R15
; %bb.61:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R4, 44
	CHAR LOD R5, R6, 45
	NOR R6, R4, R4
	NOR R4, R4, R4
	CHAR LOD R5, R6, 46
	NOR R4, R6, R4
	NOR R4, R4, R4
	CHAR LOD R5, R6, 47
	NOR R4, R6, R6
	INT LOD R14, R4, -68
	NOR R6, R6, R6
	SUB R6, R10, R0
	H LDI R15, %hi(.LBB20_86)
	SLT ADI R15, %lo(.LBB20_86)
	BRH NE, R15
; %bb.62:                               ;   in Loop: Header=BB20_43 Depth=2
	INT STR R14, R2, -80
	CHAR LOD R5, R4, 33
	LDI R6, 8
	LSH R4, R6, R4
	CHAR LOD R5, R6, 32
	NOR R4, R6, R4
	CHAR LOD R5, R6, 34
	LDI R7, 16
	LSH R6, R7, R6
	NOR R4, R4, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	SLT ADD R5, R0, R6
	ADI R6, 35
	CHAR LOD R6, R6, 0
	LDI R11, 24
	LSH R6, R11, R6
	NOR R4, R6, R6
	LDI R4, 48
	MUL R1, R4, R1
	INT LOD R14, R4, -88
	ADD R4, R1, R2
	NOR R6, R6, R1
	INT STR R2, R1, 0
	CHAR LOD R5, R6, 42
	LSH R6, R7, R6
	CHAR LOD R5, R7, 41
	LDI R4, 8
	LSH R7, R4, R7
	CHAR LOD R5, R11, 40
	NOR R7, R11, R7
	NOR R7, R7, R7
	NOR R7, R6, R6
	SLT ADD R5, R0, R7
	ADI R7, 43
	CHAR LOD R7, R7, 0
	LDI R4, 24
	LSH R7, R4, R7
	NOR R6, R6, R6
	NOR R6, R7, R6
	NOR R6, R6, R6
	SUB R6, R1, R1
	ADI R1, 1
	SLT ADD R2, R0, R7
	INT STR R2, R1, 4
	CHAR LOD R5, R1, 0
	LDI R4, 116
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB20_78)
	SLT ADI R15, %lo(.LBB20_78)
	BRH NE, R15
; %bb.63:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 1
	LDI R4, 115
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB20_78)
	SLT ADI R15, %lo(.LBB20_78)
	BRH NE, R15
; %bb.64:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 2
	LDI R4, 117
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB20_78)
	SLT ADI R15, %lo(.LBB20_78)
	BRH NE, R15
; %bb.65:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 3
	LDI R4, 67
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB20_78)
	SLT ADI R15, %lo(.LBB20_78)
	BRH NE, R15
; %bb.66:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 4
	LDI R4, 109
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB20_78)
	SLT ADI R15, %lo(.LBB20_78)
	BRH NE, R15
; %bb.67:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 5
	LDI R4, 111
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB20_78)
	SLT ADI R15, %lo(.LBB20_78)
	BRH NE, R15
; %bb.68:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 6
	LDI R4, 83
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB20_78)
	SLT ADI R15, %lo(.LBB20_78)
	BRH NE, R15
; %bb.69:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 7
	LDI R6, 70
	SUB R1, R6, R0
	H LDI R15, %hi(.LBB20_78)
	SLT ADI R15, %lo(.LBB20_78)
	BRH NE, R15
; %bb.70:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 8
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_78)
	SLT ADI R15, %lo(.LBB20_78)
	BRH NE, R15
; %bb.71:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 9
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_78)
	SLT ADI R15, %lo(.LBB20_78)
	BRH NE, R15
; %bb.72:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 10
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_78)
	SLT ADI R15, %lo(.LBB20_78)
	BRH NE, R15
; %bb.73:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 11
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_78)
	SLT ADI R15, %lo(.LBB20_78)
	BRH NE, R15
; %bb.74:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 12
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_78)
	SLT ADI R15, %lo(.LBB20_78)
	BRH NE, R15
; %bb.75:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 13
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_78)
	SLT ADI R15, %lo(.LBB20_78)
	BRH NE, R15
; %bb.76:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R1, 14
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB20_78)
	SLT ADI R15, %lo(.LBB20_78)
	BRH NE, R15
; %bb.77:                               ;   in Loop: Header=BB20_43 Depth=2
	CHAR LOD R5, R5, 15
	LDI R6, 1
	SLT ADD R6, R0, R1
	SUB R5, R6, R0
	H LDI R15, %hi(.LBB20_79)
	SLT ADI R15, %lo(.LBB20_79)
	BRH EQ, R15
.LBB20_78:                              ;   in Loop: Header=BB20_43 Depth=2
	SLT ADD R10, R0, R1
.LBB20_79:                              ;   in Loop: Header=BB20_43 Depth=2
	LDI R11, 1
	AND R1, R11, R1
	SLT ADD R7, R0, R2
	CHAR STR R2, R1, 8
	ADI R2, 9
	INT LOD R14, R5, -80
	SLT ADD R10, R0, R1
	H LDI R15, %hi(.LBB20_81)
	SLT ADI R15, %lo(.LBB20_81)
	JMP R15
.LBB20_80:                              ;   in Loop: Header=BB20_81 Depth=3
	ADD R2, R1, R7
	CHAR STR R7, R6, 0
	ADI R5, 2
	ADI R1, 1
	LDI R4, 36
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB20_84)
	SLT ADI R15, %lo(.LBB20_84)
	BRH EQ, R15
.LBB20_81:                              ;   Parent Loop BB20_20 Depth=1
                                        ;     Parent Loop BB20_43 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	CHAR LOD R5, R6, 0
	LDI R7, 8
	LSH R6, R7, R7
	CHAR LOD R5, R6, -1
	NOR R7, R6, R7
	NOR R7, R7, R7
	LDI R4, 0
	H LDI R4, 1
	SLT ADI R4, -1
	AND R7, R4, R7
	SUB R7, R10, R0
	H LDI R15, %hi(.LBB20_85)
	SLT ADI R15, %lo(.LBB20_85)
	BRH EQ, R15
; %bb.82:                               ;   in Loop: Header=BB20_81 Depth=3
	LDI R4, 128
	SUB R7, R4, R0
	H LDI R15, %hi(.LBB20_80)
	SLT ADI R15, %lo(.LBB20_80)
	BRH C, R15
; %bb.83:                               ;   in Loop: Header=BB20_81 Depth=3
	LDI R6, 63
	H LDI R15, %hi(.LBB20_80)
	SLT ADI R15, %lo(.LBB20_80)
	JMP R15
.LBB20_84:                              ;   in Loop: Header=BB20_43 Depth=2
	LDI R1, 36
.LBB20_85:                              ;   in Loop: Header=BB20_43 Depth=2
	ADD R2, R1, R1
	CHAR STR R1, R10, 0
	INT LOD R9, R1, 0
	ADI R1, 1
	INT STR R9, R1, 0
	INT LOD R14, R7, -92
	INT LOD R14, R4, -68
	INT LOD R14, R2, -80
.LBB20_86:                              ;   in Loop: Header=BB20_43 Depth=2
	INT LOD R14, R5, -84
	ADI R5, 1
	ADI R3, 1
	INT LOD R14, R1, -56
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB20_19)
	SLT ADI R15, %lo(.LBB20_19)
	BRH NC, R15
; %bb.87:                               ;   in Loop: Header=BB20_43 Depth=2
	INT LOD R14, R1, -48
	ADD R2, R1, R2
	INT LOD R14, R1, -52
	SUB R5, R1, R0
	H LDI R15, %hi(.LBB20_43)
	SLT ADI R15, %lo(.LBB20_43)
	BRH C, R15
	H LDI R15, %hi(.LBB20_19)
	SLT ADI R15, %lo(.LBB20_19)
	JMP R15
.LBB20_88:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	INT STR R14, R1, -76
.LBB20_89:
	LDI R1, 8
	INT LOD R14, R2, -36
	LSH R2, R1, R1
	INT LOD R14, R2, -32
	NOR R1, R2, R1
	LDI R2, 16
	INT LOD R14, R3, -28
	LSH R3, R2, R2
	NOR R1, R1, R1
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 24
	INT LOD R14, R3, -24
	LSH R3, R2, R2
	NOR R1, R2, R1
	NOR R1, R1, R1
	INT LOD R14, R2, -76
	XOR R2, R1, R1
	LDI R11, 0
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB20_92)
	SLT ADI R15, %lo(.LBB20_92)
	BRH EQ, R15
; %bb.90:
	INT STR R9, R11, 0
.LBB20_91:
	LDI R11, 0
	H LDI R11, 0
	SLT ADI R11, -3
.LBB20_92:
	SLT ADD R8, R0, R1
	H LDI R15, %hi(freePool)
	SLT ADI R15, %lo(freePool)
	CAL R15
.LBB20_93:
	SLT ADD R11, R0, R1
	INT LOD R14, R13, -120
	INT LOD R14, R12, -116
	INT LOD R14, R11, -112
	INT LOD R14, R10, -108
	INT LOD R14, R9, -104
	INT LOD R14, R8, -100
	SLT ADI R14, -124
	RET
.Lfunc_end20:
	.size	fs_gpt_list, .Lfunc_end20-fs_gpt_list
                                        ; -- End function
	.type	crc32Update,@function           ; -- Begin function crc32Update
crc32Update:                            ; @crc32Update
; %bb.0:
	SLT ADI R14, 32
	INT STR R14, R8, -8
	INT STR R14, R9, -12
	INT STR R14, R10, -16
	INT STR R14, R11, -20
	INT STR R14, R12, -24
	INT STR R14, R13, -28
	LDI R4, 1
	LDI R5, 0
	LDI R8, 31
	LDI R13, 26
	H LDI R15, %hi(.LBB21_1)
	SLT ADI R15, %lo(.LBB21_1)
	JMP R15
.LBB21_15:                              ;   in Loop: Header=BB21_1 Depth=1
	SLT ADD R1, R0, R5
	RSH R9, R8, R6
	LSH R6, R4, R9
	SUB R6, R9, R9
.LBB21_16:                              ;   in Loop: Header=BB21_1 Depth=1
	LDI R4, 2
	RSH R10, R4, R6
	LDI R1, 0
	H LDI R1, 30428
	SLT ADI R1, 16784
	AND R9, R1, R9
	XOR R6, R9, R6
	LDI R10, 0
	H LDI R10, 60857
	SLT ADI R10, -31968
	AND R7, R10, R7
	XOR R7, R6, R6
	AND R13, R1, R7
	INT LOD R14, R9, -4
	AND R9, R1, R9
	RSH R6, R4, R6
	XOR R6, R9, R6
	AND R12, R10, R9
	AND R5, R10, R1
	XOR R1, R6, R1
	RSH R1, R4, R1
	XOR R1, R7, R1
	XOR R9, R1, R1
	ADI R2, 1
	ADI R3, -1
	LDI R13, 26
	LDI R4, 1
	SLT ADD R11, R0, R5
	SUB R3, R5, R0
	H LDI R15, %hi(.LBB21_17)
	SLT ADI R15, %lo(.LBB21_17)
	BRH EQ, R15
.LBB21_1:                               ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R7, 0
	XOR R1, R7, R9
	LDI R1, 30
	LSH R9, R1, R10
	SUB R8, R5, R0
	H LDI R15, %hi(.LBB21_3)
	SLT ADI R15, %lo(.LBB21_3)
	BRH EQ, R15
; %bb.2:                                ;   in Loop: Header=BB21_1 Depth=1
	RSH R10, R8, R1
	LSH R1, R4, R7
	SUB R1, R7, R10
.LBB21_3:                               ;   in Loop: Header=BB21_1 Depth=1
	LSH R9, R13, R1
	SUB R8, R5, R0
	H LDI R15, %hi(.LBB21_5)
	SLT ADI R15, %lo(.LBB21_5)
	BRH EQ, R15
; %bb.4:                                ;   in Loop: Header=BB21_1 Depth=1
	RSH R1, R8, R1
	LSH R1, R4, R7
	SUB R1, R7, R1
.LBB21_5:                               ;   in Loop: Header=BB21_1 Depth=1
	LDI R6, 27
	LSH R9, R6, R6
	SUB R8, R5, R0
	H LDI R15, %hi(.LBB21_7)
	SLT ADI R15, %lo(.LBB21_7)
	BRH EQ, R15
; %bb.6:                                ;   in Loop: Header=BB21_1 Depth=1
	RSH R6, R8, R7
	LSH R7, R4, R11
	SUB R7, R11, R6
.LBB21_7:                               ;   in Loop: Header=BB21_1 Depth=1
	INT STR R14, R6, -4
	AND R9, R4, R7
	SUB R5, R7, R7
	LDI R6, 0
	H LDI R6, 60857
	SLT ADI R6, -31968
	AND R7, R6, R7
	RSH R9, R4, R12
	XOR R7, R12, R7
	AND R10, R6, R10
	RSH R7, R4, R12
	XOR R10, R12, R10
	LSH R10, R13, R12
	SUB R8, R5, R0
	H LDI R15, %hi(.LBB21_9)
	SLT ADI R15, %lo(.LBB21_9)
	BRH EQ, R15
; %bb.8:                                ;   in Loop: Header=BB21_1 Depth=1
	RSH R12, R8, R12
	LSH R12, R4, R13
	SUB R12, R13, R12
	LDI R13, 26
.LBB21_9:                               ;   in Loop: Header=BB21_1 Depth=1
	LSH R7, R13, R13
	SUB R8, R5, R0
	H LDI R15, %hi(.LBB21_11)
	SLT ADI R15, %lo(.LBB21_11)
	BRH EQ, R15
; %bb.10:                               ;   in Loop: Header=BB21_1 Depth=1
	RSH R13, R8, R7
	LSH R7, R4, R13
	SUB R7, R13, R13
.LBB21_11:                              ;   in Loop: Header=BB21_1 Depth=1
	LDI R6, 28
	LSH R9, R6, R7
	SUB R8, R5, R0
	H LDI R15, %hi(.LBB21_13)
	SLT ADI R15, %lo(.LBB21_13)
	BRH EQ, R15
; %bb.12:                               ;   in Loop: Header=BB21_1 Depth=1
	RSH R7, R8, R7
	LSH R7, R4, R6
	SUB R7, R6, R7
.LBB21_13:                              ;   in Loop: Header=BB21_1 Depth=1
	LDI R6, 29
	LSH R9, R6, R9
	SLT ADD R5, R0, R11
	SUB R8, R5, R0
	H LDI R15, %hi(.LBB21_15)
	SLT ADI R15, %lo(.LBB21_15)
	BRH NE, R15
; %bb.14:                               ;   in Loop: Header=BB21_1 Depth=1
	SLT ADD R1, R0, R5
	H LDI R15, %hi(.LBB21_16)
	SLT ADI R15, %lo(.LBB21_16)
	JMP R15
.LBB21_17:
	INT LOD R14, R13, -28
	INT LOD R14, R12, -24
	INT LOD R14, R11, -20
	INT LOD R14, R10, -16
	INT LOD R14, R9, -12
	INT LOD R14, R8, -8
	SLT ADI R14, -32
	RET
.Lfunc_end21:
	.size	crc32Update, .Lfunc_end21-crc32Update
                                        ; -- End function
	.globl	fs_mount                        ; -- Begin function fs_mount
	.type	fs_mount,@function
fs_mount:                               ; @fs_mount
; %bb.0:
	SLT ADI R14, 68
	INT STR R14, R8, -44
	INT STR R14, R9, -48
	INT STR R14, R10, -52
	INT STR R14, R11, -56
	INT STR R14, R12, -60
	INT STR R14, R13, -64
	SLT ADD R3, R0, R11
	SLT ADD R1, R0, R12
	CHAR LOD R11, R1, 8
	LDI R10, 1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB22_28)
	SLT ADI R15, %lo(.LBB22_28)
	BRH NE, R15
; %bb.1:
	SLT ADD R2, R0, R13
	ADD R14, R0, R9
	SLT ADI R9, -40
	LDI R8, 0
	INT STR R9, R8, 0
	LDI R2, 4
	LDI R3, 2
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	SLT ADD R9, R0, R4
	H LDI R15, %hi(allocatePages)
	SLT ADI R15, %lo(allocatePages)
	CAL R15
	SLT ADD R1, R0, R2
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -2
	SUB R2, R8, R0
	H LDI R15, %hi(.LBB22_33)
	SLT ADI R15, %lo(.LBB22_33)
	BRH NE, R15
; %bb.2:
	INT LOD R9, R4, 0
	SUB R4, R8, R0
	H LDI R15, %hi(.LBB22_33)
	SLT ADI R15, %lo(.LBB22_33)
	BRH EQ, R15
; %bb.3:
	INT STR R14, R10, -32
	INT STR R12, R4, 72
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -1
	INT STR R12, R3, 76
	SLT ADD R13, R0, R1
	INT STR R12, R1, 0
	ADI R4, 4096
	INT STR R12, R4, 80
	SLT ADD R12, R0, R10
	INT LOD R11, R12, 0
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -1
	INT STR R14, R2, -36
	INT STR R10, R3, 84
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -8
	AND R12, R2, R13
	LDI R3, 8
	SLT ADD R13, R0, R2
	H LDI R15, %hi(nvm_read_sectors)
	SLT ADI R15, %lo(nvm_read_sectors)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB22_32)
	SLT ADI R15, %lo(.LBB22_32)
	BRH NE, R15
; %bb.4:
	INT STR R10, R13, 84
	INT LOD R10, R1, 80
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB22_31)
	SLT ADI R15, %lo(.LBB22_31)
	BRH EQ, R15
; %bb.5:
	LDI R2, 9
	LSH R12, R2, R2
	LDI R3, 3584
	AND R2, R3, R2
	ADD R1, R2, R1
	CHAR LOD R1, R2, 37
	LDI R8, 8
	LSH R2, R8, R2
	CHAR LOD R1, R3, 36
	NOR R2, R3, R2
	CHAR LOD R1, R3, 33
	INT STR R14, R3, -16
	CHAR LOD R1, R3, 32
	INT STR R14, R3, -12
	CHAR LOD R1, R3, 34
	INT STR R14, R3, -8
	LDI R7, 16
	CHAR LOD R1, R3, 38
	LSH R3, R7, R3
	NOR R2, R2, R2
	NOR R2, R3, R2
	NOR R2, R2, R2
	SLT ADD R1, R0, R3
	ADI R3, 39
	CHAR LOD R3, R3, 0
	LDI R13, 24
	LSH R3, R13, R3
	NOR R2, R3, R3
	SLT ADD R1, R0, R2
	ADI R2, 35
	CHAR LOD R2, R2, 0
	INT STR R14, R2, -4
	SLT ADD R1, R0, R4
	ADI R4, 15
	CHAR LOD R4, R5, 0
	CHAR LOD R1, R2, 14
	INT STR R14, R2, -20
	NOR R3, R3, R4
	SLT ADD R1, R0, R3
	ADI R3, 13
	CHAR LOD R3, R2, 0
	INT STR R14, R2, -24
	CHAR LOD R1, R2, 12
	INT STR R14, R2, -28
	INT STR R10, R4, 16
	CHAR LOD R1, R3, 42
	LSH R3, R7, R3
	CHAR LOD R1, R12, 41
	LSH R12, R8, R12
	CHAR LOD R1, R2, 40
	NOR R12, R2, R2
	NOR R2, R2, R2
	NOR R2, R3, R2
	SLT ADD R1, R0, R3
	ADI R3, 43
	CHAR LOD R3, R3, 0
	LSH R3, R13, R3
	NOR R2, R2, R2
	NOR R2, R3, R2
	NOR R2, R2, R3
	SLT ADD R10, R0, R6
	INT STR R10, R3, 20
	CHAR LOD R1, R2, 0
	LDI R12, 67
	SUB R2, R12, R0
	H LDI R15, %hi(.LBB22_29)
	SLT ADI R15, %lo(.LBB22_29)
	BRH NE, R15
; %bb.6:
	CHAR LOD R1, R2, 1
	LDI R12, 85
	SUB R2, R12, R0
	H LDI R15, %hi(.LBB22_29)
	SLT ADI R15, %lo(.LBB22_29)
	BRH NE, R15
; %bb.7:
	CHAR LOD R1, R2, 2
	LDI R10, 83
	SUB R2, R10, R0
	H LDI R15, %hi(.LBB22_29)
	SLT ADI R15, %lo(.LBB22_29)
	BRH NE, R15
; %bb.8:
	CHAR LOD R1, R2, 3
	LDI R12, 84
	SUB R2, R12, R0
	H LDI R15, %hi(.LBB22_29)
	SLT ADI R15, %lo(.LBB22_29)
	BRH NE, R15
; %bb.9:
	CHAR LOD R1, R2, 4
	LDI R12, 79
	SUB R2, R12, R0
	H LDI R15, %hi(.LBB22_29)
	SLT ADI R15, %lo(.LBB22_29)
	BRH NE, R15
; %bb.10:
	CHAR LOD R1, R2, 5
	LDI R12, 77
	SUB R2, R12, R0
	H LDI R15, %hi(.LBB22_29)
	SLT ADI R15, %lo(.LBB22_29)
	BRH NE, R15
; %bb.11:
	CHAR LOD R1, R2, 6
	LDI R12, 70
	SUB R2, R12, R0
	H LDI R15, %hi(.LBB22_29)
	SLT ADI R15, %lo(.LBB22_29)
	BRH NE, R15
; %bb.12:
	CHAR LOD R1, R2, 7
	SUB R2, R10, R0
	H LDI R15, %hi(.LBB22_29)
	SLT ADI R15, %lo(.LBB22_29)
	BRH NE, R15
; %bb.13:
	SLT ADD R1, R0, R2
	ADI R2, 9
	CHAR LOD R2, R2, 0
	LSH R2, R8, R2
	CHAR LOD R1, R12, 8
	NOR R2, R12, R2
	NOR R2, R2, R2
	LDI R10, 0
	H LDI R10, 1
	SLT ADI R10, -1
	AND R2, R10, R2
	SLT ADD R8, R0, R10
	LDI R8, 1
	SUB R2, R8, R0
	H LDI R15, %hi(.LBB22_29)
	SLT ADI R15, %lo(.LBB22_29)
	BRH NE, R15
; %bb.14:
	SLT ADD R1, R0, R2
	ADI R2, 11
	CHAR LOD R2, R2, 0
	LSH R2, R10, R2
	CHAR LOD R1, R12, 10
	NOR R2, R12, R2
	NOR R2, R2, R2
	LDI R8, 0
	H LDI R8, 1
	SLT ADI R8, -1
	AND R2, R8, R2
	LDI R12, 0
	H LDI R12, 0
	SLT ADI R12, -4
	INT STR R14, R12, -36
	LDI R8, 512
	SUB R2, R8, R0
	H LDI R15, %hi(.LBB22_30)
	SLT ADI R15, %lo(.LBB22_30)
	BRH NE, R15
; %bb.15:
	LDI R8, 0
	SLT ADD R6, R0, R10
	INT LOD R14, R2, -28
	SUB R2, R8, R0
	H LDI R15, %hi(.LBB22_32)
	SLT ADI R15, %lo(.LBB22_32)
	BRH EQ, R15
; %bb.16:
	INT LOD R14, R10, -28
	SLT ADD R10, R0, R2
	ADI R2, -1
	AND R2, R10, R2
	INT STR R14, R12, -36
	SUB R2, R8, R0
	H LDI R15, %hi(.LBB22_34)
	SLT ADI R15, %lo(.LBB22_34)
	BRH NE, R15
; %bb.17:
	INT LOD R14, R2, -24
	ADI R2, -3
	LDI R8, 255
	AND R2, R8, R2
	LDI R12, 254
	SUB R2, R12, R0
	H LDI R15, %hi(.LBB22_30)
	SLT ADI R15, %lo(.LBB22_30)
	BRH C, R15
; %bb.18:
	LDI R12, 8
	LSH R5, R12, R2
	INT LOD R14, R5, -20
	NOR R2, R5, R2
	NOR R2, R2, R5
	LDI R2, 0
	H LDI R2, 1
	SLT ADI R2, -1
	INT STR R14, R5, -20
	AND R5, R2, R2
	LDI R8, 0
	SLT ADD R6, R0, R10
	SUB R2, R8, R0
	H LDI R15, %hi(.LBB22_32)
	SLT ADI R15, %lo(.LBB22_32)
	BRH EQ, R15
; %bb.19:
	CHAR LOD R1, R2, 18
	LSH R2, R7, R2
	CHAR LOD R1, R5, 17
	LSH R5, R12, R5
	CHAR LOD R1, R12, 16
	NOR R5, R12, R5
	NOR R5, R5, R5
	NOR R5, R2, R2
	SLT ADD R1, R0, R5
	ADI R5, 19
	CHAR LOD R5, R5, 0
	LSH R5, R13, R5
	NOR R2, R2, R2
	NOR R2, R5, R2
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -4
	INT STR R14, R5, -36
	INT LOD R11, R11, 0
	NOR R2, R2, R5
	SUB R5, R11, R0
	H LDI R15, %hi(.LBB22_34)
	SLT ADI R15, %lo(.LBB22_34)
	BRH NE, R15
; %bb.20:
	SLT ADD R6, R0, R10
	LDI R2, 2
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB22_32)
	SLT ADI R15, %lo(.LBB22_32)
	BRH C, R15
; %bb.21:
	LDI R4, 0
	H LDI R4, 0
	SLT ADI R4, -4
	INT STR R14, R4, -36
	SUB R3, R8, R0
	H LDI R15, %hi(.LBB22_34)
	SLT ADI R15, %lo(.LBB22_34)
	BRH EQ, R15
; %bb.22:
	LDI R2, 8
	INT LOD R14, R4, -16
	LSH R4, R2, R2
	INT LOD R14, R4, -12
	NOR R2, R4, R2
	INT LOD R14, R4, -8
	LSH R4, R7, R4
	NOR R2, R2, R2
	NOR R2, R4, R2
	NOR R2, R2, R2
	INT LOD R14, R4, -4
	LSH R4, R13, R4
	NOR R2, R4, R2
	NOR R2, R2, R2
	LDI R4, 7
	LSH R2, R4, R4
	ADI R3, 2
	SLT ADD R6, R0, R10
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB22_32)
	SLT ADI R15, %lo(.LBB22_32)
	BRH C, R15
; %bb.23:
	LDI R3, 0
	H LDI R3, 1
	SLT ADI R3, -1
	INT LOD R14, R4, -20
	AND R4, R3, R3
	INT STR R10, R5, 4
	LDI R9, 0
	SLT ADD R9, R0, R4
	LDI R10, 1
	INT LOD R14, R12, -28
	LDI R13, 255
.LBB22_24:                              ; =>This Inner Loop Header: Depth=1
	SLT ADD R9, R0, R8
	AND R8, R13, R7
	ADI R9, 1
	LSH R10, R7, R11
	SUB R11, R12, R0
	H LDI R15, %hi(.LBB22_24)
	SLT ADI R15, %lo(.LBB22_24)
	BRH C, R15
; %bb.25:
	INT LOD R14, R9, -24
	AND R9, R13, R9
	LDI R10, 2
	SUB R9, R10, R0
	H LDI R15, %hi(.LBB22_27)
	SLT ADI R15, %lo(.LBB22_27)
	BRH EQ, R15
; %bb.26:
	INT STR R14, R4, -32
.LBB22_27:
	LDI R9, 512
	LSH R9, R7, R7
	CHAR STR R6, R8, 28
	ADI R8, 9
	CHAR STR R6, R8, 29
	INT STR R6, R7, 24
	ADI R7, -1
	INT STR R6, R7, 32
	INT LOD R14, R7, -32
	LSH R2, R7, R2
	ADD R5, R3, R3
	INT STR R6, R3, 8
	ADD R3, R2, R2
	INT STR R6, R2, 12
	SLT ADD R1, R0, R2
	ADI R2, 56
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 36
	SLT ADD R1, R0, R2
	ADI R2, 57
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 37
	SLT ADD R1, R0, R2
	ADI R2, 58
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 38
	SLT ADD R1, R0, R2
	ADI R2, 59
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 39
	SLT ADD R1, R0, R2
	ADI R2, 60
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 40
	SLT ADD R1, R0, R2
	ADI R2, 61
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 41
	SLT ADD R1, R0, R2
	ADI R2, 62
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 42
	SLT ADD R1, R0, R2
	ADI R2, 63
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 43
	SLT ADD R1, R0, R2
	ADI R2, 64
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 44
	SLT ADD R1, R0, R2
	ADI R2, 65
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 45
	SLT ADD R1, R0, R2
	ADI R2, 66
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 46
	SLT ADD R1, R0, R2
	ADI R2, 67
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 47
	SLT ADD R1, R0, R2
	ADI R2, 68
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 48
	SLT ADD R1, R0, R2
	ADI R2, 69
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 49
	SLT ADD R1, R0, R2
	ADI R2, 70
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 50
	SLT ADD R1, R0, R2
	ADI R2, 71
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 51
	SLT ADD R1, R0, R2
	ADI R2, 72
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 52
	SLT ADD R1, R0, R2
	ADI R2, 73
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 53
	SLT ADD R1, R0, R2
	ADI R2, 74
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 54
	SLT ADD R1, R0, R2
	ADI R2, 75
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 55
	SLT ADD R1, R0, R2
	ADI R2, 76
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 56
	SLT ADD R1, R0, R2
	ADI R2, 77
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 57
	SLT ADD R1, R0, R2
	ADI R2, 78
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 58
	SLT ADD R1, R0, R2
	ADI R2, 79
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 59
	SLT ADD R1, R0, R2
	ADI R2, 80
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 60
	SLT ADD R1, R0, R2
	ADI R2, 81
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 61
	SLT ADD R1, R0, R2
	ADI R2, 82
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 62
	SLT ADD R1, R0, R2
	ADI R2, 83
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 63
	SLT ADD R1, R0, R2
	ADI R2, 84
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 64
	SLT ADD R1, R0, R2
	ADI R2, 85
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 65
	SLT ADD R1, R0, R2
	ADI R2, 86
	CHAR LOD R2, R2, 0
	CHAR STR R6, R2, 66
	ADI R1, 87
	CHAR LOD R1, R1, 0
	CHAR STR R6, R1, 67
	SLT ADD R4, R0, R1
	CHAR STR R6, R1, 68
	H LDI R15, %hi(.LBB22_33)
	SLT ADI R15, %lo(.LBB22_33)
	JMP R15
.LBB22_28:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -4
	H LDI R15, %hi(.LBB22_33)
	SLT ADI R15, %lo(.LBB22_33)
	JMP R15
.LBB22_29:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -4
	INT STR R14, R1, -36
.LBB22_30:
	LDI R8, 0
	SLT ADD R6, R0, R10
	H LDI R15, %hi(.LBB22_32)
	SLT ADI R15, %lo(.LBB22_32)
	JMP R15
.LBB22_31:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	INT STR R14, R1, -36
	LDI R8, 0
.LBB22_32:
	LDI R1, 2
	SLT ADD R9, R0, R2
	H LDI R15, %hi(freePages)
	SLT ADI R15, %lo(freePages)
	CAL R15
	INT STR R10, R8, 72
	INT STR R10, R8, 80
	INT LOD R14, R1, -36
.LBB22_33:
	INT LOD R14, R13, -64
	INT LOD R14, R12, -60
	INT LOD R14, R11, -56
	INT LOD R14, R10, -52
	INT LOD R14, R9, -48
	INT LOD R14, R8, -44
	SLT ADI R14, -68
	RET
.LBB22_34:
	SLT ADD R6, R0, R10
	H LDI R15, %hi(.LBB22_32)
	SLT ADI R15, %lo(.LBB22_32)
	JMP R15
.Lfunc_end22:
	.size	fs_mount, .Lfunc_end22-fs_mount
                                        ; -- End function
	.globl	fs_mount_label                  ; -- Begin function fs_mount_label
	.type	fs_mount_label,@function
fs_mount_label:                         ; @fs_mount_label
; %bb.0:
	SLT ADI R14, 812
	INT STR R14, R8, -788
	INT STR R14, R9, -792
	INT STR R14, R10, -796
	INT STR R14, R11, -800
	INT STR R14, R12, -804
	INT STR R14, R13, -808
	SLT ADD R3, R0, R9
	SLT ADD R2, R0, R11
	SLT ADD R1, R0, R13
	ADD R14, R0, R12
	SLT ADD R12, R0, R8
	SLT ADI R8, -784
	SLT ADI R12, -16
	LDI R3, 16
	SLT ADD R11, R0, R1
	SLT ADD R8, R0, R2
	SLT ADD R12, R0, R4
	H LDI R15, %hi(fs_gpt_list)
	SLT ADI R15, %lo(fs_gpt_list)
	CAL R15
	LDI R10, 0
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB23_15)
	SLT ADI R15, %lo(.LBB23_15)
	BRH NE, R15
; %bb.1:
	INT STR R14, R9, -8
	INT STR R14, R13, -12
	INT LOD R12, R1, 0
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB23_14)
	SLT ADI R15, %lo(.LBB23_14)
	BRH EQ, R15
; %bb.2:                                ; %.preheader2
	INT STR R14, R11, -4
	SLT ADD R8, R0, R11
	ADI R11, 10
	LDI R6, 48
	LDI R9, 1
	LDI R7, 255
	SLT ADD R10, R0, R12
	INT LOD R14, R2, -12
	INT LOD R14, R5, -8
	H LDI R15, %hi(.LBB23_3)
	SLT ADI R15, %lo(.LBB23_3)
	JMP R15
.LBB23_5:                               ;   in Loop: Header=BB23_3 Depth=1
	SLT ADD R5, R0, R13
	SLT ADD R10, R0, R2
.LBB23_11:                              ;   in Loop: Header=BB23_3 Depth=1
	AND R2, R7, R2
	CHAR LOD R13, R4, 0
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB23_12)
	SLT ADI R15, %lo(.LBB23_12)
	BRH EQ, R15
.LBB23_13:                              ;   in Loop: Header=BB23_3 Depth=1
	ADI R11, 48
	ADI R12, 1
	SUB R12, R1, R0
	H LDI R15, %hi(.LBB23_14)
	SLT ADI R15, %lo(.LBB23_14)
	BRH EQ, R15
.LBB23_3:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB23_7 Depth 2
	MUL R12, R6, R2
	ADD R8, R2, R3
	CHAR LOD R3, R2, 8
	SUB R2, R9, R0
	H LDI R15, %hi(.LBB23_13)
	SLT ADI R15, %lo(.LBB23_13)
	BRH NE, R15
; %bb.4:                                ;   in Loop: Header=BB23_3 Depth=1
	CHAR LOD R3, R2, 9
	SUB R2, R10, R0
	H LDI R15, %hi(.LBB23_5)
	SLT ADI R15, %lo(.LBB23_5)
	BRH EQ, R15
; %bb.6:                                ; %.preheader
                                        ;   in Loop: Header=BB23_3 Depth=1
	SLT ADD R6, R0, R9
	SLT ADD R11, R0, R4
	SLT ADD R5, R0, R13
.LBB23_7:                               ;   Parent Loop BB23_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	AND R2, R7, R5
	CHAR LOD R13, R6, 0
	SUB R5, R6, R0
	H LDI R15, %hi(.LBB23_10)
	SLT ADI R15, %lo(.LBB23_10)
	BRH NE, R15
; %bb.8:                                ;   in Loop: Header=BB23_7 Depth=2
	ADI R13, 1
	CHAR LOD R4, R2, 0
	ADI R4, 1
	SUB R2, R10, R0
	H LDI R15, %hi(.LBB23_7)
	SLT ADI R15, %lo(.LBB23_7)
	BRH NE, R15
; %bb.9:                                ;   in Loop: Header=BB23_3 Depth=1
	SLT ADD R10, R0, R2
.LBB23_10:                              ;   in Loop: Header=BB23_3 Depth=1
	INT LOD R14, R4, -12
	INT LOD R14, R5, -8
	SLT ADD R9, R0, R6
	LDI R9, 1
	H LDI R15, %hi(.LBB23_11)
	SLT ADI R15, %lo(.LBB23_11)
	JMP R15
.LBB23_14:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -5
	H LDI R15, %hi(.LBB23_15)
	SLT ADI R15, %lo(.LBB23_15)
	JMP R15
.LBB23_12:
	INT LOD R14, R1, -12
	INT LOD R14, R2, -4
	H LDI R15, %hi(fs_mount)
	SLT ADI R15, %lo(fs_mount)
	CAL R15
.LBB23_15:
	INT LOD R14, R13, -808
	INT LOD R14, R12, -804
	INT LOD R14, R11, -800
	INT LOD R14, R10, -796
	INT LOD R14, R9, -792
	INT LOD R14, R8, -788
	SLT ADI R14, -812
	RET
.Lfunc_end23:
	.size	fs_mount_label, .Lfunc_end23-fs_mount_label
                                        ; -- End function
	.globl	fs_unmount                      ; -- Begin function fs_unmount
	.type	fs_unmount,@function
fs_unmount:                             ; @fs_unmount
; %bb.0:
	SLT ADI R14, 12
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	SLT ADD R1, R0, R8
	INT LOD R8, R1, 72
	LDI R9, 0
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB24_2)
	SLT ADI R15, %lo(.LBB24_2)
	BRH EQ, R15
; %bb.1:
	SLT ADD R8, R0, R2
	ADI R2, 72
	LDI R1, 2
	H LDI R15, %hi(freePages)
	SLT ADI R15, %lo(freePages)
	CAL R15
.LBB24_2:
	INT STR R8, R9, 72
	INT STR R8, R9, 80
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -12
	RET
.Lfunc_end24:
	.size	fs_unmount, .Lfunc_end24-fs_unmount
                                        ; -- End function
	.globl	fs_readdir                      ; -- Begin function fs_readdir
	.type	fs_readdir,@function
fs_readdir:                             ; @fs_readdir
; %bb.0:
	SLT ADI R14, 28
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	INT STR R14, R13, -24
	SLT ADD R2, R0, R9
	SLT ADD R1, R0, R10
	H LDI R15, %hi(dirNext)
	SLT ADI R15, %lo(dirNext)
	CAL R15
	SLT ADD R1, R0, R8
	LDI R1, 1
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB25_15)
	SLT ADI R15, %lo(.LBB25_15)
	BRH N, R15
; %bb.1:                                ; %.preheader3
	SLT ADD R9, R0, R11
	ADI R11, 1
	LDI R12, 0
	LDI R13, 255
	LDI R8, 1
.LBB25_2:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB25_5 Depth 2
                                        ;     Child Loop BB25_9 Depth 2
	CHAR LOD R9, R1, 0
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB25_3)
	SLT ADI R15, %lo(.LBB25_3)
	BRH EQ, R15
; %bb.4:                                ; %.preheader
                                        ;   in Loop: Header=BB25_2 Depth=1
	LDI R2, 0
	H LDI R2, .L.str.1.25
	SLT ADI R2, .L.str.1.25
	SLT ADD R11, R0, R3
	SLT ADD R1, R0, R4
.LBB25_5:                               ;   Parent Loop BB25_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	AND R4, R13, R4
	CHAR LOD R2, R5, 0
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB25_8)
	SLT ADI R15, %lo(.LBB25_8)
	BRH NE, R15
; %bb.6:                                ;   in Loop: Header=BB25_5 Depth=2
	ADI R2, 1
	CHAR LOD R3, R4, 0
	ADI R3, 1
	SUB R4, R12, R0
	H LDI R15, %hi(.LBB25_5)
	SLT ADI R15, %lo(.LBB25_5)
	BRH NE, R15
; %bb.7:                                ;   in Loop: Header=BB25_2 Depth=1
	CHAR LOD R2, R2, 0
	SUB R2, R12, R0
	H LDI R15, %hi(.LBB25_13)
	SLT ADI R15, %lo(.LBB25_13)
	BRH EQ, R15
.LBB25_8:                               ;   in Loop: Header=BB25_2 Depth=1
	LDI R2, 0
	H LDI R2, .L.str.2.26
	SLT ADI R2, .L.str.2.26
	SLT ADD R11, R0, R3
.LBB25_9:                               ;   Parent Loop BB25_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	AND R1, R13, R4
	CHAR LOD R2, R5, 0
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB25_12)
	SLT ADI R15, %lo(.LBB25_12)
	BRH NE, R15
; %bb.10:                               ;   in Loop: Header=BB25_9 Depth=2
	ADI R2, 1
	CHAR LOD R3, R1, 0
	ADI R3, 1
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB25_9)
	SLT ADI R15, %lo(.LBB25_9)
	BRH NE, R15
	H LDI R15, %hi(.LBB25_11)
	SLT ADI R15, %lo(.LBB25_11)
	JMP R15
.LBB25_3:                               ;   in Loop: Header=BB25_2 Depth=1
	LDI R2, 0
	H LDI R2, .L.str.2.26
	SLT ADI R2, .L.str.2.26
.LBB25_11:                              ;   in Loop: Header=BB25_2 Depth=1
	SLT ADD R12, R0, R1
.LBB25_12:                              ;   in Loop: Header=BB25_2 Depth=1
	AND R1, R13, R1
	CHAR LOD R2, R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB25_15)
	SLT ADI R15, %lo(.LBB25_15)
	BRH NE, R15
.LBB25_13:                              ;   in Loop: Header=BB25_2 Depth=1
	SLT ADD R10, R0, R1
	SLT ADD R9, R0, R2
	H LDI R15, %hi(dirNext)
	SLT ADI R15, %lo(dirNext)
	CAL R15
	SUB R12, R1, R0
	H LDI R15, %hi(.LBB25_2)
	SLT ADI R15, %lo(.LBB25_2)
	BRH N, R15
; %bb.14:
	SLT ADD R1, R0, R8
.LBB25_15:
	SLT ADD R8, R0, R1
	INT LOD R14, R13, -24
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -28
	RET
.Lfunc_end25:
	.size	fs_readdir, .Lfunc_end25-fs_readdir
                                        ; -- End function
	.type	dirNext,@function               ; -- Begin function dirNext
dirNext:                                ; @dirNext
; %bb.0:
	SLT ADI R14, 32
	INT STR R14, R8, -8
	INT STR R14, R9, -12
	INT STR R14, R10, -16
	INT STR R14, R11, -20
	INT STR R14, R12, -24
	INT STR R14, R13, -28
	SLT ADD R2, R0, R10
	SLT ADD R1, R0, R9
	INT LOD R9, R13, 0
	LDI R8, 0
	LDI R5, 9
	LDI R6, 0
	H LDI R6, 0
	SLT ADI R6, -8
	LDI R7, 229
	H LDI R15, %hi(.LBB26_3)
	SLT ADI R15, %lo(.LBB26_3)
	JMP R15
.LBB26_1:                               ;   in Loop: Header=BB26_3 Depth=1
	INT STR R9, R8, 8
	INT STR R9, R2, 4
	INT LOD R14, R3, -4
.LBB26_2:                               ;   in Loop: Header=BB26_3 Depth=1
	SUB R3, R7, R0
	H LDI R15, %hi(.LBB26_26)
	SLT ADI R15, %lo(.LBB26_26)
	BRH NE, R15
.LBB26_3:                               ; =>This Inner Loop Header: Depth=1
	INT LOD R9, R1, 4
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB26_35)
	SLT ADI R15, %lo(.LBB26_35)
	BRH EQ, R15
; %bb.4:                                ;   in Loop: Header=BB26_3 Depth=1
	INT LOD R9, R2, 8
	RSH R2, R5, R2
	ADI R1, -2
	CHAR LOD R13, R3, 28
	LSH R1, R3, R1
	INT LOD R13, R3, 12
	ADD R1, R3, R1
	ADD R1, R2, R11
	INT LOD R13, R4, 80
	AND R11, R6, R12
	INT LOD R13, R1, 84
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB26_7)
	SLT ADI R15, %lo(.LBB26_7)
	BRH EQ, R15
; %bb.5:                                ;   in Loop: Header=BB26_3 Depth=1
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	INT STR R13, R1, 84
	INT LOD R13, R1, 0
	SLT ADD R12, R0, R2
	LDI R3, 8
	H LDI R15, %hi(nvm_read_sectors)
	SLT ADI R15, %lo(nvm_read_sectors)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB26_28)
	SLT ADI R15, %lo(.LBB26_28)
	BRH NE, R15
; %bb.6:                                ;   in Loop: Header=BB26_3 Depth=1
	INT STR R13, R12, 84
	INT LOD R13, R4, 80
	LDI R5, 9
	LDI R6, 0
	H LDI R6, 0
	SLT ADI R6, -8
	LDI R7, 229
.LBB26_7:                               ;   in Loop: Header=BB26_3 Depth=1
	SUB R4, R8, R0
	H LDI R15, %hi(.LBB26_28)
	SLT ADI R15, %lo(.LBB26_28)
	BRH EQ, R15
; %bb.8:                                ;   in Loop: Header=BB26_3 Depth=1
	LSH R11, R5, R1
	LDI R2, 3584
	AND R1, R2, R1
	ADD R4, R1, R1
	INT LOD R9, R2, 8
	LDI R3, 511
	AND R2, R3, R3
	ADD R1, R3, R1
	CHAR LOD R1, R3, 0
	SUB R3, R8, R0
	H LDI R15, %hi(.LBB26_10)
	SLT ADI R15, %lo(.LBB26_10)
	BRH EQ, R15
; %bb.9:                                ;   in Loop: Header=BB26_3 Depth=1
	SUB R3, R7, R0
	H LDI R15, %hi(.LBB26_12)
	SLT ADI R15, %lo(.LBB26_12)
	BRH NE, R15
.LBB26_10:                              ;   in Loop: Header=BB26_3 Depth=1
	ADI R2, 64
	INT STR R9, R2, 8
	SUB R3, R8, R0
	H LDI R15, %hi(.LBB26_27)
	SLT ADI R15, %lo(.LBB26_27)
	BRH EQ, R15
; %bb.11:                               ;   in Loop: Header=BB26_3 Depth=1
	INT LOD R13, R1, 24
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB26_2)
	SLT ADI R15, %lo(.LBB26_2)
	BRH C, R15
	H LDI R15, %hi(.LBB26_13)
	SLT ADI R15, %lo(.LBB26_13)
	JMP R15
.LBB26_12:                              ;   in Loop: Header=BB26_3 Depth=1
	CHAR STR R10, R3, 0
	SLT ADD R1, R0, R2
	ADI R2, 1
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 1
	SLT ADD R1, R0, R2
	ADI R2, 2
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 2
	SLT ADD R1, R0, R2
	ADI R2, 3
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 3
	SLT ADD R1, R0, R2
	ADI R2, 4
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 4
	SLT ADD R1, R0, R2
	ADI R2, 5
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 5
	SLT ADD R1, R0, R2
	ADI R2, 6
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 6
	SLT ADD R1, R0, R2
	ADI R2, 7
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 7
	SLT ADD R1, R0, R2
	ADI R2, 8
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 8
	SLT ADD R1, R0, R2
	ADI R2, 9
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 9
	SLT ADD R1, R0, R2
	ADI R2, 10
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 10
	SLT ADD R1, R0, R2
	ADI R2, 11
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 11
	SLT ADD R1, R0, R2
	ADI R2, 12
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 12
	SLT ADD R1, R0, R2
	ADI R2, 13
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 13
	SLT ADD R1, R0, R2
	ADI R2, 14
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 14
	SLT ADD R1, R0, R2
	ADI R2, 15
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 15
	SLT ADD R1, R0, R2
	ADI R2, 16
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 16
	SLT ADD R1, R0, R2
	ADI R2, 17
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 17
	SLT ADD R1, R0, R2
	ADI R2, 18
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 18
	SLT ADD R1, R0, R2
	ADI R2, 19
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 19
	SLT ADD R1, R0, R2
	ADI R2, 20
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 20
	SLT ADD R1, R0, R2
	ADI R2, 21
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 21
	SLT ADD R1, R0, R2
	ADI R2, 22
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 22
	SLT ADD R1, R0, R2
	ADI R2, 23
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 23
	SLT ADD R1, R0, R2
	ADI R2, 24
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 24
	SLT ADD R1, R0, R2
	ADI R2, 25
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 25
	SLT ADD R1, R0, R2
	ADI R2, 26
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 26
	SLT ADD R1, R0, R2
	ADI R2, 27
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 27
	SLT ADD R1, R0, R2
	ADI R2, 28
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 28
	SLT ADD R1, R0, R2
	ADI R2, 29
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 29
	SLT ADD R1, R0, R2
	ADI R2, 30
	CHAR LOD R2, R2, 0
	CHAR STR R10, R8, 31
	CHAR STR R10, R2, 30
	SLT ADD R1, R0, R2
	ADI R2, 32
	CHAR LOD R2, R2, 0
	CHAR STR R10, R2, 32
	CHAR LOD R1, R2, 37
	LDI R4, 8
	LSH R2, R4, R2
	SLT ADD R3, R0, R6
	CHAR LOD R1, R3, 36
	NOR R2, R3, R2
	CHAR LOD R1, R3, 38
	LDI R11, 16
	LSH R3, R11, R3
	NOR R2, R2, R2
	NOR R2, R3, R2
	NOR R2, R2, R2
	SLT ADD R1, R0, R3
	ADI R3, 39
	CHAR LOD R3, R3, 0
	LDI R12, 24
	LSH R3, R12, R3
	NOR R2, R3, R2
	NOR R2, R2, R2
	INT STR R10, R2, 36
	CHAR LOD R1, R2, 41
	LSH R2, R4, R2
	CHAR LOD R1, R3, 40
	NOR R2, R3, R2
	CHAR LOD R1, R3, 42
	LSH R3, R11, R3
	NOR R2, R2, R2
	NOR R2, R3, R2
	NOR R2, R2, R2
	SLT ADD R1, R0, R3
	ADI R3, 43
	CHAR LOD R3, R3, 0
	LSH R3, R12, R3
	NOR R2, R3, R2
	NOR R2, R2, R2
	INT STR R10, R2, 40
	CHAR LOD R1, R2, 46
	LSH R2, R11, R2
	CHAR LOD R1, R3, 45
	LSH R3, R4, R3
	CHAR LOD R1, R4, 44
	NOR R3, R4, R3
	NOR R3, R3, R3
	NOR R3, R2, R2
	SLT ADD R6, R0, R3
	LDI R6, 0
	H LDI R6, 0
	SLT ADI R6, -8
	ADI R1, 47
	CHAR LOD R1, R1, 0
	LSH R1, R12, R1
	NOR R2, R2, R2
	NOR R2, R1, R1
	NOR R1, R1, R1
	INT STR R10, R1, 44
	INT LOD R9, R2, 8
	ADI R2, 64
	INT STR R9, R2, 8
	INT LOD R13, R1, 24
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB26_2)
	SLT ADI R15, %lo(.LBB26_2)
	BRH C, R15
.LBB26_13:                              ;   in Loop: Header=BB26_3 Depth=1
	INT LOD R9, R11, 4
	LDI R1, 2
	SUB R11, R1, R0
	H LDI R15, %hi(.LBB26_34)
	SLT ADI R15, %lo(.LBB26_34)
	BRH C, R15
; %bb.14:                               ;   in Loop: Header=BB26_3 Depth=1
	INT LOD R13, R1, 20
	ADI R1, 1
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB26_34)
	SLT ADI R15, %lo(.LBB26_34)
	BRH C, R15
; %bb.15:                               ;   in Loop: Header=BB26_3 Depth=1
	INT STR R14, R3, -4
	LDI R1, 7
	RSH R11, R1, R1
	LDI R2, 0
	H LDI R2, 512
	SLT ADI R2, -8
	AND R1, R2, R1
	INT LOD R13, R2, 8
	ADD R2, R1, R12
	INT LOD R13, R4, 72
	INT LOD R13, R1, 76
	SUB R12, R1, R0
	H LDI R15, %hi(.LBB26_18)
	SLT ADI R15, %lo(.LBB26_18)
	BRH EQ, R15
; %bb.16:                               ;   in Loop: Header=BB26_3 Depth=1
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	INT STR R13, R1, 76
	INT LOD R13, R1, 0
	SLT ADD R12, R0, R2
	LDI R3, 8
	H LDI R15, %hi(nvm_read_sectors)
	SLT ADI R15, %lo(nvm_read_sectors)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB26_34)
	SLT ADI R15, %lo(.LBB26_34)
	BRH NE, R15
; %bb.17:                               ;   in Loop: Header=BB26_3 Depth=1
	INT STR R13, R12, 76
	INT LOD R13, R4, 72
	LDI R5, 9
	LDI R6, 0
	H LDI R6, 0
	SLT ADI R6, -8
	LDI R7, 229
.LBB26_18:                              ;   in Loop: Header=BB26_3 Depth=1
	LDI R12, 2
	LSH R11, R12, R1
	LDI R2, 4092
	AND R1, R2, R1
	ADD R4, R1, R1
	CHAR LOD R1, R2, 1
	LDI R3, 8
	LSH R2, R3, R2
	CHAR LOD R1, R3, 0
	NOR R2, R3, R2
	CHAR LOD R1, R3, 2
	LDI R4, 16
	LSH R3, R4, R3
	NOR R2, R2, R2
	NOR R2, R3, R2
	ADI R1, 3
	CHAR LOD R1, R1, 0
	LDI R3, 24
	LSH R1, R3, R1
	NOR R2, R2, R2
	NOR R2, R1, R1
	NOR R1, R1, R1
	SUB R1, R6, R0
	H LDI R15, %hi(.LBB26_20)
	SLT ADI R15, %lo(.LBB26_20)
	BRH C, R15
; %bb.19:                               ;   in Loop: Header=BB26_3 Depth=1
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	INT LOD R13, R2, 20
	H LDI R15, %hi(.LBB26_22)
	SLT ADI R15, %lo(.LBB26_22)
	JMP R15
.LBB26_20:                              ;   in Loop: Header=BB26_3 Depth=1
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB26_34)
	SLT ADI R15, %lo(.LBB26_34)
	BRH C, R15
; %bb.21:                               ;   in Loop: Header=BB26_3 Depth=1
	INT LOD R13, R2, 20
	SLT ADD R2, R0, R3
	ADI R3, 1
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB26_34)
	SLT ADI R15, %lo(.LBB26_34)
	BRH C, R15
.LBB26_22:                              ;   in Loop: Header=BB26_3 Depth=1
	INT LOD R9, R3, 12
	ADI R3, 1
	INT STR R9, R3, 12
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB26_34)
	SLT ADI R15, %lo(.LBB26_34)
	BRH C, R15
; %bb.23:                               ;   in Loop: Header=BB26_3 Depth=1
	SLT ADD R8, R0, R2
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -1
	SUB R1, R3, R0
	H LDI R15, %hi(.LBB26_1)
	SLT ADI R15, %lo(.LBB26_1)
	BRH EQ, R15
; %bb.24:                               ;   in Loop: Header=BB26_3 Depth=1
	SLT ADD R1, R0, R2
	H LDI R15, %hi(.LBB26_1)
	SLT ADI R15, %lo(.LBB26_1)
	JMP R15
.LBB26_34:
	LDI R8, 0
	H LDI R8, 0
	SLT ADI R8, -8
	H LDI R15, %hi(.LBB26_35)
	SLT ADI R15, %lo(.LBB26_35)
	JMP R15
.LBB26_28:
	LDI R8, 0
	H LDI R8, 0
	SLT ADI R8, -1
	H LDI R15, %hi(.LBB26_35)
	SLT ADI R15, %lo(.LBB26_35)
	JMP R15
.LBB26_26:
	LDI R8, 1
	H LDI R15, %hi(.LBB26_35)
	SLT ADI R15, %lo(.LBB26_35)
	JMP R15
.LBB26_27:
	LDI R8, 0
	INT STR R9, R8, 4
.LBB26_35:
	SLT ADD R8, R0, R1
	INT LOD R14, R13, -28
	INT LOD R14, R12, -24
	INT LOD R14, R11, -20
	INT LOD R14, R10, -16
	INT LOD R14, R9, -12
	INT LOD R14, R8, -8
	SLT ADI R14, -32
	RET
.Lfunc_end26:
	.size	dirNext, .Lfunc_end26-dirNext
                                        ; -- End function
	.globl	fs_stat                         ; -- Begin function fs_stat
	.type	fs_stat,@function
fs_stat:                                ; @fs_stat
; %bb.0:
	SLT ADI R14, 340
	INT STR R14, R8, -316
	INT STR R14, R9, -320
	INT STR R14, R10, -324
	INT STR R14, R11, -328
	INT STR R14, R12, -332
	INT STR R14, R13, -336
	LDI R4, 47
	LDI R9, 2
	ADD R14, R0, R7
	INT LOD R1, R10, 16
	CHAR LOD R2, R6, 0
	LDI R12, 0
	LDI R8, 1
	SUB R6, R12, R0
	H LDI R15, %hi(.LBB27_132)
	SLT ADI R15, %lo(.LBB27_132)
	BRH EQ, R15
; %bb.1:
	INT STR R14, R1, -152
	SLT ADD R7, R0, R11
	SLT ADI R11, -279
	SLT ADD R11, R0, R1
	ADI R1, 31
	INT STR R14, R1, -72
	SLT ADD R11, R0, R1
	ADI R1, 30
	INT STR R14, R1, -68
	SLT ADD R11, R0, R1
	ADI R1, 29
	INT STR R14, R1, -64
	SLT ADD R11, R0, R1
	ADI R1, 28
	INT STR R14, R1, -60
	SLT ADD R11, R0, R1
	ADI R1, 27
	INT STR R14, R1, -56
	SLT ADD R11, R0, R1
	ADI R1, 26
	INT STR R14, R1, -52
	SLT ADD R11, R0, R1
	ADI R1, 25
	INT STR R14, R1, -48
	SLT ADD R11, R0, R1
	ADI R1, 24
	INT STR R14, R1, -44
	SLT ADD R11, R0, R1
	ADI R1, 23
	INT STR R14, R1, -40
	SLT ADD R11, R0, R1
	ADI R1, 22
	INT STR R14, R1, -36
	SLT ADD R11, R0, R1
	ADI R1, 21
	INT STR R14, R1, -32
	SLT ADD R11, R0, R1
	ADI R1, 20
	INT STR R14, R1, -28
	SLT ADD R11, R0, R1
	ADI R1, 19
	INT STR R14, R1, -24
	SLT ADD R11, R0, R1
	ADI R1, 18
	INT STR R14, R1, -20
	SLT ADD R11, R0, R1
	ADI R1, 17
	INT STR R14, R1, -16
	SLT ADD R11, R0, R1
	ADI R1, 16
	INT STR R14, R1, -12
	SLT ADD R11, R0, R1
	ADI R1, 15
	INT STR R14, R1, -8
	SLT ADD R11, R0, R1
	ADI R1, 14
	INT STR R14, R1, -76
	SLT ADD R11, R0, R1
	ADI R1, 13
	INT STR R14, R1, -80
	SLT ADD R11, R0, R1
	ADI R1, 12
	INT STR R14, R1, -84
	SLT ADD R11, R0, R1
	ADI R1, 11
	INT STR R14, R1, -88
	SLT ADD R11, R0, R1
	ADI R1, 10
	INT STR R14, R1, -92
	SLT ADD R11, R0, R1
	ADI R1, 9
	INT STR R14, R1, -96
	SLT ADD R11, R0, R1
	ADI R1, 8
	INT STR R14, R1, -100
	SLT ADD R11, R0, R1
	ADI R1, 7
	INT STR R14, R1, -104
	SLT ADD R11, R0, R1
	ADI R1, 6
	INT STR R14, R1, -108
	SLT ADD R11, R0, R1
	ADI R1, 5
	INT STR R14, R1, -112
	SLT ADD R11, R0, R1
	ADI R1, 4
	INT STR R14, R1, -116
	SLT ADD R11, R0, R1
	ADI R1, 3
	INT STR R14, R1, -120
	SLT ADD R11, R0, R1
	ADI R1, 2
	INT STR R14, R1, -124
	SLT ADD R11, R0, R1
	ADI R1, 1
	INT STR R14, R1, -160
	SLT ADD R7, R0, R13
	SLT ADI R13, -228
	NOR R13, R9, R1
	NOR R13, R8, R5
	INT STR R14, R13, -156
	ADI R13, 33
	INT STR R14, R13, -132
	NOR R5, R5, R5
	INT STR R14, R5, -180
	NOR R1, R1, R1
	INT STR R14, R1, -128
	LDI R13, 255
	SLT ADD R9, R0, R5
	LDI R9, 16
	INT STR R14, R4, -172
	SLT ADD R12, R0, R1
	INT STR R14, R5, -176
	INT STR R14, R12, -168
	SLT ADD R12, R0, R5
.LBB27_2:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB27_3 Depth 2
                                        ;     Child Loop BB27_11 Depth 2
                                        ;     Child Loop BB27_15 Depth 2
                                        ;     Child Loop BB27_29 Depth 2
                                        ;       Child Loop BB27_31 Depth 3
	INT STR R14, R5, -164
	SLT ADD R2, R0, R5
	AND R6, R13, R2
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB27_4)
	SLT ADI R15, %lo(.LBB27_4)
	BRH NE, R15
.LBB27_3:                               ;   Parent Loop BB27_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ADI R5, 1
	CHAR LOD R5, R6, 0
	AND R6, R13, R2
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB27_3)
	SLT ADI R15, %lo(.LBB27_3)
	BRH EQ, R15
.LBB27_4:                               ;   in Loop: Header=BB27_2 Depth=1
	SUB R2, R12, R0
	H LDI R15, %hi(.LBB27_131)
	SLT ADI R15, %lo(.LBB27_131)
	BRH EQ, R15
; %bb.5:                                ;   in Loop: Header=BB27_2 Depth=1
	CHAR LOD R5, R2, 0
	INT STR R14, R10, -144
	INT STR R14, R1, -140
	SUB R2, R12, R0
	H LDI R15, %hi(.LBB27_7)
	SLT ADI R15, %lo(.LBB27_7)
	BRH EQ, R15
; %bb.6:                                ;   in Loop: Header=BB27_2 Depth=1
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB27_35)
	SLT ADI R15, %lo(.LBB27_35)
	BRH NE, R15
.LBB27_7:                               ;   in Loop: Header=BB27_2 Depth=1
	SLT ADD R5, R0, R2
	SLT ADD R11, R0, R6
.LBB27_8:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R6, R12, 0
	INT LOD R14, R1, -176
	LDI R4, 2
	AND R1, R4, R5
	SUB R5, R12, R0
	H LDI R15, %hi(.LBB27_137)
	SLT ADI R15, %lo(.LBB27_137)
	BRH EQ, R15
; %bb.9:                                ;   in Loop: Header=BB27_2 Depth=1
	CHAR LOD R11, R10, 0
	INT STR R14, R7, -136
	INT STR R14, R10, -148
	SUB R10, R12, R0
	H LDI R15, %hi(.LBB27_19)
	SLT ADI R15, %lo(.LBB27_19)
	BRH EQ, R15
; %bb.10:                               ; %.preheader5
                                        ;   in Loop: Header=BB27_2 Depth=1
	LDI R5, 0
	H LDI R5, .L.str.1.25
	SLT ADI R5, .L.str.1.25
	INT LOD R14, R6, -160
	LDI R4, 47
	INT LOD R14, R1, -140
.LBB27_11:                              ;   Parent Loop BB27_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	AND R10, R13, R10
	CHAR LOD R5, R7, 0
	SUB R10, R7, R0
	H LDI R15, %hi(.LBB27_14)
	SLT ADI R15, %lo(.LBB27_14)
	BRH NE, R15
; %bb.12:                               ;   in Loop: Header=BB27_11 Depth=2
	ADI R5, 1
	CHAR LOD R6, R10, 0
	ADI R6, 1
	SUB R10, R12, R0
	H LDI R15, %hi(.LBB27_11)
	SLT ADI R15, %lo(.LBB27_11)
	BRH NE, R15
; %bb.13:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR LOD R5, R5, 0
	SUB R5, R12, R0
	H LDI R15, %hi(.LBB27_97)
	SLT ADI R15, %lo(.LBB27_97)
	BRH EQ, R15
.LBB27_14:                              ;   in Loop: Header=BB27_2 Depth=1
	LDI R5, 0
	H LDI R5, .L.str.2.26
	SLT ADI R5, .L.str.2.26
	INT LOD R14, R10, -160
	INT LOD R14, R6, -148
.LBB27_15:                              ;   Parent Loop BB27_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	AND R6, R13, R7
	CHAR LOD R5, R1, 0
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB27_18)
	SLT ADI R15, %lo(.LBB27_18)
	BRH NE, R15
; %bb.16:                               ;   in Loop: Header=BB27_15 Depth=2
	ADI R5, 1
	CHAR LOD R10, R6, 0
	ADI R10, 1
	SUB R6, R12, R0
	H LDI R15, %hi(.LBB27_15)
	SLT ADI R15, %lo(.LBB27_15)
	BRH NE, R15
; %bb.17:                               ;   in Loop: Header=BB27_2 Depth=1
	SLT ADD R12, R0, R6
.LBB27_18:                              ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R7, -136
	H LDI R15, %hi(.LBB27_20)
	SLT ADI R15, %lo(.LBB27_20)
	JMP R15
.LBB27_19:                              ;   in Loop: Header=BB27_2 Depth=1
	LDI R5, 0
	H LDI R5, .L.str.2.26
	SLT ADI R5, .L.str.2.26
	SLT ADD R12, R0, R6
.LBB27_20:                              ;   in Loop: Header=BB27_2 Depth=1
	AND R6, R13, R1
	CHAR LOD R5, R5, 0
	INT LOD R14, R10, -144
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB27_23)
	SLT ADI R15, %lo(.LBB27_23)
	BRH NE, R15
; %bb.21:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R1, -152
	INT LOD R1, R1, 16
	SUB R10, R1, R0
	H LDI R15, %hi(.LBB27_23)
	SLT ADI R15, %lo(.LBB27_23)
	BRH NE, R15
; %bb.22:                               ;   in Loop: Header=BB27_2 Depth=1
	LDI R4, 47
	INT LOD R14, R5, -164
	INT LOD R14, R1, -140
	H LDI R15, %hi(.LBB27_98)
	SLT ADI R15, %lo(.LBB27_98)
	JMP R15
.LBB27_23:                              ;   in Loop: Header=BB27_2 Depth=1
	LDI R1, 2
	SUB R10, R1, R0
	H LDI R15, %hi(.LBB27_139)
	SLT ADI R15, %lo(.LBB27_139)
	BRH C, R15
; %bb.24:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R4, -152
	INT LOD R4, R1, 20
	ADI R1, 1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB27_139)
	SLT ADI R15, %lo(.LBB27_139)
	BRH C, R15
; %bb.25:                               ;   in Loop: Header=BB27_2 Depth=1
	INT STR R14, R2, -164
	INT STR R14, R3, -4
	SLT ADD R10, R0, R1
	SLT ADD R7, R0, R10
	SLT ADI R10, -244
	INT STR R10, R12, 8
	INT STR R10, R1, 4
	INT STR R10, R4, 0
	LDI R9, 1
	INT STR R10, R9, 12
	SLT ADD R10, R0, R1
	INT LOD R14, R2, -156
	H LDI R15, %hi(dirNext)
	SLT ADI R15, %lo(dirNext)
	CAL R15
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB27_135)
	SLT ADI R15, %lo(.LBB27_135)
	BRH N, R15
; %bb.26:                               ; %.preheader1
                                        ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R8, -156
	INT LOD R14, R9, -148
	H LDI R15, %hi(.LBB27_29)
	SLT ADI R15, %lo(.LBB27_29)
	JMP R15
.LBB27_27:                              ;   in Loop: Header=BB27_29 Depth=2
	SUB R9, R12, R0
	H LDI R15, %hi(.LBB27_34)
	SLT ADI R15, %lo(.LBB27_34)
	BRH EQ, R15
.LBB27_28:                              ;   in Loop: Header=BB27_29 Depth=2
	SLT ADD R10, R0, R1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(dirNext)
	SLT ADI R15, %lo(dirNext)
	CAL R15
	SUB R12, R1, R0
	H LDI R15, %hi(.LBB27_135)
	SLT ADI R15, %lo(.LBB27_135)
	BRH NN, R15
.LBB27_29:                              ;   Parent Loop BB27_2 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB27_31 Depth 3
	CHAR LOD R8, R4, 0
	SUB R4, R12, R0
	H LDI R15, %hi(.LBB27_27)
	SLT ADI R15, %lo(.LBB27_27)
	BRH EQ, R15
; %bb.30:                               ; %.preheader
                                        ;   in Loop: Header=BB27_29 Depth=2
	INT LOD R14, R1, -180
	SLT ADD R4, R0, R3
	SLT ADD R11, R0, R2
.LBB27_31:                              ;   Parent Loop BB27_2 Depth=1
                                        ;     Parent Loop BB27_29 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	AND R3, R13, R3
	CHAR LOD R2, R5, 0
	SUB R3, R5, R0
	H LDI R15, %hi(.LBB27_28)
	SLT ADI R15, %lo(.LBB27_28)
	BRH NE, R15
; %bb.32:                               ;   in Loop: Header=BB27_31 Depth=3
	ADI R2, 1
	CHAR LOD R1, R3, 0
	ADI R1, 1
	SUB R3, R12, R0
	H LDI R15, %hi(.LBB27_31)
	SLT ADI R15, %lo(.LBB27_31)
	BRH NE, R15
; %bb.33:                               ;   in Loop: Header=BB27_29 Depth=2
	CHAR LOD R2, R1, 0
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB27_28)
	SLT ADI R15, %lo(.LBB27_28)
	BRH NE, R15
.LBB27_34:                              ;   in Loop: Header=BB27_2 Depth=1
	INT STR R14, R4, -172
	INT LOD R14, R9, -128
	SHORT LOD R9, R1, 14
	LDI R4, 16
	LSH R1, R4, R1
	SHORT LOD R9, R2, 12
	NOR R1, R2, R1
	SHORT LOD R9, R2, 10
	LSH R2, R4, R2
	SHORT LOD R9, R3, 8
	NOR R2, R3, R2
	SHORT LOD R9, R3, 6
	LSH R3, R4, R3
	SHORT LOD R9, R5, 4
	NOR R3, R5, R3
	SHORT LOD R9, R5, 2
	LSH R5, R4, R5
	SHORT LOD R9, R6, 0
	NOR R5, R6, R5
	SHORT LOD R9, R6, 22
	LSH R6, R4, R6
	SHORT LOD R9, R7, 20
	NOR R6, R7, R6
	INT STR R14, R6, -176
	SHORT LOD R9, R7, 18
	LSH R7, R4, R7
	SLT ADD R8, R0, R6
	SHORT LOD R9, R8, 16
	NOR R7, R8, R7
	INT STR R14, R7, -168
	SLT ADD R9, R0, R8
	ADI R8, 28
	SHORT LOD R8, R8, 0
	INT LOD R14, R7, -136
	SLT ADD R7, R0, R10
	SLT ADI R10, -312
	SHORT STR R10, R8, 28
	NOR R5, R5, R5
	INT STR R10, R5, 0
	NOR R3, R3, R3
	INT STR R10, R3, 4
	NOR R2, R2, R2
	INT STR R10, R2, 8
	NOR R1, R1, R1
	INT STR R10, R1, 12
	INT LOD R14, R1, -168
	NOR R1, R1, R1
	INT STR R10, R1, 16
	INT LOD R14, R1, -176
	NOR R1, R1, R1
	INT STR R10, R1, 20
	SHORT LOD R9, R1, 26
	LSH R1, R4, R1
	SHORT LOD R9, R2, 24
	SLT ADD R4, R0, R9
	NOR R1, R2, R1
	NOR R1, R1, R1
	INT STR R10, R1, 24
	INT LOD R14, R3, -132
	SLT ADD R3, R0, R1
	ADI R1, 1
	CHAR LOD R1, R1, 0
	LDI R2, 8
	LSH R1, R2, R1
	CHAR LOD R3, R2, 0
	NOR R1, R2, R1
	SLT ADD R3, R0, R2
	ADI R2, 2
	CHAR LOD R2, R2, 0
	SLT ADD R7, R0, R3
	SLT ADI R3, -282
	CHAR STR R3, R2, 2
	NOR R1, R1, R1
	SHORT STR R3, R1, 0
	SLT ADD R6, R0, R1
	ADI R1, 32
	CHAR LOD R1, R1, 0
	INT STR R14, R1, -176
	INT LOD R14, R1, -180
	CHAR LOD R1, R8, 0
	INT LOD R6, R5, 44
	INT LOD R6, R1, 40
	INT STR R14, R1, -168
	INT LOD R6, R10, 36
	INT LOD R14, R3, -4
	INT LOD R14, R2, -164
	LDI R4, 47
	SLT ADD R8, R0, R1
	H LDI R15, %hi(.LBB27_98)
	SLT ADI R15, %lo(.LBB27_98)
	JMP R15
.LBB27_35:                              ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R2, 0
	SLT ADD R5, R0, R2
	ADI R2, 1
	CHAR LOD R5, R8, 1
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_99)
	SLT ADI R15, %lo(.LBB27_99)
	BRH EQ, R15
; %bb.36:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -160
	SUB R8, R4, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.37:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 1
	SLT ADD R5, R0, R2
	ADI R2, 2
	CHAR LOD R5, R8, 2
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_100)
	SLT ADI R15, %lo(.LBB27_100)
	BRH EQ, R15
; %bb.38:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -124
	LDI R1, 47
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.39:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 2
	SLT ADD R5, R0, R2
	ADI R2, 3
	CHAR LOD R5, R8, 3
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_101)
	SLT ADI R15, %lo(.LBB27_101)
	BRH EQ, R15
; %bb.40:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -120
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.41:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 3
	SLT ADD R5, R0, R2
	ADI R2, 4
	CHAR LOD R5, R8, 4
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_102)
	SLT ADI R15, %lo(.LBB27_102)
	BRH EQ, R15
; %bb.42:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -116
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.43:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 4
	SLT ADD R5, R0, R2
	ADI R2, 5
	CHAR LOD R5, R8, 5
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_103)
	SLT ADI R15, %lo(.LBB27_103)
	BRH EQ, R15
; %bb.44:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -112
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.45:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 5
	SLT ADD R5, R0, R2
	ADI R2, 6
	CHAR LOD R5, R8, 6
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_104)
	SLT ADI R15, %lo(.LBB27_104)
	BRH EQ, R15
; %bb.46:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -108
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.47:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 6
	SLT ADD R5, R0, R2
	ADI R2, 7
	CHAR LOD R5, R8, 7
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_105)
	SLT ADI R15, %lo(.LBB27_105)
	BRH EQ, R15
; %bb.48:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -104
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.49:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 7
	SLT ADD R5, R0, R2
	ADI R2, 8
	CHAR LOD R5, R8, 8
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_106)
	SLT ADI R15, %lo(.LBB27_106)
	BRH EQ, R15
; %bb.50:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -100
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.51:                               ;   in Loop: Header=BB27_2 Depth=1
	SLT ADD R9, R0, R4
	SLT ADD R7, R0, R1
	INT STR R14, R3, -4
	CHAR STR R11, R8, 8
	SLT ADD R5, R0, R2
	ADI R2, 9
	CHAR LOD R5, R8, 9
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_107)
	SLT ADI R15, %lo(.LBB27_107)
	BRH EQ, R15
; %bb.52:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -96
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	LDI R10, 47
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.53:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 9
	SLT ADD R5, R0, R2
	ADI R2, 10
	CHAR LOD R5, R8, 10
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_108)
	SLT ADI R15, %lo(.LBB27_108)
	BRH EQ, R15
; %bb.54:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -92
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.55:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 10
	SLT ADD R5, R0, R2
	ADI R2, 11
	CHAR LOD R5, R8, 11
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_109)
	SLT ADI R15, %lo(.LBB27_109)
	BRH EQ, R15
; %bb.56:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -88
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.57:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 11
	SLT ADD R5, R0, R2
	ADI R2, 12
	CHAR LOD R5, R8, 12
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_110)
	SLT ADI R15, %lo(.LBB27_110)
	BRH EQ, R15
; %bb.58:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -84
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.59:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 12
	SLT ADD R5, R0, R2
	ADI R2, 13
	CHAR LOD R5, R8, 13
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_111)
	SLT ADI R15, %lo(.LBB27_111)
	BRH EQ, R15
; %bb.60:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -80
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.61:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 13
	SLT ADD R5, R0, R2
	ADI R2, 14
	CHAR LOD R5, R8, 14
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_112)
	SLT ADI R15, %lo(.LBB27_112)
	BRH EQ, R15
; %bb.62:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -76
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.63:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 14
	SLT ADD R5, R0, R2
	ADI R2, 15
	CHAR LOD R5, R8, 15
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_113)
	SLT ADI R15, %lo(.LBB27_113)
	BRH EQ, R15
; %bb.64:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -8
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.65:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 15
	SLT ADD R5, R0, R2
	ADI R2, 16
	CHAR LOD R5, R8, 16
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_114)
	SLT ADI R15, %lo(.LBB27_114)
	BRH EQ, R15
; %bb.66:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -12
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.67:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 16
	SLT ADD R5, R0, R2
	ADI R2, 17
	CHAR LOD R5, R8, 17
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_115)
	SLT ADI R15, %lo(.LBB27_115)
	BRH EQ, R15
; %bb.68:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -16
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.69:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 17
	SLT ADD R5, R0, R2
	ADI R2, 18
	CHAR LOD R5, R8, 18
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_116)
	SLT ADI R15, %lo(.LBB27_116)
	BRH EQ, R15
; %bb.70:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -20
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.71:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 18
	SLT ADD R5, R0, R2
	ADI R2, 19
	CHAR LOD R5, R8, 19
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_117)
	SLT ADI R15, %lo(.LBB27_117)
	BRH EQ, R15
; %bb.72:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -24
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.73:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 19
	SLT ADD R5, R0, R2
	ADI R2, 20
	CHAR LOD R5, R8, 20
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_118)
	SLT ADI R15, %lo(.LBB27_118)
	BRH EQ, R15
; %bb.74:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -28
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.75:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 20
	SLT ADD R5, R0, R2
	ADI R2, 21
	CHAR LOD R5, R8, 21
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_119)
	SLT ADI R15, %lo(.LBB27_119)
	BRH EQ, R15
; %bb.76:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -32
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.77:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 21
	SLT ADD R5, R0, R2
	ADI R2, 22
	CHAR LOD R5, R8, 22
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_120)
	SLT ADI R15, %lo(.LBB27_120)
	BRH EQ, R15
; %bb.78:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -36
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.79:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 22
	SLT ADD R5, R0, R2
	ADI R2, 23
	CHAR LOD R5, R8, 23
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_121)
	SLT ADI R15, %lo(.LBB27_121)
	BRH EQ, R15
; %bb.80:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -40
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.81:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 23
	SLT ADD R5, R0, R2
	ADI R2, 24
	CHAR LOD R5, R8, 24
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_122)
	SLT ADI R15, %lo(.LBB27_122)
	BRH EQ, R15
; %bb.82:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -44
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.83:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 24
	SLT ADD R5, R0, R2
	ADI R2, 25
	CHAR LOD R5, R8, 25
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_123)
	SLT ADI R15, %lo(.LBB27_123)
	BRH EQ, R15
; %bb.84:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -48
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.85:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 25
	SLT ADD R5, R0, R2
	ADI R2, 26
	CHAR LOD R5, R8, 26
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_124)
	SLT ADI R15, %lo(.LBB27_124)
	BRH EQ, R15
; %bb.86:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -52
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.87:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 26
	SLT ADD R5, R0, R2
	ADI R2, 27
	CHAR LOD R5, R8, 27
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_125)
	SLT ADI R15, %lo(.LBB27_125)
	BRH EQ, R15
; %bb.88:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -56
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.89:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 27
	SLT ADD R5, R0, R2
	ADI R2, 28
	CHAR LOD R5, R8, 28
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_126)
	SLT ADI R15, %lo(.LBB27_126)
	BRH EQ, R15
; %bb.90:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -60
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.91:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 28
	SLT ADD R5, R0, R2
	ADI R2, 29
	CHAR LOD R5, R8, 29
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_127)
	SLT ADI R15, %lo(.LBB27_127)
	BRH EQ, R15
; %bb.92:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -64
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.93:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 29
	SLT ADD R5, R0, R2
	ADI R2, 30
	CHAR LOD R5, R8, 30
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_128)
	SLT ADI R15, %lo(.LBB27_128)
	BRH EQ, R15
; %bb.94:                               ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -68
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
; %bb.95:                               ;   in Loop: Header=BB27_2 Depth=1
	CHAR STR R11, R8, 30
	CHAR LOD R5, R8, 31
	ADI R5, 31
	LDI R2, 47
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB27_129)
	SLT ADI R15, %lo(.LBB27_129)
	BRH EQ, R15
; %bb.96:                               ;   in Loop: Header=BB27_2 Depth=1
	SLT ADD R5, R0, R2
	INT LOD R14, R6, -72
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
	H LDI R15, %hi(.LBB27_140)
	SLT ADI R15, %lo(.LBB27_140)
	JMP R15
.LBB27_97:                              ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R7, -136
	INT LOD R14, R10, -144
	INT LOD R14, R5, -164
.LBB27_98:                              ;   in Loop: Header=BB27_2 Depth=1
	CHAR LOD R2, R6, 0
	LDI R8, 1
	SUB R6, R12, R0
	H LDI R15, %hi(.LBB27_2)
	SLT ADI R15, %lo(.LBB27_2)
	BRH NE, R15
	H LDI R15, %hi(.LBB27_133)
	SLT ADI R15, %lo(.LBB27_133)
	JMP R15
.LBB27_99:                              ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -160
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	JMP R15
.LBB27_100:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -124
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	JMP R15
.LBB27_101:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -120
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	JMP R15
.LBB27_102:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -116
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	JMP R15
.LBB27_103:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -112
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	JMP R15
.LBB27_104:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -108
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	JMP R15
.LBB27_105:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -104
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	JMP R15
.LBB27_106:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -100
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	JMP R15
.LBB27_107:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -96
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_108:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -92
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_109:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -88
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_110:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -84
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_111:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -80
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_112:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -76
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_113:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -8
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_114:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -12
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_115:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -16
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_116:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -20
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_117:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -24
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_118:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -28
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_119:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -32
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_120:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -36
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_121:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -40
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_122:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -44
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_123:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -48
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_124:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -52
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_125:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -56
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_126:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -60
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_127:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -64
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_128:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R6, -68
	H LDI R15, %hi(.LBB27_130)
	SLT ADI R15, %lo(.LBB27_130)
	JMP R15
.LBB27_129:                             ;   in Loop: Header=BB27_2 Depth=1
	SLT ADD R5, R0, R2
	INT LOD R14, R6, -72
.LBB27_130:                             ;   in Loop: Header=BB27_2 Depth=1
	INT LOD R14, R3, -4
	SLT ADD R1, R0, R7
	SLT ADD R4, R0, R9
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	JMP R15
.LBB27_131:                             ; %.loopexit7
	INT LOD R14, R5, -164
	H LDI R15, %hi(.LBB27_133)
	SLT ADI R15, %lo(.LBB27_133)
	JMP R15
.LBB27_132:
	SLT ADD R12, R0, R5
	INT STR R14, R12, -168
	INT STR R14, R9, -176
	SLT ADD R12, R0, R1
	INT STR R14, R4, -172
.LBB27_133:
	CHAR STR R3, R1, 1
	INT LOD R14, R1, -172
	CHAR STR R3, R1, 0
	SLT ADD R7, R0, R2
	SLT ADI R2, -312
	SHORT LOD R2, R1, 0
	SHORT STR R3, R1, 2
	SLT ADD R2, R0, R1
	ADI R1, 4
	SHORT LOD R1, R1, 0
	SHORT STR R3, R1, 6
	SLT ADD R2, R0, R1
	ADI R1, 6
	SHORT LOD R1, R1, 0
	SHORT STR R3, R1, 8
	SLT ADD R2, R0, R1
	ADI R1, 8
	SHORT LOD R1, R1, 0
	SHORT STR R3, R1, 10
	SLT ADD R2, R0, R1
	ADI R1, 10
	SHORT LOD R1, R1, 0
	SHORT STR R3, R1, 12
	SLT ADD R2, R0, R1
	ADI R1, 12
	SHORT LOD R1, R1, 0
	SHORT STR R3, R1, 14
	SLT ADD R2, R0, R1
	ADI R1, 14
	SHORT LOD R1, R1, 0
	SHORT STR R3, R1, 16
	SLT ADD R2, R0, R1
	ADI R1, 16
	SHORT LOD R1, R1, 0
	SHORT STR R3, R1, 18
	SLT ADD R2, R0, R1
	ADI R1, 18
	SHORT LOD R1, R1, 0
	SHORT STR R3, R1, 20
	SLT ADD R2, R0, R1
	ADI R1, 20
	SHORT LOD R1, R1, 0
	SHORT STR R3, R1, 22
	SLT ADD R2, R0, R1
	ADI R1, 22
	SHORT LOD R1, R1, 0
	SHORT STR R3, R1, 24
	SLT ADD R2, R0, R1
	ADI R1, 24
	SHORT LOD R1, R1, 0
	SHORT STR R3, R1, 26
	SLT ADD R2, R0, R1
	ADI R1, 26
	SHORT LOD R1, R1, 0
	SHORT STR R3, R1, 28
	LDI R1, 2
	NOR R2, R1, R1
	ADI R2, 28
	SHORT LOD R2, R2, 0
	SHORT STR R3, R2, 30
	NOR R1, R1, R1
	SHORT LOD R1, R1, 0
	SHORT STR R3, R1, 4
	INT LOD R14, R1, -176
	CHAR STR R3, R1, 32
	SLT ADI R7, -282
	CHAR LOD R7, R1, 0
	CHAR STR R3, R1, 33
	NOR R7, R8, R1
	NOR R1, R1, R1
	CHAR LOD R1, R1, 0
	CHAR STR R3, R1, 34
	ADI R7, 2
	CHAR LOD R7, R1, 0
	CHAR STR R3, R1, 35
	INT STR R3, R5, 44
	INT LOD R14, R1, -168
	INT STR R3, R1, 40
	INT STR R3, R10, 36
	LDI R1, 0
.LBB27_134:
	INT LOD R14, R13, -336
	INT LOD R14, R12, -332
	INT LOD R14, R11, -328
	INT LOD R14, R10, -324
	INT LOD R14, R9, -320
	INT LOD R14, R8, -316
	SLT ADI R14, -340
	RET
.LBB27_135:
	SLT ADD R1, R0, R2
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -5
	SUB R2, R12, R0
	H LDI R15, %hi(.LBB27_134)
	SLT ADI R15, %lo(.LBB27_134)
	BRH EQ, R15
; %bb.136:
	SLT ADD R2, R0, R1
	H LDI R15, %hi(.LBB27_134)
	SLT ADI R15, %lo(.LBB27_134)
	JMP R15
.LBB27_139:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -8
	H LDI R15, %hi(.LBB27_134)
	SLT ADI R15, %lo(.LBB27_134)
	JMP R15
.LBB27_137:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -6
	H LDI R15, %hi(.LBB27_134)
	SLT ADI R15, %lo(.LBB27_134)
	JMP R15
.LBB27_140:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -9
	H LDI R15, %hi(.LBB27_134)
	SLT ADI R15, %lo(.LBB27_134)
	JMP R15
.Lfunc_end27:
	.size	fs_stat, .Lfunc_end27-fs_stat
                                        ; -- End function
	.globl	fs_opendir                      ; -- Begin function fs_opendir
	.type	fs_opendir,@function
fs_opendir:                             ; @fs_opendir
; %bb.0:
	SLT ADI R14, 64
	INT STR R14, R8, -52
	INT STR R14, R9, -56
	INT STR R14, R10, -60
	SLT ADD R3, R0, R8
	SLT ADD R1, R0, R9
	ADD R14, R0, R10
	SLT ADI R10, -48
	SLT ADD R10, R0, R3
	H LDI R15, %hi(fs_stat)
	SLT ADI R15, %lo(fs_stat)
	CAL R15
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB28_8)
	SLT ADI R15, %lo(.LBB28_8)
	BRH NE, R15
; %bb.1:
	CHAR LOD R10, R1, 32
	LDI R3, 2
	AND R1, R3, R1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB28_3)
	SLT ADI R15, %lo(.LBB28_3)
	BRH NE, R15
; %bb.2:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -6
	H LDI R15, %hi(.LBB28_8)
	SLT ADI R15, %lo(.LBB28_8)
	JMP R15
.LBB28_3:
	INT LOD R10, R1, 36
	SUB R1, R3, R0
	H LDI R15, %hi(.LBB28_4)
	SLT ADI R15, %lo(.LBB28_4)
	BRH C, R15
; %bb.5:
	INT LOD R9, R3, 20
	ADI R3, 1
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB28_7)
	SLT ADI R15, %lo(.LBB28_7)
	BRH NC, R15
.LBB28_4:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -8
	H LDI R15, %hi(.LBB28_8)
	SLT ADI R15, %lo(.LBB28_8)
	JMP R15
.LBB28_7:
	LDI R3, 1
	INT STR R8, R3, 12
	INT STR R8, R1, 4
	INT STR R8, R9, 0
	INT STR R8, R2, 8
	SLT ADD R2, R0, R1
.LBB28_8:
	INT LOD R14, R10, -60
	INT LOD R14, R9, -56
	INT LOD R14, R8, -52
	SLT ADI R14, -64
	RET
.Lfunc_end28:
	.size	fs_opendir, .Lfunc_end28-fs_opendir
                                        ; -- End function
	.globl	fs_open                         ; -- Begin function fs_open
	.type	fs_open,@function
fs_open:                                ; @fs_open
; %bb.0:
	SLT ADI R14, 64
	INT STR R14, R8, -52
	INT STR R14, R9, -56
	INT STR R14, R10, -60
	SLT ADD R3, R0, R8
	SLT ADD R1, R0, R10
	ADD R14, R0, R9
	SLT ADI R9, -48
	SLT ADD R9, R0, R3
	H LDI R15, %hi(fs_stat)
	SLT ADI R15, %lo(fs_stat)
	CAL R15
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB29_4)
	SLT ADI R15, %lo(.LBB29_4)
	BRH NE, R15
; %bb.1:
	CHAR LOD R9, R1, 32
	LDI R3, 2
	AND R1, R3, R1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB29_2)
	SLT ADI R15, %lo(.LBB29_2)
	BRH NE, R15
; %bb.3:
	INT STR R8, R10, 0
	INT LOD R9, R1, 36
	INT STR R8, R1, 4
	INT LOD R9, R3, 40
	INT STR R8, R1, 16
	INT STR R8, R3, 8
	INT STR R8, R2, 20
	INT STR R8, R2, 12
	SLT ADD R2, R0, R1
	H LDI R15, %hi(.LBB29_4)
	SLT ADI R15, %lo(.LBB29_4)
	JMP R15
.LBB29_2:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -7
.LBB29_4:
	INT LOD R14, R10, -60
	INT LOD R14, R9, -56
	INT LOD R14, R8, -52
	SLT ADI R14, -64
	RET
.Lfunc_end29:
	.size	fs_open, .Lfunc_end29-fs_open
                                        ; -- End function
	.globl	fs_seek                         ; -- Begin function fs_seek
	.type	fs_seek,@function
fs_seek:                                ; @fs_seek
; %bb.0:
	SLT ADI R14, 4
	INT LOD R1, R3, 8
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB30_2)
	SLT ADI R15, %lo(.LBB30_2)
	BRH C, R15
; %bb.1:
	SLT ADD R3, R0, R2
.LBB30_2:
	INT STR R1, R2, 12
	LDI R1, 0
	SLT ADI R14, -4
	RET
.Lfunc_end30:
	.size	fs_seek, .Lfunc_end30-fs_seek
                                        ; -- End function
	.globl	fs_read                         ; -- Begin function fs_read
	.type	fs_read,@function
fs_read:                                ; @fs_read
; %bb.0:
	SLT ADI R14, 60
	INT STR R14, R8, -36
	INT STR R14, R9, -40
	INT STR R14, R10, -44
	INT STR R14, R11, -48
	INT STR R14, R12, -52
	INT STR R14, R13, -56
	SLT ADD R3, R0, R5
	INT STR R14, R2, -28
	SLT ADD R1, R0, R11
	INT LOD R11, R2, 12
	INT LOD R11, R1, 8
	SUB R1, R2, R3
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB31_2)
	SLT ADI R15, %lo(.LBB31_2)
	BRH C, R15
; %bb.1:
	SLT ADD R3, R0, R5
.LBB31_2:
	LDI R8, 0
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB31_5)
	SLT ADI R15, %lo(.LBB31_5)
	BRH NC, R15
; %bb.3:
	SLT ADD R8, R0, R1
	SUB R5, R8, R0
	H LDI R15, %hi(.LBB31_73)
	SLT ADI R15, %lo(.LBB31_73)
	BRH EQ, R15
; %bb.4:
	INT STR R14, R4, -4
	INT LOD R11, R6, 0
	LDI R7, 2
	SLT ADD R8, R0, R4
	INT STR R14, R11, -24
	H LDI R15, %hi(.LBB31_8)
	SLT ADI R15, %lo(.LBB31_8)
	JMP R15
.LBB31_5:
	SLT ADD R8, R0, R1
	H LDI R15, %hi(.LBB31_73)
	SLT ADI R15, %lo(.LBB31_73)
	JMP R15
.LBB31_6:                               ;   in Loop: Header=BB31_8 Depth=1
	SLT ADD R12, R0, R1
.LBB31_7:                               ;   in Loop: Header=BB31_8 Depth=1
	INT LOD R11, R2, 12
	ADD R2, R1, R2
	INT STR R11, R2, 12
	INT LOD R14, R4, -20
	ADD R1, R4, R4
	INT LOD R14, R3, -28
	ADD R3, R1, R3
	INT STR R14, R3, -28
	SUB R5, R1, R5
	SUB R5, R8, R0
	H LDI R15, %hi(.LBB31_75)
	SLT ADI R15, %lo(.LBB31_75)
	BRH EQ, R15
.LBB31_8:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB31_12 Depth 2
                                        ;     Child Loop BB31_40 Depth 2
                                        ;     Child Loop BB31_50 Depth 2
	INT STR R14, R4, -20
	INT LOD R11, R9, 0
	CHAR LOD R9, R1, 29
	RSH R2, R1, R10
	INT LOD R11, R12, 16
	SUB R12, R8, R0
	H LDI R15, %hi(.LBB31_10)
	SLT ADI R15, %lo(.LBB31_10)
	BRH EQ, R15
; %bb.9:                                ;   in Loop: Header=BB31_8 Depth=1
	INT LOD R11, R1, 20
	SUB R10, R1, R0
	H LDI R15, %hi(.LBB31_11)
	SLT ADI R15, %lo(.LBB31_11)
	BRH NC, R15
.LBB31_10:                              ;   in Loop: Header=BB31_8 Depth=1
	INT STR R11, R8, 20
	INT LOD R11, R12, 4
	INT STR R11, R12, 16
	SLT ADD R8, R0, R1
.LBB31_11:                              ;   in Loop: Header=BB31_8 Depth=1
	INT STR R14, R5, -32
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB31_23)
	SLT ADI R15, %lo(.LBB31_23)
	BRH NC, R15
.LBB31_12:                              ;   Parent Loop BB31_8 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	SUB R12, R7, R0
	H LDI R15, %hi(.LBB31_70)
	SLT ADI R15, %lo(.LBB31_70)
	BRH C, R15
; %bb.13:                               ;   in Loop: Header=BB31_12 Depth=2
	INT LOD R9, R1, 20
	ADI R1, 1
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB31_70)
	SLT ADI R15, %lo(.LBB31_70)
	BRH C, R15
; %bb.14:                               ;   in Loop: Header=BB31_12 Depth=2
	LDI R1, 7
	RSH R12, R1, R1
	LDI R2, 0
	H LDI R2, 512
	SLT ADI R2, -8
	AND R1, R2, R1
	INT LOD R9, R2, 8
	ADD R2, R1, R13
	INT LOD R9, R4, 72
	INT LOD R9, R1, 76
	SUB R13, R1, R0
	H LDI R15, %hi(.LBB31_17)
	SLT ADI R15, %lo(.LBB31_17)
	BRH EQ, R15
; %bb.15:                               ;   in Loop: Header=BB31_12 Depth=2
	SLT ADD R6, R0, R11
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	INT STR R9, R1, 76
	INT LOD R9, R1, 0
	SLT ADD R13, R0, R2
	LDI R3, 8
	H LDI R15, %hi(nvm_read_sectors)
	SLT ADI R15, %lo(nvm_read_sectors)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB31_70)
	SLT ADI R15, %lo(.LBB31_70)
	BRH NE, R15
; %bb.16:                               ;   in Loop: Header=BB31_12 Depth=2
	INT STR R9, R13, 76
	INT LOD R9, R4, 72
	INT LOD R14, R5, -32
	SLT ADD R11, R0, R6
	INT LOD R14, R11, -24
	LDI R7, 2
.LBB31_17:                              ;   in Loop: Header=BB31_12 Depth=2
	LSH R12, R7, R1
	LDI R2, 4092
	AND R1, R2, R1
	ADD R4, R1, R1
	CHAR LOD R1, R2, 1
	LDI R3, 8
	LSH R2, R3, R2
	CHAR LOD R1, R3, 0
	NOR R2, R3, R2
	CHAR LOD R1, R3, 2
	LDI R4, 16
	LSH R3, R4, R3
	NOR R2, R2, R2
	NOR R2, R3, R2
	ADI R1, 3
	CHAR LOD R1, R1, 0
	LDI R3, 24
	LSH R1, R3, R1
	NOR R2, R2, R2
	NOR R2, R1, R1
	NOR R1, R1, R12
	SLT ADD R12, R0, R1
	ADI R1, -2
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -11
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB31_70)
	SLT ADI R15, %lo(.LBB31_70)
	BRH C, R15
; %bb.18:                               ;   in Loop: Header=BB31_12 Depth=2
	INT LOD R9, R2, 20
	ADI R2, 1
	SLT ADD R8, R0, R1
	SUB R2, R12, R0
	H LDI R15, %hi(.LBB31_20)
	SLT ADI R15, %lo(.LBB31_20)
	BRH C, R15
; %bb.19:                               ;   in Loop: Header=BB31_12 Depth=2
	SLT ADD R12, R0, R1
.LBB31_20:                              ;   in Loop: Header=BB31_12 Depth=2
	SLT ADD R1, R0, R2
	ADI R2, -1
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -3
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB31_70)
	SLT ADI R15, %lo(.LBB31_70)
	BRH C, R15
; %bb.21:                               ;   in Loop: Header=BB31_12 Depth=2
	INT STR R11, R1, 16
	INT LOD R11, R1, 20
	ADI R1, 1
	INT STR R11, R1, 20
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB31_12)
	SLT ADI R15, %lo(.LBB31_12)
	BRH C, R15
; %bb.22:                               ;   in Loop: Header=BB31_8 Depth=1
	INT LOD R11, R2, 12
.LBB31_23:                              ;   in Loop: Header=BB31_8 Depth=1
	INT LOD R6, R1, 32
	AND R1, R2, R10
	SUB R10, R8, R0
	H LDI R15, %hi(.LBB31_42)
	SLT ADI R15, %lo(.LBB31_42)
	BRH EQ, R15
; %bb.24:                               ;   in Loop: Header=BB31_8 Depth=1
	INT LOD R6, R9, 24
	SLT ADD R6, R0, R1
	ADI R1, 28
	CHAR LOD R1, R1, 0
.LBB31_25:                              ;   in Loop: Header=BB31_8 Depth=1
	LDI R2, 255
	AND R1, R2, R1
	ADI R12, -2
	LSH R12, R1, R1
	LDI R2, 9
	SLT ADD R2, R0, R4
	RSH R10, R4, R2
	INT LOD R6, R3, 12
	ADD R3, R2, R2
	ADD R2, R1, R1
	LSH R1, R4, R2
	LDI R3, 3584
	AND R2, R3, R3
	INT STR R14, R9, -16
	SUB R9, R10, R9
	LDI R2, 511
	AND R10, R2, R2
	INT STR R14, R3, -12
	INT STR R14, R2, -8
	NOR R2, R3, R2
	NOR R2, R2, R2
	LDI R3, 4096
	SUB R3, R2, R12
	SUB R12, R9, R0
	H LDI R15, %hi(.LBB31_27)
	SLT ADI R15, %lo(.LBB31_27)
	BRH C, R15
; %bb.26:                               ;   in Loop: Header=BB31_8 Depth=1
	SLT ADD R9, R0, R12
.LBB31_27:                              ;   in Loop: Header=BB31_8 Depth=1
	SUB R12, R5, R0
	H LDI R15, %hi(.LBB31_29)
	SLT ADI R15, %lo(.LBB31_29)
	BRH C, R15
; %bb.28:                               ;   in Loop: Header=BB31_8 Depth=1
	SLT ADD R5, R0, R12
.LBB31_29:                              ;   in Loop: Header=BB31_8 Depth=1
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -8
	AND R1, R2, R13
	INT LOD R6, R4, 80
	INT LOD R6, R1, 84
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB31_32)
	SLT ADI R15, %lo(.LBB31_32)
	BRH EQ, R15
; %bb.30:                               ;   in Loop: Header=BB31_8 Depth=1
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	INT STR R6, R1, 84
	INT LOD R6, R1, 0
	SLT ADD R13, R0, R2
	LDI R3, 8
	SLT ADD R6, R0, R11
	H LDI R15, %hi(nvm_read_sectors)
	SLT ADI R15, %lo(nvm_read_sectors)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB31_76)
	SLT ADI R15, %lo(.LBB31_76)
	BRH NE, R15
; %bb.31:                               ;   in Loop: Header=BB31_8 Depth=1
	INT STR R11, R13, 84
	INT LOD R11, R4, 80
	INT LOD R14, R5, -32
	SLT ADD R11, R0, R6
	INT LOD R14, R11, -24
	LDI R7, 2
.LBB31_32:                              ;   in Loop: Header=BB31_8 Depth=1
	SUB R4, R8, R0
	H LDI R15, %hi(.LBB31_74)
	SLT ADI R15, %lo(.LBB31_74)
	BRH EQ, R15
; %bb.33:                               ;   in Loop: Header=BB31_8 Depth=1
	SLT ADD R8, R0, R1
	INT LOD R14, R2, -16
	SUB R2, R10, R0
	H LDI R15, %hi(.LBB31_7)
	SLT ADI R15, %lo(.LBB31_7)
	BRH EQ, R15
; %bb.34:                               ;   in Loop: Header=BB31_8 Depth=1
	INT LOD R14, R1, -12
	INT LOD R14, R2, -8
	ADD R2, R1, R1
	LDI R2, 4096
	SUB R2, R1, R1
	SLT ADD R5, R0, R2
	SUB R5, R1, R0
	H LDI R15, %hi(.LBB31_36)
	SLT ADI R15, %lo(.LBB31_36)
	BRH C, R15
; %bb.35:                               ;   in Loop: Header=BB31_8 Depth=1
	SLT ADD R1, R0, R2
.LBB31_36:                              ;   in Loop: Header=BB31_8 Depth=1
	LDI R10, 1
	SUB R2, R9, R0
	H LDI R15, %hi(.LBB31_38)
	SLT ADI R15, %lo(.LBB31_38)
	BRH C, R15
; %bb.37:                               ;   in Loop: Header=BB31_8 Depth=1
	SLT ADD R9, R0, R2
.LBB31_38:                              ;   in Loop: Header=BB31_8 Depth=1
	INT LOD R14, R1, -12
	ADD R4, R1, R1
	INT LOD R14, R3, -8
	ADD R1, R3, R1
	SUB R8, R2, R2
	INT LOD R14, R3, -28
	H LDI R15, %hi(.LBB31_40)
	SLT ADI R15, %lo(.LBB31_40)
	JMP R15
.LBB31_39:                              ;   in Loop: Header=BB31_40 Depth=2
	ADI R3, 1
	ADI R1, 1
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB31_6)
	SLT ADI R15, %lo(.LBB31_6)
	BRH EQ, R15
.LBB31_40:                              ;   Parent Loop BB31_8 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	CHAR LOD R1, R4, 0
	CHAR STR R3, R4, 0
	ADI R2, 1
	SLT ADD R10, R0, R4
	SUB R2, R8, R0
	H LDI R15, %hi(.LBB31_39)
	SLT ADI R15, %lo(.LBB31_39)
	BRH EQ, R15
; %bb.41:                               ;   in Loop: Header=BB31_40 Depth=2
	SLT ADD R8, R0, R4
	H LDI R15, %hi(.LBB31_39)
	SLT ADI R15, %lo(.LBB31_39)
	JMP R15
.LBB31_42:                              ;   in Loop: Header=BB31_8 Depth=1
	CHAR LOD R6, R1, 28
	INT LOD R6, R9, 24
	SUB R5, R9, R0
	H LDI R15, %hi(.LBB31_25)
	SLT ADI R15, %lo(.LBB31_25)
	BRH C, R15
; %bb.43:                               ;   in Loop: Header=BB31_8 Depth=1
	INT LOD R14, R2, -28
	LDI R3, 3
	AND R2, R3, R2
	SUB R2, R8, R0
	H LDI R15, %hi(.LBB31_25)
	SLT ADI R15, %lo(.LBB31_25)
	BRH NE, R15
; %bb.44:                               ;   in Loop: Header=BB31_8 Depth=1
	LDI R2, 128
	RSH R2, R1, R1
	CHAR LOD R6, R2, 29
	RSH R5, R2, R5
	SUB R5, R1, R0
	H LDI R15, %hi(.LBB31_46)
	SLT ADI R15, %lo(.LBB31_46)
	BRH C, R15
; %bb.45:                               ;   in Loop: Header=BB31_8 Depth=1
	SLT ADD R1, R0, R5
.LBB31_46:                              ;   in Loop: Header=BB31_8 Depth=1
	SLT ADD R5, R0, R10
	LDI R9, 1
	SUB R9, R5, R0
	H LDI R15, %hi(.LBB31_48)
	SLT ADI R15, %lo(.LBB31_48)
	BRH C, R15
; %bb.47:                               ;   in Loop: Header=BB31_8 Depth=1
	SLT ADD R9, R0, R10
.LBB31_48:                              ;   in Loop: Header=BB31_8 Depth=1
	SUB R5, R7, R0
	H LDI R15, %hi(.LBB31_68)
	SLT ADI R15, %lo(.LBB31_68)
	BRH C, R15
; %bb.49:                               ; %.preheader
                                        ;   in Loop: Header=BB31_8 Depth=1
	INT STR R14, R10, -16
	INT STR R14, R5, -12
.LBB31_50:                              ;   Parent Loop BB31_8 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	SUB R12, R7, R0
	H LDI R15, %hi(.LBB31_54)
	SLT ADI R15, %lo(.LBB31_54)
	BRH NC, R15
.LBB31_51:                              ;   in Loop: Header=BB31_50 Depth=2
	SLT ADD R8, R0, R1
.LBB31_52:                              ;   in Loop: Header=BB31_50 Depth=2
	SLT ADD R12, R0, R2
	ADI R2, 1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB31_66)
	SLT ADI R15, %lo(.LBB31_66)
	BRH NE, R15
; %bb.53:                               ;   in Loop: Header=BB31_50 Depth=2
	ADI R9, 1
	SLT ADD R1, R0, R12
	SUB R5, R9, R0
	H LDI R15, %hi(.LBB31_50)
	SLT ADI R15, %lo(.LBB31_50)
	BRH NE, R15
	H LDI R15, %hi(.LBB31_67)
	SLT ADI R15, %lo(.LBB31_67)
	JMP R15
.LBB31_54:                              ;   in Loop: Header=BB31_50 Depth=2
	INT LOD R6, R1, 20
	ADI R1, 1
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB31_51)
	SLT ADI R15, %lo(.LBB31_51)
	BRH C, R15
; %bb.56:                               ;   in Loop: Header=BB31_50 Depth=2
	LDI R1, 7
	RSH R12, R1, R1
	LDI R2, 0
	H LDI R2, 512
	SLT ADI R2, -8
	AND R1, R2, R1
	INT LOD R6, R2, 8
	ADD R2, R1, R13
	INT LOD R6, R4, 72
	INT LOD R6, R1, 76
	SUB R13, R1, R0
	H LDI R15, %hi(.LBB31_60)
	SLT ADI R15, %lo(.LBB31_60)
	BRH EQ, R15
; %bb.57:                               ;   in Loop: Header=BB31_50 Depth=2
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	INT STR R6, R1, 76
	INT LOD R6, R1, 0
	SLT ADD R13, R0, R2
	LDI R3, 8
	SLT ADD R6, R0, R10
	H LDI R15, %hi(nvm_read_sectors)
	SLT ADI R15, %lo(nvm_read_sectors)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB31_59)
	SLT ADI R15, %lo(.LBB31_59)
	BRH EQ, R15
; %bb.58:                               ;   in Loop: Header=BB31_50 Depth=2
	SLT ADD R8, R0, R1
	SLT ADD R10, R0, R6
	LDI R7, 2
	INT LOD R14, R10, -16
	INT LOD R14, R5, -12
	H LDI R15, %hi(.LBB31_52)
	SLT ADI R15, %lo(.LBB31_52)
	JMP R15
.LBB31_59:                              ;   in Loop: Header=BB31_50 Depth=2
	INT STR R10, R13, 76
	INT LOD R10, R4, 72
	SLT ADD R10, R0, R6
	LDI R7, 2
	INT LOD R14, R10, -16
	INT LOD R14, R5, -12
.LBB31_60:                              ;   in Loop: Header=BB31_50 Depth=2
	LSH R12, R7, R1
	LDI R2, 4092
	AND R1, R2, R1
	ADD R4, R1, R1
	CHAR LOD R1, R2, 1
	LDI R3, 8
	LSH R2, R3, R2
	CHAR LOD R1, R3, 0
	NOR R2, R3, R2
	CHAR LOD R1, R3, 2
	LDI R4, 16
	LSH R3, R4, R3
	NOR R2, R2, R2
	NOR R2, R3, R2
	ADI R1, 3
	CHAR LOD R1, R1, 0
	LDI R3, 24
	LSH R1, R3, R1
	NOR R2, R2, R2
	NOR R2, R1, R1
	NOR R1, R1, R2
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -9
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB31_62)
	SLT ADI R15, %lo(.LBB31_62)
	BRH NC, R15
; %bb.61:                               ;   in Loop: Header=BB31_50 Depth=2
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	H LDI R15, %hi(.LBB31_52)
	SLT ADI R15, %lo(.LBB31_52)
	JMP R15
.LBB31_62:                              ;   in Loop: Header=BB31_50 Depth=2
	SUB R2, R7, R0
	H LDI R15, %hi(.LBB31_51)
	SLT ADI R15, %lo(.LBB31_51)
	BRH C, R15
; %bb.64:                               ;   in Loop: Header=BB31_50 Depth=2
	INT LOD R6, R3, 20
	ADI R3, 1
	SLT ADD R8, R0, R1
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB31_52)
	SLT ADI R15, %lo(.LBB31_52)
	BRH C, R15
; %bb.65:                               ;   in Loop: Header=BB31_50 Depth=2
	SLT ADD R2, R0, R1
	H LDI R15, %hi(.LBB31_52)
	SLT ADI R15, %lo(.LBB31_52)
	JMP R15
.LBB31_66:                              ;   in Loop: Header=BB31_8 Depth=1
	SLT ADD R9, R0, R10
	H LDI R15, %hi(.LBB31_68)
	SLT ADI R15, %lo(.LBB31_68)
	JMP R15
.LBB31_67:                              ;   in Loop: Header=BB31_8 Depth=1
	SLT ADD R1, R0, R12
.LBB31_68:                              ;   in Loop: Header=BB31_8 Depth=1
	INT LOD R11, R1, 16
	ADI R1, -2
	CHAR LOD R6, R2, 28
	LSH R10, R2, R3
	LSH R1, R2, R1
	INT LOD R6, R2, 12
	ADD R1, R2, R2
	INT LOD R6, R1, 0
	INT LOD R14, R4, -28
	SLT ADD R6, R0, R9
	H LDI R15, %hi(nvm_read_sectors)
	SLT ADI R15, %lo(nvm_read_sectors)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB31_74)
	SLT ADI R15, %lo(.LBB31_74)
	BRH NE, R15
; %bb.69:                               ;   in Loop: Header=BB31_8 Depth=1
	INT STR R11, R12, 16
	INT LOD R11, R1, 20
	ADD R10, R1, R1
	ADI R1, -1
	INT STR R11, R1, 20
	CHAR LOD R9, R1, 29
	LSH R10, R1, R1
	INT LOD R14, R5, -32
	SLT ADD R9, R0, R6
	LDI R7, 2
	H LDI R15, %hi(.LBB31_7)
	SLT ADI R15, %lo(.LBB31_7)
	JMP R15
.LBB31_70:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -8
.LBB31_71:
	INT LOD R14, R8, -20
.LBB31_72:
	INT LOD R14, R4, -4
.LBB31_73:
	INT STR R4, R8, 0
	INT LOD R14, R13, -56
	INT LOD R14, R12, -52
	INT LOD R14, R11, -48
	INT LOD R14, R10, -44
	INT LOD R14, R9, -40
	INT LOD R14, R8, -36
	SLT ADI R14, -60
	RET
.LBB31_74:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	H LDI R15, %hi(.LBB31_71)
	SLT ADI R15, %lo(.LBB31_71)
	JMP R15
.LBB31_75:
	SLT ADD R8, R0, R1
	SLT ADD R4, R0, R8
	H LDI R15, %hi(.LBB31_72)
	SLT ADI R15, %lo(.LBB31_72)
	JMP R15
.LBB31_76:
	INT LOD R14, R8, -20
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	H LDI R15, %hi(.LBB31_72)
	SLT ADI R15, %lo(.LBB31_72)
	JMP R15
.Lfunc_end31:
	.size	fs_read, .Lfunc_end31-fs_read
                                        ; -- End function
	.globl	bus_Enumeration                 ; -- Begin function bus_Enumeration
	.type	bus_Enumeration,@function
bus_Enumeration:                        ; @bus_Enumeration
; %bb.0:
	SLT ADI R14, 48
	INT STR R14, R8, -24
	INT STR R14, R9, -28
	INT STR R14, R10, -32
	INT STR R14, R11, -36
	INT STR R14, R12, -40
	INT STR R14, R13, -44
	INT STR R14, R3, -20
	SLT ADD R2, R0, R6
	SLT ADD R1, R0, R5
	LDI R9, 255
	SUB R9, R5, R0
	H LDI R15, %hi(.LBB32_1)
	SLT ADI R15, %lo(.LBB32_1)
	BRH NC, R15
.LBB32_57:
	INT LOD R14, R13, -44
	INT LOD R14, R12, -40
	INT LOD R14, R11, -36
	INT LOD R14, R10, -32
	INT LOD R14, R9, -28
	INT LOD R14, R8, -24
	SLT ADI R14, -48
	RET
.LBB32_1:
	LDI R12, 1
	LDI R4, 0
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB32_3)
	SLT ADI R15, %lo(.LBB32_3)
	BRH EQ, R15
; %bb.2:
	SLT ADD R4, R0, R12
.LBB32_3:
	LDI R1, 20
	LSH R5, R1, R2
	LDI R1, 15
	LSH R12, R1, R1
	INT STR R14, R2, -16
	NOR R2, R1, R1
	NOR R1, R1, R1
	LDI R2, 4096
	NOR R1, R2, R1
	NOR R1, R1, R11
	LDI R10, 0
	H LDI R10, 57344
	SLT ADI R10, 0
	INT LOD R14, R1, -20
	INT STR R14, R6, -8
	INT STR R14, R5, -4
	H LDI R15, %hi(.LBB32_4)
	SLT ADI R15, %lo(.LBB32_4)
	JMP R15
.LBB32_21:                              ;   in Loop: Header=BB32_4 Depth=1
	LDI R4, 0
.LBB32_22:                              ;   in Loop: Header=BB32_4 Depth=1
	LDI R10, 0
	H LDI R10, 57344
	SLT ADI R10, 0
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB32_23)
	SLT ADI R15, %lo(.LBB32_23)
	BRH EQ, R15
.LBB32_56:                              ;   in Loop: Header=BB32_4 Depth=1
	LDI R1, 0
	H LDI R1, 1
	SLT ADI R1, -32768
	ADD R11, R1, R11
	ADI R12, 1
	LDI R1, 32
	SUB R12, R1, R0
	H LDI R15, %hi(.LBB32_57)
	SLT ADI R15, %lo(.LBB32_57)
	BRH EQ, R15
.LBB32_4:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB32_17 Depth 2
	LDI R1, 15
	LSH R12, R1, R1
	INT LOD R14, R2, -16
	ADD R1, R2, R13
	NOR R13, R10, R1
	NOR R1, R1, R1
	INT LOD R1, R1, 0
	LDI R2, 0
	H LDI R2, 1
	SLT ADI R2, -1
	AND R1, R2, R1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB32_56)
	SLT ADI R15, %lo(.LBB32_56)
	BRH EQ, R15
; %bb.5:                                ;   in Loop: Header=BB32_4 Depth=1
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R1, 0
	LDI R2, 63
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB32_57)
	SLT ADI R15, %lo(.LBB32_57)
	BRH C, R15
; %bb.6:                                ;   in Loop: Header=BB32_4 Depth=1
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 8
	NOR R13, R1, R1
	NOR R1, R1, R1
	INT LOD R1, R8, 0
	LDI R1, 24
	RSH R8, R1, R1
	LDI R2, 127
	AND R1, R2, R2
	NOR R2, R5, R1
	NOR R1, R1, R1
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB32_56)
	SLT ADI R15, %lo(.LBB32_56)
	BRH EQ, R15
; %bb.7:                                ;   in Loop: Header=BB32_4 Depth=1
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R1, 0
	INT LOD R14, R3, -20
	INT LOD R3, R3, 0
	LDI R10, 0
	H LDI R10, 49152
	SLT ADI R10, 0
	ADD R3, R10, R3
	LDI R10, 20
	MUL R1, R10, R10
	LDI R1, 0
	H LDI R1, mapa
	SLT ADI R1, mapa
	INT LOD R1, R1, 0
	ADD R1, R10, R1
	INT STR R1, R3, 0
	CHAR STR R1, R5, 16
	CHAR STR R1, R12, 17
	CHAR STR R1, R4, 18
	INT STR R1, R8, 12
	LDI R3, 1
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB32_22)
	SLT ADI R15, %lo(.LBB32_22)
	BRH NE, R15
; %bb.8:                                ;   in Loop: Header=BB32_4 Depth=1
	INT LOD R14, R4, -20
	INT LOD R4, R2, 0
	LDI R3, 0
	H LDI R3, 1
	SLT ADI R3, -1
	ADD R2, R3, R2
	LDI R3, 0
	H LDI R3, 65535
	SLT ADI R3, 0
	AND R2, R3, R2
	INT STR R4, R2, 0
	LDI R3, 0
	H LDI R3, 16096
	SLT ADI R3, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB32_58)
	SLT ADI R15, %lo(.LBB32_58)
	BRH C, R15
; %bb.9:                                ;   in Loop: Header=BB32_4 Depth=1
	INT LOD R6, R3, 0
	SUB R9, R3, R0
	H LDI R15, %hi(.LBB32_58)
	SLT ADI R15, %lo(.LBB32_58)
	BRH C, R15
; %bb.10:                               ;   in Loop: Header=BB32_4 Depth=1
	LDI R3, 0
	H LDI R3, 49152
	SLT ADI R3, 0
	NOR R2, R3, R2
	NOR R2, R2, R2
	INT STR R1, R2, 0
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
	INT STR R14, R13, -12
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 16
	NOR R13, R1, R1
	NOR R1, R1, R2
	INT LOD R6, R1, 0
	INT LOD R2, R3, 0
	LDI R4, 0
	H LDI R4, 65280
	SLT ADI R4, 0
	AND R3, R4, R3
	AND R1, R9, R4
	SLT ADD R5, R0, R9
	LDI R5, 16
	LSH R4, R5, R5
	NOR R3, R5, R3
	NOR R3, R3, R3
	NOR R3, R9, R3
	LDI R5, 8
	LSH R4, R5, R9
	NOR R3, R3, R3
	NOR R3, R9, R3
	NOR R3, R3, R3
	INT STR R2, R3, 0
	INT LOD R6, R2, 0
	ADI R2, 1
	INT STR R6, R2, 0
	SLT ADD R6, R0, R2
	INT LOD R14, R3, -20
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	INT LOD R14, R2, -20
	LDI R1, 0
	H LDI R1, mapa
	SLT ADI R1, mapa
	INT LOD R1, R1, 0
	ADD R1, R10, R1
	INT LOD R2, R2, 0
	INT LOD R1, R3, 0
	LDI R4, 0
	H LDI R4, 16384
	SLT ADI R4, 0
	ADD R3, R4, R3
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB32_12)
	SLT ADI R15, %lo(.LBB32_12)
	BRH NC, R15
; %bb.11:                               ;   in Loop: Header=BB32_4 Depth=1
	LDI R3, 0
	H LDI R3, 1
	SLT ADI R3, -1
	ADD R2, R3, R2
	LDI R3, 0
	H LDI R3, 65535
	SLT ADI R3, 0
	AND R2, R3, R2
	INT LOD R14, R3, -20
	INT STR R3, R2, 0
	LDI R3, 0
	H LDI R3, 16096
	SLT ADI R3, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB32_58)
	SLT ADI R15, %lo(.LBB32_58)
	BRH C, R15
.LBB32_12:                              ;   in Loop: Header=BB32_4 Depth=1
	INT LOD R14, R13, -12
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 16
	ADD R13, R2, R2
	INT LOD R2, R3, 0
	LDI R4, 0
	H LDI R4, 65280
	SLT ADI R4, 255
	AND R3, R4, R3
	INT LOD R14, R6, -8
	INT LOD R6, R4, 0
	LDI R7, 16
	LSH R4, R7, R4
	LDI R5, 0
	H LDI R5, 255
	SLT ADI R5, 0
	ADD R4, R5, R4
	AND R4, R5, R4
	NOR R3, R4, R3
	NOR R3, R3, R3
	NOR R3, R9, R3
	NOR R3, R3, R3
	INT STR R2, R3, 0
	INT LOD R14, R2, -20
	INT LOD R2, R3, 0
	LDI R2, 0
	H LDI R2, 49152
	SLT ADI R2, 0
	ADD R3, R2, R2
	INT STR R1, R2, 4
	INT LOD R1, R4, 0
	SUB R2, R4, R4
	INT STR R1, R4, 8
	INT LOD R1, R4, 0
	LDI R10, 0
	SLT ADD R10, R0, R9
	INT LOD R14, R5, -4
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB32_15)
	SLT ADI R15, %lo(.LBB32_15)
	BRH NC, R15
; %bb.13:                               ;   in Loop: Header=BB32_4 Depth=1
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, -1
	ADD R3, R4, R3
	RSH R3, R7, R10
	INT LOD R1, R3, 0
	RSH R3, R7, R9
	LDI R3, 0
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB32_15)
	SLT ADI R15, %lo(.LBB32_15)
	BRH NE, R15
; %bb.14:                               ;   in Loop: Header=BB32_4 Depth=1
	INT LOD R1, R1, 0
	H LDI R15, %hi(allocateIOMemory)
	SLT ADI R15, %lo(allocateIOMemory)
	CAL R15
	INT LOD R14, R5, -4
	INT LOD R14, R6, -8
	INT LOD R14, R2, -20
	LDI R7, 16
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB32_58)
	SLT ADI R15, %lo(.LBB32_58)
	BRH NE, R15
.LBB32_15:                              ;   in Loop: Header=BB32_4 Depth=1
	LSH R10, R7, R1
	NOR R1, R9, R1
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 24
	NOR R13, R2, R2
	NOR R2, R2, R2
	NOR R1, R1, R1
	INT STR R2, R1, 0
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 4
	NOR R13, R1, R1
	NOR R1, R1, R1
	LDI R2, 3
	INT STR R1, R2, 0
	LDI R9, 255
	LDI R4, 0
	LDI R10, 0
	H LDI R10, 57344
	SLT ADI R10, 0
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB32_56)
	SLT ADI R15, %lo(.LBB32_56)
	BRH N, R15
; %bb.16:                               ; %.preheader
                                        ;   in Loop: Header=BB32_4 Depth=1
	SLT ADD R11, R0, R13
	SLT ADD R4, R0, R8
	H LDI R15, %hi(.LBB32_17)
	SLT ADI R15, %lo(.LBB32_17)
	JMP R15
.LBB32_55:                              ;   in Loop: Header=BB32_17 Depth=2
	LSH R10, R7, R1
	NOR R1, R9, R1
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 24
	ADD R13, R2, R2
	NOR R1, R1, R1
	INT STR R2, R1, 0
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 4
	ADD R13, R1, R1
	LDI R2, 3
	INT STR R1, R2, 0
	ADI R13, 4096
	LDI R9, 255
	LDI R4, 0
	LDI R10, 0
	H LDI R10, 57344
	SLT ADI R10, 0
	LDI R1, 7
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB32_56)
	SLT ADI R15, %lo(.LBB32_56)
	BRH NC, R15
.LBB32_17:                              ;   Parent Loop BB32_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ADD R13, R10, R1
	INT LOD R1, R1, 0
	LDI R2, 0
	H LDI R2, 1
	SLT ADI R2, -1
	AND R1, R2, R1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB32_56)
	SLT ADI R15, %lo(.LBB32_56)
	BRH EQ, R15
; %bb.18:                               ;   in Loop: Header=BB32_17 Depth=2
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R1, 0
	LDI R2, 63
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB32_57)
	SLT ADI R15, %lo(.LBB32_57)
	BRH C, R15
; %bb.19:                               ;   in Loop: Header=BB32_17 Depth=2
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 8
	ADD R13, R1, R1
	INT LOD R1, R3, 0
	LDI R1, 24
	RSH R3, R1, R1
	LDI R2, 127
	AND R1, R2, R2
	NOR R2, R5, R1
	NOR R1, R1, R1
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB32_56)
	SLT ADI R15, %lo(.LBB32_56)
	BRH EQ, R15
; %bb.20:                               ;   in Loop: Header=BB32_17 Depth=2
	ADI R8, 1
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R1, 0
	INT LOD R14, R4, -20
	INT LOD R4, R4, 0
	LDI R10, 0
	H LDI R10, 49152
	SLT ADI R10, 0
	ADD R4, R10, R4
	LDI R10, 20
	MUL R1, R10, R10
	LDI R1, 0
	H LDI R1, mapa
	SLT ADI R1, mapa
	INT LOD R1, R1, 0
	ADD R1, R10, R1
	INT STR R1, R4, 0
	CHAR STR R1, R5, 16
	CHAR STR R1, R12, 17
	CHAR STR R1, R8, 18
	INT STR R1, R3, 12
	LDI R3, 1
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB32_21)
	SLT ADI R15, %lo(.LBB32_21)
	BRH NE, R15
; %bb.48:                               ;   in Loop: Header=BB32_17 Depth=2
	INT LOD R14, R4, -20
	INT LOD R4, R2, 0
	LDI R3, 0
	H LDI R3, 1
	SLT ADI R3, -1
	ADD R2, R3, R2
	LDI R3, 0
	H LDI R3, 65535
	SLT ADI R3, 0
	AND R2, R3, R2
	INT STR R4, R2, 0
	LDI R3, 0
	H LDI R3, 16096
	SLT ADI R3, 1
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB32_58)
	SLT ADI R15, %lo(.LBB32_58)
	BRH NC, R15
; %bb.49:                               ;   in Loop: Header=BB32_17 Depth=2
	INT LOD R6, R3, 0
	LDI R4, 256
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB32_58)
	SLT ADI R15, %lo(.LBB32_58)
	BRH NC, R15
; %bb.50:                               ;   in Loop: Header=BB32_17 Depth=2
	LDI R3, 0
	H LDI R3, 49152
	SLT ADI R3, 0
	NOR R2, R3, R2
	NOR R2, R2, R2
	INT STR R1, R2, 0
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
	INT STR R14, R13, -12
	SLT ADD R9, R0, R3
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 16
	ADD R13, R1, R9
	INT LOD R6, R1, 0
	INT LOD R9, R2, 0
	LDI R4, 0
	H LDI R4, 65280
	SLT ADI R4, 0
	AND R2, R4, R2
	AND R1, R3, R3
	LDI R4, 16
	LSH R3, R4, R4
	NOR R2, R4, R2
	NOR R2, R2, R2
	NOR R2, R5, R2
	LDI R4, 8
	LSH R3, R4, R13
	NOR R2, R2, R2
	NOR R2, R13, R2
	NOR R2, R2, R2
	INT STR R9, R2, 0
	INT LOD R6, R2, 0
	ADI R2, 1
	INT STR R6, R2, 0
	SLT ADD R6, R0, R2
	INT LOD R14, R3, -20
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	INT LOD R14, R2, -20
	LDI R1, 0
	H LDI R1, mapa
	SLT ADI R1, mapa
	INT LOD R1, R1, 0
	ADD R1, R10, R1
	INT LOD R2, R2, 0
	INT LOD R1, R3, 0
	LDI R4, 0
	H LDI R4, 16384
	SLT ADI R4, 0
	ADD R3, R4, R3
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB32_52)
	SLT ADI R15, %lo(.LBB32_52)
	BRH NC, R15
; %bb.51:                               ;   in Loop: Header=BB32_17 Depth=2
	LDI R3, 0
	H LDI R3, 1
	SLT ADI R3, -1
	ADD R2, R3, R2
	LDI R3, 0
	H LDI R3, 65535
	SLT ADI R3, 0
	AND R2, R3, R2
	INT LOD R14, R3, -20
	INT STR R3, R2, 0
	LDI R3, 0
	H LDI R3, 16096
	SLT ADI R3, 1
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB32_58)
	SLT ADI R15, %lo(.LBB32_58)
	BRH NC, R15
.LBB32_52:                              ;   in Loop: Header=BB32_17 Depth=2
	INT LOD R9, R2, 0
	LDI R3, 0
	H LDI R3, 65280
	SLT ADI R3, 255
	AND R2, R3, R2
	INT LOD R14, R6, -8
	INT LOD R6, R3, 0
	LDI R7, 16
	LSH R3, R7, R3
	LDI R4, 0
	H LDI R4, 255
	SLT ADI R4, 0
	ADD R3, R4, R3
	AND R3, R4, R3
	NOR R2, R3, R2
	NOR R2, R2, R2
	NOR R2, R13, R2
	NOR R2, R2, R2
	INT STR R9, R2, 0
	INT LOD R14, R2, -20
	INT LOD R2, R3, 0
	LDI R2, 0
	H LDI R2, 49152
	SLT ADI R2, 0
	ADD R3, R2, R2
	INT STR R1, R2, 4
	INT LOD R1, R4, 0
	SUB R2, R4, R4
	INT STR R1, R4, 8
	INT LOD R1, R4, 0
	LDI R10, 0
	SLT ADD R10, R0, R9
	INT LOD R14, R13, -12
	INT LOD R14, R5, -4
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB32_55)
	SLT ADI R15, %lo(.LBB32_55)
	BRH NC, R15
; %bb.53:                               ;   in Loop: Header=BB32_17 Depth=2
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, -1
	ADD R3, R4, R3
	RSH R3, R7, R10
	INT LOD R1, R3, 0
	RSH R3, R7, R9
	LDI R3, 0
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB32_55)
	SLT ADI R15, %lo(.LBB32_55)
	BRH NE, R15
; %bb.54:                               ;   in Loop: Header=BB32_17 Depth=2
	INT LOD R1, R1, 0
	H LDI R15, %hi(allocateIOMemory)
	SLT ADI R15, %lo(allocateIOMemory)
	CAL R15
	INT LOD R14, R5, -4
	INT LOD R14, R6, -8
	INT LOD R14, R2, -20
	LDI R7, 16
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB32_55)
	SLT ADI R15, %lo(.LBB32_55)
	BRH EQ, R15
.LBB32_58:
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
.LBB32_23:
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 16
	ADD R13, R2, R2
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -1
	INT STR R2, R3, 0
	INT LOD R2, R4, 0
	LDI R2, 0
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB32_29)
	SLT ADI R15, %lo(.LBB32_29)
	BRH EQ, R15
; %bb.24:
	LDI R5, 4096
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB32_26)
	SLT ADI R15, %lo(.LBB32_26)
	BRH C, R15
; %bb.25:
	SLT ADD R5, R0, R4
.LBB32_26:
	INT LOD R14, R5, -20
	INT LOD R5, R5, 0
	LDI R6, 0
	H LDI R6, 16096
	SLT ADI R6, 0
	SUB R6, R5, R6
	SUB R6, R4, R0
	H LDI R15, %hi(.LBB32_58)
	SLT ADI R15, %lo(.LBB32_58)
	BRH C, R15
; %bb.27:
	ADI R4, 4095
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -4096
	AND R4, R7, R4
	INT LOD R14, R7, -20
	SUB R6, R4, R0
	H LDI R15, %hi(.LBB32_58)
	SLT ADI R15, %lo(.LBB32_58)
	BRH C, R15
; %bb.28:
	LDI R6, 0
	H LDI R6, 49152
	SLT ADI R6, 0
	ADD R5, R6, R5
	LDI R6, 0
	H LDI R6, 57344
	SLT ADI R6, 16
	ADD R13, R6, R6
	INT STR R6, R5, 0
	INT LOD R14, R6, -20
	INT LOD R6, R5, 0
	ADD R5, R4, R4
	INT STR R6, R4, 0
.LBB32_29:
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 20
	ADD R13, R4, R4
	INT STR R4, R3, 0
	INT LOD R4, R3, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB32_35)
	SLT ADI R15, %lo(.LBB32_35)
	BRH EQ, R15
; %bb.30:
	LDI R4, 4096
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB32_32)
	SLT ADI R15, %lo(.LBB32_32)
	BRH C, R15
; %bb.31:
	SLT ADD R4, R0, R3
.LBB32_32:
	INT LOD R14, R4, -20
	INT LOD R4, R4, 0
	LDI R5, 0
	H LDI R5, 16096
	SLT ADI R5, 0
	SUB R5, R4, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB32_58)
	SLT ADI R15, %lo(.LBB32_58)
	BRH C, R15
; %bb.33:
	ADI R3, 4095
	LDI R6, 0
	H LDI R6, 0
	SLT ADI R6, -4096
	AND R3, R6, R3
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB32_58)
	SLT ADI R15, %lo(.LBB32_58)
	BRH C, R15
; %bb.34:
	LDI R5, 0
	H LDI R5, 49152
	SLT ADI R5, 0
	ADD R4, R5, R4
	LDI R5, 0
	H LDI R5, 57344
	SLT ADI R5, 20
	ADD R13, R5, R5
	INT STR R5, R4, 0
	INT LOD R14, R5, -20
	INT LOD R5, R4, 0
	ADD R4, R3, R3
	INT STR R5, R3, 0
.LBB32_35:
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 24
	ADD R13, R3, R4
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -1
	INT STR R4, R3, 0
	INT LOD R4, R4, 0
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB32_41)
	SLT ADI R15, %lo(.LBB32_41)
	BRH EQ, R15
; %bb.36:
	LDI R5, 4096
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB32_38)
	SLT ADI R15, %lo(.LBB32_38)
	BRH C, R15
; %bb.37:
	SLT ADD R5, R0, R4
.LBB32_38:
	INT LOD R14, R5, -20
	INT LOD R5, R5, 0
	LDI R6, 0
	H LDI R6, 16096
	SLT ADI R6, 0
	SUB R6, R5, R6
	SUB R6, R4, R0
	H LDI R15, %hi(.LBB32_58)
	SLT ADI R15, %lo(.LBB32_58)
	BRH C, R15
; %bb.39:
	ADI R4, 4095
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -4096
	AND R4, R7, R4
	INT LOD R14, R7, -20
	SUB R6, R4, R0
	H LDI R15, %hi(.LBB32_58)
	SLT ADI R15, %lo(.LBB32_58)
	BRH C, R15
; %bb.40:
	LDI R6, 0
	H LDI R6, 49152
	SLT ADI R6, 0
	ADD R5, R6, R5
	LDI R6, 0
	H LDI R6, 57344
	SLT ADI R6, 24
	ADD R13, R6, R6
	INT STR R6, R5, 0
	INT LOD R14, R6, -20
	INT LOD R6, R5, 0
	ADD R5, R4, R4
	INT STR R6, R4, 0
.LBB32_41:
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 28
	ADD R13, R4, R4
	INT STR R4, R3, 0
	INT LOD R4, R4, 0
	INT LOD R14, R3, -20
	INT LOD R3, R3, 0
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB32_47)
	SLT ADI R15, %lo(.LBB32_47)
	BRH EQ, R15
; %bb.42:
	LDI R2, 0
	H LDI R2, 16096
	SLT ADI R2, 0
	SUB R2, R3, R2
	LDI R5, 4096
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB32_44)
	SLT ADI R15, %lo(.LBB32_44)
	BRH C, R15
; %bb.43:
	SLT ADD R5, R0, R4
.LBB32_44:
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB32_58)
	SLT ADI R15, %lo(.LBB32_58)
	BRH C, R15
; %bb.45:
	ADI R4, 4095
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -4096
	AND R4, R5, R4
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB32_58)
	SLT ADI R15, %lo(.LBB32_58)
	BRH C, R15
; %bb.46:
	LDI R2, 0
	H LDI R2, 49152
	SLT ADI R2, 0
	ADD R3, R2, R2
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 28
	ADD R13, R3, R3
	INT STR R3, R2, 0
	INT LOD R14, R5, -20
	INT LOD R5, R2, 0
	ADD R2, R4, R3
	INT STR R5, R3, 0
.LBB32_47:
	INT LOD R1, R2, 0
	SUB R3, R2, R2
	LDI R3, 0
	H LDI R3, 49152
	SLT ADI R3, 0
	ADD R2, R3, R2
	INT STR R1, R2, 8
	INT LOD R14, R2, -20
	INT LOD R2, R2, 0
	ADD R2, R3, R2
	INT STR R1, R2, 4
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB32_57)
	SLT ADI R15, %lo(.LBB32_57)
	JMP R15
.Lfunc_end32:
	.size	bus_Enumeration, .Lfunc_end32-bus_Enumeration
                                        ; -- End function
	.globl	PCIe_Bus_Enumeration            ; -- Begin function PCIe_Bus_Enumeration
	.type	PCIe_Bus_Enumeration,@function
PCIe_Bus_Enumeration:                   ; @PCIe_Bus_Enumeration
; %bb.0:
	SLT ADI R14, 24
	INT STR R14, R8, -12
	INT STR R14, R9, -16
	INT STR R14, R10, -20
	ADD R14, R0, R8
	SLT ADD R8, R0, R9
	SLT ADI R9, -8
	LDI R3, 1
	INT STR R9, R3, 0
	SLT ADI R8, -4
	LDI R10, 0
	INT STR R8, R10, 0
	LDI R2, 3
	LDI R1, 0
	H LDI R1, 2048
	SLT ADI R1, 0
	LDI R4, 0
	H LDI R4, mapa
	SLT ADI R4, mapa
	H LDI R15, %hi(allocatePages)
	SLT ADI R15, %lo(allocatePages)
	CAL R15
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB33_2)
	SLT ADI R15, %lo(.LBB33_2)
	BRH NE, R15
; %bb.1:
	LDI R1, 0
	SLT ADD R9, R0, R2
	SLT ADD R8, R0, R3
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	INT LOD R14, R10, -20
	INT LOD R14, R9, -16
	INT LOD R14, R8, -12
	SLT ADI R14, -24
	RET
.LBB33_2:
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
.Lfunc_end33:
	.size	PCIe_Bus_Enumeration, .Lfunc_end33-PCIe_Bus_Enumeration
                                        ; -- End function
	.globl	searchFirst                     ; -- Begin function searchFirst
	.type	searchFirst,@function
searchFirst:                            ; @searchFirst
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R1, R0, R2
	LDI R3, 0
	H LDI R3, Globals
	SLT ADI R3, Globals
	INT LOD R3, R1, 0
	INT LOD R1, R1, 0
	LDI R4, 0
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB34_4)
	SLT ADI R15, %lo(.LBB34_4)
	BRH EQ, R15
; %bb.1:
	LDI R1, 0
	LDI R4, 0
	H LDI R4, mapa
	SLT ADI R4, mapa
	INT LOD R4, R4, 0
	ADI R4, 12
	LDI R5, 0
	H LDI R5, 256
	SLT ADI R5, -1
.LBB34_2:                               ; =>This Inner Loop Header: Depth=1
	INT LOD R4, R6, 0
	AND R6, R5, R6
	SUB R6, R2, R0
	H LDI R15, %hi(.LBB34_5)
	SLT ADI R15, %lo(.LBB34_5)
	BRH EQ, R15
; %bb.3:                                ;   in Loop: Header=BB34_2 Depth=1
	ADI R4, 20
	ADI R1, 1
	INT LOD R3, R6, 0
	INT LOD R6, R6, 0
	SUB R1, R6, R0
	H LDI R15, %hi(.LBB34_2)
	SLT ADI R15, %lo(.LBB34_2)
	BRH C, R15
.LBB34_4:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
.LBB34_5:
	SLT ADI R14, -4
	RET
.Lfunc_end34:
	.size	searchFirst, .Lfunc_end34-searchFirst
                                        ; -- End function
	.globl	search                          ; -- Begin function search
	.type	search,@function
search:                                 ; @search
; %bb.0:
	SLT ADI R14, 28
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	INT STR R14, R13, -24
	LDI R4, 0
	H LDI R4, Globals
	SLT ADI R4, Globals
	INT LOD R4, R3, 0
	INT LOD R3, R5, 0
	LDI R3, 0
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB35_6)
	SLT ADI R15, %lo(.LBB35_6)
	BRH EQ, R15
; %bb.1:
	LDI R7, 0
	LDI R3, 0
	H LDI R3, mapa
	SLT ADI R3, mapa
	INT LOD R3, R5, 0
	ADI R5, 18
	LDI R6, 0
	H LDI R6, 256
	SLT ADI R6, -1
	LDI R10, 0
	H LDI R10, 57344
	SLT ADI R10, 0
	LDI R11, 2
	LDI R12, 30
	SLT ADD R7, R0, R13
	H LDI R15, %hi(.LBB35_2)
	SLT ADI R15, %lo(.LBB35_2)
	JMP R15
.LBB35_3:                               ;   in Loop: Header=BB35_2 Depth=1
	SLT ADD R7, R0, R3
.LBB35_5:                               ;   in Loop: Header=BB35_2 Depth=1
	ADI R5, 20
	ADI R13, 1
	INT LOD R4, R7, 0
	INT LOD R7, R8, 0
	SLT ADD R3, R0, R7
	SUB R13, R8, R0
	H LDI R15, %hi(.LBB35_6)
	SLT ADI R15, %lo(.LBB35_6)
	BRH NC, R15
.LBB35_2:                               ; =>This Inner Loop Header: Depth=1
	INT LOD R5, R3, -6
	AND R3, R6, R3
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB35_3)
	SLT ADI R15, %lo(.LBB35_3)
	BRH NE, R15
; %bb.4:                                ;   in Loop: Header=BB35_2 Depth=1
	CHAR LOD R5, R3, -2
	LDI R8, 20
	LSH R3, R8, R3
	CHAR LOD R5, R8, -1
	LDI R9, 15
	LSH R8, R9, R8
	NOR R3, R8, R3
	CHAR LOD R5, R8, 0
	LDI R9, 12
	LSH R8, R9, R8
	NOR R3, R3, R3
	NOR R3, R8, R3
	NOR R3, R3, R3
	NOR R3, R10, R3
	LSH R7, R11, R8
	ADD R2, R8, R8
	NOR R3, R3, R3
	INT STR R8, R3, 0
	SLT ADD R7, R0, R3
	ADI R3, 1
	SUB R12, R7, R0
	H LDI R15, %hi(.LBB35_5)
	SLT ADI R15, %lo(.LBB35_5)
	BRH NC, R15
.LBB35_6:
	SLT ADD R3, R0, R1
	INT LOD R14, R13, -24
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -28
	RET
.Lfunc_end35:
	.size	search, .Lfunc_end35-search
                                        ; -- End function
	.globl	mainHandler                     ; -- Begin function mainHandler
	.type	mainHandler,@function
mainHandler:                            ; @mainHandler
; %bb.0:
	SLT ADI R14, 24
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	;APP
	CYE SR1, R9
	;NO_APP
	;APP
	CYE SR8, R2
	;NO_APP
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -5
	AND R2, R3, R10
	LDI R3, 8
	AND R2, R3, R4
	;APP
	CYE SR9, R11
	;NO_APP
	;APP
	CYE SR10, R12
	;NO_APP
	;APP
	CYE SR7, R8
	;NO_APP
	LDI R3, 0
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB36_2)
	SLT ADI R15, %lo(.LBB36_2)
	BRH EQ, R15
; %bb.1:
	LDI R4, 4
	NOR R2, R4, R4
	NOR R4, R4, R4
	;APP
	CYR R4, SR8
	;NO_APP
.LBB36_2:
	SUB R8, R3, R0
	H LDI R15, %hi(.LBB36_7)
	SLT ADI R15, %lo(.LBB36_7)
	BRH EQ, R15
; %bb.3:
	LDI R1, 127
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB36_6)
	SLT ADI R15, %lo(.LBB36_6)
	BRH C, R15
; %bb.4:
	LDI R1, 2
	LSH R8, R1, R1
	LDI R4, 0
	H LDI R4, irq_table
	SLT ADI R4, irq_table
	INT LOD R4, R4, 0
	ADD R4, R1, R1
	INT LOD R1, R4, 0
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB36_6)
	SLT ADI R15, %lo(.LBB36_6)
	BRH EQ, R15
; %bb.5:
	SLT ADD R2, R0, R1
	SLT ADD R9, R0, R2
	SLT ADD R8, R0, R3
	CAL R4
	H LDI R15, %hi(.LBB36_8)
	SLT ADI R15, %lo(.LBB36_8)
	JMP R15
.LBB36_6:
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -5
	AND R1, R2, R1
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	LDI R2, 1
	CHAR STR R1, R2, 4
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.43
	SLT ADI R1, .L.str.43
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB36_9)
	SLT ADI R15, %lo(.LBB36_9)
	JMP R15
.LBB36_7:
	SLT ADD R9, R0, R3
	H LDI R15, %hi(syscallsHandler)
	SLT ADI R15, %lo(syscallsHandler)
	CAL R15
.LBB36_8:
	SLT ADD R1, R0, R9
.LBB36_9:
	;APP
	CYR R10, SR8
	;NO_APP
	;APP
	CYR R9, SR1
	;NO_APP
	;APP
	CYR R11, SR9
	;NO_APP
	;APP
	CYR R12, SR10
	;NO_APP
	LDI R1, 16
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB36_11)
	SLT ADI R15, %lo(.LBB36_11)
	BRH C, R15
; %bb.10:
	LDI R1, 0
	H LDI R1, Registros
	SLT ADI R1, Registros
	INT LOD R1, R1, 0
	LDI R2, 1
	INT STR R1, R2, 16
.LBB36_11:
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -24
	RET
.Lfunc_end36:
	.size	mainHandler, .Lfunc_end36-mainHandler
                                        ; -- End function
	.globl	entryHandler                    ; -- Begin function entryHandler
	.type	entryHandler,@function
entryHandler:                           ; @entryHandler
; %bb.0:
	;APP
	SLT ADI R14, 56 
INT STR R14, R1, -56 
INT STR R14, R2, -52 
INT STR R14, R3, -48 
INT STR R14, R4, -44 
INT STR R14, R5, -40 
INT STR R14, R6, -36 
INT STR R14, R7, -32 
INT STR R14, R8, -28 
INT STR R14, R9, -24 
INT STR R14, R10, -20 
INT STR R14, R11, -16 
INT STR R14, R12, -12 
INT STR R14, R13, -8 
INT STR R14, R15, -4 
SLT ADD R14, R0, R1 
SLT ADI R1, -56 
H LDI R15, %hi(mainHandler) 
SLT ADI R15, %lo(mainHandler) 
CAL R15 
INT LOD R14, R1, -56 
INT LOD R14, R2, -52 
INT LOD R14, R3, -48 
INT LOD R14, R4, -44 
INT LOD R14, R5, -40 
INT LOD R14, R6, -36 
INT LOD R14, R7, -32 
INT LOD R14, R8, -28 
INT LOD R14, R9, -24 
INT LOD R14, R10, -20 
INT LOD R14, R11, -16 
INT LOD R14, R12, -12 
INT LOD R14, R13, -8 
INT LOD R14, R15, -4 
SLT ADI R14, -56 
SRT 

	;NO_APP
.Lfunc_end37:
	.size	entryHandler, .Lfunc_end37-entryHandler
                                        ; -- End function
	.globl	initMSI                         ; -- Begin function initMSI
	.type	initMSI,@function
initMSI:                                ; @initMSI
; %bb.0:
	SLT ADI R14, 4
	INT LOD R1, R4, 36
	ADD R4, R1, R1
	INT LOD R1, R4, 0
	LDI R5, 255
	AND R4, R5, R4
	LDI R5, 5
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB38_5)
	SLT ADI R15, %lo(.LBB38_5)
	BRH NE, R15
; %bb.1:
	INT LOD R1, R4, 0
	LDI R5, 0
	H LDI R5, 65248
	SLT ADI R5, 44
	INT STR R1, R5, 4
	INT STR R1, R2, 8
	LDI R5, 127
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB38_4)
	SLT ADI R15, %lo(.LBB38_4)
	BRH C, R15
; %bb.2:
	LDI R5, 0
	SUB R3, R5, R0
	H LDI R15, %hi(.LBB38_4)
	SLT ADI R15, %lo(.LBB38_4)
	BRH EQ, R15
; %bb.3:
	LDI R5, 2
	LSH R2, R5, R2
	LDI R5, 0
	H LDI R5, irq_table
	SLT ADI R5, irq_table
	INT LOD R5, R5, 0
	ADD R5, R2, R2
	INT STR R2, R3, 0
.LBB38_4:
	LDI R2, 13
	RSH R4, R2, R2
	LDI R3, 112
	AND R2, R3, R2
	LDI R3, 1
	NOR R2, R3, R2
	NOR R2, R2, R2
	INT STR R1, R2, 0
.LBB38_5:
	SLT ADI R14, -4
	RET
.Lfunc_end38:
	.size	initMSI, .Lfunc_end38-initMSI
                                        ; -- End function
	.globl	initLAPIC                       ; -- Begin function initLAPIC
	.type	initLAPIC,@function
initLAPIC:                              ; @initLAPIC
; %bb.0:
	SLT ADI R14, 8
	INT STR R14, R8, -4
	LDI R1, 2
	LDI R2, 512
	LDI R8, 0
	H LDI R8, irq_table
	SLT ADI R8, irq_table
	LDI R3, 0
	H LDI R3, irq_table
	SLT ADI R3, irq_table
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB39_2)
	SLT ADI R15, %lo(.LBB39_2)
	BRH NE, R15
; %bb.1:
	INT LOD R8, R1, 0
	LDI R3, 0
	H LDI R3, doubleFault
	SLT ADI R3, doubleFault
	INT STR R1, R3, 20
	LDI R3, 0
	H LDI R3, invalidOpCode
	SLT ADI R3, invalidOpCode
	INT STR R1, R3, 16
	LDI R3, 0
	H LDI R3, generalProtectionFault
	SLT ADI R3, generalProtectionFault
	INT STR R1, R3, 12
	LDI R3, 0
	H LDI R3, alignamentFault
	SLT ADI R3, alignamentFault
	INT STR R1, R3, 8
	LDI R3, 0
	H LDI R3, pageFault
	SLT ADI R3, pageFault
	INT STR R1, R3, 4
	LDI R1, 0
	H LDI R1, entryHandler
	SLT ADI R1, entryHandler
	;APP
	CYR R1, SR12
	;NO_APP
	LDI R1, 0
	H LDI R1, 65248
	SLT ADI R1, 0
	LDI R3, 0
	H LDI R3, Registros
	SLT ADI R3, Registros
	INT STR R3, R1, 0
	INT STR R1, R1, 0
	LDI R1, 0
	H LDI R1, 65248
	SLT ADI R1, 4
	INT STR R1, R2, 0
	LDI R1, 0
	H LDI R1, 65248
	SLT ADI R1, 12
	INT STR R1, R2, 0
	LDI R1, 3
	LDI R2, 0
	H LDI R2, 65248
	SLT ADI R2, 8
	INT STR R2, R1, 0
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R2, 4
	NOR R1, R2, R1
	NOR R1, R1, R1
	;APP
	CYR R1, SR8
	;NO_APP
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.LBB39_2:
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
.Lfunc_end39:
	.size	initLAPIC, .Lfunc_end39-initLAPIC
                                        ; -- End function
	.globl	pageFault                       ; -- Begin function pageFault
	.type	pageFault,@function
pageFault:                              ; @pageFault
; %bb.0:
	SLT ADI R14, 8
	INT STR R14, R8, -4
	SLT ADD R2, R0, R8
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -5
	AND R1, R2, R1
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	LDI R2, 1
	CHAR STR R1, R2, 4
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.50
	SLT ADI R1, .L.str.50
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	;APP
	HLT
	;NO_APP
	SLT ADD R8, R0, R1
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.Lfunc_end40:
	.size	pageFault, .Lfunc_end40-pageFault
                                        ; -- End function
	.globl	alignamentFault                 ; -- Begin function alignamentFault
	.type	alignamentFault,@function
alignamentFault:                        ; @alignamentFault
; %bb.0:
	SLT ADI R14, 8
	INT STR R14, R8, -4
	SLT ADD R2, R0, R8
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -5
	AND R1, R2, R1
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	LDI R2, 1
	CHAR STR R1, R2, 4
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.1.53
	SLT ADI R1, .L.str.1.53
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	;APP
	HLT
	;NO_APP
	SLT ADD R8, R0, R1
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.Lfunc_end41:
	.size	alignamentFault, .Lfunc_end41-alignamentFault
                                        ; -- End function
	.globl	generalProtectionFault          ; -- Begin function generalProtectionFault
	.type	generalProtectionFault,@function
generalProtectionFault:                 ; @generalProtectionFault
; %bb.0:
	SLT ADI R14, 8
	INT STR R14, R8, -4
	SLT ADD R2, R0, R8
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -5
	AND R1, R2, R1
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	LDI R2, 1
	CHAR STR R1, R2, 4
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.2.56
	SLT ADI R1, .L.str.2.56
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	;APP
	HLT
	;NO_APP
	SLT ADD R8, R0, R1
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.Lfunc_end42:
	.size	generalProtectionFault, .Lfunc_end42-generalProtectionFault
                                        ; -- End function
	.globl	invalidOpCode                   ; -- Begin function invalidOpCode
	.type	invalidOpCode,@function
invalidOpCode:                          ; @invalidOpCode
; %bb.0:
	SLT ADI R14, 8
	INT STR R14, R8, -4
	SLT ADD R2, R0, R8
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -5
	AND R1, R2, R1
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	LDI R2, 1
	CHAR STR R1, R2, 4
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.3.59
	SLT ADI R1, .L.str.3.59
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	;APP
	HLT
	;NO_APP
	SLT ADD R8, R0, R1
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.Lfunc_end43:
	.size	invalidOpCode, .Lfunc_end43-invalidOpCode
                                        ; -- End function
	.globl	doubleFault                     ; -- Begin function doubleFault
	.type	doubleFault,@function
doubleFault:                            ; @doubleFault
; %bb.0:
	SLT ADI R14, 8
	INT STR R14, R8, -4
	SLT ADD R2, R0, R8
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -5
	AND R1, R2, R1
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	LDI R2, 1
	CHAR STR R1, R2, 4
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.4.62
	SLT ADI R1, .L.str.4.62
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	;APP
	HLT
	;NO_APP
	SLT ADD R8, R0, R1
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.Lfunc_end44:
	.size	doubleFault, .Lfunc_end44-doubleFault
                                        ; -- End function
	.globl	syscallsHandler                 ; -- Begin function syscallsHandler
	.type	syscallsHandler,@function
syscallsHandler:                        ; @syscallsHandler
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R3, R0, R1
	ADI R1, 4
	SLT ADI R14, -4
	RET
.Lfunc_end45:
	.size	syscallsHandler, .Lfunc_end45-syscallsHandler
                                        ; -- End function
	.globl	ToAscii                         ; -- Begin function ToAscii
	.type	ToAscii,@function
ToAscii:                                ; @ToAscii
; %bb.0:
	SLT ADI R14, 32
	INT STR R14, R8, -8
	INT STR R14, R9, -12
	INT STR R14, R10, -16
	INT STR R14, R11, -20
	INT STR R14, R12, -24
	INT STR R14, R13, -28
	SLT ADD R2, R0, R8
	;APP
	CYE SR8, R11
	;NO_APP
	;APP
	CYE SR8, R2
	;NO_APP
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -5
	AND R2, R3, R2
	;APP
	CYR R2, SR8
	;NO_APP
	LDI R2, 0
	H LDI R2, current_pool_index
	SLT ADI R2, current_pool_index
	INT LOD R2, R2, 0
	LDI R10, 0
	SUB R2, R10, R0
	H LDI R15, %hi(.LBB46_2)
	SLT ADI R15, %lo(.LBB46_2)
	BRH EQ, R15
; %bb.1:
	INT LOD R2, R9, 0
	H LDI R15, %hi(.LBB46_5)
	SLT ADI R15, %lo(.LBB46_5)
	JMP R15
.LBB46_2:
	SLT ADD R1, R0, R12
	LDI R9, 0
	LDI R2, 4
	SLT ADD R9, R0, R1
	LDI R3, 0
	H LDI R3, current_pool_index
	SLT ADI R3, current_pool_index
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB46_56)
	SLT ADI R15, %lo(.LBB46_56)
	BRH NE, R15
; %bb.3:
	LDI R2, 256
	SLT ADD R9, R0, R1
	LDI R3, 0
	H LDI R3, ascii_pool
	SLT ADI R3, ascii_pool
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB46_56)
	SLT ADI R15, %lo(.LBB46_56)
	BRH NE, R15
; %bb.4:
	LDI R1, 0
	H LDI R1, current_pool_index
	SLT ADI R1, current_pool_index
	INT LOD R1, R2, 0
	INT STR R2, R9, 0
	SLT ADD R12, R0, R1
.LBB46_5:
	SLT ADD R9, R0, R5
	ADI R5, 1
	LDI R4, 31
	LDI R3, 1
	SLT ADD R5, R0, R6
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB46_7)
	SLT ADI R15, %lo(.LBB46_7)
	BRH EQ, R15
; %bb.6:
	RSH R5, R4, R6
	LSH R6, R3, R7
	SUB R6, R7, R6
.LBB46_7:
	LDI R7, 29
	RSH R6, R7, R6
	ADD R5, R6, R6
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -8
	AND R6, R7, R6
	SUB R5, R6, R5
	LDI R6, 0
	H LDI R6, ascii_pool
	SLT ADI R6, ascii_pool
	INT LOD R6, R6, 0
	INT STR R2, R5, 0
	LDI R2, 5
	LSH R9, R2, R2
	ADD R6, R2, R2
	;APP
	CYR R11, SR8
	;NO_APP
	CHAR STR R2, R10, 31
	SLT ADD R2, R0, R5
	ADI R5, 31
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB46_42)
	SLT ADI R15, %lo(.LBB46_42)
	BRH EQ, R15
; %bb.8:
	LDI R6, 2
	SUB R8, R6, R0
	H LDI R15, %hi(.LBB46_36)
	SLT ADI R15, %lo(.LBB46_36)
	BRH EQ, R15
; %bb.9:
	LDI R6, 3
	SUB R8, R6, R0
	H LDI R15, %hi(.LBB46_10)
	SLT ADI R15, %lo(.LBB46_10)
	BRH NE, R15
; %bb.11:
	LDI R3, 8
	RSH R1, R3, R3
	LDI R6, 15
	AND R3, R6, R3
	LDI R4, 48
	LDI R7, 10
	SUB R3, R7, R0
	H LDI R15, %hi(.LBB46_12)
	SLT ADI R15, %lo(.LBB46_12)
	BRH C, R15
; %bb.13:
	ADI R3, 55
	H LDI R15, %hi(.LBB46_14)
	SLT ADI R15, %lo(.LBB46_14)
	JMP R15
.LBB46_36:
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB46_57)
	SLT ADI R15, %lo(.LBB46_57)
	BRH EQ, R15
; %bb.37:
	LDI R3, 15
	LDI R4, 48
	LDI R6, 10
	LDI R7, 4
	SLT ADD R5, R0, R2
	H LDI R15, %hi(.LBB46_38)
	SLT ADI R15, %lo(.LBB46_38)
	JMP R15
.LBB46_40:                              ;   in Loop: Header=BB46_38 Depth=1
	ADI R5, 55
.LBB46_41:                              ;   in Loop: Header=BB46_38 Depth=1
	CHAR STR R2, R5, -1
	RSH R1, R7, R1
	ADI R2, -1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB46_55)
	SLT ADI R15, %lo(.LBB46_55)
	BRH EQ, R15
.LBB46_38:                              ; =>This Inner Loop Header: Depth=1
	AND R1, R3, R5
	SUB R5, R6, R0
	H LDI R15, %hi(.LBB46_40)
	SLT ADI R15, %lo(.LBB46_40)
	BRH NC, R15
; %bb.39:                               ;   in Loop: Header=BB46_38 Depth=1
	NOR R5, R4, R5
	NOR R5, R5, R5
	H LDI R15, %hi(.LBB46_41)
	SLT ADI R15, %lo(.LBB46_41)
	JMP R15
.LBB46_42:
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -1
	SLT ADD R3, R0, R6
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB46_44)
	SLT ADI R15, %lo(.LBB46_44)
	BRH N, R15
; %bb.43:
	SLT ADD R10, R0, R6
.LBB46_44:
	SLT ADD R1, R0, R7
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB46_46)
	SLT ADI R15, %lo(.LBB46_46)
	BRH EQ, R15
; %bb.45:
	RSH R1, R4, R7
	LSH R7, R3, R8
	SUB R7, R8, R7
.LBB46_46:
	XOR R1, R7, R1
	SUB R1, R7, R1
	H LDI R15, %hi(.LBB46_47)
	SLT ADI R15, %lo(.LBB46_47)
	JMP R15
.LBB46_10:
	SLT ADD R3, R0, R6
.LBB46_47:
	INT STR R14, R6, -4
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB46_58)
	SLT ADI R15, %lo(.LBB46_58)
	BRH EQ, R15
; %bb.48:
	LDI R2, 0
	H LDI R2, 52429
	SLT ADI R2, -13107
	LDI R7, 3
	LDI R8, 10
	LDI R9, 48
	LDI R11, 9
	H LDI R15, %hi(.LBB46_49)
	SLT ADI R15, %lo(.LBB46_49)
	JMP R15
.LBB46_51:                              ;   in Loop: Header=BB46_49 Depth=1
	AND R1, R2, R1
	MUL R12, R2, R13
	GOF R6
	ADD R6, R1, R1
	ADD R1, R12, R1
	RSH R1, R7, R1
	MUL R1, R8, R6
	SUB R12, R6, R6
	NOR R6, R9, R6
	NOR R6, R6, R6
	CHAR STR R5, R6, -1
	ADI R5, -1
	SUB R11, R12, R0
	H LDI R15, %hi(.LBB46_52)
	SLT ADI R15, %lo(.LBB46_52)
	BRH NC, R15
.LBB46_49:                              ; =>This Inner Loop Header: Depth=1
	SLT ADD R1, R0, R12
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB46_51)
	SLT ADI R15, %lo(.LBB46_51)
	BRH EQ, R15
; %bb.50:                               ;   in Loop: Header=BB46_49 Depth=1
	RSH R12, R4, R1
	LSH R1, R3, R13
	SUB R1, R13, R1
	H LDI R15, %hi(.LBB46_51)
	SLT ADI R15, %lo(.LBB46_51)
	JMP R15
.LBB46_12:
	NOR R3, R4, R3
	NOR R3, R3, R3
.LBB46_14:
	LDI R5, 4
	RSH R1, R5, R5
	AND R5, R6, R5
	SUB R5, R7, R0
	H LDI R15, %hi(.LBB46_15)
	SLT ADI R15, %lo(.LBB46_15)
	BRH C, R15
; %bb.16:
	ADI R5, 55
	AND R1, R6, R8
	SUB R8, R7, R0
	H LDI R15, %hi(.LBB46_19)
	SLT ADI R15, %lo(.LBB46_19)
	BRH NC, R15
.LBB46_18:
	NOR R8, R4, R8
	NOR R8, R8, R8
	H LDI R15, %hi(.LBB46_20)
	SLT ADI R15, %lo(.LBB46_20)
	JMP R15
.LBB46_15:
	NOR R5, R4, R5
	NOR R5, R5, R5
	AND R1, R6, R8
	SUB R8, R7, R0
	H LDI R15, %hi(.LBB46_18)
	SLT ADI R15, %lo(.LBB46_18)
	BRH C, R15
.LBB46_19:
	ADI R8, 55
.LBB46_20:
	LDI R9, 24
	RSH R1, R9, R9
	AND R9, R6, R9
	SUB R9, R7, R0
	H LDI R15, %hi(.LBB46_21)
	SLT ADI R15, %lo(.LBB46_21)
	BRH C, R15
; %bb.22:
	ADI R9, 55
	H LDI R15, %hi(.LBB46_23)
	SLT ADI R15, %lo(.LBB46_23)
	JMP R15
.LBB46_21:
	NOR R9, R4, R9
	NOR R9, R9, R9
.LBB46_23:
	LDI R10, 20
	RSH R1, R10, R10
	AND R10, R6, R10
	SUB R10, R7, R0
	H LDI R15, %hi(.LBB46_24)
	SLT ADI R15, %lo(.LBB46_24)
	BRH C, R15
; %bb.25:
	ADI R10, 55
	H LDI R15, %hi(.LBB46_26)
	SLT ADI R15, %lo(.LBB46_26)
	JMP R15
.LBB46_24:
	NOR R10, R4, R10
	NOR R10, R10, R10
.LBB46_26:
	LDI R11, 16
	RSH R1, R11, R11
	AND R11, R6, R11
	SUB R11, R7, R0
	H LDI R15, %hi(.LBB46_27)
	SLT ADI R15, %lo(.LBB46_27)
	BRH C, R15
; %bb.28:
	ADI R11, 55
	H LDI R15, %hi(.LBB46_29)
	SLT ADI R15, %lo(.LBB46_29)
	JMP R15
.LBB46_27:
	NOR R11, R4, R11
	NOR R11, R11, R11
.LBB46_29:
	LDI R12, 12
	RSH R1, R12, R12
	AND R12, R6, R6
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB46_30)
	SLT ADI R15, %lo(.LBB46_30)
	BRH C, R15
; %bb.31:
	ADI R6, 55
	H LDI R15, %hi(.LBB46_32)
	SLT ADI R15, %lo(.LBB46_32)
	JMP R15
.LBB46_30:
	NOR R6, R4, R6
	NOR R6, R6, R6
.LBB46_32:
	LDI R7, 28
	RSH R1, R7, R7
	LDI R12, 0
	H LDI R12, 40960
	SLT ADI R12, 0
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB46_33)
	SLT ADI R15, %lo(.LBB46_33)
	BRH C, R15
; %bb.34:
	ADI R7, 55
	H LDI R15, %hi(.LBB46_35)
	SLT ADI R15, %lo(.LBB46_35)
	JMP R15
.LBB46_33:
	NOR R7, R4, R1
	NOR R1, R1, R7
.LBB46_35:
	CHAR STR R2, R8, 30
	CHAR STR R2, R7, 23
	CHAR STR R2, R5, 29
	CHAR STR R2, R3, 28
	CHAR STR R2, R6, 27
	CHAR STR R2, R11, 26
	CHAR STR R2, R10, 25
	CHAR STR R2, R9, 24
	ADI R2, 23
	H LDI R15, %hi(.LBB46_55)
	SLT ADI R15, %lo(.LBB46_55)
	JMP R15
.LBB46_58:
	LDI R1, 48
	CHAR STR R2, R1, 30
	ADI R2, 30
	SLT ADD R2, R0, R5
.LBB46_52:
	INT LOD R14, R1, -4
	AND R1, R3, R1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB46_54)
	SLT ADI R15, %lo(.LBB46_54)
	BRH NE, R15
; %bb.53:
	LDI R1, 45
	CHAR STR R5, R1, -1
	ADI R5, -1
.LBB46_54:
	SLT ADD R5, R0, R2
.LBB46_55:
	SLT ADD R2, R0, R1
	INT LOD R14, R13, -28
	INT LOD R14, R12, -24
	INT LOD R14, R11, -20
	INT LOD R14, R10, -16
	INT LOD R14, R9, -12
	INT LOD R14, R8, -8
	SLT ADI R14, -32
	RET
.LBB46_57:
	LDI R1, 48
	CHAR STR R2, R1, 30
	ADI R2, 30
	H LDI R15, %hi(.LBB46_55)
	SLT ADI R15, %lo(.LBB46_55)
	JMP R15
.LBB46_56:
	;APP
	CYR R11, SR8
	;NO_APP
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
.Lfunc_end46:
	.size	ToAscii, .Lfunc_end46-ToAscii
                                        ; -- End function
	.globl	__udivsi3                       ; -- Begin function __udivsi3
	.type	__udivsi3,@function
__udivsi3:                              ; @__udivsi3
; %bb.0:
	SLT ADI R14, 16
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	LDI R4, 0
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB47_1)
	SLT ADI R15, %lo(.LBB47_1)
	BRH EQ, R15
; %bb.2:                                ; %.preheader
	LDI R5, 31
	LDI R6, 1
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -1
	SLT ADD R4, R0, R8
	SLT ADD R4, R0, R3
	H LDI R15, %hi(.LBB47_3)
	SLT ADI R15, %lo(.LBB47_3)
	JMP R15
.LBB47_7:                               ;   in Loop: Header=BB47_3 Depth=1
	SUB R8, R10, R8
	NOR R9, R3, R3
	NOR R3, R3, R3
	ADI R5, -1
	SUB R5, R7, R0
	H LDI R15, %hi(.LBB47_8)
	SLT ADI R15, %lo(.LBB47_8)
	BRH EQ, R15
.LBB47_3:                               ; =>This Inner Loop Header: Depth=1
	LSH R8, R6, R8
	RSH R1, R5, R9
	AND R9, R6, R9
	NOR R9, R8, R8
	NOR R8, R8, R8
	SLT ADD R4, R0, R9
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB47_5)
	SLT ADI R15, %lo(.LBB47_5)
	BRH C, R15
; %bb.4:                                ;   in Loop: Header=BB47_3 Depth=1
	LSH R6, R5, R9
.LBB47_5:                               ;   in Loop: Header=BB47_3 Depth=1
	SLT ADD R4, R0, R10
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB47_7)
	SLT ADI R15, %lo(.LBB47_7)
	BRH C, R15
; %bb.6:                                ;   in Loop: Header=BB47_3 Depth=1
	SLT ADD R2, R0, R10
	H LDI R15, %hi(.LBB47_7)
	SLT ADI R15, %lo(.LBB47_7)
	JMP R15
.LBB47_1:
	SLT ADD R4, R0, R3
.LBB47_8:
	SLT ADD R3, R0, R1
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -16
	RET
.Lfunc_end47:
	.size	__udivsi3, .Lfunc_end47-__udivsi3
                                        ; -- End function
	.globl	__umodsi3                       ; -- Begin function __umodsi3
	.type	__umodsi3,@function
__umodsi3:                              ; @__umodsi3
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R1, R0, R3
	LDI R1, 0
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB48_66)
	SLT ADI R15, %lo(.LBB48_66)
	BRH EQ, R15
; %bb.1:
	LDI R4, 31
	RSH R3, R4, R4
	SLT ADD R1, R0, R5
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB48_3)
	SLT ADI R15, %lo(.LBB48_3)
	BRH C, R15
; %bb.2:
	SLT ADD R2, R0, R5
.LBB48_3:
	SUB R4, R5, R5
	LDI R4, 1
	LSH R5, R4, R5
	LDI R6, 30
	RSH R3, R6, R6
	AND R6, R4, R6
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_5)
	SLT ADI R15, %lo(.LBB48_5)
	BRH C, R15
; %bb.4:
	SLT ADD R2, R0, R6
.LBB48_5:
	SUB R5, R6, R5
	LDI R6, 29
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_7)
	SLT ADI R15, %lo(.LBB48_7)
	BRH C, R15
; %bb.6:
	SLT ADD R2, R0, R6
.LBB48_7:
	SUB R5, R6, R5
	LDI R6, 28
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_9)
	SLT ADI R15, %lo(.LBB48_9)
	BRH C, R15
; %bb.8:
	SLT ADD R2, R0, R6
.LBB48_9:
	SUB R5, R6, R5
	LDI R6, 27
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_11)
	SLT ADI R15, %lo(.LBB48_11)
	BRH C, R15
; %bb.10:
	SLT ADD R2, R0, R6
.LBB48_11:
	SUB R5, R6, R5
	LDI R6, 26
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_13)
	SLT ADI R15, %lo(.LBB48_13)
	BRH C, R15
; %bb.12:
	SLT ADD R2, R0, R6
.LBB48_13:
	SUB R5, R6, R5
	LDI R6, 25
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_15)
	SLT ADI R15, %lo(.LBB48_15)
	BRH C, R15
; %bb.14:
	SLT ADD R2, R0, R6
.LBB48_15:
	SUB R5, R6, R5
	LDI R6, 24
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_17)
	SLT ADI R15, %lo(.LBB48_17)
	BRH C, R15
; %bb.16:
	SLT ADD R2, R0, R6
.LBB48_17:
	SUB R5, R6, R5
	LDI R6, 23
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_19)
	SLT ADI R15, %lo(.LBB48_19)
	BRH C, R15
; %bb.18:
	SLT ADD R2, R0, R6
.LBB48_19:
	SUB R5, R6, R5
	LDI R6, 22
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_21)
	SLT ADI R15, %lo(.LBB48_21)
	BRH C, R15
; %bb.20:
	SLT ADD R2, R0, R6
.LBB48_21:
	SUB R5, R6, R5
	LDI R6, 21
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_23)
	SLT ADI R15, %lo(.LBB48_23)
	BRH C, R15
; %bb.22:
	SLT ADD R2, R0, R6
.LBB48_23:
	SUB R5, R6, R5
	LDI R6, 20
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_25)
	SLT ADI R15, %lo(.LBB48_25)
	BRH C, R15
; %bb.24:
	SLT ADD R2, R0, R6
.LBB48_25:
	SUB R5, R6, R5
	LDI R6, 19
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_27)
	SLT ADI R15, %lo(.LBB48_27)
	BRH C, R15
; %bb.26:
	SLT ADD R2, R0, R6
.LBB48_27:
	SUB R5, R6, R5
	LDI R6, 18
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_29)
	SLT ADI R15, %lo(.LBB48_29)
	BRH C, R15
; %bb.28:
	SLT ADD R2, R0, R6
.LBB48_29:
	SUB R5, R6, R5
	LDI R6, 17
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_31)
	SLT ADI R15, %lo(.LBB48_31)
	BRH C, R15
; %bb.30:
	SLT ADD R2, R0, R6
.LBB48_31:
	SUB R5, R6, R5
	LDI R6, 16
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_33)
	SLT ADI R15, %lo(.LBB48_33)
	BRH C, R15
; %bb.32:
	SLT ADD R2, R0, R6
.LBB48_33:
	SUB R5, R6, R5
	LDI R6, 15
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_35)
	SLT ADI R15, %lo(.LBB48_35)
	BRH C, R15
; %bb.34:
	SLT ADD R2, R0, R6
.LBB48_35:
	SUB R5, R6, R5
	LDI R6, 14
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_37)
	SLT ADI R15, %lo(.LBB48_37)
	BRH C, R15
; %bb.36:
	SLT ADD R2, R0, R6
.LBB48_37:
	SUB R5, R6, R5
	LDI R6, 13
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_39)
	SLT ADI R15, %lo(.LBB48_39)
	BRH C, R15
; %bb.38:
	SLT ADD R2, R0, R6
.LBB48_39:
	SUB R5, R6, R5
	LDI R6, 12
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_41)
	SLT ADI R15, %lo(.LBB48_41)
	BRH C, R15
; %bb.40:
	SLT ADD R2, R0, R6
.LBB48_41:
	SUB R5, R6, R5
	LDI R6, 11
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_43)
	SLT ADI R15, %lo(.LBB48_43)
	BRH C, R15
; %bb.42:
	SLT ADD R2, R0, R6
.LBB48_43:
	SUB R5, R6, R5
	LDI R6, 10
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_45)
	SLT ADI R15, %lo(.LBB48_45)
	BRH C, R15
; %bb.44:
	SLT ADD R2, R0, R6
.LBB48_45:
	SUB R5, R6, R5
	LDI R6, 9
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_47)
	SLT ADI R15, %lo(.LBB48_47)
	BRH C, R15
; %bb.46:
	SLT ADD R2, R0, R6
.LBB48_47:
	SUB R5, R6, R5
	LDI R6, 8
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_49)
	SLT ADI R15, %lo(.LBB48_49)
	BRH C, R15
; %bb.48:
	SLT ADD R2, R0, R6
.LBB48_49:
	SUB R5, R6, R5
	LDI R6, 7
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_51)
	SLT ADI R15, %lo(.LBB48_51)
	BRH C, R15
; %bb.50:
	SLT ADD R2, R0, R6
.LBB48_51:
	SUB R5, R6, R5
	LDI R6, 6
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_53)
	SLT ADI R15, %lo(.LBB48_53)
	BRH C, R15
; %bb.52:
	SLT ADD R2, R0, R6
.LBB48_53:
	SUB R5, R6, R5
	LDI R6, 5
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_55)
	SLT ADI R15, %lo(.LBB48_55)
	BRH C, R15
; %bb.54:
	SLT ADD R2, R0, R6
.LBB48_55:
	SUB R5, R6, R5
	LDI R6, 4
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_57)
	SLT ADI R15, %lo(.LBB48_57)
	BRH C, R15
; %bb.56:
	SLT ADD R2, R0, R6
.LBB48_57:
	SUB R5, R6, R5
	LDI R6, 3
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_59)
	SLT ADI R15, %lo(.LBB48_59)
	BRH C, R15
; %bb.58:
	SLT ADD R2, R0, R6
.LBB48_59:
	SUB R5, R6, R5
	LDI R6, 2
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_61)
	SLT ADI R15, %lo(.LBB48_61)
	BRH C, R15
; %bb.60:
	SLT ADD R2, R0, R6
.LBB48_61:
	SUB R5, R6, R5
	RSH R3, R4, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB48_63)
	SLT ADI R15, %lo(.LBB48_63)
	BRH C, R15
; %bb.62:
	SLT ADD R2, R0, R6
.LBB48_63:
	SUB R5, R6, R5
	AND R3, R4, R3
	LSH R5, R4, R4
	NOR R3, R4, R3
	NOR R3, R3, R3
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB48_65)
	SLT ADI R15, %lo(.LBB48_65)
	BRH C, R15
; %bb.64:
	SLT ADD R2, R0, R1
.LBB48_65:
	SUB R3, R1, R1
.LBB48_66:
	SLT ADI R14, -4
	RET
.Lfunc_end48:
	.size	__umodsi3, .Lfunc_end48-__umodsi3
                                        ; -- End function
	.globl	strcmp                          ; -- Begin function strcmp
	.type	strcmp,@function
strcmp:                                 ; @strcmp
; %bb.0:
	SLT ADI R14, 28
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	INT STR R14, R13, -24
	LDI R4, 3
	AND R1, R4, R5
	LDI R3, 0
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB49_1)
	SLT ADI R15, %lo(.LBB49_1)
	BRH EQ, R15
.LBB49_9:                               ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R5, 0
	CHAR LOD R1, R6, 0
	SUB R6, R3, R0
	H LDI R15, %hi(.LBB49_11)
	SLT ADI R15, %lo(.LBB49_11)
	BRH EQ, R15
; %bb.10:                               ;   in Loop: Header=BB49_9 Depth=1
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB49_11)
	SLT ADI R15, %lo(.LBB49_11)
	BRH NE, R15
; %bb.8:                                ;   in Loop: Header=BB49_9 Depth=1
	ADI R2, 1
	ADI R1, 1
	AND R1, R4, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB49_9)
	SLT ADI R15, %lo(.LBB49_9)
	BRH NE, R15
.LBB49_1:
	LDI R5, 4095
	AND R1, R5, R4
	LDI R6, 4092
	SUB R6, R4, R0
	H LDI R15, %hi(.LBB49_13)
	SLT ADI R15, %lo(.LBB49_13)
	BRH C, R15
; %bb.2:
	AND R2, R5, R4
	SUB R6, R4, R0
	H LDI R15, %hi(.LBB49_13)
	SLT ADI R15, %lo(.LBB49_13)
	BRH C, R15
; %bb.3:
	LDI R11, 0
	H LDI R11, 32897
	SLT ADI R11, -32640
	LDI R4, 255
.LBB49_4:                               ; =>This Inner Loop Header: Depth=1
	INT LOD R1, R7, 0
	INT LOD R2, R8, 0
	LDI R9, 0
	H LDI R9, 257
	SLT ADI R9, 256
	SUB R9, R7, R12
	NOR R12, R7, R12
	NOR R12, R12, R12
	AND R12, R11, R12
	SUB R12, R11, R0
	H LDI R15, %hi(.LBB49_6)
	SLT ADI R15, %lo(.LBB49_6)
	BRH NE, R15
; %bb.5:                                ;   in Loop: Header=BB49_4 Depth=1
	SUB R7, R8, R0
	H LDI R15, %hi(.LBB49_28)
	SLT ADI R15, %lo(.LBB49_28)
	BRH EQ, R15
.LBB49_6:                               ;   in Loop: Header=BB49_4 Depth=1
	AND R7, R4, R12
	SUB R12, R3, R0
	H LDI R15, %hi(.LBB49_7)
	SLT ADI R15, %lo(.LBB49_7)
	BRH EQ, R15
; %bb.20:                               ;   in Loop: Header=BB49_4 Depth=1
	AND R8, R4, R9
	AND R7, R4, R10
	SLT ADD R7, R0, R12
	SLT ADD R8, R0, R13
	SUB R10, R9, R0
	H LDI R15, %hi(.LBB49_27)
	SLT ADI R15, %lo(.LBB49_27)
	BRH NE, R15
; %bb.21:                               ;   in Loop: Header=BB49_4 Depth=1
	LDI R9, 8
	RSH R8, R9, R13
	RSH R7, R9, R12
	AND R12, R4, R9
	SUB R9, R3, R0
	H LDI R15, %hi(.LBB49_27)
	SLT ADI R15, %lo(.LBB49_27)
	BRH EQ, R15
; %bb.22:                               ;   in Loop: Header=BB49_4 Depth=1
	AND R13, R4, R9
	AND R12, R4, R10
	SUB R10, R9, R0
	H LDI R15, %hi(.LBB49_27)
	SLT ADI R15, %lo(.LBB49_27)
	BRH NE, R15
; %bb.23:                               ;   in Loop: Header=BB49_4 Depth=1
	LDI R9, 16
	RSH R8, R9, R13
	RSH R7, R9, R12
	AND R12, R4, R9
	SUB R9, R3, R0
	H LDI R15, %hi(.LBB49_27)
	SLT ADI R15, %lo(.LBB49_27)
	BRH EQ, R15
; %bb.24:                               ;   in Loop: Header=BB49_4 Depth=1
	AND R13, R4, R9
	AND R12, R4, R10
	SUB R10, R9, R0
	H LDI R15, %hi(.LBB49_27)
	SLT ADI R15, %lo(.LBB49_27)
	BRH NE, R15
; %bb.25:                               ;   in Loop: Header=BB49_4 Depth=1
	LDI R9, 24
	RSH R8, R9, R13
	RSH R7, R9, R12
	SUB R12, R3, R0
	H LDI R15, %hi(.LBB49_27)
	SLT ADI R15, %lo(.LBB49_27)
	BRH EQ, R15
; %bb.26:                               ;   in Loop: Header=BB49_4 Depth=1
	SUB R12, R13, R0
	H LDI R15, %hi(.LBB49_27)
	SLT ADI R15, %lo(.LBB49_27)
	BRH NE, R15
.LBB49_28:                              ;   in Loop: Header=BB49_4 Depth=1
	ADI R2, 4
	ADI R1, 4
	AND R1, R5, R7
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB49_13)
	SLT ADI R15, %lo(.LBB49_13)
	BRH C, R15
; %bb.29:                               ;   in Loop: Header=BB49_4 Depth=1
	AND R2, R5, R7
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB49_4)
	SLT ADI R15, %lo(.LBB49_4)
	BRH NC, R15
.LBB49_13:
	CHAR LOD R1, R5, 0
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB49_19)
	SLT ADI R15, %lo(.LBB49_19)
	BRH EQ, R15
; %bb.14:                               ; %.preheader
	ADI R1, 1
	LDI R4, 255
.LBB49_15:                              ; =>This Inner Loop Header: Depth=1
	AND R5, R4, R6
	CHAR LOD R2, R7, 0
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB49_16)
	SLT ADI R15, %lo(.LBB49_16)
	BRH NE, R15
; %bb.17:                               ;   in Loop: Header=BB49_15 Depth=1
	ADI R2, 1
	CHAR LOD R1, R5, 0
	ADI R1, 1
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB49_15)
	SLT ADI R15, %lo(.LBB49_15)
	BRH NE, R15
	H LDI R15, %hi(.LBB49_18)
	SLT ADI R15, %lo(.LBB49_18)
	JMP R15
.LBB49_11:
	SUB R6, R5, R1
	H LDI R15, %hi(.LBB49_12)
	SLT ADI R15, %lo(.LBB49_12)
	JMP R15
.LBB49_16:
	SLT ADD R5, R0, R3
.LBB49_18:
	AND R3, R4, R3
.LBB49_19:
	CHAR LOD R2, R1, 0
	SUB R3, R1, R1
	H LDI R15, %hi(.LBB49_12)
	SLT ADI R15, %lo(.LBB49_12)
	JMP R15
.LBB49_7:
	SLT ADD R7, R0, R12
	SLT ADD R8, R0, R13
.LBB49_27:
	AND R13, R4, R1
	AND R12, R4, R2
	SUB R2, R1, R1
.LBB49_12:
	INT LOD R14, R13, -24
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -28
	RET
.Lfunc_end49:
	.size	strcmp, .Lfunc_end49-strcmp
                                        ; -- End function
	.globl	strlen                          ; -- Begin function strlen
	.type	strlen,@function
strlen:                                 ; @strlen
; %bb.0:
	SLT ADI R14, 12
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	LDI R4, 3
	AND R1, R4, R2
	LDI R3, 0
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB50_1)
	SLT ADI R15, %lo(.LBB50_1)
	BRH EQ, R15
; %bb.8:
	SLT ADD R1, R0, R2
.LBB50_9:                               ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R5, 0
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB50_17)
	SLT ADI R15, %lo(.LBB50_17)
	BRH EQ, R15
; %bb.10:                               ;   in Loop: Header=BB50_9 Depth=1
	ADI R2, 1
	AND R2, R4, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB50_9)
	SLT ADI R15, %lo(.LBB50_9)
	BRH NE, R15
	H LDI R15, %hi(.LBB50_2)
	SLT ADI R15, %lo(.LBB50_2)
	JMP R15
.LBB50_1:
	SLT ADD R1, R0, R2
.LBB50_2:
	LDI R4, 4095
	AND R2, R4, R6
	LDI R5, 4092
	SUB R5, R6, R0
	H LDI R15, %hi(.LBB50_15)
	SLT ADI R15, %lo(.LBB50_15)
	BRH C, R15
; %bb.3:
	LDI R6, 0
	H LDI R6, 257
	SLT ADI R6, 256
	LDI R7, 0
	H LDI R7, 32897
	SLT ADI R7, -32640
.LBB50_4:                               ; =>This Inner Loop Header: Depth=1
	INT LOD R2, R8, 0
	SUB R6, R8, R9
	NOR R9, R8, R9
	NOR R9, R9, R9
	AND R9, R7, R9
	SUB R9, R7, R0
	H LDI R15, %hi(.LBB50_5)
	SLT ADI R15, %lo(.LBB50_5)
	BRH NE, R15
; %bb.14:                               ;   in Loop: Header=BB50_4 Depth=1
	ADI R2, 4
	AND R2, R4, R8
	SUB R5, R8, R0
	H LDI R15, %hi(.LBB50_4)
	SLT ADI R15, %lo(.LBB50_4)
	BRH NC, R15
.LBB50_15:
	ADI R2, -1
.LBB50_16:                              ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R4, 1
	ADI R2, 1
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB50_16)
	SLT ADI R15, %lo(.LBB50_16)
	BRH NE, R15
.LBB50_17:
	SUB R2, R1, R1
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -12
	RET
.LBB50_5:
	LDI R4, 255
	AND R8, R4, R4
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB50_17)
	SLT ADI R15, %lo(.LBB50_17)
	BRH EQ, R15
; %bb.6:
	LDI R4, 0
	H LDI R4, 1
	SLT ADI R4, -256
	AND R8, R4, R4
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB50_7)
	SLT ADI R15, %lo(.LBB50_7)
	BRH EQ, R15
; %bb.11:
	LDI R4, 0
	H LDI R4, 255
	SLT ADI R4, 0
	AND R8, R4, R4
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB50_12)
	SLT ADI R15, %lo(.LBB50_12)
	BRH EQ, R15
; %bb.13:
	ADI R2, 3
	H LDI R15, %hi(.LBB50_17)
	SLT ADI R15, %lo(.LBB50_17)
	JMP R15
.LBB50_7:
	ADI R2, 1
	H LDI R15, %hi(.LBB50_17)
	SLT ADI R15, %lo(.LBB50_17)
	JMP R15
.LBB50_12:
	ADI R2, 2
	H LDI R15, %hi(.LBB50_17)
	SLT ADI R15, %lo(.LBB50_17)
	JMP R15
.Lfunc_end50:
	.size	strlen, .Lfunc_end50-strlen
                                        ; -- End function
	.globl	memcmp                          ; -- Begin function memcmp
	.type	memcmp,@function
memcmp:                                 ; @memcmp
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R1, R0, R4
	LDI R1, 0
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB51_4)
	SLT ADI R15, %lo(.LBB51_4)
	BRH EQ, R15
.LBB51_2:                               ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R5, 0
	CHAR LOD R4, R6, 0
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB51_3)
	SLT ADI R15, %lo(.LBB51_3)
	BRH NE, R15
; %bb.1:                                ;   in Loop: Header=BB51_2 Depth=1
	ADI R4, 1
	ADI R2, 1
	ADI R3, -1
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB51_2)
	SLT ADI R15, %lo(.LBB51_2)
	BRH NE, R15
	H LDI R15, %hi(.LBB51_4)
	SLT ADI R15, %lo(.LBB51_4)
	JMP R15
.LBB51_3:
	SUB R6, R5, R1
.LBB51_4:
	SLT ADI R14, -4
	RET
.Lfunc_end51:
	.size	memcmp, .Lfunc_end51-memcmp
                                        ; -- End function
	.globl	strncpy                         ; -- Begin function strncpy
	.type	strncpy,@function
strncpy:                                ; @strncpy
; %bb.0:
	SLT ADI R14, 24
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	LDI R4, 0
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB52_30)
	SLT ADI R15, %lo(.LBB52_30)
	BRH EQ, R15
; %bb.1:
	LDI R6, 3
	AND R1, R6, R5
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB52_2)
	SLT ADI R15, %lo(.LBB52_2)
	BRH EQ, R15
; %bb.3:                                ; %.preheader9
	LDI R8, 1
	SLT ADD R1, R0, R5
.LBB52_4:                               ; =>This Inner Loop Header: Depth=1
	SLT ADD R3, R0, R7
	CHAR LOD R2, R3, 0
	CHAR STR R5, R3, 0
	ADI R5, 1
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB52_17)
	SLT ADI R15, %lo(.LBB52_17)
	BRH EQ, R15
; %bb.5:                                ;   in Loop: Header=BB52_4 Depth=1
	AND R5, R6, R9
	SLT ADD R7, R0, R3
	ADI R3, -1
	ADI R2, 1
	SUB R9, R4, R0
	H LDI R15, %hi(.LBB52_7)
	SLT ADI R15, %lo(.LBB52_7)
	BRH EQ, R15
; %bb.6:                                ;   in Loop: Header=BB52_4 Depth=1
	SUB R7, R8, R0
	H LDI R15, %hi(.LBB52_4)
	SLT ADI R15, %lo(.LBB52_4)
	BRH NE, R15
	H LDI R15, %hi(.LBB52_7)
	SLT ADI R15, %lo(.LBB52_7)
	JMP R15
.LBB52_2:
	SLT ADD R1, R0, R5
.LBB52_7:
	AND R2, R6, R7
	SUB R7, R4, R0
	H LDI R15, %hi(.LBB52_13)
	SLT ADI R15, %lo(.LBB52_13)
	BRH NE, R15
; %bb.8:
	LDI R7, 4
	SUB R3, R7, R0
	H LDI R15, %hi(.LBB52_13)
	SLT ADI R15, %lo(.LBB52_13)
	BRH C, R15
; %bb.9:                                ; %.preheader6
	LDI R7, 4095
	LDI R8, 4092
	LDI R9, 0
	H LDI R9, 257
	SLT ADI R9, 256
	LDI R10, 0
	H LDI R10, 32897
	SLT ADI R10, -32640
.LBB52_10:                              ; =>This Inner Loop Header: Depth=1
	AND R2, R7, R11
	SUB R8, R11, R0
	H LDI R15, %hi(.LBB52_14)
	SLT ADI R15, %lo(.LBB52_14)
	BRH C, R15
; %bb.11:                               ;   in Loop: Header=BB52_10 Depth=1
	INT LOD R2, R11, 0
	SUB R9, R11, R12
	NOR R12, R11, R12
	NOR R12, R12, R12
	AND R12, R10, R12
	SUB R12, R10, R0
	H LDI R15, %hi(.LBB52_14)
	SLT ADI R15, %lo(.LBB52_14)
	BRH NE, R15
; %bb.12:                               ;   in Loop: Header=BB52_10 Depth=1
	INT STR R5, R11, 0
	ADI R2, 4
	ADI R5, 4
	ADI R3, -4
	SUB R6, R3, R0
	H LDI R15, %hi(.LBB52_10)
	SLT ADI R15, %lo(.LBB52_10)
	BRH C, R15
.LBB52_13:
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB52_30)
	SLT ADI R15, %lo(.LBB52_30)
	BRH EQ, R15
.LBB52_14:
	ADI R5, 1
.LBB52_15:                              ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R7, 0
	CHAR STR R5, R7, -1
	SUB R7, R4, R0
	H LDI R15, %hi(.LBB52_16)
	SLT ADI R15, %lo(.LBB52_16)
	BRH EQ, R15
; %bb.31:                               ;   in Loop: Header=BB52_15 Depth=1
	ADI R5, 1
	ADI R2, 1
	ADI R3, -1
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB52_15)
	SLT ADI R15, %lo(.LBB52_15)
	BRH NE, R15
	H LDI R15, %hi(.LBB52_30)
	SLT ADI R15, %lo(.LBB52_30)
	JMP R15
.LBB52_16:
	SLT ADD R3, R0, R7
.LBB52_17:
	ADI R7, -1
	SUB R7, R4, R0
	H LDI R15, %hi(.LBB52_30)
	SLT ADI R15, %lo(.LBB52_30)
	BRH EQ, R15
; %bb.18:
	AND R5, R6, R2
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB52_22)
	SLT ADI R15, %lo(.LBB52_22)
	BRH EQ, R15
; %bb.19:
	LDI R2, 1
.LBB52_20:                              ; =>This Inner Loop Header: Depth=1
	SLT ADD R7, R0, R3
	ADI R7, -1
	CHAR STR R5, R4, 0
	ADI R5, 1
	AND R5, R6, R8
	SUB R8, R4, R0
	H LDI R15, %hi(.LBB52_22)
	SLT ADI R15, %lo(.LBB52_22)
	BRH EQ, R15
; %bb.21:                               ;   in Loop: Header=BB52_20 Depth=1
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB52_20)
	SLT ADI R15, %lo(.LBB52_20)
	BRH NE, R15
.LBB52_22:
	LDI R2, 4
	SUB R7, R2, R0
	H LDI R15, %hi(.LBB52_27)
	SLT ADI R15, %lo(.LBB52_27)
	BRH C, R15
; %bb.23:
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -4
	AND R7, R2, R2
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB52_26)
	SLT ADI R15, %lo(.LBB52_26)
	BRH EQ, R15
; %bb.24:                               ; %dynamic-memset-expansion-main-body.preheader
	SLT ADD R4, R0, R3
.LBB52_25:                              ; %dynamic-memset-expansion-main-body
                                        ; =>This Inner Loop Header: Depth=1
	ADD R5, R3, R8
	CHAR STR R8, R4, 0
	ADI R3, 1
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB52_25)
	SLT ADI R15, %lo(.LBB52_25)
	BRH C, R15
.LBB52_26:                              ; %dynamic-memset-post-expansion
	AND R7, R6, R7
	ADD R5, R2, R5
.LBB52_27:
	SUB R7, R4, R0
	H LDI R15, %hi(.LBB52_30)
	SLT ADI R15, %lo(.LBB52_30)
	BRH EQ, R15
; %bb.28:                               ; %dynamic-memset-expansion-main-body2.preheader
	SLT ADD R4, R0, R2
.LBB52_29:                              ; %dynamic-memset-expansion-main-body2
                                        ; =>This Inner Loop Header: Depth=1
	ADD R5, R2, R3
	CHAR STR R3, R4, 0
	ADI R2, 1
	SUB R2, R7, R0
	H LDI R15, %hi(.LBB52_29)
	SLT ADI R15, %lo(.LBB52_29)
	BRH C, R15
.LBB52_30:
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -24
	RET
.Lfunc_end52:
	.size	strncpy, .Lfunc_end52-strncpy
                                        ; -- End function
	.globl	strtok                          ; -- Begin function strtok
	.type	strtok,@function
strtok:                                 ; @strtok
; %bb.0:
	SLT ADI R14, 56
	INT STR R14, R8, -36
	INT STR R14, R9, -40
	INT STR R14, R10, -44
	INT STR R14, R11, -48
	INT STR R14, R12, -52
	SLT ADD R1, R0, R3
	LDI R1, 0
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB53_2)
	SLT ADI R15, %lo(.LBB53_2)
	BRH EQ, R15
; %bb.1:
	LDI R4, 0
	H LDI R4, strtok.last_token
	SLT ADI R4, strtok.last_token
	INT STR R4, R3, 0
	H LDI R15, %hi(.LBB53_3)
	SLT ADI R15, %lo(.LBB53_3)
	JMP R15
.LBB53_2:
	LDI R3, 0
	H LDI R3, strtok.last_token
	SLT ADI R3, strtok.last_token
	INT LOD R3, R3, 0
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB53_14)
	SLT ADI R15, %lo(.LBB53_14)
	BRH EQ, R15
.LBB53_3:
	CHAR LOD R3, R7, 0
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB53_14)
	SLT ADI R15, %lo(.LBB53_14)
	BRH EQ, R15
; %bb.4:
	ADD R14, R0, R4
	SLT ADI R4, -32
	INT STR R4, R1, 28
	INT STR R4, R1, 24
	INT STR R4, R1, 20
	INT STR R4, R1, 16
	INT STR R4, R1, 12
	INT STR R4, R1, 8
	INT STR R4, R1, 4
	INT STR R4, R1, 0
	CHAR LOD R2, R10, 0
	LDI R5, 31
	LDI R6, 3
	LDI R8, 28
	LDI R9, 1
	SUB R10, R1, R0
	H LDI R15, %hi(.LBB53_7)
	SLT ADI R15, %lo(.LBB53_7)
	BRH EQ, R15
; %bb.5:                                ; %.preheader2
	ADI R2, 1
.LBB53_6:                               ; =>This Inner Loop Header: Depth=1
	AND R10, R5, R11
	LSH R9, R11, R11
	RSH R10, R6, R10
	AND R10, R8, R10
	ADD R4, R10, R10
	INT LOD R10, R12, 0
	NOR R12, R11, R11
	NOR R11, R11, R11
	INT STR R10, R11, 0
	CHAR LOD R2, R10, 0
	ADI R2, 1
	SUB R10, R1, R0
	H LDI R15, %hi(.LBB53_6)
	SLT ADI R15, %lo(.LBB53_6)
	BRH NE, R15
.LBB53_7:
	ADI R3, 1
	LDI R2, 0
	H LDI R2, strtok.last_token
	SLT ADI R2, strtok.last_token
.LBB53_8:                               ; =>This Inner Loop Header: Depth=1
	AND R7, R5, R10
	RSH R7, R6, R11
	AND R11, R8, R11
	ADD R4, R11, R11
	INT LOD R11, R11, 0
	RSH R11, R10, R10
	AND R10, R9, R10
	SUB R10, R1, R0
	H LDI R15, %hi(.LBB53_9)
	SLT ADI R15, %lo(.LBB53_9)
	BRH EQ, R15
; %bb.15:                               ;   in Loop: Header=BB53_8 Depth=1
	INT STR R2, R3, 0
	CHAR LOD R3, R7, 0
	ADI R3, 1
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB53_8)
	SLT ADI R15, %lo(.LBB53_8)
	BRH NE, R15
	H LDI R15, %hi(.LBB53_14)
	SLT ADI R15, %lo(.LBB53_14)
	JMP R15
.LBB53_9:                               ; %.preheader
	SLT ADD R3, R0, R2
	ADI R2, -1
	LDI R10, 0
	H LDI R10, strtok.last_token
	SLT ADI R10, strtok.last_token
.LBB53_10:                              ; =>This Inner Loop Header: Depth=1
	AND R7, R5, R11
	RSH R7, R6, R7
	AND R7, R8, R7
	ADD R4, R7, R7
	INT LOD R7, R7, 0
	RSH R7, R11, R7
	AND R7, R9, R7
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB53_11)
	SLT ADI R15, %lo(.LBB53_11)
	BRH NE, R15
; %bb.12:                               ;   in Loop: Header=BB53_10 Depth=1
	INT STR R10, R3, 0
	CHAR LOD R3, R7, 0
	ADI R3, 1
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB53_10)
	SLT ADI R15, %lo(.LBB53_10)
	BRH NE, R15
	H LDI R15, %hi(.LBB53_13)
	SLT ADI R15, %lo(.LBB53_13)
	JMP R15
.LBB53_11:
	CHAR STR R3, R1, -1
	LDI R1, 0
	H LDI R1, strtok.last_token
	SLT ADI R1, strtok.last_token
	INT STR R1, R3, 0
.LBB53_13:
	SLT ADD R2, R0, R1
.LBB53_14:
	INT LOD R14, R12, -52
	INT LOD R14, R11, -48
	INT LOD R14, R10, -44
	INT LOD R14, R9, -40
	INT LOD R14, R8, -36
	SLT ADI R14, -56
	RET
.Lfunc_end53:
	.size	strtok, .Lfunc_end53-strtok
                                        ; -- End function
	.globl	allocatePool                    ; -- Begin function allocatePool
	.type	allocatePool,@function
allocatePool:                           ; @allocatePool
; %bb.0:
	SLT ADI R14, 40
	INT STR R14, R8, -16
	INT STR R14, R9, -20
	INT STR R14, R10, -24
	INT STR R14, R11, -28
	INT STR R14, R12, -32
	INT STR R14, R13, -36
	SLT ADD R1, R0, R4
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	SLT ADD R2, R0, R5
	ADI R5, -4089
	LDI R6, 0
	H LDI R6, 0
	SLT ADI R6, -4088
	SUB R5, R6, R0
	H LDI R15, %hi(.LBB54_20)
	SLT ADI R15, %lo(.LBB54_20)
	BRH C, R15
; %bb.1:
	LDI R5, 6
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB54_20)
	SLT ADI R15, %lo(.LBB54_20)
	BRH C, R15
; %bb.2:
	LDI R10, 0
	SUB R3, R10, R0
	H LDI R15, %hi(.LBB54_20)
	SLT ADI R15, %lo(.LBB54_20)
	BRH EQ, R15
; %bb.3:
	;APP
	CYE SR8, R1
	;NO_APP
	INT STR R14, R1, -8
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -5
	AND R1, R5, R1
	;APP
	CYR R1, SR8
	;NO_APP
	ADI R2, 3
	LDI R1, 8188
	AND R2, R1, R12
	LDI R7, 0
	H LDI R7, poolFreeList
	SLT ADI R7, poolFreeList
	SLT ADD R12, R0, R13
	ADI R13, 8
	LDI R1, 16
	LDI R2, 24
	LDI R11, 8
	SLT ADD R10, R0, R5
.LBB54_4:                               ; =>This Inner Loop Header: Depth=1
	SLT ADD R5, R0, R6
	CHAR LOD R7, R5, 2
	LSH R5, R1, R5
	CHAR LOD R7, R8, 3
	LSH R8, R2, R8
	NOR R8, R5, R5
	CHAR LOD R7, R8, 1
	LSH R8, R11, R8
	CHAR LOD R7, R7, 0
	NOR R8, R7, R7
	NOR R5, R5, R5
	NOR R7, R7, R7
	NOR R5, R7, R5
	NOR R5, R5, R5
	SUB R5, R10, R0
	H LDI R15, %hi(.LBB54_12)
	SLT ADI R15, %lo(.LBB54_12)
	BRH EQ, R15
; %bb.5:                                ;   in Loop: Header=BB54_4 Depth=1
	CHAR LOD R5, R7, 6
	LSH R7, R1, R7
	CHAR LOD R5, R8, 7
	LSH R8, R2, R8
	NOR R8, R7, R7
	CHAR LOD R5, R8, 5
	LSH R8, R11, R8
	CHAR LOD R5, R9, 4
	NOR R8, R9, R8
	NOR R7, R7, R7
	NOR R8, R8, R8
	NOR R7, R8, R7
	NOR R7, R7, R8
	SLT ADD R5, R0, R7
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB54_4)
	SLT ADI R15, %lo(.LBB54_4)
	BRH C, R15
; %bb.6:
	SLT ADD R12, R0, R4
	ADI R4, 12
	SUB R8, R4, R0
	H LDI R15, %hi(.LBB54_7)
	SLT ADI R15, %lo(.LBB54_7)
	BRH NC, R15
; %bb.9:
	CHAR LOD R5, R4, 2
	LSH R4, R1, R4
	CHAR LOD R5, R7, 3
	LSH R7, R2, R7
	NOR R7, R4, R4
	CHAR LOD R5, R7, 1
	LSH R7, R11, R7
	CHAR LOD R5, R8, 0
	NOR R7, R8, R7
	NOR R4, R4, R4
	NOR R7, R7, R7
	NOR R4, R7, R4
	NOR R4, R4, R4
	SUB R6, R10, R0
	H LDI R15, %hi(.LBB54_8)
	SLT ADI R15, %lo(.LBB54_8)
	BRH NE, R15
.LBB54_10:
	LDI R1, 0
	H LDI R1, poolFreeList
	SLT ADI R1, poolFreeList
	INT STR R1, R4, 0
	H LDI R15, %hi(.LBB54_11)
	SLT ADI R15, %lo(.LBB54_11)
	JMP R15
.LBB54_12:
	LDI R5, 0
	H LDI R5, poolRemaining
	SLT ADI R5, poolRemaining
	INT LOD R5, R6, 0
	LDI R5, 0
	H LDI R5, poolBump
	SLT ADI R5, poolBump
	INT LOD R5, R5, 0
	SUB R5, R10, R0
	H LDI R15, %hi(.LBB54_14)
	SLT ADI R15, %lo(.LBB54_14)
	BRH EQ, R15
; %bb.13:
	SUB R6, R13, R0
	H LDI R15, %hi(.LBB54_19)
	SLT ADI R15, %lo(.LBB54_19)
	BRH NC, R15
.LBB54_14:
	INT STR R14, R3, -4
	SUB R5, R10, R0
	H LDI R15, %hi(.LBB54_17)
	SLT ADI R15, %lo(.LBB54_17)
	BRH EQ, R15
; %bb.15:
	LDI R3, 12
	SUB R6, R3, R0
	H LDI R15, %hi(.LBB54_17)
	SLT ADI R15, %lo(.LBB54_17)
	BRH C, R15
; %bb.16:
	ADI R6, -8
	RSH R6, R2, R3
	CHAR STR R5, R3, 7
	RSH R6, R1, R3
	CHAR STR R5, R3, 6
	CHAR STR R5, R6, 4
	RSH R6, R11, R3
	CHAR STR R5, R3, 5
	LDI R3, 0
	H LDI R3, poolFreeList
	SLT ADI R3, poolFreeList
	INT LOD R3, R6, 0
	RSH R6, R2, R2
	CHAR STR R5, R2, 3
	RSH R6, R1, R1
	CHAR STR R5, R1, 2
	CHAR STR R5, R6, 0
	RSH R6, R11, R1
	CHAR STR R5, R1, 1
	INT STR R3, R5, 0
.LBB54_17:
	LDI R1, 0
	H LDI R1, poolRemaining
	SLT ADI R1, poolRemaining
	INT STR R1, R10, 0
	LDI R1, 0
	H LDI R1, poolBump
	SLT ADI R1, poolBump
	INT STR R1, R10, 0
	ADD R14, R0, R8
	SLT ADI R8, -12
	INT STR R8, R10, 0
	LDI R3, 1
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	SLT ADD R4, R0, R2
	SLT ADD R8, R0, R4
	H LDI R15, %hi(allocatePages)
	SLT ADI R15, %lo(allocatePages)
	CAL R15
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB54_18)
	SLT ADI R15, %lo(.LBB54_18)
	BRH EQ, R15
; %bb.21:
	INT LOD R14, R1, -8
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	H LDI R15, %hi(.LBB54_20)
	SLT ADI R15, %lo(.LBB54_20)
	JMP R15
.LBB54_7:
	SUB R8, R12, R7
	ADI R7, -8
	RSH R7, R2, R8
	ADD R5, R12, R4
	CHAR STR R4, R8, 15
	RSH R7, R1, R8
	CHAR STR R4, R8, 14
	CHAR STR R4, R7, 12
	RSH R7, R11, R7
	CHAR STR R4, R7, 13
	CHAR LOD R5, R7, 0
	CHAR LOD R5, R8, 1
	CHAR LOD R5, R9, 2
	CHAR LOD R5, R13, 3
	CHAR STR R4, R13, 11
	CHAR STR R4, R9, 10
	CHAR STR R4, R8, 9
	CHAR STR R4, R7, 8
	RSH R12, R11, R7
	CHAR STR R5, R12, 4
	CHAR STR R5, R7, 5
	CHAR STR R5, R10, 6
	CHAR STR R5, R10, 7
	ADI R4, 8
	SUB R6, R10, R0
	H LDI R15, %hi(.LBB54_10)
	SLT ADI R15, %lo(.LBB54_10)
	BRH EQ, R15
.LBB54_8:
	RSH R4, R2, R2
	CHAR STR R6, R2, 3
	RSH R4, R1, R1
	CHAR STR R6, R1, 2
	CHAR STR R6, R4, 0
	RSH R4, R11, R1
	CHAR STR R6, R1, 1
.LBB54_11:
	ADI R5, 8
	INT STR R3, R5, 0
	INT LOD R14, R1, -8
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R15, %hi(.LBB54_20)
	SLT ADI R15, %lo(.LBB54_20)
	JMP R15
.LBB54_18:
	LDI R6, 4096
	INT LOD R8, R5, 0
	INT LOD R14, R3, -4
.LBB54_19:
	RSH R12, R11, R1
	CHAR STR R5, R12, 4
	CHAR STR R5, R1, 5
	CHAR STR R5, R10, 3
	CHAR STR R5, R10, 2
	CHAR STR R5, R10, 1
	CHAR STR R5, R10, 0
	CHAR STR R5, R10, 7
	CHAR STR R5, R10, 6
	SUB R6, R13, R1
	LDI R2, 0
	H LDI R2, poolRemaining
	SLT ADI R2, poolRemaining
	INT STR R2, R1, 0
	ADD R5, R13, R1
	LDI R2, 0
	H LDI R2, poolBump
	SLT ADI R2, poolBump
	INT STR R2, R1, 0
	ADI R5, 8
	INT STR R3, R5, 0
	INT LOD R14, R1, -8
	;APP
	CYR R1, SR8
	;NO_APP
	SLT ADD R10, R0, R1
.LBB54_20:
	INT LOD R14, R13, -36
	INT LOD R14, R12, -32
	INT LOD R14, R11, -28
	INT LOD R14, R10, -24
	INT LOD R14, R9, -20
	INT LOD R14, R8, -16
	SLT ADI R14, -40
	RET
.Lfunc_end54:
	.size	allocatePool, .Lfunc_end54-allocatePool
                                        ; -- End function
	.globl	allocatePages                   ; -- Begin function allocatePages
	.type	allocatePages,@function
allocatePages:                          ; @allocatePages
; %bb.0:
	SLT ADI R14, 52
	INT STR R14, R8, -28
	INT STR R14, R9, -32
	INT STR R14, R10, -36
	INT STR R14, R11, -40
	INT STR R14, R12, -44
	INT STR R14, R13, -48
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -1
	LDI R8, 0
	SUB R3, R8, R0
	H LDI R15, %hi(.LBB55_27)
	SLT ADI R15, %lo(.LBB55_27)
	BRH EQ, R15
; %bb.1:
	LDI R7, 6
	SUB R7, R2, R0
	H LDI R15, %hi(.LBB55_27)
	SLT ADI R15, %lo(.LBB55_27)
	BRH C, R15
; %bb.2:
	SUB R4, R8, R0
	H LDI R15, %hi(.LBB55_27)
	SLT ADI R15, %lo(.LBB55_27)
	BRH EQ, R15
; %bb.3:
	INT STR R14, R2, -20
	;APP
	CYE SR8, R5
	;NO_APP
	INT STR R14, R5, -24
	;APP
	CYE SR8, R5
	;NO_APP
	LDI R6, 0
	H LDI R6, 0
	SLT ADI R6, -5
	AND R5, R6, R5
	;APP
	CYR R5, SR8
	;NO_APP
	LDI R5, 0
	H LDI R5, varMap
	SLT ADI R5, varMap
	INT LOD R5, R2, 0
	SUB R2, R8, R0
	H LDI R15, %hi(.LBB55_5)
	SLT ADI R15, %lo(.LBB55_5)
	BRH EQ, R15
; %bb.4:
	LDI R5, 0
	H LDI R5, mapEntries
	SLT ADI R5, mapEntries
	INT LOD R5, R7, 0
	SUB R7, R8, R0
	H LDI R15, %hi(.LBB55_6)
	SLT ADI R15, %lo(.LBB55_6)
	BRH NE, R15
	H LDI R15, %hi(.LBB55_25)
	SLT ADI R15, %lo(.LBB55_25)
	JMP R15
.LBB55_5:
	LDI R2, 8192
	INT STR R5, R2, 0
	INT STR R2, R2, 0
	LDI R5, 255
	LDI R9, 8196
	INT STR R9, R5, 0
	LDI R9, 4096
	LDI R10, 8200
	INT STR R10, R9, 0
	LDI R10, 1
	LDI R11, 8204
	INT STR R11, R10, 0
	LDI R11, 0
	H LDI R11, 65248
	SLT ADI R11, -12288
	LDI R12, 8208
	INT STR R12, R11, 0
	LDI R11, 8212
	INT STR R11, R5, 0
	LDI R11, 8216
	INT STR R11, R9, 0
	LDI R9, 8220
	INT STR R9, R7, 0
	LDI R9, 0
	H LDI R9, 272
	SLT ADI R9, -4096
	LDI R11, 8224
	INT STR R11, R9, 0
	LDI R9, 8228
	INT STR R9, R5, 0
	LDI R5, 0
	H LDI R5, 16
	SLT ADI R5, 0
	LDI R9, 8232
	INT STR R9, R5, 0
	LDI R5, 8236
	INT STR R5, R10, 0
	LDI R5, 0
	H LDI R5, mapEntries
	SLT ADI R5, mapEntries
	INT STR R5, R7, 0
.LBB55_6:
	LDI R5, 12
	LSH R3, R5, R3
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -1
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB55_17)
	SLT ADI R15, %lo(.LBB55_17)
	BRH EQ, R15
; %bb.7:
	LDI R5, 4095
	AND R1, R5, R5
	SUB R5, R8, R0
	H LDI R15, %hi(.LBB55_25)
	SLT ADI R15, %lo(.LBB55_25)
	BRH NE, R15
; %bb.8:                                ; %.preheader6
	ADD R3, R1, R5
	INT STR R14, R5, -16
	LDI R9, 0
	SLT ADD R2, R0, R12
	ADI R12, 4
	LDI R13, 255
	SLT ADD R9, R0, R5
	H LDI R15, %hi(.LBB55_11)
	SLT ADI R15, %lo(.LBB55_11)
	JMP R15
.LBB55_9:                               ;   in Loop: Header=BB55_11 Depth=1
	ADD R10, R5, R5
.LBB55_10:                              ;   in Loop: Header=BB55_11 Depth=1
	ADI R12, 8
	ADI R9, 1
	SUB R7, R9, R0
	H LDI R15, %hi(.LBB55_25)
	SLT ADI R15, %lo(.LBB55_25)
	BRH EQ, R15
.LBB55_11:                              ; =>This Inner Loop Header: Depth=1
	INT LOD R12, R10, -4
	INT LOD R12, R11, 0
	SUB R11, R13, R0
	H LDI R15, %hi(.LBB55_9)
	SLT ADI R15, %lo(.LBB55_9)
	BRH NE, R15
; %bb.12:                               ;   in Loop: Header=BB55_11 Depth=1
	ADD R10, R5, R11
	SUB R10, R3, R0
	H LDI R15, %hi(.LBB55_16)
	SLT ADI R15, %lo(.LBB55_16)
	BRH C, R15
; %bb.13:                               ;   in Loop: Header=BB55_11 Depth=1
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB55_16)
	SLT ADI R15, %lo(.LBB55_16)
	BRH C, R15
; %bb.14:                               ;   in Loop: Header=BB55_11 Depth=1
	SLT ADD R11, R0, R5
	INT LOD R14, R6, -16
	SUB R11, R6, R0
	H LDI R15, %hi(.LBB55_10)
	SLT ADI R15, %lo(.LBB55_10)
	BRH C, R15
	H LDI R15, %hi(.LBB55_21)
	SLT ADI R15, %lo(.LBB55_21)
	JMP R15
.LBB55_16:                              ;   in Loop: Header=BB55_11 Depth=1
	SLT ADD R11, R0, R5
	H LDI R15, %hi(.LBB55_10)
	SLT ADI R15, %lo(.LBB55_10)
	JMP R15
.LBB55_17:                              ; %.preheader3
	LDI R9, 0
	SLT ADD R2, R0, R5
	ADI R5, 4
	LDI R11, 255
	SLT ADD R9, R0, R1
	H LDI R15, %hi(.LBB55_19)
	SLT ADI R15, %lo(.LBB55_19)
	JMP R15
.LBB55_18:                              ;   in Loop: Header=BB55_19 Depth=1
	ADD R10, R1, R1
	ADI R5, 8
	ADI R9, 1
	SUB R7, R9, R0
	H LDI R15, %hi(.LBB55_25)
	SLT ADI R15, %lo(.LBB55_25)
	BRH EQ, R15
.LBB55_19:                              ; =>This Inner Loop Header: Depth=1
	INT LOD R5, R10, -4
	INT LOD R5, R12, 0
	SUB R12, R11, R0
	H LDI R15, %hi(.LBB55_18)
	SLT ADI R15, %lo(.LBB55_18)
	BRH NE, R15
; %bb.20:                               ;   in Loop: Header=BB55_19 Depth=1
	SUB R10, R3, R0
	H LDI R15, %hi(.LBB55_18)
	SLT ADI R15, %lo(.LBB55_18)
	BRH C, R15
.LBB55_21:
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -1
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB55_25)
	SLT ADI R15, %lo(.LBB55_25)
	BRH EQ, R15
; %bb.22:
	INT STR R14, R4, -16
	SUB R9, R8, R0
	H LDI R15, %hi(.LBB55_28)
	SLT ADI R15, %lo(.LBB55_28)
	BRH EQ, R15
; %bb.23:                               ; %.preheader1
	SLT ADD R2, R0, R5
	SLT ADD R9, R0, R12
	SLT ADD R8, R0, R11
.LBB55_24:                              ; =>This Inner Loop Header: Depth=1
	INT LOD R5, R4, 0
	ADD R4, R11, R11
	ADI R5, 8
	ADI R12, -1
	SUB R12, R8, R0
	H LDI R15, %hi(.LBB55_24)
	SLT ADI R15, %lo(.LBB55_24)
	BRH NE, R15
	H LDI R15, %hi(.LBB55_29)
	SLT ADI R15, %lo(.LBB55_29)
	JMP R15
.LBB55_25:
	INT LOD R14, R1, -24
	;APP
	CYR R1, SR8
	;NO_APP
.LBB55_26:
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -1
.LBB55_27:
	SLT ADD R5, R0, R1
	INT LOD R14, R13, -48
	INT LOD R14, R12, -44
	INT LOD R14, R11, -40
	INT LOD R14, R10, -36
	INT LOD R14, R9, -32
	INT LOD R14, R8, -28
	SLT ADI R14, -52
	RET
.LBB55_28:
	SLT ADD R8, R0, R11
.LBB55_29:
	LDI R5, 1
	SLT ADD R5, R0, R12
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB55_31)
	SLT ADI R15, %lo(.LBB55_31)
	BRH NE, R15
; %bb.30:
	SLT ADD R8, R0, R12
.LBB55_31:
	SUB R1, R11, R13
	ADD R13, R3, R4
	SUB R10, R4, R0
	H LDI R15, %hi(.LBB55_33)
	SLT ADI R15, %lo(.LBB55_33)
	BRH NE, R15
; %bb.32:
	SLT ADD R8, R0, R5
.LBB55_33:
	ADD R5, R12, R5
	ADD R5, R7, R8
	LDI R12, 512
	SUB R12, R8, R0
	H LDI R15, %hi(.LBB55_35)
	SLT ADI R15, %lo(.LBB55_35)
	BRH NC, R15
; %bb.34:
	INT LOD R14, R1, -24
	;APP
	CYR R1, SR8
	;NO_APP
	H LDI R15, %hi(.LBB55_26)
	SLT ADI R15, %lo(.LBB55_26)
	JMP R15
.LBB55_35:
	INT STR R14, R13, -4
	INT STR R14, R8, -12
	INT STR R14, R4, -8
	LDI R12, 0
	SUB R5, R12, R0
	H LDI R15, %hi(.LBB55_39)
	SLT ADI R15, %lo(.LBB55_39)
	BRH EQ, R15
; %bb.36:
	ADD R5, R9, R4
	INT LOD R14, R5, -12
	ADI R5, -1
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB55_39)
	SLT ADI R15, %lo(.LBB55_39)
	BRH NC, R15
; %bb.37:                               ; %.preheader
	INT LOD R14, R8, -12
	LDI R12, 3
	SLT ADD R12, R0, R13
	LSH R8, R13, R12
	LSH R7, R13, R7
	ADD R7, R2, R7
	ADD R12, R2, R12
	ADI R12, -8
	ADI R7, -8
.LBB55_38:                              ; =>This Inner Loop Header: Depth=1
	INT LOD R7, R8, 0
	INT LOD R7, R13, 4
	INT STR R12, R13, 4
	INT STR R12, R8, 0
	ADI R12, -8
	ADI R7, -8
	ADI R5, -1
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB55_38)
	SLT ADI R15, %lo(.LBB55_38)
	BRH C, R15
.LBB55_39:
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB55_41)
	SLT ADI R15, %lo(.LBB55_41)
	BRH EQ, R15
; %bb.40:
	LDI R11, 3
	LSH R9, R11, R4
	ADD R2, R4, R4
	LDI R5, 255
	INT STR R4, R5, 4
	INT LOD R14, R5, -4
	INT STR R4, R5, 0
	ADI R9, 1
	INT LOD R14, R7, -24
	INT LOD R14, R8, -8
	H LDI R15, %hi(.LBB55_42)
	SLT ADI R15, %lo(.LBB55_42)
	JMP R15
.LBB55_41:
	INT LOD R14, R7, -24
	INT LOD R14, R8, -8
	LDI R11, 3
.LBB55_42:
	INT LOD R14, R6, -20
	LSH R9, R11, R4
	ADD R2, R4, R5
	INT STR R5, R6, 4
	INT STR R5, R3, 0
	SUB R10, R8, R0
	H LDI R15, %hi(.LBB55_44)
	SLT ADI R15, %lo(.LBB55_44)
	BRH EQ, R15
; %bb.43:
	SUB R10, R8, R2
	LDI R3, 255
	INT STR R5, R3, 12
	INT STR R5, R2, 8
.LBB55_44:
	LDI R2, 0
	H LDI R2, mapEntries
	SLT ADI R2, mapEntries
	INT LOD R14, R3, -12
	INT STR R2, R3, 0
	INT LOD R14, R2, -16
	INT STR R2, R1, 0
	;APP
	CYR R7, SR8
	;NO_APP
	LDI R5, 0
	H LDI R15, %hi(.LBB55_27)
	SLT ADI R15, %lo(.LBB55_27)
	JMP R15
.Lfunc_end55:
	.size	allocatePages, .Lfunc_end55-allocatePages
                                        ; -- End function
	.globl	freePool                        ; -- Begin function freePool
	.type	freePool,@function
freePool:                               ; @freePool
; %bb.0:
	SLT ADI R14, 36
	INT STR R14, R8, -12
	INT STR R14, R9, -16
	INT STR R14, R10, -20
	INT STR R14, R11, -24
	INT STR R14, R12, -28
	INT STR R14, R13, -32
	LDI R9, 0
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB56_29)
	SLT ADI R15, %lo(.LBB56_29)
	BRH EQ, R15
; %bb.1:
	INT LOD R1, R2, 0
	SUB R2, R9, R0
	H LDI R15, %hi(.LBB56_29)
	SLT ADI R15, %lo(.LBB56_29)
	BRH EQ, R15
; %bb.2:
	;APP
	CYE SR8, R8
	;NO_APP
	;APP
	CYE SR8, R2
	;NO_APP
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -5
	AND R2, R3, R2
	;APP
	CYR R2, SR8
	;NO_APP
	INT LOD R1, R2, 0
	INT STR R1, R9, 0
	LDI R3, 0
	H LDI R3, poolFreeList
	SLT ADI R3, poolFreeList
	SLT ADD R2, R0, R10
	ADI R10, -8
	LDI R13, 16
	LDI R12, 24
	LDI R11, 8
	SLT ADD R9, R0, R4
.LBB56_3:                               ; =>This Inner Loop Header: Depth=1
	SLT ADD R4, R0, R1
	CHAR LOD R3, R4, 2
	LSH R4, R13, R4
	CHAR LOD R3, R5, 3
	LSH R5, R12, R5
	NOR R5, R4, R4
	CHAR LOD R3, R5, 1
	LSH R5, R11, R5
	CHAR LOD R3, R3, 0
	NOR R5, R3, R3
	NOR R4, R4, R4
	NOR R3, R3, R3
	NOR R4, R3, R3
	NOR R3, R3, R4
	SUB R4, R9, R0
	H LDI R15, %hi(.LBB56_5)
	SLT ADI R15, %lo(.LBB56_5)
	BRH EQ, R15
; %bb.4:                                ;   in Loop: Header=BB56_3 Depth=1
	SLT ADD R4, R0, R3
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB56_3)
	SLT ADI R15, %lo(.LBB56_3)
	BRH C, R15
.LBB56_5:
	RSH R4, R12, R3
	CHAR STR R10, R3, 3
	RSH R4, R13, R3
	CHAR STR R10, R3, 2
	CHAR STR R10, R4, 0
	RSH R4, R11, R3
	CHAR STR R10, R3, 1
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB56_7)
	SLT ADI R15, %lo(.LBB56_7)
	BRH EQ, R15
; %bb.6:
	RSH R10, R12, R3
	CHAR STR R1, R3, 3
	RSH R10, R13, R3
	CHAR STR R1, R3, 2
	CHAR STR R1, R10, 0
	RSH R10, R11, R3
	CHAR STR R1, R3, 1
	H LDI R15, %hi(.LBB56_8)
	SLT ADI R15, %lo(.LBB56_8)
	JMP R15
.LBB56_7:
	LDI R3, 0
	H LDI R3, poolFreeList
	SLT ADI R3, poolFreeList
	INT STR R3, R10, 0
.LBB56_8:
	CHAR LOD R10, R3, 2
	LSH R3, R13, R3
	CHAR LOD R10, R4, 3
	LSH R4, R12, R4
	NOR R4, R3, R3
	CHAR LOD R10, R4, 1
	LSH R4, R11, R4
	CHAR LOD R10, R5, 0
	NOR R4, R5, R4
	NOR R3, R3, R3
	NOR R4, R4, R4
	NOR R3, R4, R3
	NOR R3, R3, R4
	LDI R3, 4095
	SUB R4, R9, R0
	H LDI R15, %hi(.LBB56_9)
	SLT ADI R15, %lo(.LBB56_9)
	BRH EQ, R15
; %bb.10:
	CHAR LOD R2, R5, -2
	LSH R5, R13, R5
	CHAR LOD R2, R6, -1
	LSH R6, R12, R6
	NOR R6, R5, R5
	CHAR LOD R2, R6, -3
	LSH R6, R11, R6
	CHAR LOD R2, R7, -4
	NOR R6, R7, R6
	NOR R5, R5, R5
	NOR R6, R6, R6
	NOR R5, R6, R5
	NOR R5, R5, R5
	ADD R2, R5, R6
	SUB R6, R4, R0
	H LDI R15, %hi(.LBB56_13)
	SLT ADI R15, %lo(.LBB56_13)
	BRH NE, R15
; %bb.11:
	XOR R4, R10, R6
	SUB R3, R6, R0
	H LDI R15, %hi(.LBB56_13)
	SLT ADI R15, %lo(.LBB56_13)
	BRH C, R15
; %bb.12:
	CHAR LOD R4, R6, 6
	LSH R6, R13, R6
	CHAR LOD R4, R7, 7
	LSH R7, R12, R7
	NOR R7, R6, R6
	CHAR LOD R4, R7, 5
	LSH R7, R11, R7
	SLT ADD R8, R0, R3
	CHAR LOD R4, R8, 4
	NOR R7, R8, R7
	NOR R6, R6, R6
	NOR R7, R7, R7
	NOR R6, R7, R6
	NOR R6, R6, R6
	ADD R5, R6, R5
	ADI R5, 8
	RSH R5, R12, R6
	CHAR STR R2, R6, -1
	RSH R5, R13, R6
	CHAR STR R2, R6, -2
	CHAR STR R2, R5, -4
	RSH R5, R11, R5
	CHAR STR R2, R5, -3
	CHAR LOD R4, R5, 3
	LSH R5, R12, R6
	CHAR LOD R4, R7, 0
	CHAR LOD R4, R8, 1
	CHAR LOD R4, R4, 2
	CHAR STR R2, R5, -5
	LSH R4, R13, R5
	CHAR STR R2, R4, -6
	CHAR STR R2, R8, -7
	CHAR STR R2, R7, -8
	NOR R6, R5, R4
	LSH R8, R11, R5
	SLT ADD R3, R0, R8
	LDI R3, 4095
	NOR R5, R7, R5
	NOR R4, R4, R4
	NOR R5, R5, R5
	NOR R4, R5, R4
	NOR R4, R4, R4
.LBB56_13:
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB56_14)
	SLT ADI R15, %lo(.LBB56_14)
	BRH NE, R15
	H LDI R15, %hi(.LBB56_17)
	SLT ADI R15, %lo(.LBB56_17)
	JMP R15
.LBB56_9:
	SLT ADD R9, R0, R4
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB56_17)
	SLT ADI R15, %lo(.LBB56_17)
	BRH EQ, R15
.LBB56_14:
	CHAR LOD R1, R5, 6
	LSH R5, R13, R5
	CHAR LOD R1, R6, 7
	LSH R6, R12, R6
	NOR R6, R5, R5
	CHAR LOD R1, R6, 5
	LSH R6, R11, R6
	CHAR LOD R1, R7, 4
	NOR R6, R7, R6
	NOR R5, R5, R5
	NOR R6, R6, R6
	NOR R5, R6, R5
	NOR R5, R5, R5
	ADD R1, R5, R6
	ADI R6, 8
	SUB R6, R10, R0
	H LDI R15, %hi(.LBB56_17)
	SLT ADI R15, %lo(.LBB56_17)
	BRH NE, R15
; %bb.15:
	XOR R1, R10, R6
	SUB R3, R6, R0
	H LDI R15, %hi(.LBB56_17)
	SLT ADI R15, %lo(.LBB56_17)
	BRH C, R15
; %bb.16:
	CHAR LOD R2, R6, -2
	LSH R6, R13, R6
	CHAR LOD R2, R7, -1
	LSH R7, R12, R7
	NOR R7, R6, R6
	CHAR LOD R2, R7, -3
	LSH R7, R11, R7
	CHAR LOD R2, R2, -4
	NOR R7, R2, R2
	NOR R6, R6, R6
	NOR R2, R2, R2
	NOR R6, R2, R2
	NOR R2, R2, R2
	ADD R5, R2, R2
	RSH R4, R13, R5
	CHAR STR R1, R5, 2
	RSH R4, R12, R5
	CHAR STR R1, R5, 3
	CHAR STR R1, R4, 0
	RSH R4, R11, R4
	CHAR STR R1, R4, 1
	ADI R2, 8
	RSH R2, R13, R4
	CHAR STR R1, R4, 6
	RSH R2, R12, R4
	CHAR STR R1, R4, 7
	CHAR STR R1, R2, 4
	RSH R2, R11, R2
	CHAR STR R1, R2, 5
	SLT ADD R1, R0, R10
.LBB56_17:
	AND R10, R3, R1
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB56_28)
	SLT ADI R15, %lo(.LBB56_28)
	BRH NE, R15
; %bb.18:
	CHAR LOD R10, R1, 6
	LSH R1, R13, R1
	CHAR LOD R10, R2, 7
	LSH R2, R12, R2
	NOR R2, R1, R1
	CHAR LOD R10, R2, 5
	LSH R2, R11, R2
	CHAR LOD R10, R3, 4
	NOR R2, R3, R2
	NOR R1, R1, R1
	NOR R2, R2, R2
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 4088
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB56_28)
	SLT ADI R15, %lo(.LBB56_28)
	BRH NE, R15
; %bb.19:
	INT STR R14, R8, -4
	ADD R14, R0, R8
	SLT ADI R8, -8
	INT STR R8, R10, 0
	LDI R1, 1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(freePages)
	SLT ADI R15, %lo(freePages)
	CAL R15
	INT LOD R8, R1, 0
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB56_27)
	SLT ADI R15, %lo(.LBB56_27)
	BRH NE, R15
; %bb.20:
	LDI R1, 0
	H LDI R1, poolFreeList
	SLT ADI R1, poolFreeList
	INT LOD R1, R2, 0
	SUB R10, R2, R0
	H LDI R15, %hi(.LBB56_21)
	SLT ADI R15, %lo(.LBB56_21)
	BRH EQ, R15
.LBB56_22:                              ; =>This Inner Loop Header: Depth=1
	SLT ADD R2, R0, R1
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB56_25)
	SLT ADI R15, %lo(.LBB56_25)
	BRH EQ, R15
; %bb.23:                               ;   in Loop: Header=BB56_22 Depth=1
	CHAR LOD R1, R2, 2
	LSH R2, R13, R2
	CHAR LOD R1, R3, 3
	LSH R3, R12, R3
	NOR R3, R2, R2
	CHAR LOD R1, R3, 1
	LSH R3, R11, R3
	CHAR LOD R1, R4, 0
	NOR R3, R4, R3
	NOR R2, R2, R2
	NOR R3, R3, R3
	NOR R2, R3, R2
	NOR R2, R2, R2
	SUB R2, R10, R0
	H LDI R15, %hi(.LBB56_22)
	SLT ADI R15, %lo(.LBB56_22)
	BRH NE, R15
; %bb.24:
	CHAR LOD R10, R2, 1
	CHAR LOD R10, R3, 0
	CHAR LOD R10, R4, 3
	CHAR LOD R10, R5, 2
	CHAR STR R1, R5, 2
	CHAR STR R1, R4, 3
	CHAR STR R1, R3, 0
	CHAR STR R1, R2, 1
	H LDI R15, %hi(.LBB56_25)
	SLT ADI R15, %lo(.LBB56_25)
	JMP R15
.LBB56_21:
	CHAR LOD R10, R2, 2
	LSH R2, R13, R2
	CHAR LOD R10, R3, 3
	LSH R3, R12, R3
	NOR R3, R2, R2
	CHAR LOD R10, R3, 1
	LSH R3, R11, R3
	CHAR LOD R10, R4, 0
	NOR R3, R4, R3
	NOR R2, R2, R2
	NOR R3, R3, R3
	NOR R2, R3, R2
	NOR R2, R2, R2
	INT STR R1, R2, 0
.LBB56_25:
	LDI R1, 0
	H LDI R1, poolBump
	SLT ADI R1, poolBump
	INT LOD R1, R2, 0
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -4096
	AND R2, R3, R2
	SUB R2, R10, R0
	H LDI R15, %hi(.LBB56_27)
	SLT ADI R15, %lo(.LBB56_27)
	BRH NE, R15
; %bb.26:
	LDI R2, 0
	H LDI R2, poolRemaining
	SLT ADI R2, poolRemaining
	INT STR R2, R9, 0
	INT STR R1, R9, 0
.LBB56_27:
	INT LOD R14, R8, -4
.LBB56_28:
	;APP
	CYR R8, SR8
	;NO_APP
.LBB56_29:
	INT LOD R14, R13, -32
	INT LOD R14, R12, -28
	INT LOD R14, R11, -24
	INT LOD R14, R10, -20
	INT LOD R14, R9, -16
	INT LOD R14, R8, -12
	SLT ADI R14, -36
	RET
.Lfunc_end56:
	.size	freePool, .Lfunc_end56-freePool
                                        ; -- End function
	.globl	freePages                       ; -- Begin function freePages
	.type	freePages,@function
freePages:                              ; @freePages
; %bb.0:
	SLT ADI R14, 56
	INT STR R14, R8, -32
	INT STR R14, R9, -36
	INT STR R14, R10, -40
	INT STR R14, R11, -44
	INT STR R14, R12, -48
	INT STR R14, R13, -52
	LDI R3, 0
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB57_28)
	SLT ADI R15, %lo(.LBB57_28)
	BRH EQ, R15
; %bb.1:
	SUB R1, R3, R0
	H LDI R15, %hi(.LBB57_28)
	SLT ADI R15, %lo(.LBB57_28)
	BRH EQ, R15
; %bb.2:
	INT LOD R2, R4, 0
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB57_28)
	SLT ADI R15, %lo(.LBB57_28)
	BRH EQ, R15
; %bb.3:
	INT STR R14, R2, -28
	;APP
	CYE SR8, R2
	;NO_APP
	;APP
	CYE SR8, R4
	;NO_APP
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -5
	AND R4, R5, R4
	;APP
	CYR R4, SR8
	;NO_APP
	LDI R4, 0
	H LDI R4, varMap
	SLT ADI R4, varMap
	INT LOD R4, R5, 0
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB57_4)
	SLT ADI R15, %lo(.LBB57_4)
	BRH EQ, R15
; %bb.5:
	LDI R4, 0
	H LDI R4, mapEntries
	SLT ADI R4, mapEntries
	INT LOD R4, R10, 0
	SUB R10, R3, R0
	H LDI R15, %hi(.LBB57_6)
	SLT ADI R15, %lo(.LBB57_6)
	BRH NE, R15
.LBB57_10:
	;APP
	CYR R2, SR8
	;NO_APP
	H LDI R15, %hi(.LBB57_28)
	SLT ADI R15, %lo(.LBB57_28)
	JMP R15
.LBB57_4:
	LDI R5, 8192
	INT STR R4, R5, 0
	INT STR R5, R5, 0
	LDI R4, 255
	LDI R5, 8196
	INT STR R5, R4, 0
	LDI R5, 4096
	LDI R6, 8200
	INT STR R6, R5, 0
	LDI R6, 1
	LDI R7, 8204
	INT STR R7, R6, 0
	LDI R7, 0
	H LDI R7, 65248
	SLT ADI R7, -12288
	LDI R8, 8208
	INT STR R8, R7, 0
	LDI R7, 8212
	INT STR R7, R4, 0
	LDI R7, 8216
	INT STR R7, R5, 0
	LDI R10, 6
	LDI R5, 8220
	INT STR R5, R10, 0
	LDI R5, 0
	H LDI R5, 272
	SLT ADI R5, -4096
	LDI R7, 8224
	INT STR R7, R5, 0
	LDI R5, 8228
	INT STR R5, R4, 0
	LDI R4, 0
	H LDI R4, 16
	SLT ADI R4, 0
	LDI R5, 8232
	INT STR R5, R4, 0
	LDI R4, 8236
	INT STR R4, R6, 0
	LDI R4, 0
	H LDI R4, mapEntries
	SLT ADI R4, mapEntries
	INT STR R4, R10, 0
.LBB57_6:
	LDI R4, 12
	LSH R1, R4, R1
	SUB R3, R10, R8
	LDI R4, 0
	H LDI R4, varMap
	SLT ADI R4, varMap
	INT LOD R4, R6, 0
	INT LOD R14, R4, -28
	INT LOD R4, R7, 0
	INT STR R14, R6, -24
	SLT ADD R3, R0, R5
	SLT ADD R3, R0, R9
	H LDI R15, %hi(.LBB57_7)
	SLT ADI R15, %lo(.LBB57_7)
	JMP R15
.LBB57_8:                               ;   in Loop: Header=BB57_7 Depth=1
	INT LOD R6, R11, 0
.LBB57_9:                               ;   in Loop: Header=BB57_7 Depth=1
	ADD R11, R9, R9
	ADI R6, 8
	ADI R5, -1
	SUB R8, R5, R0
	H LDI R15, %hi(.LBB57_10)
	SLT ADI R15, %lo(.LBB57_10)
	BRH EQ, R15
.LBB57_7:                               ; =>This Inner Loop Header: Depth=1
	SUB R7, R9, R0
	H LDI R15, %hi(.LBB57_8)
	SLT ADI R15, %lo(.LBB57_8)
	BRH C, R15
; %bb.11:                               ;   in Loop: Header=BB57_7 Depth=1
	SUB R7, R9, R13
	ADD R13, R1, R12
	INT LOD R6, R11, 0
	SUB R11, R12, R0
	H LDI R15, %hi(.LBB57_9)
	SLT ADI R15, %lo(.LBB57_9)
	BRH C, R15
; %bb.12:
	INT LOD R6, R4, 4
	LDI R8, 255
	INT STR R14, R4, -16
	SUB R4, R8, R0
	H LDI R15, %hi(.LBB57_27)
	SLT ADI R15, %lo(.LBB57_27)
	BRH EQ, R15
; %bb.13:
	LDI R4, 1
	SLT ADD R4, R0, R8
	SUB R9, R7, R0
	H LDI R15, %hi(.LBB57_15)
	SLT ADI R15, %lo(.LBB57_15)
	BRH NE, R15
; %bb.14:
	SLT ADD R3, R0, R8
.LBB57_15:
	SUB R11, R12, R0
	H LDI R15, %hi(.LBB57_17)
	SLT ADI R15, %lo(.LBB57_17)
	BRH NE, R15
; %bb.16:
	SLT ADD R3, R0, R4
.LBB57_17:
	ADD R4, R8, R4
	INT STR R14, R4, -20
	ADD R4, R10, R4
	LDI R8, 512
	INT STR R14, R4, -12
	SUB R8, R4, R0
	H LDI R15, %hi(.LBB57_27)
	SLT ADI R15, %lo(.LBB57_27)
	BRH C, R15
; %bb.18:
	INT STR R14, R2, -8
	SUB R3, R5, R2
	INT STR R14, R2, -4
	LDI R2, 0
	INT LOD R14, R3, -20
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB57_22)
	SLT ADI R15, %lo(.LBB57_22)
	BRH EQ, R15
; %bb.19:
	SUB R3, R5, R2
	INT LOD R14, R3, -12
	ADI R3, -1
	INT STR R14, R2, -20
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB57_22)
	SLT ADI R15, %lo(.LBB57_22)
	BRH NC, R15
; %bb.20:                               ; %.preheader
	INT LOD R14, R2, -12
	LDI R4, 3
	SLT ADD R4, R0, R8
	LSH R2, R8, R4
	LSH R10, R8, R10
	INT LOD R14, R2, -24
	ADD R10, R2, R10
	ADD R4, R2, R4
	ADI R4, -8
	ADI R10, -8
.LBB57_21:                              ; =>This Inner Loop Header: Depth=1
	INT LOD R10, R2, 0
	INT LOD R10, R8, 4
	INT STR R4, R8, 4
	INT STR R4, R2, 0
	ADI R4, -8
	ADI R10, -8
	ADI R3, -1
	INT LOD R14, R2, -20
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB57_21)
	SLT ADI R15, %lo(.LBB57_21)
	BRH C, R15
.LBB57_22:
	INT LOD R14, R3, -4
	SUB R9, R7, R0
	H LDI R15, %hi(.LBB57_24)
	SLT ADI R15, %lo(.LBB57_24)
	BRH EQ, R15
; %bb.23:
	INT LOD R14, R2, -16
	INT STR R6, R2, 4
	INT STR R6, R13, 0
	LDI R2, 1
	SUB R2, R5, R3
.LBB57_24:
	INT LOD R14, R8, -28
	LDI R2, 3
	LSH R3, R2, R2
	INT LOD R14, R3, -24
	ADD R3, R2, R2
	LDI R3, 255
	INT STR R2, R3, 4
	INT STR R2, R1, 0
	SUB R11, R12, R0
	H LDI R15, %hi(.LBB57_26)
	SLT ADI R15, %lo(.LBB57_26)
	BRH EQ, R15
; %bb.25:
	SUB R11, R12, R1
	INT LOD R14, R3, -16
	INT STR R2, R3, 12
	INT STR R2, R1, 8
.LBB57_26:
	LDI R1, 0
	H LDI R1, mapEntries
	SLT ADI R1, mapEntries
	INT LOD R14, R2, -12
	INT STR R1, R2, 0
	H LDI R15, %hi(coalesceMap)
	SLT ADI R15, %lo(coalesceMap)
	CAL R15
	LDI R1, 0
	INT STR R8, R1, 0
	INT LOD R14, R2, -8
.LBB57_27:
	;APP
	CYR R2, SR8
	;NO_APP
.LBB57_28:
	INT LOD R14, R13, -52
	INT LOD R14, R12, -48
	INT LOD R14, R11, -44
	INT LOD R14, R10, -40
	INT LOD R14, R9, -36
	INT LOD R14, R8, -32
	SLT ADI R14, -56
	RET
.Lfunc_end57:
	.size	freePages, .Lfunc_end57-freePages
                                        ; -- End function
	.type	coalesceMap,@function           ; -- Begin function coalesceMap
coalesceMap:                            ; @coalesceMap
; %bb.0:
	SLT ADI R14, 36
	INT STR R14, R8, -12
	INT STR R14, R9, -16
	INT STR R14, R10, -20
	INT STR R14, R11, -24
	INT STR R14, R12, -28
	INT STR R14, R13, -32
	LDI R1, 0
	H LDI R1, mapEntries
	SLT ADI R1, mapEntries
	INT LOD R1, R10, 0
	LDI R1, 2
	SUB R10, R1, R0
	H LDI R15, %hi(.LBB58_16)
	SLT ADI R15, %lo(.LBB58_16)
	BRH C, R15
; %bb.1:
	LDI R2, 0
	LDI R3, 1
	LDI R1, 0
	H LDI R1, varMap
	SLT ADI R1, varMap
	INT LOD R1, R4, 0
	SLT ADD R4, R0, R1
	ADI R1, -1
	INT STR R14, R1, -4
	SLT ADD R4, R0, R1
	ADI R1, 8
	INT STR R14, R1, -8
	LDI R7, 3
	SLT ADD R3, R0, R13
	SLT ADD R2, R0, R5
	H LDI R15, %hi(.LBB58_2)
	SLT ADI R15, %lo(.LBB58_2)
	JMP R15
.LBB58_14:                              ;   in Loop: Header=BB58_2 Depth=1
	SLT ADD R11, R0, R10
	LDI R1, 0
	H LDI R1, mapEntries
	SLT ADI R1, mapEntries
	INT STR R1, R10, 0
	ADI R9, -1
.LBB58_15:                              ;   in Loop: Header=BB58_2 Depth=1
	SLT ADD R9, R0, R5
	ADI R5, 1
	ADI R9, 2
	SLT ADD R9, R0, R13
	SUB R9, R10, R0
	H LDI R15, %hi(.LBB58_16)
	SLT ADI R15, %lo(.LBB58_16)
	BRH NC, R15
.LBB58_2:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB58_13 Depth 2
                                        ;     Child Loop BB58_8 Depth 2
	SLT ADD R5, R0, R9
	LSH R13, R7, R12
	LSH R9, R7, R1
	ADD R4, R1, R11
	ADD R4, R12, R5
	INT LOD R5, R1, 4
	INT LOD R11, R6, 4
	SUB R6, R1, R0
	H LDI R15, %hi(.LBB58_15)
	SLT ADI R15, %lo(.LBB58_15)
	BRH NE, R15
; %bb.3:                                ;   in Loop: Header=BB58_2 Depth=1
	INT LOD R5, R1, 0
	LDI R6, 0
	H LDI R6, 0
	SLT ADI R6, -1
	XOR R1, R6, R8
	INT LOD R11, R6, 0
	SUB R8, R6, R0
	H LDI R15, %hi(.LBB58_15)
	SLT ADI R15, %lo(.LBB58_15)
	BRH C, R15
; %bb.4:                                ;   in Loop: Header=BB58_2 Depth=1
	ADD R1, R6, R1
	INT STR R11, R1, 0
	SLT ADD R13, R0, R1
	ADI R1, 1
	SLT ADD R10, R0, R11
	ADI R11, -1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB58_14)
	SLT ADI R15, %lo(.LBB58_14)
	BRH NC, R15
; %bb.5:                                ;   in Loop: Header=BB58_2 Depth=1
	SUB R11, R13, R1
	LSH R1, R7, R1
	INT LOD R14, R6, -8
	ADD R6, R12, R13
	SUB R13, R5, R0
	H LDI R15, %hi(.LBB58_11)
	SLT ADI R15, %lo(.LBB58_11)
	BRH NC, R15
; %bb.6:                                ; %memmove_copy_backwards
                                        ;   in Loop: Header=BB58_2 Depth=1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB58_14)
	SLT ADI R15, %lo(.LBB58_14)
	BRH EQ, R15
; %bb.7:                                ; %memmove_bwd_main_loop.preheader
                                        ;   in Loop: Header=BB58_2 Depth=1
	LSH R10, R7, R1
	INT LOD R14, R5, -4
	ADD R5, R1, R10
	SUB R12, R1, R12
	ADI R12, 8
	H LDI R15, %hi(.LBB58_8)
	SLT ADI R15, %lo(.LBB58_8)
	JMP R15
.LBB58_10:                              ; %memmove_bwd_main_loop
                                        ;   in Loop: Header=BB58_8 Depth=2
	AND R1, R3, R1
	ADI R10, -1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB58_14)
	SLT ADI R15, %lo(.LBB58_14)
	BRH NE, R15
.LBB58_8:                               ; %memmove_bwd_main_loop
                                        ;   Parent Loop BB58_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	CHAR LOD R10, R1, 0
	CHAR STR R10, R1, -8
	ADI R12, 1
	SLT ADD R3, R0, R1
	SUB R12, R2, R0
	H LDI R15, %hi(.LBB58_10)
	SLT ADI R15, %lo(.LBB58_10)
	BRH EQ, R15
; %bb.9:                                ; %memmove_bwd_main_loop
                                        ;   in Loop: Header=BB58_8 Depth=2
	SLT ADD R2, R0, R1
	H LDI R15, %hi(.LBB58_10)
	SLT ADI R15, %lo(.LBB58_10)
	JMP R15
.LBB58_11:                              ; %memmove_copy_forward
                                        ;   in Loop: Header=BB58_2 Depth=1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB58_14)
	SLT ADI R15, %lo(.LBB58_14)
	BRH EQ, R15
; %bb.12:                               ; %memmove_fwd_main_loop.preheader
                                        ;   in Loop: Header=BB58_2 Depth=1
	LSH R10, R7, R1
	SUB R1, R12, R5
	ADI R5, -8
.LBB58_13:                              ; %memmove_fwd_main_loop
                                        ;   Parent Loop BB58_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	CHAR LOD R13, R1, 0
	CHAR STR R13, R1, -8
	ADI R13, 1
	ADI R5, -1
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB58_13)
	SLT ADI R15, %lo(.LBB58_13)
	BRH NE, R15
	H LDI R15, %hi(.LBB58_14)
	SLT ADI R15, %lo(.LBB58_14)
	JMP R15
.LBB58_16:
	INT LOD R14, R13, -32
	INT LOD R14, R12, -28
	INT LOD R14, R11, -24
	INT LOD R14, R10, -20
	INT LOD R14, R9, -16
	INT LOD R14, R8, -12
	SLT ADI R14, -36
	RET
.Lfunc_end58:
	.size	coalesceMap, .Lfunc_end58-coalesceMap
                                        ; -- End function
	.globl	allocateIOMemory                ; -- Begin function allocateIOMemory
	.type	allocateIOMemory,@function
allocateIOMemory:                       ; @allocateIOMemory
; %bb.0:
	SLT ADI R14, 56
	INT STR R14, R8, -32
	INT STR R14, R9, -36
	INT STR R14, R10, -40
	INT STR R14, R11, -44
	INT STR R14, R12, -48
	INT STR R14, R13, -52
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB59_62)
	SLT ADI R15, %lo(.LBB59_62)
	BRH NC, R15
; %bb.1:
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -4096
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB59_62)
	SLT ADI R15, %lo(.LBB59_62)
	BRH C, R15
; %bb.2:
	;APP
	CYE SR8, R3
	;NO_APP
	INT STR R14, R3, -8
	;APP
	CYE SR8, R3
	;NO_APP
	LDI R4, 0
	H LDI R4, 0
	SLT ADI R4, -5
	AND R3, R4, R3
	;APP
	CYR R3, SR8
	;NO_APP
	LDI R3, 0
	H LDI R3, varMap
	SLT ADI R3, varMap
	INT LOD R3, R4, 0
	LDI R12, 0
	LDI R7, 255
	LDI R10, 6
	SUB R4, R12, R0
	H LDI R15, %hi(.LBB59_4)
	SLT ADI R15, %lo(.LBB59_4)
	BRH EQ, R15
; %bb.3:
	LDI R3, 0
	H LDI R3, mapEntries
	SLT ADI R3, mapEntries
	INT LOD R3, R3, 0
	SUB R3, R12, R0
	H LDI R15, %hi(.LBB59_5)
	SLT ADI R15, %lo(.LBB59_5)
	BRH NE, R15
	H LDI R15, %hi(.LBB59_61)
	SLT ADI R15, %lo(.LBB59_61)
	JMP R15
.LBB59_4:
	LDI R4, 8192
	INT STR R3, R4, 0
	INT STR R4, R4, 0
	LDI R3, 8196
	INT STR R3, R7, 0
	LDI R3, 4096
	LDI R6, 8200
	INT STR R6, R3, 0
	LDI R6, 1
	LDI R8, 8204
	INT STR R8, R6, 0
	LDI R8, 0
	H LDI R8, 65248
	SLT ADI R8, -12288
	LDI R9, 8208
	INT STR R9, R8, 0
	LDI R8, 8212
	INT STR R8, R7, 0
	LDI R8, 8216
	INT STR R8, R3, 0
	LDI R3, 8220
	INT STR R3, R10, 0
	LDI R3, 0
	H LDI R3, 272
	SLT ADI R3, -4096
	LDI R8, 8224
	INT STR R8, R3, 0
	LDI R3, 8228
	INT STR R3, R7, 0
	LDI R3, 0
	H LDI R3, 16
	SLT ADI R3, 0
	LDI R8, 8232
	INT STR R8, R3, 0
	LDI R3, 8236
	INT STR R3, R6, 0
	LDI R3, 0
	H LDI R3, mapEntries
	SLT ADI R3, mapEntries
	INT STR R3, R10, 0
	SLT ADD R10, R0, R3
.LBB59_5:
	AND R1, R5, R8
	ADI R2, 4095
	AND R2, R5, R2
	INT STR R14, R4, -28
	SLT ADD R4, R0, R1
	ADI R1, 4
	SLT ADD R3, R0, R5
	SLT ADD R12, R0, R6
	LDI R4, 6
	H LDI R15, %hi(.LBB59_7)
	SLT ADI R15, %lo(.LBB59_7)
	JMP R15
.LBB59_6:                               ;   in Loop: Header=BB59_7 Depth=1
	ADD R9, R6, R6
	ADI R1, 8
	ADI R5, -1
	SUB R5, R12, R0
	H LDI R15, %hi(.LBB59_14)
	SLT ADI R15, %lo(.LBB59_14)
	BRH EQ, R15
.LBB59_7:                               ; =>This Inner Loop Header: Depth=1
	SUB R6, R2, R0
	H LDI R15, %hi(.LBB59_14)
	SLT ADI R15, %lo(.LBB59_14)
	BRH NC, R15
; %bb.8:                                ;   in Loop: Header=BB59_7 Depth=1
	INT LOD R1, R9, -4
	SUB R8, R6, R0
	H LDI R15, %hi(.LBB59_10)
	SLT ADI R15, %lo(.LBB59_10)
	BRH C, R15
; %bb.9:                                ;   in Loop: Header=BB59_7 Depth=1
	SUB R8, R6, R10
	SUB R10, R9, R0
	H LDI R15, %hi(.LBB59_6)
	SLT ADI R15, %lo(.LBB59_6)
	BRH NC, R15
.LBB59_10:                              ;   in Loop: Header=BB59_7 Depth=1
	INT LOD R1, R10, 0
	SUB R10, R7, R0
	H LDI R15, %hi(.LBB59_6)
	SLT ADI R15, %lo(.LBB59_6)
	BRH EQ, R15
; %bb.11:                               ;   in Loop: Header=BB59_7 Depth=1
	SUB R10, R4, R0
	H LDI R15, %hi(.LBB59_6)
	SLT ADI R15, %lo(.LBB59_6)
	BRH EQ, R15
; %bb.12:
	INT LOD R14, R1, -8
	;APP
	CYR R1, SR8
	;NO_APP
	H LDI R15, %hi(.LBB59_13)
	SLT ADI R15, %lo(.LBB59_13)
	JMP R15
.LBB59_14:
	SLT ADD R3, R0, R1
	ADI R1, -511
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -513
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB59_16)
	SLT ADI R15, %lo(.LBB59_16)
	BRH NC, R15
; %bb.15:
	INT LOD R14, R1, -8
	;APP
	CYR R1, SR8
	;NO_APP
.LBB59_13:
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -1
	H LDI R15, %hi(.LBB59_62)
	SLT ADI R15, %lo(.LBB59_62)
	JMP R15
.LBB59_16:                              ; %.preheader4
	INT LOD R14, R10, -28
	SLT ADD R10, R0, R1
	ADI R1, -8
	INT STR R14, R1, -4
	LDI R5, 1
	SLT ADD R12, R0, R6
	SLT ADD R12, R0, R13
	H LDI R15, %hi(.LBB59_18)
	SLT ADI R15, %lo(.LBB59_18)
	JMP R15
.LBB59_17:                              ;   in Loop: Header=BB59_18 Depth=1
	ADD R11, R13, R13
	SLT ADD R5, R0, R1
	ADD R1, R6, R6
	SUB R6, R3, R0
	H LDI R15, %hi(.LBB59_42)
	SLT ADI R15, %lo(.LBB59_42)
	BRH NC, R15
.LBB59_18:                              ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB59_34 Depth 2
	SUB R13, R2, R0
	H LDI R15, %hi(.LBB59_42)
	SLT ADI R15, %lo(.LBB59_42)
	BRH NC, R15
; %bb.19:                               ;   in Loop: Header=BB59_18 Depth=1
	LDI R1, 3
	LSH R6, R1, R1
	ADD R10, R1, R7
	INT LOD R7, R11, 0
	SUB R8, R13, R0
	H LDI R15, %hi(.LBB59_21)
	SLT ADI R15, %lo(.LBB59_21)
	BRH C, R15
; %bb.20:                               ;   in Loop: Header=BB59_18 Depth=1
	SUB R8, R13, R1
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB59_17)
	SLT ADI R15, %lo(.LBB59_17)
	BRH NC, R15
.LBB59_21:                              ;   in Loop: Header=BB59_18 Depth=1
	INT LOD R7, R1, 4
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB59_17)
	SLT ADI R15, %lo(.LBB59_17)
	BRH EQ, R15
; %bb.22:                               ;   in Loop: Header=BB59_18 Depth=1
	INT STR R14, R1, -24
	SUB R2, R13, R1
	SLT ADD R2, R0, R9
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB59_24)
	SLT ADI R15, %lo(.LBB59_24)
	BRH C, R15
; %bb.23:                               ;   in Loop: Header=BB59_18 Depth=1
	ADD R11, R13, R9
.LBB59_24:                              ;   in Loop: Header=BB59_18 Depth=1
	SLT ADD R5, R0, R1
	SUB R13, R8, R0
	H LDI R15, %hi(.LBB59_26)
	SLT ADI R15, %lo(.LBB59_26)
	BRH C, R15
; %bb.25:                               ;   in Loop: Header=BB59_18 Depth=1
	SLT ADD R12, R0, R1
.LBB59_26:                              ;   in Loop: Header=BB59_18 Depth=1
	SUB R9, R13, R4
	INT STR R14, R4, -20
	SUB R11, R4, R0
	H LDI R15, %hi(.LBB59_28)
	SLT ADI R15, %lo(.LBB59_28)
	BRH NE, R15
; %bb.27:                               ;   in Loop: Header=BB59_18 Depth=1
	SLT ADD R12, R0, R5
.LBB59_28:                              ;   in Loop: Header=BB59_18 Depth=1
	SLT ADD R13, R0, R4
	SUB R8, R13, R0
	H LDI R15, %hi(.LBB59_30)
	SLT ADI R15, %lo(.LBB59_30)
	BRH C, R15
; %bb.29:                               ;   in Loop: Header=BB59_18 Depth=1
	SLT ADD R8, R0, R4
.LBB59_30:                              ;   in Loop: Header=BB59_18 Depth=1
	INT STR R14, R4, -16
	ADD R5, R1, R1
	ADD R1, R3, R10
	LDI R4, 512
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB59_63)
	SLT ADI R15, %lo(.LBB59_63)
	BRH C, R15
; %bb.31:                               ;   in Loop: Header=BB59_18 Depth=1
	INT STR R14, R9, -12
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB59_35)
	SLT ADI R15, %lo(.LBB59_35)
	BRH EQ, R15
; %bb.32:                               ;   in Loop: Header=BB59_18 Depth=1
	ADD R1, R6, R1
	SLT ADD R10, R0, R5
	ADI R5, -1
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB59_35)
	SLT ADI R15, %lo(.LBB59_35)
	BRH NC, R15
; %bb.33:                               ; %.preheader
                                        ;   in Loop: Header=BB59_18 Depth=1
	LDI R4, 3
	LSH R10, R4, R12
	INT LOD R14, R9, -4
	ADD R9, R12, R12
	LSH R3, R4, R3
	ADD R9, R3, R3
.LBB59_34:                              ;   Parent Loop BB59_18 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	INT LOD R3, R4, 0
	INT LOD R3, R9, 4
	INT STR R12, R9, 4
	INT STR R12, R4, 0
	ADI R12, -8
	ADI R3, -8
	ADI R5, -1
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB59_34)
	SLT ADI R15, %lo(.LBB59_34)
	BRH C, R15
.LBB59_35:                              ;   in Loop: Header=BB59_18 Depth=1
	SLT ADD R6, R0, R1
	INT LOD R14, R9, -24
	INT LOD R14, R3, -16
	SUB R13, R8, R0
	H LDI R15, %hi(.LBB59_37)
	SLT ADI R15, %lo(.LBB59_37)
	BRH NC, R15
; %bb.36:                               ;   in Loop: Header=BB59_18 Depth=1
	SUB R3, R13, R1
	INT STR R7, R9, 4
	INT STR R7, R1, 0
	SLT ADD R6, R0, R1
	ADI R1, 1
.LBB59_37:                              ;   in Loop: Header=BB59_18 Depth=1
	INT LOD R14, R7, -12
	SUB R7, R3, R3
	LDI R4, 3
	LSH R1, R4, R1
	INT LOD R14, R4, -28
	ADD R4, R1, R1
	LDI R4, 6
	INT STR R1, R4, 4
	INT STR R1, R3, 0
	LDI R5, 1
	INT LOD R14, R3, -20
	SUB R11, R3, R0
	H LDI R15, %hi(.LBB59_39)
	SLT ADI R15, %lo(.LBB59_39)
	BRH EQ, R15
; %bb.38:                               ;   in Loop: Header=BB59_18 Depth=1
	SUB R11, R3, R3
	INT STR R1, R9, 12
	INT STR R1, R3, 8
.LBB59_39:                              ;   in Loop: Header=BB59_18 Depth=1
	LDI R1, 2
	SUB R13, R8, R0
	H LDI R15, %hi(.LBB59_41)
	SLT ADI R15, %lo(.LBB59_41)
	BRH C, R15
; %bb.40:                               ;   in Loop: Header=BB59_18 Depth=1
	SLT ADD R5, R0, R1
.LBB59_41:                              ;   in Loop: Header=BB59_18 Depth=1
	LDI R3, 0
	H LDI R3, mapEntries
	SLT ADI R3, mapEntries
	INT STR R3, R10, 0
	SLT ADD R10, R0, R3
	SLT ADD R7, R0, R13
	INT LOD R14, R10, -28
	LDI R12, 0
	ADD R1, R6, R6
	SUB R6, R3, R0
	H LDI R15, %hi(.LBB59_18)
	SLT ADI R15, %lo(.LBB59_18)
	BRH C, R15
.LBB59_42:
	LDI R1, 2
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB59_61)
	SLT ADI R15, %lo(.LBB59_61)
	BRH C, R15
; %bb.43:
	LDI R2, 0
	LDI R6, 1
	SLT ADD R10, R0, R1
	ADI R1, -1
	INT STR R14, R1, -24
	SLT ADD R10, R0, R8
	ADI R8, 8
	LDI R9, 0
	H LDI R9, 0
	SLT ADI R9, -1
	SLT ADD R6, R0, R12
	SLT ADD R2, R0, R1
	H LDI R15, %hi(.LBB59_46)
	SLT ADI R15, %lo(.LBB59_46)
	JMP R15
.LBB59_44:                              ;   in Loop: Header=BB59_46 Depth=1
	INT LOD R14, R10, -28
.LBB59_45:                              ;   in Loop: Header=BB59_46 Depth=1
	SLT ADD R11, R0, R1
	ADI R1, 1
	ADI R11, 2
	SLT ADD R11, R0, R12
	SUB R11, R3, R0
	H LDI R15, %hi(.LBB59_61)
	SLT ADI R15, %lo(.LBB59_61)
	BRH NC, R15
.LBB59_46:                              ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB59_58 Depth 2
                                        ;     Child Loop BB59_53 Depth 2
	SLT ADD R1, R0, R11
	LDI R1, 3
	LSH R12, R1, R5
	LSH R11, R1, R1
	ADD R10, R1, R1
	ADD R10, R5, R13
	INT LOD R13, R4, 4
	INT LOD R1, R7, 4
	SUB R7, R4, R0
	H LDI R15, %hi(.LBB59_45)
	SLT ADI R15, %lo(.LBB59_45)
	BRH NE, R15
; %bb.47:                               ;   in Loop: Header=BB59_46 Depth=1
	INT LOD R13, R7, 0
	XOR R7, R9, R4
	INT LOD R1, R10, 0
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB59_44)
	SLT ADI R15, %lo(.LBB59_44)
	BRH C, R15
; %bb.48:                               ;   in Loop: Header=BB59_46 Depth=1
	ADD R7, R10, R4
	INT STR R1, R4, 0
	SLT ADD R12, R0, R1
	ADI R1, 1
	SUB R1, R3, R0
	H LDI R15, %hi(.LBB59_55)
	SLT ADI R15, %lo(.LBB59_55)
	BRH NC, R15
; %bb.49:                               ;   in Loop: Header=BB59_46 Depth=1
	SLT ADD R3, R0, R1
	ADI R1, -1
	SUB R1, R12, R4
	LDI R7, 3
	LSH R4, R7, R7
	ADD R8, R5, R12
	SUB R12, R13, R0
	H LDI R15, %hi(.LBB59_56)
	SLT ADI R15, %lo(.LBB59_56)
	BRH NC, R15
; %bb.50:                               ; %memmove_copy_backwards
                                        ;   in Loop: Header=BB59_46 Depth=1
	INT LOD R14, R10, -28
	SUB R7, R2, R0
	H LDI R15, %hi(.LBB59_59)
	SLT ADI R15, %lo(.LBB59_59)
	BRH EQ, R15
; %bb.51:                               ; %memmove_bwd_main_loop.preheader
                                        ;   in Loop: Header=BB59_46 Depth=1
	LDI R4, 3
	LSH R3, R4, R4
	INT LOD R14, R3, -24
	ADD R3, R4, R3
	SUB R5, R4, R5
	ADI R5, 8
	H LDI R15, %hi(.LBB59_53)
	SLT ADI R15, %lo(.LBB59_53)
	JMP R15
.LBB59_52:                              ; %memmove_bwd_main_loop
                                        ;   in Loop: Header=BB59_53 Depth=2
	AND R7, R6, R4
	ADI R3, -1
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB59_59)
	SLT ADI R15, %lo(.LBB59_59)
	BRH NE, R15
.LBB59_53:                              ; %memmove_bwd_main_loop
                                        ;   Parent Loop BB59_46 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	CHAR LOD R3, R4, 0
	CHAR STR R3, R4, -8
	ADI R5, 1
	SLT ADD R6, R0, R7
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB59_52)
	SLT ADI R15, %lo(.LBB59_52)
	BRH EQ, R15
; %bb.54:                               ; %memmove_bwd_main_loop
                                        ;   in Loop: Header=BB59_53 Depth=2
	SLT ADD R2, R0, R7
	H LDI R15, %hi(.LBB59_52)
	SLT ADI R15, %lo(.LBB59_52)
	JMP R15
.LBB59_55:                              ;   in Loop: Header=BB59_46 Depth=1
	ADI R3, -1
	INT LOD R14, R10, -28
	H LDI R15, %hi(.LBB59_60)
	SLT ADI R15, %lo(.LBB59_60)
	JMP R15
.LBB59_56:                              ; %memmove_copy_forward
                                        ;   in Loop: Header=BB59_46 Depth=1
	INT LOD R14, R10, -28
	SUB R7, R2, R0
	H LDI R15, %hi(.LBB59_59)
	SLT ADI R15, %lo(.LBB59_59)
	BRH EQ, R15
; %bb.57:                               ; %memmove_fwd_main_loop.preheader
                                        ;   in Loop: Header=BB59_46 Depth=1
	LDI R4, 3
	LSH R3, R4, R3
	SUB R3, R5, R3
	ADI R3, -8
.LBB59_58:                              ; %memmove_fwd_main_loop
                                        ;   Parent Loop BB59_46 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	CHAR LOD R12, R4, 0
	CHAR STR R12, R4, -8
	ADI R12, 1
	ADI R3, -1
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB59_58)
	SLT ADI R15, %lo(.LBB59_58)
	BRH NE, R15
.LBB59_59:                              ;   in Loop: Header=BB59_46 Depth=1
	SLT ADD R1, R0, R3
.LBB59_60:                              ;   in Loop: Header=BB59_46 Depth=1
	LDI R1, 0
	H LDI R1, mapEntries
	SLT ADI R1, mapEntries
	INT STR R1, R3, 0
	ADI R11, -1
	H LDI R15, %hi(.LBB59_45)
	SLT ADI R15, %lo(.LBB59_45)
	JMP R15
.LBB59_61:
	INT LOD R14, R1, -8
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R3, 0
.LBB59_62:
	SLT ADD R3, R0, R1
	INT LOD R14, R13, -52
	INT LOD R14, R12, -48
	INT LOD R14, R11, -44
	INT LOD R14, R10, -40
	INT LOD R14, R9, -36
	INT LOD R14, R8, -32
	SLT ADI R14, -56
	RET
.LBB59_63:
	INT LOD R14, R1, -8
	;APP
	CYR R1, SR8
	;NO_APP
	H LDI R15, %hi(.LBB59_13)
	SLT ADI R15, %lo(.LBB59_13)
	JMP R15
.Lfunc_end59:
	.size	allocateIOMemory, .Lfunc_end59-allocateIOMemory
                                        ; -- End function
	.globl	getVarMap                       ; -- Begin function getVarMap
	.type	getVarMap,@function
getVarMap:                              ; @getVarMap
; %bb.0:
	SLT ADI R14, 4
	;APP
	CYE SR8, R2
	;NO_APP
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -5
	AND R1, R3, R1
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R3, 0
	H LDI R3, varMap
	SLT ADI R3, varMap
	INT LOD R3, R1, 0
	LDI R4, 0
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB60_2)
	SLT ADI R15, %lo(.LBB60_2)
	BRH NE, R15
; %bb.1:
	LDI R1, 8192
	INT STR R3, R1, 0
	INT STR R1, R1, 0
	LDI R3, 255
	LDI R4, 8196
	INT STR R4, R3, 0
	LDI R4, 4096
	LDI R5, 8200
	INT STR R5, R4, 0
	LDI R5, 1
	LDI R6, 8204
	INT STR R6, R5, 0
	LDI R6, 0
	H LDI R6, 65248
	SLT ADI R6, -12288
	LDI R7, 8208
	INT STR R7, R6, 0
	LDI R6, 8212
	INT STR R6, R3, 0
	LDI R6, 8216
	INT STR R6, R4, 0
	LDI R4, 6
	LDI R6, 8220
	INT STR R6, R4, 0
	LDI R6, 0
	H LDI R6, 272
	SLT ADI R6, -4096
	LDI R7, 8224
	INT STR R7, R6, 0
	LDI R6, 8228
	INT STR R6, R3, 0
	LDI R3, 0
	H LDI R3, 16
	SLT ADI R3, 0
	LDI R6, 8232
	INT STR R6, R3, 0
	LDI R3, 8236
	INT STR R3, R5, 0
	LDI R3, 0
	H LDI R3, mapEntries
	SLT ADI R3, mapEntries
	INT STR R3, R4, 0
.LBB60_2:
	;APP
	CYR R2, SR8
	;NO_APP
	SLT ADI R14, -4
	RET
.Lfunc_end60:
	.size	getVarMap, .Lfunc_end60-getVarMap
                                        ; -- End function
	.globl	help                            ; -- Begin function help
	.type	help,@function
help:                                   ; @help
; %bb.0:
	SLT ADI R14, 16
	INT STR R14, R8, -12
	LDI R8, 0
	LDI R1, 0
	H LDI R1, .L.str.81
	SLT ADI R1, .L.str.81
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.82
	SLT ADI R1, .L.str.1.82
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.28
	SLT ADI R1, .L.str.28
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.83
	SLT ADI R1, .L.str.2.83
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.82
	SLT ADI R1, .L.str.1.82
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.29
	SLT ADI R1, .L.str.29
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.83
	SLT ADI R1, .L.str.2.83
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.82
	SLT ADI R1, .L.str.1.82
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.30
	SLT ADI R1, .L.str.30
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.83
	SLT ADI R1, .L.str.2.83
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.82
	SLT ADI R1, .L.str.1.82
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.31
	SLT ADI R1, .L.str.31
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.83
	SLT ADI R1, .L.str.2.83
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.82
	SLT ADI R1, .L.str.1.82
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.32
	SLT ADI R1, .L.str.32
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.83
	SLT ADI R1, .L.str.2.83
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.36
	SLT ADI R1, .L.str.36
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADD R14, R0, R8
	SLT ADI R8, -8
	LDI R2, 8
	SLT ADD R8, R0, R1
	H LDI R15, %hi(readInput)
	SLT ADI R15, %lo(readInput)
	CAL R15
	CHAR LOD R8, R1, 0
	LDI R2, 223
	AND R1, R2, R1
	LDI R2, 81
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB61_2)
	SLT ADI R15, %lo(.LBB61_2)
	BRH EQ, R15
; %bb.1:
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	LDI R8, 0
	LDI R1, 0
	H LDI R1, .L.str.81
	SLT ADI R1, .L.str.81
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.82
	SLT ADI R1, .L.str.1.82
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.33
	SLT ADI R1, .L.str.33
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.83
	SLT ADI R1, .L.str.2.83
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.82
	SLT ADI R1, .L.str.1.82
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.34
	SLT ADI R1, .L.str.34
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.83
	SLT ADI R1, .L.str.2.83
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.82
	SLT ADI R1, .L.str.1.82
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.35
	SLT ADI R1, .L.str.35
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.83
	SLT ADI R1, .L.str.2.83
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB61_2:
	INT LOD R14, R8, -12
	SLT ADI R14, -16
	RET
.Lfunc_end61:
	.size	help, .Lfunc_end61-help
                                        ; -- End function
	.globl	sysOff                          ; -- Begin function sysOff
	.type	sysOff,@function
sysOff:                                 ; @sysOff
; %bb.0:
	SLT ADI R14, 4
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.3.84
	SLT ADI R1, .L.str.3.84
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
.Lfunc_end62:
	.size	sysOff, .Lfunc_end62-sysOff
                                        ; -- End function
	.globl	reset                           ; -- Begin function reset
	.type	reset,@function
reset:                                  ; @reset
; %bb.0:
	SLT ADI R14, 4
	;APP
	H LDI R14, 0
SLT ADI R14, 4096
H LDI R15, %hi(main) 
SLT ADI R15, %lo(main) 
JMP R15
	;NO_APP
	SLT ADI R14, -4
	RET
.Lfunc_end63:
	.size	reset, .Lfunc_end63-reset
                                        ; -- End function
	.globl	initSO                          ; -- Begin function initSO
	.type	initSO,@function
initSO:                                 ; @initSO
; %bb.0:
	SLT ADI R14, 20
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	LDI R10, 0
	H LDI R10, bootSelected
	SLT ADI R10, bootSelected
	INT LOD R10, R9, 0
	LDI R1, 0
	SUB R9, R1, R0
	H LDI R15, %hi(.LBB64_1)
	SLT ADI R15, %lo(.LBB64_1)
	BRH N, R15
; %bb.2:
	LDI R1, 0
	H LDI R1, bootEntries
	SLT ADI R1, bootEntries
	INT LOD R1, R11, 0
	LDI R8, 0
	LDI R1, 0
	H LDI R1, .L.str.5
	SLT ADI R1, .L.str.5
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 68
	MUL R9, R1, R1
	ADD R11, R1, R9
	SLT ADD R9, R0, R1
	ADI R1, 4
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.6
	SLT ADI R1, .L.str.6
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADI R9, 36
	SLT ADD R9, R0, R1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.7
	SLT ADI R1, .L.str.7
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	INT LOD R10, R1, 0
	H LDI R15, %hi(bootRun)
	SLT ADI R15, %lo(bootRun)
	CAL R15
	ADI R1, 4
	LDI R2, 4
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB64_3)
	SLT ADI R15, %lo(.LBB64_3)
	BRH C, R15
; %bb.4:
	LDI R2, 2
	LSH R1, R2, R1
	LDI R2, 0
	H LDI R2, .Lswitch.table.initSO
	SLT ADI R2, .Lswitch.table.initSO
	ADD R1, R2, R1
	INT LOD R1, R1, 0
	H LDI R15, %hi(.LBB64_5)
	SLT ADI R15, %lo(.LBB64_5)
	JMP R15
.LBB64_1:
	LDI R1, 0
	H LDI R1, .L.str.4.85
	SLT ADI R1, .L.str.4.85
	H LDI R15, %hi(.LBB64_5)
	SLT ADI R15, %lo(.LBB64_5)
	JMP R15
.LBB64_3:
	LDI R1, 0
	H LDI R1, .L.str.12.86
	SLT ADI R1, .L.str.12.86
.LBB64_5:
	LDI R2, 0
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -20
	RET
.Lfunc_end64:
	.size	initSO, .Lfunc_end64-initSO
                                        ; -- End function
	.globl	enumdisp                        ; -- Begin function enumdisp
	.type	enumdisp,@function
enumdisp:                               ; @enumdisp
; %bb.0:
	SLT ADI R14, 44
	INT STR R14, R8, -20
	INT STR R14, R9, -24
	INT STR R14, R10, -28
	INT STR R14, R11, -32
	INT STR R14, R12, -36
	INT STR R14, R13, -40
	LDI R8, 0
	LDI R1, 0
	H LDI R1, .L.str.13
	SLT ADI R1, .L.str.13
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R9, 0
	H LDI R9, Globals
	SLT ADI R9, Globals
	INT LOD R9, R1, 0
	INT LOD R1, R1, 0
	SLT ADD R8, R0, R2
	H LDI R15, %hi(ToAscii)
	SLT ADI R15, %lo(ToAscii)
	CAL R15
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.14
	SLT ADI R1, .L.str.14
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.15
	SLT ADI R1, .L.str.15
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.16
	SLT ADI R1, .L.str.16
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	INT LOD R9, R1, 0
	INT LOD R1, R1, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB65_12)
	SLT ADI R15, %lo(.LBB65_12)
	BRH EQ, R15
; %bb.1:                                ; %.preheader1
	ADD R14, R0, R10
	INT STR R14, R10, -4
	SLT ADI R10, -8
	LDI R13, 1
	SLT ADD R8, R0, R9
	H LDI R15, %hi(.LBB65_2)
	SLT ADI R15, %lo(.LBB65_2)
	JMP R15
.LBB65_11:                              ;   in Loop: Header=BB65_2 Depth=1
	INT LOD R11, R1, 0
	INT LOD R1, R1, 0
	SUB R9, R1, R0
	H LDI R15, %hi(.LBB65_12)
	SLT ADI R15, %lo(.LBB65_12)
	BRH NC, R15
.LBB65_2:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB65_4 Depth 2
	LDI R1, 20
	MUL R9, R1, R11
	LDI R1, 0
	H LDI R1, mapa
	SLT ADI R1, mapa
	INT LOD R1, R1, 0
	ADD R1, R11, R1
	INT LOD R1, R1, 12
	LDI R2, 3
	H LDI R15, %hi(ToAscii)
	SLT ADI R15, %lo(ToAscii)
	CAL R15
	SLT ADD R1, R0, R12
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	SLT ADD R12, R0, R1
	H LDI R15, %hi(strlen)
	SLT ADI R15, %lo(strlen)
	CAL R15
	SLT ADD R1, R0, R12
	LDI R1, 32
	SHORT STR R10, R1, 0
	LDI R1, 12
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB65_7)
	SLT ADI R15, %lo(.LBB65_7)
	BRH N, R15
; %bb.3:                                ; %.preheader
                                        ;   in Loop: Header=BB65_2 Depth=1
	ADI R12, -13
	H LDI R15, %hi(.LBB65_4)
	SLT ADI R15, %lo(.LBB65_4)
	JMP R15
.LBB65_6:                               ;   in Loop: Header=BB65_4 Depth=2
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB65_7)
	SLT ADI R15, %lo(.LBB65_7)
	BRH EQ, R15
.LBB65_4:                               ;   Parent Loop BB65_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	SLT ADD R10, R0, R1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADI R12, 1
	SLT ADD R13, R0, R1
	SUB R12, R8, R0
	H LDI R15, %hi(.LBB65_6)
	SLT ADI R15, %lo(.LBB65_6)
	BRH EQ, R15
; %bb.5:                                ;   in Loop: Header=BB65_4 Depth=2
	SLT ADD R8, R0, R1
	H LDI R15, %hi(.LBB65_6)
	SLT ADI R15, %lo(.LBB65_6)
	JMP R15
.LBB65_7:                               ;   in Loop: Header=BB65_2 Depth=1
	LDI R1, 0
	H LDI R1, mapa
	SLT ADI R1, mapa
	INT LOD R1, R1, 0
	ADD R1, R11, R1
	CHAR LOD R1, R2, 16
	LDI R3, 20
	LSH R2, R3, R2
	CHAR LOD R1, R3, 17
	LDI R4, 15
	LSH R3, R4, R3
	NOR R2, R3, R2
	CHAR LOD R1, R1, 18
	LDI R3, 12
	LSH R1, R3, R1
	NOR R2, R2, R2
	NOR R2, R1, R1
	NOR R1, R1, R1
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 0
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 3
	H LDI R15, %hi(ToAscii)
	SLT ADI R15, %lo(ToAscii)
	CAL R15
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.83
	SLT ADI R1, .L.str.2.83
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADI R9, 1
	LDI R1, 0
	H LDI R1, 43691
	SLT ADI R1, -21845
	MUL R9, R1, R2
	LDI R11, 0
	H LDI R11, Globals
	SLT ADI R11, Globals
	INT LOD R11, R1, 0
	INT LOD R1, R1, 0
	LDI R3, 0
	H LDI R3, 21845
	SLT ADI R3, 21845
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB65_11)
	SLT ADI R15, %lo(.LBB65_11)
	BRH C, R15
; %bb.8:                                ;   in Loop: Header=BB65_2 Depth=1
	SUB R9, R1, R0
	H LDI R15, %hi(.LBB65_11)
	SLT ADI R15, %lo(.LBB65_11)
	BRH NC, R15
; %bb.9:                                ;   in Loop: Header=BB65_2 Depth=1
	LDI R1, 0
	H LDI R1, .L.str.36
	SLT ADI R1, .L.str.36
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	INT LOD R14, R12, -4
	SLT ADI R12, -16
	SLT ADD R12, R0, R1
	LDI R2, 8
	H LDI R15, %hi(readInput)
	SLT ADI R15, %lo(readInput)
	CAL R15
	CHAR LOD R12, R1, 0
	LDI R2, 223
	AND R1, R2, R1
	LDI R2, 81
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB65_12)
	SLT ADI R15, %lo(.LBB65_12)
	BRH EQ, R15
; %bb.10:                               ;   in Loop: Header=BB65_2 Depth=1
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.15
	SLT ADI R1, .L.str.15
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.16
	SLT ADI R1, .L.str.16
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(.LBB65_11)
	SLT ADI R15, %lo(.LBB65_11)
	JMP R15
.LBB65_12:
	INT LOD R14, R13, -40
	INT LOD R14, R12, -36
	INT LOD R14, R11, -32
	INT LOD R14, R10, -28
	INT LOD R14, R9, -24
	INT LOD R14, R8, -20
	SLT ADI R14, -44
	RET
.Lfunc_end65:
	.size	enumdisp, .Lfunc_end65-enumdisp
                                        ; -- End function
	.globl	lsboot                          ; -- Begin function lsboot
	.type	lsboot,@function
lsboot:                                 ; @lsboot
; %bb.0:
	SLT ADI R14, 48
	INT STR R14, R8, -24
	INT STR R14, R9, -28
	INT STR R14, R10, -32
	INT STR R14, R11, -36
	INT STR R14, R12, -40
	INT STR R14, R13, -44
	LDI R9, 0
	H LDI R9, bootCount
	SLT ADI R9, bootCount
	INT LOD R9, R1, 0
	LDI R8, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB66_1)
	SLT ADI R15, %lo(.LBB66_1)
	BRH EQ, R15
; %bb.2:
	LDI R1, 0
	H LDI R1, .L.str.13
	SLT ADI R1, .L.str.13
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	INT LOD R9, R1, 0
	SLT ADD R8, R0, R2
	H LDI R15, %hi(ToAscii)
	SLT ADI R15, %lo(ToAscii)
	CAL R15
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.18
	SLT ADI R1, .L.str.18
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.19
	SLT ADI R1, .L.str.19
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.20
	SLT ADI R1, .L.str.20
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	INT LOD R9, R1, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB66_19)
	SLT ADI R15, %lo(.LBB66_19)
	BRH EQ, R15
; %bb.3:                                ; %.preheader3
	ADD R14, R0, R9
	INT STR R14, R9, -4
	SLT ADI R9, -10
	LDI R10, 1
	LDI R13, 0
	H LDI R13, bootEntries
	SLT ADI R13, bootEntries
	SLT ADD R8, R0, R11
	H LDI R15, %hi(.LBB66_4)
	SLT ADI R15, %lo(.LBB66_4)
	JMP R15
.LBB66_18:                              ;   in Loop: Header=BB66_4 Depth=1
	SUB R11, R1, R0
	H LDI R15, %hi(.LBB66_19)
	SLT ADI R15, %lo(.LBB66_19)
	BRH NC, R15
.LBB66_4:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB66_6 Depth 2
                                        ;     Child Loop BB66_11 Depth 2
	SLT ADD R11, R0, R1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(ToAscii)
	SLT ADI R15, %lo(ToAscii)
	CAL R15
	SLT ADD R1, R0, R12
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	SLT ADD R12, R0, R1
	H LDI R15, %hi(strlen)
	SLT ADI R15, %lo(strlen)
	CAL R15
	SLT ADD R1, R0, R12
	LDI R1, 32
	SHORT STR R9, R1, 0
	LDI R1, 5
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB66_9)
	SLT ADI R15, %lo(.LBB66_9)
	BRH N, R15
; %bb.5:                                ; %.preheader1
                                        ;   in Loop: Header=BB66_4 Depth=1
	ADI R12, -6
	H LDI R15, %hi(.LBB66_6)
	SLT ADI R15, %lo(.LBB66_6)
	JMP R15
.LBB66_8:                               ;   in Loop: Header=BB66_6 Depth=2
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB66_9)
	SLT ADI R15, %lo(.LBB66_9)
	BRH EQ, R15
.LBB66_6:                               ;   Parent Loop BB66_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	SLT ADD R9, R0, R1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADI R12, 1
	SLT ADD R10, R0, R1
	SUB R12, R8, R0
	H LDI R15, %hi(.LBB66_8)
	SLT ADI R15, %lo(.LBB66_8)
	BRH EQ, R15
; %bb.7:                                ;   in Loop: Header=BB66_6 Depth=2
	SLT ADD R8, R0, R1
	H LDI R15, %hi(.LBB66_8)
	SLT ADI R15, %lo(.LBB66_8)
	JMP R15
.LBB66_9:                               ;   in Loop: Header=BB66_4 Depth=1
	LDI R1, 68
	INT STR R14, R11, -8
	MUL R11, R1, R11
	INT LOD R13, R1, 0
	ADD R1, R11, R12
	ADI R12, 4
	SLT ADD R12, R0, R1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	SLT ADD R12, R0, R1
	H LDI R15, %hi(strlen)
	SLT ADI R15, %lo(strlen)
	CAL R15
	SLT ADD R1, R0, R12
	INT LOD R14, R13, -4
	SLT ADI R13, -12
	LDI R1, 32
	SHORT STR R13, R1, 0
	LDI R1, 15
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB66_14)
	SLT ADI R15, %lo(.LBB66_14)
	BRH N, R15
; %bb.10:                               ; %.preheader
                                        ;   in Loop: Header=BB66_4 Depth=1
	ADI R12, -16
	H LDI R15, %hi(.LBB66_11)
	SLT ADI R15, %lo(.LBB66_11)
	JMP R15
.LBB66_13:                              ;   in Loop: Header=BB66_11 Depth=2
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB66_14)
	SLT ADI R15, %lo(.LBB66_14)
	BRH EQ, R15
.LBB66_11:                              ;   Parent Loop BB66_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	SLT ADD R13, R0, R1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADI R12, 1
	SLT ADD R10, R0, R1
	SUB R12, R8, R0
	H LDI R15, %hi(.LBB66_13)
	SLT ADI R15, %lo(.LBB66_13)
	BRH EQ, R15
; %bb.12:                               ;   in Loop: Header=BB66_11 Depth=2
	SLT ADD R8, R0, R1
	H LDI R15, %hi(.LBB66_13)
	SLT ADI R15, %lo(.LBB66_13)
	JMP R15
.LBB66_14:                              ;   in Loop: Header=BB66_4 Depth=1
	LDI R13, 0
	H LDI R13, bootEntries
	SLT ADI R13, bootEntries
	INT LOD R13, R1, 0
	ADD R1, R11, R1
	ADI R1, 36
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.83
	SLT ADI R1, .L.str.2.83
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	INT LOD R14, R11, -8
	ADI R11, 1
	LDI R1, 0
	H LDI R1, 43691
	SLT ADI R1, -21845
	MUL R11, R1, R2
	LDI R1, 0
	H LDI R1, bootCount
	SLT ADI R1, bootCount
	INT LOD R1, R1, 0
	LDI R3, 0
	H LDI R3, 21845
	SLT ADI R3, 21845
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB66_18)
	SLT ADI R15, %lo(.LBB66_18)
	BRH C, R15
; %bb.15:                               ;   in Loop: Header=BB66_4 Depth=1
	SUB R11, R1, R0
	H LDI R15, %hi(.LBB66_18)
	SLT ADI R15, %lo(.LBB66_18)
	BRH NC, R15
; %bb.16:                               ;   in Loop: Header=BB66_4 Depth=1
	LDI R1, 0
	H LDI R1, .L.str.36
	SLT ADI R1, .L.str.36
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	INT LOD R14, R12, -4
	SLT ADI R12, -20
	SLT ADD R12, R0, R1
	LDI R2, 8
	H LDI R15, %hi(readInput)
	SLT ADI R15, %lo(readInput)
	CAL R15
	CHAR LOD R12, R1, 0
	LDI R2, 223
	AND R1, R2, R1
	LDI R2, 81
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB66_19)
	SLT ADI R15, %lo(.LBB66_19)
	BRH EQ, R15
; %bb.17:                               ;   in Loop: Header=BB66_4 Depth=1
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.19
	SLT ADI R1, .L.str.19
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.20
	SLT ADI R1, .L.str.20
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, bootCount
	SLT ADI R1, bootCount
	INT LOD R1, R1, 0
	H LDI R15, %hi(.LBB66_18)
	SLT ADI R15, %lo(.LBB66_18)
	JMP R15
.LBB66_1:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.17
	SLT ADI R1, .L.str.17
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB66_19:
	INT LOD R14, R13, -44
	INT LOD R14, R12, -40
	INT LOD R14, R11, -36
	INT LOD R14, R10, -32
	INT LOD R14, R9, -28
	INT LOD R14, R8, -24
	SLT ADI R14, -48
	RET
.Lfunc_end66:
	.size	lsboot, .Lfunc_end66-lsboot
                                        ; -- End function
	.globl	setboot                         ; -- Begin function setboot
	.type	setboot,@function
setboot:                                ; @setboot
; %bb.0:
	SLT ADI R14, 28
	INT STR R14, R8, -12
	INT STR R14, R9, -16
	INT STR R14, R10, -20
	INT STR R14, R11, -24
	LDI R1, 0
	H LDI R1, bootCount
	SLT ADI R1, bootCount
	INT LOD R1, R1, 0
	LDI R8, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB67_9)
	SLT ADI R15, %lo(.LBB67_9)
	BRH EQ, R15
; %bb.1:
	LDI R1, 0
	H LDI R1, .L.str.22
	SLT ADI R1, .L.str.22
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADD R14, R0, R9
	SLT ADI R9, -8
	LDI R10, 8
	SLT ADD R9, R0, R1
	SLT ADD R10, R0, R2
	H LDI R15, %hi(readInput)
	SLT ADI R15, %lo(readInput)
	CAL R15
	CHAR LOD R9, R1, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB67_10)
	SLT ADI R15, %lo(.LBB67_10)
	BRH EQ, R15
; %bb.2:                                ; %.preheader
	ADI R9, 1
	LDI R2, 255
	LDI R3, 48
	LDI R4, 57
	LDI R5, 10
	SLT ADD R8, R0, R6
	SLT ADD R8, R0, R11
.LBB67_3:                               ; =>This Inner Loop Header: Depth=1
	AND R1, R2, R7
	SUB R7, R3, R0
	H LDI R15, %hi(.LBB67_12)
	SLT ADI R15, %lo(.LBB67_12)
	BRH C, R15
; %bb.4:                                ;   in Loop: Header=BB67_3 Depth=1
	LDI R1, 0
	H LDI R1, .L.str.24
	SLT ADI R1, .L.str.24
	SUB R4, R7, R0
	H LDI R15, %hi(.LBB67_13)
	SLT ADI R15, %lo(.LBB67_13)
	BRH C, R15
; %bb.5:                                ;   in Loop: Header=BB67_3 Depth=1
	SUB R10, R6, R0
	H LDI R15, %hi(.LBB67_13)
	SLT ADI R15, %lo(.LBB67_13)
	BRH C, R15
; %bb.6:                                ;   in Loop: Header=BB67_3 Depth=1
	MUL R11, R5, R1
	ADD R7, R1, R11
	ADD R9, R6, R1
	ADI R6, 1
	ADI R11, -48
	CHAR LOD R1, R1, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB67_3)
	SLT ADI R15, %lo(.LBB67_3)
	BRH NE, R15
; %bb.7:
	LDI R1, 0
	H LDI R1, bootCount
	SLT ADI R1, bootCount
	INT LOD R1, R1, 0
	SUB R11, R1, R0
	H LDI R15, %hi(.LBB67_12)
	SLT ADI R15, %lo(.LBB67_12)
	BRH NC, R15
; %bb.8:
	LDI R1, 0
	H LDI R1, bootSelected
	SLT ADI R1, bootSelected
	INT STR R1, R11, 0
	LDI R8, 0
	LDI R1, 0
	H LDI R1, .L.str.25
	SLT ADI R1, .L.str.25
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 68
	MUL R11, R1, R9
	LDI R10, 0
	H LDI R10, bootEntries
	SLT ADI R10, bootEntries
	INT LOD R10, R1, 0
	ADD R1, R9, R1
	ADI R1, 4
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.6
	SLT ADI R1, .L.str.6
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	INT LOD R10, R1, 0
	ADD R1, R9, R1
	ADI R1, 36
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.83
	SLT ADI R1, .L.str.2.83
	H LDI R15, %hi(.LBB67_13)
	SLT ADI R15, %lo(.LBB67_13)
	JMP R15
.LBB67_9:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.21
	SLT ADI R1, .L.str.21
	H LDI R15, %hi(.LBB67_14)
	SLT ADI R15, %lo(.LBB67_14)
	JMP R15
.LBB67_10:
	LDI R1, 0
	H LDI R1, .L.str.23
	SLT ADI R1, .L.str.23
	H LDI R15, %hi(.LBB67_13)
	SLT ADI R15, %lo(.LBB67_13)
	JMP R15
.LBB67_12:
	LDI R1, 0
	H LDI R1, .L.str.24
	SLT ADI R1, .L.str.24
.LBB67_13:
	LDI R2, 0
.LBB67_14:
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	INT LOD R14, R11, -24
	INT LOD R14, R10, -20
	INT LOD R14, R9, -16
	INT LOD R14, R8, -12
	SLT ADI R14, -28
	RET
.Lfunc_end67:
	.size	setboot, .Lfunc_end67-setboot
                                        ; -- End function
	.globl	cls                             ; -- Begin function cls
	.type	cls,@function
cls:                                    ; @cls
; %bb.0:
	SLT ADI R14, 4
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	SLT ADI R14, -4
	RET
.Lfunc_end68:
	.size	cls, .Lfunc_end68-cls
                                        ; -- End function
	.globl	BiosShell                       ; -- Begin function BiosShell
	.type	BiosShell,@function
BiosShell:                              ; @BiosShell
; %bb.0:
	SLT ADI R14, 60
	INT STR R14, R8, -36
	INT STR R14, R9, -40
	INT STR R14, R10, -44
	INT STR R14, R11, -48
	INT STR R14, R12, -52
	INT STR R14, R13, -56
	LDI R13, 4
	LDI R8, 0
	ADD R14, R0, R9
	SLT ADI R9, -32
	LDI R10, 32
	LDI R11, 5
	LDI R12, 7
	H LDI R15, %hi(.LBB69_1)
	SLT ADI R15, %lo(.LBB69_1)
	JMP R15
.LBB69_2:                               ;   in Loop: Header=BB69_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos
	SLT ADI R1, tabla_comandos
.LBB69_17:                              ;   in Loop: Header=BB69_1 Depth=1
	INT LOD R1, R1, 4
	CAL R1
.LBB69_1:                               ; =>This Inner Loop Header: Depth=1
	;APP
	CYE SR8, R1
	;NO_APP
	NOR R1, R13, R1
	NOR R1, R1, R1
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R1, .L.str.26
	SLT ADI R1, .L.str.26
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	SLT ADD R9, R0, R1
	SLT ADD R10, R0, R2
	H LDI R15, %hi(readInput)
	SLT ADI R15, %lo(readInput)
	CAL R15
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.28
	SLT ADI R2, .L.str.28
	SLT ADD R11, R0, R3
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB69_2)
	SLT ADI R15, %lo(.LBB69_2)
	BRH EQ, R15
; %bb.3:                                ;   in Loop: Header=BB69_1 Depth=1
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.29
	SLT ADI R2, .L.str.29
	SLT ADD R12, R0, R3
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB69_4)
	SLT ADI R15, %lo(.LBB69_4)
	BRH EQ, R15
; %bb.5:                                ;   in Loop: Header=BB69_1 Depth=1
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.30
	SLT ADI R2, .L.str.30
	LDI R3, 6
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB69_6)
	SLT ADI R15, %lo(.LBB69_6)
	BRH EQ, R15
; %bb.7:                                ;   in Loop: Header=BB69_1 Depth=1
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.31
	SLT ADI R2, .L.str.31
	SLT ADD R12, R0, R3
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB69_8)
	SLT ADI R15, %lo(.LBB69_8)
	BRH EQ, R15
; %bb.9:                                ;   in Loop: Header=BB69_1 Depth=1
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.32
	SLT ADI R2, .L.str.32
	LDI R3, 9
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB69_10)
	SLT ADI R15, %lo(.LBB69_10)
	BRH EQ, R15
; %bb.11:                               ;   in Loop: Header=BB69_1 Depth=1
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.33
	SLT ADI R2, .L.str.33
	SLT ADD R12, R0, R3
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB69_12)
	SLT ADI R15, %lo(.LBB69_12)
	BRH EQ, R15
; %bb.13:                               ;   in Loop: Header=BB69_1 Depth=1
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.34
	SLT ADI R2, .L.str.34
	LDI R3, 8
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB69_14)
	SLT ADI R15, %lo(.LBB69_14)
	BRH EQ, R15
; %bb.15:                               ;   in Loop: Header=BB69_1 Depth=1
	CHAR LOD R9, R1, 2
	LDI R2, 16
	LSH R1, R2, R1
	CHAR LOD R9, R2, 3
	LDI R3, 24
	LSH R2, R3, R2
	NOR R2, R1, R1
	CHAR LOD R9, R2, 1
	LDI R3, 8
	LSH R2, R3, R2
	CHAR LOD R9, R3, 0
	NOR R2, R3, R2
	NOR R1, R1, R1
	NOR R2, R2, R2
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 0
	H LDI R2, 115
	SLT ADI R2, 27747
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB69_16)
	SLT ADI R15, %lo(.LBB69_16)
	BRH EQ, R15
; %bb.18:                               ;   in Loop: Header=BB69_1 Depth=1
	CHAR LOD R9, R1, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB69_1)
	SLT ADI R15, %lo(.LBB69_1)
	BRH EQ, R15
; %bb.19:                               ;   in Loop: Header=BB69_1 Depth=1
	LDI R1, 0
	H LDI R1, .L.str.27
	SLT ADI R1, .L.str.27
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(.LBB69_1)
	SLT ADI R15, %lo(.LBB69_1)
	JMP R15
.LBB69_4:                               ;   in Loop: Header=BB69_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+8
	SLT ADI R1, tabla_comandos+8
	H LDI R15, %hi(.LBB69_17)
	SLT ADI R15, %lo(.LBB69_17)
	JMP R15
.LBB69_6:                               ;   in Loop: Header=BB69_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+16
	SLT ADI R1, tabla_comandos+16
	H LDI R15, %hi(.LBB69_17)
	SLT ADI R15, %lo(.LBB69_17)
	JMP R15
.LBB69_8:                               ;   in Loop: Header=BB69_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+24
	SLT ADI R1, tabla_comandos+24
	H LDI R15, %hi(.LBB69_17)
	SLT ADI R15, %lo(.LBB69_17)
	JMP R15
.LBB69_10:                              ;   in Loop: Header=BB69_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+32
	SLT ADI R1, tabla_comandos+32
	H LDI R15, %hi(.LBB69_17)
	SLT ADI R15, %lo(.LBB69_17)
	JMP R15
.LBB69_12:                              ;   in Loop: Header=BB69_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+40
	SLT ADI R1, tabla_comandos+40
	H LDI R15, %hi(.LBB69_17)
	SLT ADI R15, %lo(.LBB69_17)
	JMP R15
.LBB69_14:                              ;   in Loop: Header=BB69_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+48
	SLT ADI R1, tabla_comandos+48
	H LDI R15, %hi(.LBB69_17)
	SLT ADI R15, %lo(.LBB69_17)
	JMP R15
.LBB69_16:                              ;   in Loop: Header=BB69_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+56
	SLT ADI R1, tabla_comandos+56
	H LDI R15, %hi(.LBB69_17)
	SLT ADI R15, %lo(.LBB69_17)
	JMP R15
.Lfunc_end69:
	.size	BiosShell, .Lfunc_end69-BiosShell
                                        ; -- End function
	.type	.L.str,@object                  ; @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"No se encontraron Memorias secundarias\n"
	.size	.L.str, 40

	.type	.L.str.1,@object                ; @.str.1
.L.str.1:
	.asciz	"No hay teclado conectado\n"
	.size	.L.str.1, 26

	.type	.L.str.2,@object                ; @.str.2
.L.str.2:
	.asciz	"EFI"
	.size	.L.str.2, 4

	.type	.L.str.1.3,@object              ; @.str.1.3
.L.str.1.3:
	.asciz	"/"
	.size	.L.str.1.3, 2

	.type	.L.str.2.4,@object              ; @.str.2.4
.L.str.2.4:
	.asciz	"EFI_Services"
	.size	.L.str.2.4, 13

	.type	kq,@object                      ; @kq
	.local	kq
	.comm	kq,4,4
	.type	kb_registers,@object            ; @kb_registers
	.local	kb_registers
	.comm	kb_registers,4,4
	.type	.L.str.9,@object                ; @.str.9
.L.str.9:
	.asciz	"\nIRQs deshabilitadas. Imposible leer datos.\n"
	.size	.L.str.9, 45

	.type	.L.str.1.7,@object              ; @.str.1.7
.L.str.1.7:
	.asciz	"\b"
	.size	.L.str.1.7, 2

	.type	.L.str.2.8,@object              ; @.str.2.8
.L.str.2.8:
	.asciz	"\n"
	.size	.L.str.2.8, 2

	.type	.L.str.3,@object                ; @.str.3
.L.str.3:
	.asciz	"\nError alojando memoria para el buffer de teclado"
	.size	.L.str.3, 50

	.type	nvmDevs,@object                 ; @nvmDevs
	.section	.bss,"aw",@nobits
	.globl	nvmDevs
	.p2align	2, 0x0
nvmDevs:
	.long	0
	.size	nvmDevs, 4

	.type	.L.str.12,@object               ; @.str.12
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.12:
	.asciz	"\nError alojando memoria para tabla NVM"
	.size	.L.str.12, 39

	.type	.L.str.1.13,@object             ; @.str.1.13
.L.str.1.13:
	.asciz	"\nError alojando tabla de bootloaders"
	.size	.L.str.1.13, 37

	.type	.L.str.2.14,@object             ; @.str.2.14
.L.str.2.14:
	.asciz	"\nError alojando paginas DMA para NVM"
	.size	.L.str.2.14, 37

	.type	.L.str.4,@object                ; @.str.4
.L.str.4:
	.asciz	"\nDispositivo NVM inexistente"
	.size	.L.str.4, 29

	.type	current_display,@object         ; @current_display
	.local	current_display
	.comm	current_display,4,4
	.type	display_queue,@object           ; @display_queue
	.local	display_queue
	.comm	display_queue,4,4
	.type	fs_gpt_list.zero,@object        ; @fs_gpt_list.zero
	.section	.rodata,"a",@progbits
fs_gpt_list.zero:
	.zero	4
	.size	fs_gpt_list.zero, 4

	.type	.L.str.1.25,@object             ; @.str.1.25
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.1.25:
	.asciz	"."
	.size	.L.str.1.25, 2

	.type	.L.str.2.26,@object             ; @.str.2.26
.L.str.2.26:
	.asciz	".."
	.size	.L.str.2.26, 3

	.type	irq_table,@object               ; @irq_table
	.local	irq_table
	.comm	irq_table,4,4
	.type	Registros,@object               ; @Registros
	.section	.bss,"aw",@nobits
	.globl	Registros
	.p2align	2, 0x0
Registros:
	.long	0
	.size	Registros, 4

	.type	.L.str.43,@object               ; @.str.43
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.43:
	.asciz	"Fatal Error: Unhandled IRQ"
	.size	.L.str.43, 27

	.type	.L.str.50,@object               ; @.str.50
.L.str.50:
	.asciz	"\nFatal Error: Page Fault without MMU"
	.size	.L.str.50, 37

	.type	.L.str.1.53,@object             ; @.str.1.53
.L.str.1.53:
	.asciz	"\nFatal Error: Alignament Fault"
	.size	.L.str.1.53, 31

	.type	.L.str.2.56,@object             ; @.str.2.56
.L.str.2.56:
	.asciz	"\nFatal Error: General Protection Fault"
	.size	.L.str.2.56, 39

	.type	.L.str.3.59,@object             ; @.str.3.59
.L.str.3.59:
	.asciz	"\nFatal Error: Invalid OpCode"
	.size	.L.str.3.59, 29

	.type	.L.str.4.62,@object             ; @.str.4.62
.L.str.4.62:
	.asciz	"\nFatal Error: Double Fault"
	.size	.L.str.4.62, 27

	.type	current_pool_index,@object      ; @current_pool_index
	.local	current_pool_index
	.comm	current_pool_index,4,4
	.type	ascii_pool,@object              ; @ascii_pool
	.local	ascii_pool
	.comm	ascii_pool,4,4
	.type	strtok.last_token,@object       ; @strtok.last_token
	.local	strtok.last_token
	.comm	strtok.last_token,4,4
	.type	poolFreeList,@object            ; @poolFreeList
	.local	poolFreeList
	.comm	poolFreeList,4,4
	.type	poolBump,@object                ; @poolBump
	.local	poolBump
	.comm	poolBump,4,4
	.type	poolRemaining,@object           ; @poolRemaining
	.local	poolRemaining
	.comm	poolRemaining,4,4
	.type	varMap,@object                  ; @varMap
	.local	varMap
	.comm	varMap,4,4
	.type	mapEntries,@object              ; @mapEntries
	.local	mapEntries
	.comm	mapEntries,4,4
	.type	.L.str.81,@object               ; @.str.81
.L.str.81:
	.asciz	"El sistema permite estos comandos: \n"
	.size	.L.str.81, 37

	.type	.L.str.1.82,@object             ; @.str.1.82
.L.str.1.82:
	.asciz	"- "
	.size	.L.str.1.82, 3

	.type	tabla_comandos,@object          ; @tabla_comandos
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
tabla_comandos:
	.long	.L.str.28
	.long	help
	.long	.L.str.29
	.long	sysOff
	.long	.L.str.30
	.long	reset
	.long	.L.str.31
	.long	initSO
	.long	.L.str.32
	.long	enumdisp
	.long	.L.str.33
	.long	lsboot
	.long	.L.str.34
	.long	setboot
	.long	.L.str.35
	.long	cls
	.size	tabla_comandos, 64

	.type	.L.str.2.83,@object             ; @.str.2.83
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.2.83:
	.asciz	"\n"
	.size	.L.str.2.83, 2

	.type	.L.str.3.84,@object             ; @.str.3.84
.L.str.3.84:
	.asciz	"Apagando sistema..."
	.size	.L.str.3.84, 20

	.type	bootSelected,@object            ; @bootSelected
	.section	.bss,"aw",@nobits
	.globl	bootSelected
	.p2align	2, 0x0
bootSelected:
	.long	0                               ; 0x0
	.size	bootSelected, 4

	.type	.L.str.4.85,@object             ; @.str.4.85
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.4.85:
	.asciz	"Primero seleccione un bootloader con 'setboot'\n"
	.size	.L.str.4.85, 48

	.type	bootEntries,@object             ; @bootEntries
	.section	.bss,"aw",@nobits
	.globl	bootEntries
	.p2align	2, 0x0
bootEntries:
	.long	0
	.size	bootEntries, 4

	.type	.L.str.5,@object                ; @.str.5
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.5:
	.asciz	"Cargando "
	.size	.L.str.5, 10

	.type	.L.str.6,@object                ; @.str.6
.L.str.6:
	.asciz	"/"
	.size	.L.str.6, 2

	.type	.L.str.7,@object                ; @.str.7
.L.str.7:
	.asciz	"...\n"
	.size	.L.str.7, 5

	.type	.L.str.8,@object                ; @.str.8
.L.str.8:
	.asciz	"El bootloader devolvio el control a la BIOS\n"
	.size	.L.str.8, 45

	.type	.L.str.9.87,@object             ; @.str.9.87
.L.str.9.87:
	.asciz	"Error: no se pudo montar la particion EFI\n"
	.size	.L.str.9.87, 43

	.type	.L.str.10,@object               ; @.str.10
.L.str.10:
	.asciz	"Error: no se pudo leer el bootloader\n"
	.size	.L.str.10, 38

	.type	.L.str.11,@object               ; @.str.11
.L.str.11:
	.asciz	"Error: no hay memoria para cargar el bootloader\n"
	.size	.L.str.11, 49

	.type	.L.str.12.86,@object            ; @.str.12.86
.L.str.12.86:
	.asciz	"Error: bootloader inexistente\n"
	.size	.L.str.12.86, 31

	.type	.L.str.13,@object               ; @.str.13
.L.str.13:
	.asciz	"Hay "
	.size	.L.str.13, 5

	.type	Globals,@object                 ; @Globals
	.section	.bss,"aw",@nobits
	.globl	Globals
	.p2align	2, 0x0
Globals:
	.long	0
	.size	Globals, 4

	.type	.L.str.14,@object               ; @.str.14
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.14:
	.asciz	" dispositivos conectados\n"
	.size	.L.str.14, 26

	.type	.L.str.15,@object               ; @.str.15
.L.str.15:
	.asciz	"Class Code   ECAM Address\n"
	.size	.L.str.15, 27

	.type	.L.str.16,@object               ; @.str.16
.L.str.16:
	.asciz	"------------ ------------\n"
	.size	.L.str.16, 27

	.type	mapa,@object                    ; @mapa
	.section	.bss,"aw",@nobits
	.globl	mapa
	.p2align	2, 0x0
mapa:
	.long	0
	.size	mapa, 4

	.type	bootCount,@object               ; @bootCount
	.globl	bootCount
	.p2align	2, 0x0
bootCount:
	.long	0                               ; 0x0
	.size	bootCount, 4

	.type	.L.str.17,@object               ; @.str.17
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.17:
	.asciz	"No hay bootloaders en las particiones EFI\n"
	.size	.L.str.17, 43

	.type	.L.str.18,@object               ; @.str.18
.L.str.18:
	.asciz	" bootloaders\n"
	.size	.L.str.18, 14

	.type	.L.str.19,@object               ; @.str.19
.L.str.19:
	.asciz	"ID    Carpeta         Bootloader\n"
	.size	.L.str.19, 34

	.type	.L.str.20,@object               ; @.str.20
.L.str.20:
	.asciz	"--    -------         ----------\n"
	.size	.L.str.20, 34

	.type	.L.str.21,@object               ; @.str.21
.L.str.21:
	.asciz	"No hay bootloaders para elegir\n"
	.size	.L.str.21, 32

	.type	.L.str.22,@object               ; @.str.22
.L.str.22:
	.asciz	"ID del bootloader (Enter para cancelar): "
	.size	.L.str.22, 42

	.type	.L.str.23,@object               ; @.str.23
.L.str.23:
	.asciz	"Cancelado\n"
	.size	.L.str.23, 11

	.type	.L.str.24,@object               ; @.str.24
.L.str.24:
	.asciz	"ID invalido. Use 'lsboot' para ver los IDs\n"
	.size	.L.str.24, 44

	.type	.L.str.25,@object               ; @.str.25
.L.str.25:
	.asciz	"Seleccionado: "
	.size	.L.str.25, 15

	.type	.L.str.26,@object               ; @.str.26
.L.str.26:
	.asciz	">"
	.size	.L.str.26, 2

	.type	.L.str.27,@object               ; @.str.27
.L.str.27:
	.asciz	"Comando no reconocido. Use 'help' para ver los comandos reconocidos\n"
	.size	.L.str.27, 69

	.type	.L.str.28,@object               ; @.str.28
.L.str.28:
	.asciz	"help"
	.size	.L.str.28, 5

	.type	.L.str.29,@object               ; @.str.29
.L.str.29:
	.asciz	"sysOff"
	.size	.L.str.29, 7

	.type	.L.str.30,@object               ; @.str.30
.L.str.30:
	.asciz	"reset"
	.size	.L.str.30, 6

	.type	.L.str.31,@object               ; @.str.31
.L.str.31:
	.asciz	"initSO"
	.size	.L.str.31, 7

	.type	.L.str.32,@object               ; @.str.32
.L.str.32:
	.asciz	"enumdisp"
	.size	.L.str.32, 9

	.type	.L.str.33,@object               ; @.str.33
.L.str.33:
	.asciz	"lsboot"
	.size	.L.str.33, 7

	.type	.L.str.34,@object               ; @.str.34
.L.str.34:
	.asciz	"setboot"
	.size	.L.str.34, 8

	.type	.L.str.35,@object               ; @.str.35
.L.str.35:
	.asciz	"cls"
	.size	.L.str.35, 4

	.type	.L.str.36,@object               ; @.str.36
.L.str.36:
	.asciz	"Continuar? (c/Enter, q para salir): "
	.size	.L.str.36, 37

	.type	.Lswitch.table.initSO,@object   ; @switch.table.initSO
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
.Lswitch.table.initSO:
	.long	.L.str.11
	.long	.L.str.10
	.long	.L.str.9.87
	.long	.L.str.12.86
	.long	.L.str.8
	.size	.Lswitch.table.initSO, 20

	.ident	"clang version 24.0.0git (https://github.com/Licha-M/llvm-project-ISA32-LM.git 2be4a0c0192624151272935c0f47976a434289a2)"
	.section	".note.GNU-stack","",@progbits

; ════════════════════ .start auto-generado ════════════════════
; Inicio en palabra ROM 13023 (byte 0x00CB7C)
; .start:
;	H LDI R14, 0		; SP = 0x00001000
;	SLT ADI R14, 4096
;	H LDI R15, %hi(main)
;	SLT ADI R15, %lo(main)
;	JMP R15
