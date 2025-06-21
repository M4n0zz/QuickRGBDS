/*
Source is compiled with QuickRGBDS
https://github.com/M4n0zz/QuickRGBDS

MOVE THIS FILE OUTSIDE QuickRGBDS FOLDER BEFORE COMPILATION, otherwise it will be deleted!

This assembly file serves as a clear and practical example of how to use RGBDS to write ACE payloads.

One of the main advantages of using RGBDS is that you can define the exact memory location
where a payload should reside, allowing all static and relative jumps to be automatically
calculated by the assembler.

To simplify compatibility across different game versions (e.g., Pokémon Red and Yellow)
and completely avoid dealing with hardcoded addresses when calling specific functions,
you can include preconfigured .inc files containing memory labels—sourced from pret-style projects.
This makes it easy to write portable and version-flexible payloads.

This example showcases the use of the game's internal copy function to render a message on-screen,
and then executes a payload that triggers the HealParty routine to restore all party Pokémon.

*/


include "pokered.inc"              ; we first include our game's compatible address book
;include "pokeyellow.inc"          ; this way we can call functions by using names coming
                                   ; directly from pret .sym files
                                   ; https://github.com/pret/pokered/blob/symbols/pokered.sym
                                   
include "charmap.inc"              ; this one gives us all game's character to easily print text

                                   
                                   ; we can also declare our own values 
DEF injectAddressRB      = $D8B5   ; In our example we are using TimoVM's nickname writer
DEF injectAddressY       = $D8B4   ; to inject our payloads, which uses these specific addresses
                                   ; https://glitchcity.wiki/wiki/Guides:TimoVM%27s_gen_1_ACE_setups                                 
                                   

SECTION "ScriptName", ROM0         ; this is required from RGBDS, we can give our script's name


start:

LOAD "NicknameWriterPayload", WRAMX[injectAddressRB]
; The LOAD directive tells the assembler where the payload will be placed in memory.
; This ensures that any static jumps or memory references within the payload are automatically
; adjusted based on that starting address.
; USEFUL NOTE: Different memory segments have specific labels.
; For example:
; $C000–$CFFF is referred to as WRAM0 (Work RAM Bank 0)
; $D000–$DFFF is referred to as WRAMX (Switchable Work RAM Bank 1)
     
;;;;;;;;;;;; Payload ;;;;;;;;;;;; 
payload:
ld   bc, textwidth                 ; number of bytes to be copied
ld   hl, textstart                 ; origin address
ld   de, $c3cc                     ; destination address
call CopyData
; This particular function copies a number of bytes—specified in register BC—
; from the source address in HL to the destination address in DE.
; 
; The value in HL is calculated dynamically within the script and points to the start of the text,
; while DE holds the destination tilemap address, typically corresponding to a position on the screen.
; 
; The exact number of bytes to copy (BC) is defined and calculated at the end of the program.

halt
halt
halt
halt
halt
halt
; Add a brief delay so the text stays on screen long enough to be seen.

ld   b, $03                   
ld   hl, HealParty
jp   Bankswitch
; Game Boy games use different ROM banks. In this example, we use the game's internal function
; by first loading the desired bank (bank 3) into register B, and setting HL to point to the 
; HealParty function.
;
; Once the payload calls HealParty, the function completes its task and returns to the address
; that was previously stored on the stack by the game.
; Furthermore, the Bankswitch function also restores the previously loaded ROM bank after execution.
; This ensures the game doesn't crash due to ROM bank misalignment, maintaining stability after the payload runs.
;
; Instead of using a CALL followed by a RET, we use a single JP as a shortcut. This works because
; HealParty handles its own return internally, so there's no need for our payload to explicitly
; return afterward.

textstart:
db "Healing..."               ; characters are picked automatically from charmap.inc
db $e7                        ; char '!'
textstop:
     
.end
ENDL                          ; is required to close the LOAD BLOCK
     
     
DEF textwidth = textstop-textstart           
; this calculation should be placed here, since RGBDS throws an error if done at the beginning


