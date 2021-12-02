extends Button

func _on_hardButton_pressed():
	global.difficulty = 2


func _on_hardButton_mouse_entered():
		sounds.button.play()
