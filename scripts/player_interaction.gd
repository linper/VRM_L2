extends RayCast3D

var cur_target = null

signal interactible_hovered(interactible)
signal interactible_unhovered()

@export var pickup: Pickup

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

# This function runs every frame
func _process(delta: float) -> void:
    # Update the raycast (make sure it is enabled)
    
    var target = get_collider()
    
    if target != cur_target:
        if target != null and target is not Interactible_sb and target is not Interactible_rb:
            cur_target = null
            interactible_unhovered.emit()
        elif target is Interactible_rb or target is Interactible_sb:
            cur_target = target
            interactible_hovered.emit(cur_target)


func _input(event: InputEvent) -> void:
    if event is InputEvent and event.is_action_pressed("interact"):
        if pickup.is_picked_up():
            var picked_interactible = pickup.get_pickable()
            pickup.release_interactible()
            if cur_target is Interactible_rb or cur_target is Interactible_sb:
                cur_target.interact(picked_interactible)
        else:
            if cur_target != null:
                if cur_target is Pickable:
                    pickup.pickup(cur_target)
                else:
                    cur_target.interact(null)
