extends Pickable

class_name Projectile

const VELOCITY_CHANGE_THRESHOLD: float = -5.0
var v_prev: Vector3 = Vector3.ZERO

@export var is_fired:bool = false
@onready var barrel_audio_player = $ProjectileAudioPlayer
@onready var particles = $GPUParticles3D
@onready var flash = $Flash

func _ready():
    v_prev = linear_velocity

func _physics_process(delta):

    var v_ch = linear_velocity.length() - v_prev.length()
    #print("Velocity:", linear_velocity.length())
        
    if is_fired and v_ch < VELOCITY_CHANGE_THRESHOLD:
        #print("Large velocity change detected:", v_ch, " ", v_prev.length(), " => ", linear_velocity.length())
        handle_large_velocity_change()

    v_prev = linear_velocity

func handle_large_velocity_change():
    is_fired = false
    # Replace with desired behavior
    print("Handling large velocity change!")
             
    barrel_audio_player.stream = preload("res://audio/explosion-sound-effect-1-free-on-gamesfxpackscom-241821.mp3")
    barrel_audio_player.play()
    flash.restart()
    particles.restart()
    #get_parent().remove_child(self)
    #self.queue_free()
    #visible = false
