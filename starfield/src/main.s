.include "cpctelera.h.s"
.include "cpctelera_functions.h.s"
.include "entity_manager.h.s"
.include "physics_system.h.s"
.include "render_system.h.s"


.area _DATA
.area _CODE


;; Entities to create
Entity_t init_e0 e_type_star, 79, 1,   -3, 0xFF ; type, x, y, vx, color
Entity_t init_e1 e_type_star, 79, 9,  -1, 0xFF ; type, x, y, vx, color
Entity_t init_e2 e_type_star, 79, 15,  -3, 0xFF ; type, x, y, vx, color
Entity_t init_e3 e_type_star, 79, 30, -1, 0xFF ; type, x, y, vx, color
Entity_t init_e4 e_type_star, 79, 55, -2, 0xFF ; type, x, y, vx, color
Entity_t init_e5 e_type_star, 79, 70, -1, 0xFF ; type, x, y, vx, color
Entity_t init_e6 e_type_star, 79, 75, -3, 0xFF ; type, x, y, vx, color
Entity_t init_e7 e_type_star, 79, 100, -1, 0xFF ; type, x, y, vx, color
Entity_t init_e8 e_type_star, 79, 120, -2, 0xFF ; type, x, y, vx, color
Entity_t init_e9 e_type_star, 79, 125, -3, 0xFF ; type, x, y, vx, color
Entity_t init_e10 e_type_star, 79, 150, -2, 0xFF ; type, x, y, vx, color
Entity_t init_e11 e_type_star, 79, 155, -1, 0xFF ; type, x, y, vx, color
Entity_t init_e12 e_type_star, 79, 130, -3, 0xFF ; type, x, y, vx, color
Entity_t init_e13 e_type_star, 79, 151, -2, 0xFF ; type, x, y, vx, color
Entity_t init_e14 e_type_star, 79, 170, -1, 0xFF ; type, x, y, vx, color


_main::

   ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm

   ;; Each byte has 2 pixels
   ld    c, #0
   call cpct_setVideoMode_asm

  ; ld    h, #30
  ; ld    l, #30
  ; ld    a, #30
  ; call cpct_setBorder_asm

  ; ld    l, #0
  ; ld    h, #31
  ; call cpct_setPALColour_asm


   ld    hl, #init_e0
   call manager_entity_create
   ld    hl, #init_e1
   call manager_entity_create
   ld    hl, #init_e2
   call manager_entity_create
   ld    hl, #init_e3
   call manager_entity_create
   ld    hl, #init_e4
   call manager_entity_create
   ld    hl, #init_e5
   call manager_entity_create
   ld    hl, #init_e6
   call manager_entity_create
   ld    hl, #init_e7
   call manager_entity_create
   ld    hl, #init_e8
   call manager_entity_create
   ld    hl, #init_e9
   call manager_entity_create
   ld    hl, #init_e10
   call manager_entity_create
   ld    hl, #init_e11
   call manager_entity_create
   ld    hl, #init_e12
   call manager_entity_create
   ld    hl, #init_e13
   call manager_entity_create
   ld    hl, #init_e14
   call manager_entity_create
  

   ;; Loop forever
loop:

   call system_physics_update
   call cpct_waitVSYNC_asm
;  call wait_go_slow
   call system_render_update

   jr    loop




wait_go_slow::

   ld    a, #0x15

_wtloop:
   halt

   dec   a
   jr   nz, _wtloop

   call cpct_waitVSYNC_asm

   ret