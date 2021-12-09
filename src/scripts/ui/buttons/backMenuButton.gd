extends Button


func _on_backMenuButton_pressed():
	get_tree().change_scene("res://src/scenes/Game.tscn")
	global.paused = false

func _on_Button_mouse_entered():
	sounds.button_hover()


func _on_backMenuButton_pressed_save_config():
	global.save_config()
