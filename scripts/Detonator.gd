extends Pickable

class_name Detonator

#@onready var rb = self as RigidBody3D
#
#var is_stuck = false

#func _ready():
    ## Connect the signals
    #connect("body_entered", _on_body_entered)
    #connect("body_exited", _on_body_exited)

# Called when this body collides with another body
#func _on_body_entered(body: Node3D):
    #print("Collided with:", body.name)

# Called when this body stops colliding with another body
#func _on_body_exited(body: Node3D):
    #print("Stopped colliding with:", body.name)

#func _ready():
    #rb.connect("body_entered",  _on_body_entered)

# This function is called when the rigid body collides with another body
#func _on_body_entered(body: Node3D) -> void:
    #print("Body entered:", body.name)
    #if not is_stuck:
        #stick_to_obstacle(body)

#func stick_to_obstacle(obstacle):
    #is_stuck = true
    #self.mode = FREEZE_MODE_STATIC  # Switch to static mode to "stick" to the obstacle
    #print("Stuck to obstacle:", obstacle.name)
#
    ## Optionally, align to the obstacle's surface
    #var collision = get_collision()
    #if collision:
        #global_transform.origin = collision.position  # Snap to the collision point
        #global_transform.basis = collision.normal.basis_orthonormalized()  # Align to the surface
#
#func get_collision():
    #var space_state = get_world_3d().direct_space_state
    #var result = space_state.get_rest_info(
        #global_transform.origin
    #)
    #return result if result else null
