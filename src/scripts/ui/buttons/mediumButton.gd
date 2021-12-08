extends Button


func _ready():
	set_pressed_no_signal(global.difficulty == 1)


func _on_mediumButton_pressed():
	global.difficulty = 1


func _on_mediumButton_mouse_entered():
	sounds.button_hover()