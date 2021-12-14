extends Button


func _ready():
	disabled = not file.file_exists(global.SAVE_FILE)
