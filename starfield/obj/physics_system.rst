ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;  PHYSICS SYSTEM
                              3 ;;
                              4 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              5 .include "physics_system.h.s"
                              1 ;;
                              2 ;;  PHYSICS SYSTEM
                              3 ;;
                              4 
                              5 
                              6 ;; FUNCTIONS
                              7 .globl system_physics_update_one_entity
                              8 .globl system_physics_update
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              6 .include "entity_manager.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             55 .globl manager_entity_restart
                             56 .globl manager_entity_forall
                             57 .globl manager_entity_set4destruction
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              7 
                              8 
                              9 
                             10 
                             11 ;; Update one entity
                             12 ;; INPUTS
                             13 ;;      IX: Pointer to one entity for updating
                             14 ;; DESTROY
                             15 ;;      A, B
   4179                      16 system_physics_update_one_entity::
                             17 
                             18     ;; Reanimate star
   4179 DD 7E 04      [19]   19     ld      a, t_color(ix)
   417C C6 00         [ 7]   20     add     a, #0x00
   417E 20 03         [12]   21     jr     nz, _strtloop
                             22 
   4180 CD AE 40      [17]   23         call manager_entity_restart
                             24 
   4183                      25 _strtloop:
                             26 
                             27     ;; Update position x with vx
   4183 DD 7E 01      [19]   28     ld      a, t_x(ix)
   4186 DD 46 03      [19]   29     ld      b, t_vx(ix)
                             30     
   4189                      31 _vxloop:
                             32 
   4189 3D            [ 4]   33     dec     a
   418A 28 08         [12]   34     jr      z, destroy_entity
                             35 
   418C 04            [ 4]   36     inc     b
   418D 20 FA         [12]   37     jr     nz, _vxloop              ; Check if position go out the screen
                             38 
   418F DD 77 01      [19]   39     ld      t_x(ix), a              ; Save new position on memory
   4192 18 03         [12]   40     jr      finish_update           ; Dont destroy and finish
                             41 
   4194                      42 destroy_entity:
   4194 CD A9 40      [17]   43     call    manager_entity_set4destruction
                             44 
   4197                      45 finish_update:
   4197 C9            [10]   46     ret
                             47 
                             48 
                             49 
                             50 
                             51 ;; Update all entities
   4198                      52 system_physics_update::
                             53    ; ld     hl, #system_physics_update_one_entity
   4198 0E 01         [ 7]   54     ld      c, #0x01
   419A CD 7E 40      [17]   55     call    manager_entity_forall      ; Disengage physic system and entity manager
   419D C9            [10]   56     ret
