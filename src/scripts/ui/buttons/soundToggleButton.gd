extends Button


func _ready():
	set_pressed_no_signal(sounds.mainTheme.is_playing())
	sounds.soundsCanPlay = sounds.mainTheme.is_playing()


func _on_soundToggleButton_toggled(is_enabled):
	if is_enabled:
		sounds.button.play()
		sounds.mainTheme.play()
		sounds.soundsCanPlay = true
	else:
		sounds.button.stop()
		sounds.mainTheme.stop()
		sounds.soundsCanPlay = false
