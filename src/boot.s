.code16

.text
.global _start
_start:
	cli
	ljmp $0x07C0, $start

start:
	/* set up segment registers to match CS */
	mov %cs, %ax
	mov %ax, %ds
	mov %ax, %es
	mov %ax, %fs
	mov %ax, %gs

	xor %ax, %ax
	mov %ax, %ss
	mov $0x7C00, %sp

	sti

xor %si, %si

print:
	mov $0x0E, %ah
	mov hello(%si), %al
	cmpb $0, %al
	je halt

	int $0x10
	inc %si
	jmp print


halt:
	cli
1:	hlt
	jmp 1b

hello:
	.asciz "Hello World!\n"

.org 510
.word 0xAA55
