/*
Source to be compiled with RGBDS
*/

include "pokeyellow.inc"
; include "pokered.inc"

SECTION "ItemGiverTest", ROM0

LOAD "ItemGiver", WRAMX[$D8B4]  ; $D8B5 for rb
start:
call ClearScreen
ld a, 255		    ; total item IDs
ld [wMaxItemQuantity],a 
call DisplayChooseQuantityMenu
and a, a		    ; if a is 0, z flag is set
ret nz 			    ; if B pressed, then ret
ld a, [wItemQuantity]
push af
ld [wNamedObjectIndex], a
call GetItemName 
ld hl, $c409	    ; destination
ld de, wNameBuffer	; origin
call CopyString
dec hl
ld [hl], $7f	    ; blank last name byte
ld a, 99
ld [wMaxItemQuantity], a
call DisplayChooseQuantityMenu
pop bc
and a, a		    ; if a is 0, z flag is set
jr nz, start	    ; if B pressed go to the beginning, ln0
ld a, [wItemQuantity]
ld c, a			    ; bc = id, quantity
call GiveItem
jr start		    ; jp to start, ln0
ENDL
 
