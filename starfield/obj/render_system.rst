ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;  PHYSICS SYSTEM
                              3 ;;
                              4 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              5 .include "render_system.h.s"
                              1 ;;
                              2 ;;  PHYSICS SYSTEM
                              3 ;;
                              4 
                              5 .globl system_render_one_entity
                              6 .globl system_render_update
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              6 .include "cpctelera_functions.h.s"
                              1 ;;
                              2 ;;  CPCTELERA FUNCTIONS
                              3 ;;
                              4 
                              5 ;; GLOBAL FUNCTIONS
                              6 .globl cpct_disableFirmware_asm
                              7 .globl cpct_getScreenPtr_asm
                              8 .globl cpct_setVideoMode_asm
                              9 .globl cpct_setPALColour_asm
                             10 .globl cpct_getRandom_mxor_u8_asm
                             11 .globl cpct_waitVSYNC_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              7 .include "entity_manager.h.s"
                              1 ;;
                              2 ;; ENTITY MANAGER
                              3 ;;
                              4 
                              5 
                              6 
                              7 ;; CONSTANT
                     000F     8 max_entities == 15
                              9 
                             10 ;; Accessing to each variable of entity
                     0000    11 t_type   = 0
                     0001    12 t_x      = 1
                     0002    13 t_y      = 2
                     0003    14 t_vx     = 3
                     0004    15 t_color  = 4
                     0005    16 sizeof_t = 5
                             17 
                             18 ;; Entity state
                     0000    19 e_type_invalid = 0x00
                     0001    20 e_type_star    = 0x01   ; Lower bit signals star entity
                     0080    21 e_type_dead    = 0x80   ; Upper bit signals dead entity
                     007F    22 e_type_default = 0x7F   ; Default entity (all bits = 1)
                             23 
                             24 
                             25 
                             26 ;; MACROS
                             27 ;; Define a new unknown entity
                             28 .macro Unknown_Entity_t, _type, _x, _y, _vx, _color
                             29    .db   _type
                             30    .db   _x
                             31    .db   _y
                             32    .db   _vx
                             33    .db   _color
                             34 .endm
                             35 
                             36 ;; Define a new Entity
                             37 .macro Entity_t, _name, _type, _x, _y, _vx, _color
                             38 _name::
                             39    Unknown_Entity_t _type, _x, _y, _vx, _color
                             40 .endm
                             41 
                             42 ;; Define an entities array
                             43 .macro Entity_Array _name, _N
                             44 _name::
                             45    .rept _N
                             46       Unknown_Entity_t 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
                             47    .endm
                             48 .endm
                             49 
                             50 
                             51 
                             52 ;; FUNTIONS
                             53 .globl manager_entity_init
                             54 .globl manager_entity_create
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                             55 .globl manager_entity_restart
                             56 .globl manager_entity_forall
                             57 .globl manager_entity_set4destruction
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              8 
                              9 
                             10 
                             11 ;; Render one entity
                             12 ;; INPUTS
                             13 ;;      IX: Pointer to one entity for updating
                             14 ;; DESTROY
                             15 ;;      HL, DE, BC, A
   419E                      16 system_render_one_entity::
   419E 11 00 C0      [10]   17     ld      de, #0xC000             ; Start of the screen
   41A1 DD 4E 01      [19]   18     ld       c, t_x(ix)             ; X
   41A4 DD 46 02      [19]   19     ld       b, t_y(ix)             ; Y
   41A7 CD 12 42      [17]   20     call    cpct_getScreenPtr_asm   ; Save pointer in HL
                             21 
   41AA DD 7E 04      [19]   22     ld      a, t_color(ix)
   41AD 77            [ 7]   23     ld      (hl), a
                             24 
   41AE 3E 03         [ 7]   25     ld      a, #3
   41B0                      26 _delete_back:
   41B0 23            [ 6]   27     inc     hl
   41B1 36 00         [10]   28     ld      (hl), #0x00             ; Draw with background color
   41B3 3D            [ 4]   29     dec     a
   41B4 20 FA         [12]   30     jr     nz, _delete_back
                             31 
   41B6 C9            [10]   32     ret
                             33 
                             34 
                             35 
                             36 
   41B7                      37 system_render_update::
   41B7 0E 00         [ 7]   38     ld      c, #0x00
   41B9 CD 7E 40      [17]   39     call    manager_entity_forall
   41BC C9            [10]   40     ret
                             41 
