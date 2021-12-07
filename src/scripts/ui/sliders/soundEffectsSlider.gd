extends HSlider


func _ready():
	value = sounds.button.get_volume_db()

func _on_soundEffectsSlider_value_changed(value):
	sounds.button.set_volume_db(value)
	
func setDefaultValue():
	value = sounds.defaultButtonSoundVolume
