;;
;; ENTITY MANAGER
;;



;; CONSTANT
max_entities == 15

;; Accessing to each variable of entity
t_type   = 0
t_x      = 1
t_y      = 2
t_vx     = 3
t_color  = 4
sizeof_t = 5

;; Entity state
e_type_invalid = 0x00
e_type_star    = 0x01   ; Lower bit signals star entity
e_type_dead    = 0x80   ; Upper bit signals dead entity
e_type_default = 0x7F   ; Default entity (all bits = 1)



;; MACROS
;; Define a new unknown entity
.macro Unknown_Entity_t, _type, _x, _y, _vx, _color
   .db   _type
   .db   _x
   .db   _y
   .db   _vx
   .db   _color
.endm

;; Define a new Entity
.macro Entity_t, _name, _type, _x, _y, _vx, _color
_name::
   Unknown_Entity_t _type, _x, _y, _vx, _color
.endm

;; Define an entities array
.macro Entity_Array _name, _N
_name::
   .rept _N
      Unknown_Entity_t 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   .endm
.endm



;; FUNTIONS
.globl manager_entity_init
.globl manager_entity_create
.globl manager_entity_restart
.globl manager_entity_forall
.globl manager_entity_set4destruction
