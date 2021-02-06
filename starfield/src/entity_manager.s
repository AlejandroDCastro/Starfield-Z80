;;
;; ENTITY MANAGER
;;

.include "entity_manager.h.s"
.include "physics_system.h.s"
.include "render_system.h.s"
.include "cpctelera_functions.h.s"


;; Global variables
_reserved_entities::    .db 0
_last_element_ptr::     .dw m_entities
_function_forall::      .db 0

;; Create an empty array with all entities
Entity_Array m_entities max_entities



manager_entity_init::
    ret


;; Create a new Entity
;; INPUTS
;;      HL: Pointer to entity initializer byte of entity
;; DESTROY
;;      HL, DE, BC, IX, A
manager_entity_create::

    ;; Copy new entity in memory
    ld      de, (_last_element_ptr)
    ld      bc, #sizeof_t
    ldir

    ;; Give a random y position
    ld      ix, (_last_element_ptr)
    call    cpct_getRandom_mxor_u8_asm  ; WARNING: Destroy AF, BC, DE, HL
    ld      a, l
    ld      t_x(ix), a

    ;; Set entity type with defult value
    ld       a, #e_type_default
    ld      t_type(ix), a

    ;; Move the pointer to the next free entity
    ld      hl, (_last_element_ptr)
    ld      bc, #sizeof_t
    add     hl, bc
    ld      (_last_element_ptr), hl

    ;; Increment the total count of entities in the array
    ld      a, (_reserved_entities)
    inc     a
    ld      (_reserved_entities), a

    call    cpct_getRandom_mxor_u8_asm
    
    ret



;; Travel the entities array for updating each one
;; INPUTS
;;      C: Funtion to execute (1-Physics or 0-Render)
;; DESTROY
;;      A, IX, DE
manager_entity_forall::

    ld      a, c
    ld      (_function_forall), a
    ld      a, (_reserved_entities) ; Num of entities
    ld     ix, #m_entities          ; Direction of the first element in array
 ;   ld     (_function_forall), bc   ; Choose the function to execute in BC

_updloop:
    push   af                       ; Save number of entities in the stack

    ld      a, t_type(ix)           ; Entity type
    add     a, #0x00                ; if = 0
    jr      z, _next_it_loop        ; The type is invalid

        ; the type is valid so update it
        ;call (_function_forall)     ; WARNING: Destroy A and B
        ld      a, (_function_forall)
        dec     a
        jr      z, function1

            call    system_render_one_entity    ;; Cant read the content
            jr      _next_it_loop

        function1:
            call    system_physics_update_one_entity

_next_it_loop:
    pop     af                      ; Bring A value from stack

    dec     a                       ; One less entity
    ret     z                       ; End loop

    ld     de, #sizeof_t            ; Size of a entity
    add    ix, de                   ; Next entity of array
    jr     _updloop                 ; Go back to the loop




;; Set entity for later destruction
;; INPUTS
;;      IX: Pointer to one entity for updating
;; DESTROY
;;      A
manager_entity_set4destruction::
    ld      t_color(ix), #0x00
    ret




;; Destroy an existent entity
;; Only reset the position
;; INPUTS
;;      IX: Pointer to one entity for updating
;; DESTROY
;;      A
manager_entity_restart::
    ld      t_x(ix), #79
    ld      t_color(ix), #0xFF
    ret
