ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;; ENTITY MANAGER
                              3 ;;
                              4 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              5 .include "entity_manager.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                             55 .globl manager_entity_restart
                             56 .globl manager_entity_forall
                             57 .globl manager_entity_set4destruction
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              6 .include "physics_system.h.s"
                              1 ;;
                              2 ;;  PHYSICS SYSTEM
                              3 ;;
                              4 
                              5 
                              6 ;; FUNCTIONS
                              7 .globl system_physics_update_one_entity
                              8 .globl system_physics_update
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              7 .include "render_system.h.s"
                              1 ;;
                              2 ;;  PHYSICS SYSTEM
                              3 ;;
                              4 
                              5 .globl system_render_one_entity
                              6 .globl system_render_update
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                              8 .include "cpctelera_functions.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                              9 
                             10 
                             11 ;; Global variables
   4000 00                   12 _reserved_entities::    .db 0
   4001 04 40                13 _last_element_ptr::     .dw m_entities
   4003 00                   14 _function_forall::      .db 0
                             15 
                             16 ;; Create an empty array with all entities
   4004                      17 Entity_Array m_entities max_entities
   0004                       1 m_entities::
                              2    .rept max_entities
                              3       Unknown_Entity_t 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
                              4    .endm
   0004                       1       Unknown_Entity_t 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   4004 DE                    1    .db   0xDE
   4005 AD                    2    .db   0xAD
   4006 DE                    3    .db   0xDE
   4007 AD                    4    .db   0xAD
   4008 AA                    5    .db   0xAA
   0009                       1       Unknown_Entity_t 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   4009 DE                    1    .db   0xDE
   400A AD                    2    .db   0xAD
   400B DE                    3    .db   0xDE
   400C AD                    4    .db   0xAD
   400D AA                    5    .db   0xAA
   000E                       1       Unknown_Entity_t 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   400E DE                    1    .db   0xDE
   400F AD                    2    .db   0xAD
   4010 DE                    3    .db   0xDE
   4011 AD                    4    .db   0xAD
   4012 AA                    5    .db   0xAA
   0013                       1       Unknown_Entity_t 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   4013 DE                    1    .db   0xDE
   4014 AD                    2    .db   0xAD
   4015 DE                    3    .db   0xDE
   4016 AD                    4    .db   0xAD
   4017 AA                    5    .db   0xAA
   0018                       1       Unknown_Entity_t 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   4018 DE                    1    .db   0xDE
   4019 AD                    2    .db   0xAD
   401A DE                    3    .db   0xDE
   401B AD                    4    .db   0xAD
   401C AA                    5    .db   0xAA
   001D                       1       Unknown_Entity_t 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   401D DE                    1    .db   0xDE
   401E AD                    2    .db   0xAD
   401F DE                    3    .db   0xDE
   4020 AD                    4    .db   0xAD
   4021 AA                    5    .db   0xAA
   0022                       1       Unknown_Entity_t 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   4022 DE                    1    .db   0xDE
   4023 AD                    2    .db   0xAD
   4024 DE                    3    .db   0xDE
   4025 AD                    4    .db   0xAD
   4026 AA                    5    .db   0xAA
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   0027                       1       Unknown_Entity_t 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   4027 DE                    1    .db   0xDE
   4028 AD                    2    .db   0xAD
   4029 DE                    3    .db   0xDE
   402A AD                    4    .db   0xAD
   402B AA                    5    .db   0xAA
   002C                       1       Unknown_Entity_t 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   402C DE                    1    .db   0xDE
   402D AD                    2    .db   0xAD
   402E DE                    3    .db   0xDE
   402F AD                    4    .db   0xAD
   4030 AA                    5    .db   0xAA
   0031                       1       Unknown_Entity_t 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   4031 DE                    1    .db   0xDE
   4032 AD                    2    .db   0xAD
   4033 DE                    3    .db   0xDE
   4034 AD                    4    .db   0xAD
   4035 AA                    5    .db   0xAA
   0036                       1       Unknown_Entity_t 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   4036 DE                    1    .db   0xDE
   4037 AD                    2    .db   0xAD
   4038 DE                    3    .db   0xDE
   4039 AD                    4    .db   0xAD
   403A AA                    5    .db   0xAA
   003B                       1       Unknown_Entity_t 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   403B DE                    1    .db   0xDE
   403C AD                    2    .db   0xAD
   403D DE                    3    .db   0xDE
   403E AD                    4    .db   0xAD
   403F AA                    5    .db   0xAA
   0040                       1       Unknown_Entity_t 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   4040 DE                    1    .db   0xDE
   4041 AD                    2    .db   0xAD
   4042 DE                    3    .db   0xDE
   4043 AD                    4    .db   0xAD
   4044 AA                    5    .db   0xAA
   0045                       1       Unknown_Entity_t 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   4045 DE                    1    .db   0xDE
   4046 AD                    2    .db   0xAD
   4047 DE                    3    .db   0xDE
   4048 AD                    4    .db   0xAD
   4049 AA                    5    .db   0xAA
   004A                       1       Unknown_Entity_t 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   404A DE                    1    .db   0xDE
   404B AD                    2    .db   0xAD
   404C DE                    3    .db   0xDE
   404D AD                    4    .db   0xAD
   404E AA                    5    .db   0xAA
                             18 
                             19 
                             20 
   404F                      21 manager_entity_init::
   404F C9            [10]   22     ret
                             23 
                             24 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                             25 ;; Create a new Entity
                             26 ;; INPUTS
                             27 ;;      HL: Pointer to entity initializer byte of entity
                             28 ;; DESTROY
                             29 ;;      HL, DE, BC, IX, A
   4050                      30 manager_entity_create::
                             31 
                             32     ;; Copy new entity in memory
   4050 ED 5B 01 40   [20]   33     ld      de, (_last_element_ptr)
   4054 01 05 00      [10]   34     ld      bc, #sizeof_t
   4057 ED B0         [21]   35     ldir
                             36 
                             37     ;; Give a random y position
   4059 DD 2A 01 40   [20]   38     ld      ix, (_last_element_ptr)
   405D CD EC 41      [17]   39     call    cpct_getRandom_mxor_u8_asm  ; WARNING: Destroy AF, BC, DE, HL
   4060 7D            [ 4]   40     ld      a, l
   4061 DD 77 01      [19]   41     ld      t_x(ix), a
                             42 
                             43     ;; Set entity type with defult value
   4064 3E 7F         [ 7]   44     ld       a, #e_type_default
   4066 DD 77 00      [19]   45     ld      t_type(ix), a
                             46 
                             47     ;; Move the pointer to the next free entity
   4069 2A 01 40      [16]   48     ld      hl, (_last_element_ptr)
   406C 01 05 00      [10]   49     ld      bc, #sizeof_t
   406F 09            [11]   50     add     hl, bc
   4070 22 01 40      [16]   51     ld      (_last_element_ptr), hl
                             52 
                             53     ;; Increment the total count of entities in the array
   4073 3A 00 40      [13]   54     ld      a, (_reserved_entities)
   4076 3C            [ 4]   55     inc     a
   4077 32 00 40      [13]   56     ld      (_reserved_entities), a
                             57 
   407A CD EC 41      [17]   58     call    cpct_getRandom_mxor_u8_asm
                             59     
   407D C9            [10]   60     ret
                             61 
                             62 
                             63 
                             64 ;; Travel the entities array for updating each one
                             65 ;; INPUTS
                             66 ;;      C: Funtion to execute (1-Physics or 0-Render)
                             67 ;; DESTROY
                             68 ;;      A, IX, DE
   407E                      69 manager_entity_forall::
                             70 
   407E 79            [ 4]   71     ld      a, c
   407F 32 03 40      [13]   72     ld      (_function_forall), a
   4082 3A 00 40      [13]   73     ld      a, (_reserved_entities) ; Num of entities
   4085 DD 21 04 40   [14]   74     ld     ix, #m_entities          ; Direction of the first element in array
                             75  ;   ld     (_function_forall), bc   ; Choose the function to execute in BC
                             76 
   4089                      77 _updloop:
   4089 F5            [11]   78     push   af                       ; Save number of entities in the stack
                             79 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   408A DD 7E 00      [19]   80     ld      a, t_type(ix)           ; Entity type
   408D C6 00         [ 7]   81     add     a, #0x00                ; if = 0
   408F 28 0E         [12]   82     jr      z, _next_it_loop        ; The type is invalid
                             83 
                             84         ; the type is valid so update it
                             85         ;call (_function_forall)     ; WARNING: Destroy A and B
   4091 3A 03 40      [13]   86         ld      a, (_function_forall)
   4094 3D            [ 4]   87         dec     a
   4095 28 05         [12]   88         jr      z, function1
                             89 
   4097 CD 9E 41      [17]   90             call    system_render_one_entity    ;; Cant read the content
   409A 18 03         [12]   91             jr      _next_it_loop
                             92 
   409C                      93         function1:
   409C CD 79 41      [17]   94             call    system_physics_update_one_entity
                             95 
   409F                      96 _next_it_loop:
   409F F1            [10]   97     pop     af                      ; Bring A value from stack
                             98 
   40A0 3D            [ 4]   99     dec     a                       ; One less entity
   40A1 C8            [11]  100     ret     z                       ; End loop
                            101 
   40A2 11 05 00      [10]  102     ld     de, #sizeof_t            ; Size of a entity
   40A5 DD 19         [15]  103     add    ix, de                   ; Next entity of array
   40A7 18 E0         [12]  104     jr     _updloop                 ; Go back to the loop
                            105 
                            106 
                            107 
                            108 
                            109 ;; Set entity for later destruction
                            110 ;; INPUTS
                            111 ;;      IX: Pointer to one entity for updating
                            112 ;; DESTROY
                            113 ;;      A
   40A9                     114 manager_entity_set4destruction::
   40A9 DD 36 04 00   [19]  115     ld      t_color(ix), #0x00
   40AD C9            [10]  116     ret
                            117 
                            118 
                            119 
                            120 
                            121 ;; Destroy an existent entity
                            122 ;; Only reset the position
                            123 ;; INPUTS
                            124 ;;      IX: Pointer to one entity for updating
                            125 ;; DESTROY
                            126 ;;      A
   40AE                     127 manager_entity_restart::
   40AE DD 36 01 4F   [19]  128     ld      t_x(ix), #79
   40B2 DD 36 04 FF   [19]  129     ld      t_color(ix), #0xFF
   40B6 C9            [10]  130     ret
