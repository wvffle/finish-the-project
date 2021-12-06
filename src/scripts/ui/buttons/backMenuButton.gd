extends Button


func _on_backMenuButton_pressed():
	get_tree().change_scene("res://src/scenes/Game.tscn")

func _on_Button_mouse_entered():
	sounds.button_hover()