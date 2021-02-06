ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



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
                             55 .globl manager_entity_restart
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             56 .globl manager_entity_forall
                             57 .globl manager_entity_set4destruction
