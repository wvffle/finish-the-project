extends Button


func _on_Button2_button_up():
	global.paused = false
	get_tree().quit()
