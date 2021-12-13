extends ColorRect


signal selected(draggable)

var area
var selected

func _ready():
	area = Area2D.new()
	add_child(area)
	area.add_to_group('zone')
	mouse_filter = MOUSE_FILTER_IGNORE

func select(draggable):
	selected = draggable
	emit_signal("selected", draggable)

func deselect():
	selected = null

func can_select():
	return selected == null
