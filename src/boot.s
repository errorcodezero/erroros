.code16
.org 0

.text
.global _start
_start:
	cli
	xor %ax, %ax
	mov %ax, %ds
	mov %ax, %es
	mov %ax, %fs
	mov %ax, %gs

	mov %ax, %ss
	mov $0x7C00, %sp

	sti

hang:
	hlt
	jmp hang

.org 510
.word 0xAA55
