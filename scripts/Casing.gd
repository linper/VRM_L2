extends Pickable

class_name Casing

@export var has_propellant:bool = false
@export var is_stable:bool = false

@export var cur_projectile = null
@export var cur_detonator = null


func add_propellant(propellant):
    if !is_stable:
        print("Casing is not stable")
        return
    if has_propellant:
        print("Casing alreaddy has propellant")
        return       
        
    for child in get_children():
        print("Child:" + child.name)
        if child is MeshInstance3D:
            child.get_active_material(0).emission = "#636300"    

    has_propellant = true
    propellant.get_parent().remove_child(propellant)
    propellant.queue_free()
    print("Propelant added.")
        

func add_projectile(projectile):
    if !is_stable:
        print("Casing is not stable")
        return
    if !has_propellant:
        print("Casing is not filled with propellant")
        return 
    if cur_projectile != null:
        print("Casing alreaddy has projectile")
        return
        
    var casing_snap_point = get_node("SnapPointA")
    projectile.get_parent().remove_child(projectile)
    add_child(projectile)
    projectile.position = casing_snap_point.position
    projectile.rotation = casing_snap_point.rotation
    projectile.freeze = true
    projectile.pickup_disabled = true
    cur_projectile = projectile
    print("Projectile added.")
            

func add_detonator(detonator):
    if !is_stable:
        print("Casing is not stable")
        return
    if !has_propellant:
        print("Casing is not filled with propellant")
        return
    if cur_projectile == null:
        print("Projectile is not inserted")
        return
    if cur_detonator != null:
        print("Casing alreaddy has detonator")
        return
        
    var casing_snap_point = cur_projectile.get_node("SnapPointA")
    detonator.get_parent().remove_child(detonator)
    cur_projectile.add_child(detonator)
    detonator.position = casing_snap_point.position
    detonator.rotation = casing_snap_point.rotation
    detonator.freeze = true
    detonator.pickup_disabled = true
    cur_detonator = detonator
    print("Detonator added.")
    
    
func interact(picked):
    print("Casing interacted. Has pickable:" + picked.name)
    
    if picked is Projectile:
        add_projectile(picked)      
    elif picked is Propellant:
        add_propellant(picked)
    elif picked is Detonator:
        add_detonator(picked)
#func interaction_text():
    #return "aa"
