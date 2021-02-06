;;
;;  PHYSICS SYSTEM
;;

.include "render_system.h.s"
.include "cpctelera_functions.h.s"
.include "entity_manager.h.s"



;; Render one entity
;; INPUTS
;;      IX: Pointer to one entity for updating
;; DESTROY
;;      HL, DE, BC, A
system_render_one_entity::
    ld      de, #0xC000             ; Start of the screen
    ld       c, t_x(ix)             ; X
    ld       b, t_y(ix)             ; Y
    call    cpct_getScreenPtr_asm   ; Save pointer in HL

    ld      a, t_color(ix)
    ld      (hl), a

    ld      a, #3
_delete_back:
    inc     hl
    ld      (hl), #0x00             ; Draw with background color
    dec     a
    jr     nz, _delete_back

    ret




system_render_update::
    ld      c, #0x00
    call    manager_entity_forall
    ret

