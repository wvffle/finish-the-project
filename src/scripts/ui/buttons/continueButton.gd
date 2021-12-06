extends Button


func _ready():
	disabled = not global.file_exists(global.SAVE_FILE)
