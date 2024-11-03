extends Label

func show_interactible_text(interactible):
    show()
    text = "Press E to " + interactible.interaction_text()
    
func hide_interactible_text():
    hide()
