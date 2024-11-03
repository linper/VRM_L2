extends Interactible

class_name Cannon

@onready var pad_joint = get_node(".")
@onready var yaw_joint = get_node("./CannonYaw")
@onready var pitch_joint = get_node("./CannonYaw/CannonBarrel")

var target_x_pos = 0
var target_z_pos = 0
var target_yaw_angle = deg_to_rad(0)
var target_pitch_angle = deg_to_rad(0)

var min_x_pos = -3
var min_z_pos = -3
var min_yaw_angle = deg_to_rad(-45)
var min_pitch_angle = deg_to_rad(-10)

var max_x_pos = 3
var max_z_pos = 3
var max_yaw_angle = deg_to_rad(45)
var max_pitch_angle = deg_to_rad(45)

func mod_x(mod):
    if target_x_pos + mod > max_x_pos:
        target_x_pos = max_x_pos
    elif target_x_pos + mod < min_x_pos:
        target_x_pos = min_x_pos
    else:
        target_x_pos += mod
        
    #pad_joint.position = Vector3(target_x_pos,0,0)
    var cur_pos = pad_joint.position
    cur_pos[0] = target_x_pos
    pad_joint.position = cur_pos
        
func mod_z(mod):
    if target_z_pos + mod > max_z_pos:
        target_z_pos = max_z_pos
    elif target_z_pos + mod < min_z_pos:
        target_z_pos = min_z_pos
    else:
        target_z_pos += mod
    
    var cur_pos = pad_joint.position
    cur_pos[2] = target_z_pos
    pad_joint.position = cur_pos
    
func mod_yaw_deg(mod):
    if target_yaw_angle + deg_to_rad(mod) > max_yaw_angle:
        target_yaw_angle = max_yaw_angle
    elif target_yaw_angle + deg_to_rad(mod) < min_yaw_angle:
        target_yaw_angle = min_yaw_angle
    else:
        target_yaw_angle += deg_to_rad(mod)
        
    #yaw_joint.global_transform.basis = Basis().rotated(Vector3(0,1,0), target_yaw_angle).orthonormalized()
    yaw_joint.rotation = Vector3(0,target_yaw_angle,0)

func mod_pitch_deg(mod):
    if target_pitch_angle + deg_to_rad(mod) > max_pitch_angle:
        target_pitch_angle = max_pitch_angle
    elif target_pitch_angle + deg_to_rad(mod) < min_pitch_angle:
        target_pitch_angle = min_pitch_angle
    else:
        target_pitch_angle += deg_to_rad(mod)
        
    #pitch_joint.global_transform.basis = Basis().rotated(Vector3(1,0,0), target_pitch_angle).orthonormalized()
    pitch_joint.rotation = Vector3(target_pitch_angle,0,0)
    
func fire():
    pitch_joint.fire()
    
func interact(picked):
    pass
    
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
