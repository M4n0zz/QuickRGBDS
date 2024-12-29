/*
Source to be compiled with RGBDS
*/

DEF GiveItem 	EQU $3e3f
DEF ClearScreen EQU $16dd

SECTION "YellowTest", ROM0

LOAD "ItemGiver", WRAMX[$D8B4]
start:
call ClearScreen
ld a, 255		; total item IDs
ld [$cf96],a 	; wMaxItemQuantity write
call $2c51 		; DisplayChooseQuantityMenu
and a, a		; if a is 0, z flag is set
ret nz 			; if B pressed, then ret
ld a, [$cf95] 	; wItemQuantity read
push af
ld [$d11d], a	; wd11e - wNamedObjectIndex
call $2ec4 		; GetItemName
ld hl, $c409	; destination
ld de, $cd6d	; origin (wNameBuffer)
call $3816		; CopyString
dec hl
ld [hl], $7f	; blank last name byte
ld a, 99
ld [$cf96], a 	; wMaxItemQuantity
call $2c51 		; DisplayChooseQuantityMenu
pop bc
and a, a		; if a is 0, z flag is set
jr nz, start	; if B pressed go to the beginning, ln0
ld a, [$cf95] 	; wItemQuantity
ld c, a			; bc = id, quantity
call GiveItem
jr start		; jp to start, ln0
ENDL
 