;;
;;  PHYSICS SYSTEM
;;

.include "physics_system.h.s"
.include "entity_manager.h.s"




;; Update one entity
;; INPUTS
;;      IX: Pointer to one entity for updating
;; DESTROY
;;      A, B
system_physics_update_one_entity::

    ;; Reanimate star
    ld      a, t_color(ix)
    add     a, #0x00
    jr     nz, _strtloop

        call manager_entity_restart

_strtloop:

    ;; Update position x with vx
    ld      a, t_x(ix)
    ld      b, t_vx(ix)
    
_vxloop:

    dec     a
    jr      z, destroy_entity

    inc     b
    jr     nz, _vxloop              ; Check if position go out the screen

    ld      t_x(ix), a              ; Save new position on memory
    jr      finish_update           ; Dont destroy and finish

destroy_entity:
    call    manager_entity_set4destruction

finish_update:
    ret




;; Update all entities
system_physics_update::
   ; ld     hl, #system_physics_update_one_entity
    ld      c, #0x01
    call    manager_entity_forall      ; Disengage physic system and entity manager
    ret
