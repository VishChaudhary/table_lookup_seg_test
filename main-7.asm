;
; table_lookup_seg_test.asm
;
; Created: 10/27/2021 5:56:38 PM
; Author : vish7
;


; Replace with your application code
start:
	ldi r16, 0xFF
	out VPORTD_DIR, r16
	ldi r16, 0xF0
	out VPORTA_DIR, r16
	ldi r16, 0x01
	out VPORTE_DIR, r16
	ldi r16, 0x00
	out VPORTC_DIR, r16
main:
	ldi r17, 0xE0 //only using right most digit
	out VPORTA_OUT, r17
	in r16, VPORTC_IN ;take in input
	rcall reverse_bit ;reverse it
	rcall hex_to_7seg ;converts it to 7seg
	out VPORTD_OUT, r18 ;output
	rjmp main ;loop

reverse_bit:
	bst r16, 0
	bld r18, 7
	bst r16, 1
	bld r18, 6
	bst r16, 2
	bld r18, 5
	bst r16, 3
	bld r18, 4
	bst r16, 4
	bld r18, 3
	bst r16, 5
	bld r18, 2
	bst r16, 6
	bld r18, 1
	bst r16, 7
	bld r18, 0
	ret

hex_to_7seg:
	ldi ZH, HIGH(hextable *2) //set Z to point to start of table
	ldi ZL, LOW(hextable *2)
	ldi r16, $00
	andi r18, 0x0F
	add ZL, r18
	adc ZH, r16

	lpm r18, Z
	ret

//Table of segment values to display digits 0 - F
//!!! seven values must be added
hextable: .db $01, $4F, $12, $06, $4C, $24, $20, $0F, $00, $4F, $04, $08, $60, $31, $42, $38


