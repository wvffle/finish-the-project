extends HSlider

func _ready():
	value = sounds.mainTheme.get_volume_db()

func _on_backgroundMusicSlider_value_changed(value):
	sounds.mainTheme.set_volume_db(value)
