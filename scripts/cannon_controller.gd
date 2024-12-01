extends Interactible_sb

@export var movement_type: String
@onready var cannon = get_node("/root/root/Cannon")
@onready var audio_player = get_node("/root/root/GlobSFXAudioPlayer")


func _ready():
    match movement_type:
        "X_add":
            self.name = "move right"
        "X_sub":
            self.name = "move left"
        "Z_add":
            self.name = "move forward"
        "Z_sub":
            self.name = "move backward"
        "Yaw_add":
            self.name = "increase yaw"
        "Yaw_sub":
            self.name = "decrease yaw"
        "Pitch_add":
            self.name = "increase pitch"
        "Pitch_sub":
            self.name = "decrease pitch"
        "Fire":
            self.name = "fire"

func interact(picked):
    audio_player.stream = preload("res://audio/button-press-beep-269718.mp3")
    match movement_type:
        "X_add":
            audio_player.play()
            cannon.mod_x(0.1)
        "X_sub":
            audio_player.play()
            cannon.mod_x(-0.1)
        "Z_add":
            audio_player.play()
            cannon.mod_z(-0.1)
        "Z_sub":
            audio_player.play()
            cannon.mod_z(0.1)
        "Yaw_add":
            audio_player.play()
            cannon.mod_yaw_deg(-3)
        "Yaw_sub":
            audio_player.play()
            cannon.mod_yaw_deg(3)
        "Pitch_add":
            audio_player.play()
            cannon.mod_pitch_deg(3)
        "Pitch_sub":
            audio_player.play()
            cannon.mod_pitch_deg(-3)
        "Fire":
            audio_player.play()
            cannon.fire()


func interaction_text():
    return self.name
    
