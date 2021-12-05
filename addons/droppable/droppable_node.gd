extends ColorRect

var area
var selected = false

func _ready():
	area = Area2D.new()
	add_child(area)
	area.add_to_group('zone')
	mouse_filter = MOUSE_FILTER_IGNORE

func select():
	selected = true

func deselect():
	selected = false

func can_select():
	return not selected
