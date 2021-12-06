extends Button


func _on_easyButton_pressed():
	global.difficulty = 0


func _on_easyButton_mouse_entered():
	sounds.button_hover()