extends Button


func _ready():
	set_pressed_no_signal(global.difficulty == 0)
	
	
func _on_easyButton_pressed():
	if global.difficulty != 0:
		get_parent().find_node("mediumButton").set_pressed_no_signal(false)
		get_parent().find_node("hardButton").set_pressed_no_signal(false)
			
	global.difficulty = 0
	set_pressed_no_signal(true)


func _on_easyButton_mouse_entered():
	sounds.button_hover()
