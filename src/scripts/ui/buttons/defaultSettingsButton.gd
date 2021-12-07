extends Node


func _on_defaultSettingsButton_pressed():
	sounds.mainTheme.set_volume_db(sounds.defaultMusicVolume)
	sounds.button.set_volume_db(sounds.defaultButtonSoundVolume)	
	
	get_parent().find_node("soundEffectsSlider").setDefaultValue()
	get_parent().find_node("backgroundMusicSlider").setDefaultValue()

	global.difficulty = 1
	
func _on_Button_mouse_entered():
	sounds.button.play()
