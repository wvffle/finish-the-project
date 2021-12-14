extends Button


func _ready():
	set_pressed_no_signal(global.difficulty == 2)
	
	
func _on_hardButton_pressed():
	if global.difficulty != 2:
		get_parent().find_node("mediumButton").set_pressed_no_signal(false)
		get_parent().find_node("easyButton").set_pressed_no_signal(false)
			
	global.difficulty = 2
	set_pressed_no_signal(true)


func _on_hardButton_mouse_entered():
	sounds.button_hover()
