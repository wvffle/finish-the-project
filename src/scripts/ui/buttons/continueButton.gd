extends Button

var save_exists = false

func _ready():
	disabled = not save_exists
