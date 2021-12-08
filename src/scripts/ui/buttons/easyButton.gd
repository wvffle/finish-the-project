extends Button


func _ready():
	set_pressed_no_signal(global.difficulty == 0)
	
	
func _on_easyButton_pressed():
	global.difficulty = 0


func _on_easyButton_mouse_entered():
	sounds.button_hover()