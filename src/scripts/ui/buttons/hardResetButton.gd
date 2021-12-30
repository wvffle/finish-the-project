extends Button


func _on_hardResetButton_mouse_entered():
	sounds.button_hover()


func _on_hardResetButton_pressed():
	file.file_delete(global.CONFIG_FILE)
	file.file_delete(global.SAVE_FILE)
	file.file_delete(global.SCOREBOARD_FILE)
	
	get_tree().change_scene("res://src/scenes/Game.tscn")
