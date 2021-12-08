extends Button


func _ready():
	set_pressed_no_signal(global.difficulty == 1)


func _on_mediumButton_pressed():
	if global.difficulty != 1:
		get_parent().find_node("easyButton").set_pressed_no_signal(false)
		get_parent().find_node("hardButton").set_pressed_no_signal(false)
			
	global.difficulty = 1
	set_pressed_no_signal(true)


func _on_mediumButton_mouse_entered():
	sounds.button_hover()