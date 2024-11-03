extends Interactible

@export var movement_type: String
@onready var cannon = get_node("/root/root/Cannon")


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
    match movement_type:
        "X_add":
            cannon.mod_x(0.1)
        "X_sub":
            cannon.mod_x(-0.1)
        "Z_add":
            cannon.mod_z(-0.1)
        "Z_sub":
            cannon.mod_z(0.1)
        "Yaw_add":
            cannon.mod_yaw_deg(-3)
        "Yaw_sub":
            cannon.mod_yaw_deg(3)
        "Pitch_add":
            cannon.mod_pitch_deg(3)
        "Pitch_sub":
            cannon.mod_pitch_deg(-3)
        "Fire":
            cannon.fire()


func interaction_text():
    return self.name
    
