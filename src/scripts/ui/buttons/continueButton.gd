extends Button

var save_exists 

func _ready():
	if save_exists:
		save_exists = global.file_exists(global.SAVE_FILE)
