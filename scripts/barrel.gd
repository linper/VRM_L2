extends Interactible_sb

class_name CannonBarrel

@export var loaded_ammo = null
var is_ammo_fired:bool = false
var shot_strength = 12
@onready var audio_player = get_node("/root/root/GlobSFXAudioPlayer")
@onready var barrel_audio_player = $BarrelAudioPlayer
@onready var particles = $GPUParticles3D
@onready var flash = $Flash

func load_ammo(ammo:Casing):
    if loaded_ammo != null:
        print("Cannon is already loaded")
        return
    if ammo.cur_detonator == null or ammo.cur_projectile == null or !ammo.has_propellant:
        print("Ammo is not complete")
        return
    
    for child in get_children():
        print("Child:" + child.name)
        if child is MeshInstance3D:
            child.get_active_material(0).emission = "#784c4c"    
    
    ammo.get_parent().remove_child(ammo)
    add_child(ammo)

    ammo.hide()

    audio_player.stream = preload("res://audio/steampunk-mechanical-gadget-188052.mp3")
    audio_player.play()

    ammo.freeze = true
    loaded_ammo = ammo
    is_ammo_fired = false

func unload_ammo():
    if loaded_ammo == null:
        print("Cannon is not loaded")
        return
    
    for child in get_children():
        print("Child:" + child.name)
        if child is MeshInstance3D:
            child.get_active_material(0).emission = "#000000"    
    

    loaded_ammo.get_parent().remove_child(loaded_ammo)
    get_tree().get_root().add_child(loaded_ammo)
    #projectile.position = casing_snap_point.position
    #projectile.rotation = casing_snap_point.rotation
    loaded_ammo.global_transform.origin = global_transform.origin
    loaded_ammo.global_transform.basis = global_transform.basis

    audio_player.stream = preload("res://audio/steampunk-mechanical-gadget-188052.mp3")
    audio_player.play()

    loaded_ammo.freeze = false
    loaded_ammo.show()
    loaded_ammo = null

func fire():
    #particles.restart()
    #flash.restart()
    #particles.emitting = false  # Ensure it's reset
    #particles.emitting = true
    print("barrel fire")
    if loaded_ammo == null:
        print("Cannon is not loaded")
        return
    
    if is_ammo_fired:
        print("Barrel has empty Casing")
        return
    
    for child in get_children():
        print("Child:" + child.name)
        if child is MeshInstance3D:
            child.get_active_material(0).emission = "#000000"
        
    is_ammo_fired = true
    var barrel_snap_point = get_node("BarrelEnd")
    var projectile = loaded_ammo.get_node("Projectile")

    #particles.emitting = false  # Ensure it's reset
    particles.emitting = true

    #projectile.position = casing_snap_point.position
    #projectile.rotation = casing_snap_point.rotation
    projectile.get_parent().remove_child(projectile)
    get_tree().get_root().add_child(projectile)
    projectile.freeze = false
    var velocity = (barrel_snap_point.global_transform.origin - global_transform.origin) * shot_strength
    projectile.global_transform.origin = barrel_snap_point.global_transform.origin
    projectile.global_transform.basis = barrel_snap_point.global_transform.basis
    projectile.linear_velocity  = velocity
    
    projectile.is_fired = true
    
    projectile.pickup_disabled = false
    loaded_ammo.has_propellant = false
    loaded_ammo.cur_projectile = null
    loaded_ammo.cur_detonator = null
         
    barrel_audio_player.stream = preload("res://audio/cannon-shot-6153.mp3")
    barrel_audio_player.play()
    flash.restart()
    particles.restart()
    
    print("Fire!")
    
func interact(picked):
    if picked is Casing:
        if loaded_ammo == null:
            load_ammo(picked)
        return

    unload_ammo()
    
