extends Node3D

class_name Pickup

var cur_interactible = null

func pickup(inter):
    if cur_interactible != null:
        release_interactible()
    else:
        take_interactible(inter)
        
func get_pickable():
    return cur_interactible
        
func take_interactible(inter):
    if inter is not Pickable:
        return
    if inter.pickup_disabled:
        return
    inter.get_parent().remove_child(inter)
    add_child(inter)
    inter.global_transform.origin = global_transform.origin
    if inter is RigidBody3D:
        inter.freeze = true
    for child in inter.get_children():
        if child is CollisionShape3D:
            child.disabled = true
    cur_interactible = inter

func release_interactible():
    remove_child(cur_interactible)
    get_parent().get_parent().get_parent().add_child(cur_interactible)
    cur_interactible.global_transform.origin = global_transform.origin
    if cur_interactible is RigidBody3D:
        cur_interactible.freeze = false
    for child in cur_interactible.get_children():
        if child is CollisionShape3D:
            child.disabled = false
    cur_interactible = null
    
func is_picked_up():
    return cur_interactible != null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
