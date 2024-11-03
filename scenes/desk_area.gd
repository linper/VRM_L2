extends Area3D

var placement_offset: Vector3 = Vector3(0.4, 0, 0)  # Adjust as needed
var placement_basis: Basis = Basis().rotated(Vector3.BACK, 90).orthonormalized()

var curr_build:Casing = null


func _on_body_entered(body: Node3D) -> void:
    if body is Casing:
        if curr_build != null:
            print("Casing is already placed")
            return
        body.global_transform.origin = global_transform.origin + placement_offset
        body.global_transform.basis = placement_basis
        body.is_stable = true
        # Re-parent the object to the scene root or a container node
        #get_tree().root.add_child(body)
        #body.release()
        curr_build = body
        print("Casing placed.")
        


func _on_body_exited(body: Node3D) -> void:
    if body is Casing:
        body.is_stable = false
        curr_build = null

        print("Casing removed")
