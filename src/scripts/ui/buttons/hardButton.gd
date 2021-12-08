extends Button


func _ready():
	set_pressed_no_signal(global.difficulty == 2)
	
	
func _on_hardButton_pressed():
	global.difficulty = 2


func _on_hardButton_mouse_entered():
	sounds.button_hover()