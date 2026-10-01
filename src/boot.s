.code16

.text
.global _start
_start:
	xor %ax, %ax
	mov %ax, %cs
	mov %ax, %ds
	mov %ax, %gs
	mov %ax, %fs

	ljmp $0x07C0, $start

.org 510
.word 0xAA55

.org 0x07C0
start:
	cli

	sti
