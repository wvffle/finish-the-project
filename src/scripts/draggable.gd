extends Node2D

var selected = false
var drop_point
var droppable_nodes = []

			
func get_nerest_point():
	var min_distance = INF
	for child in droppable_nodes:
		var distance = global_position.distance_squared_to(child.global_position)
		if distance < min_distance:
			child.select()
			drop_point = child.global_position
			min_distance = distance

func _ready():
	droppable_nodes = get_tree().get_nodes_in_group("zone")
	
	var min_distance = INF
	for child in droppable_nodes:
		var distance = global_position.distance_squared_to(child.global_position)
		if distance < min_distance:
			child.select()
			drop_point = child.global_position
			min_distance = distance

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		global_position = lerp(global_position, drop_point, 10 * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
			get_nerest_point()
			
