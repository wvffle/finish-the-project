extends Node


func _on_defaultSettingsButton_pressed():
	sounds.mainTheme.set_volume_db(sounds.defaultMusicVolume)
	sounds.button.set_volume_db(sounds.defaultButtonSoundVolume)	
	
	get_parent().find_node("soundEffectsSlider").setDefaultValue()
	get_parent().find_node("backgroundMusicSlider").setDefaultValue()
	get_parent().find_node("soundToggleButton").set_pressed_no_signal(true)
	if !sounds.mainTheme.is_playing():
		sounds.mainTheme.play()
	
	global.difficulty = 1
	get_parent().find_node("easyButton").set_pressed_no_signal(false)
	get_parent().find_node("hardButton").set_pressed_no_signal(false)
	get_parent().find_node("mediumButton").set_pressed_no_signal(true)

	
func _on_Button_mouse_entered():
	sounds.button_hover()
