extends Node2D

var selected = false
var drop_point
var droppable
var droppable_nodes = []

			
func get_nerest_point():
	var min_distance = INF
	var point = drop_point
	var closest_droppable
	
	for child in droppable_nodes:
		var local_droppable = child.get_parent()
		
		var distance = global_position.distance_squared_to(child.global_position)
		if distance < min_distance and (local_droppable.can_select() or droppable == local_droppable):
			closest_droppable = local_droppable
			point = child.global_position
			min_distance = distance
	
	if droppable:
		droppable.deselect()
		set_size()
	
	if closest_droppable:
		closest_droppable.select()
		droppable = closest_droppable
		drop_point = point
		
		# TODO: Set size to the droppable size
		set_size()

var shape
var max_width = 0
var max_height = 0
func _ready():
	droppable_nodes = get_tree().get_nodes_in_group("zone")
	shape = find_node('__shape__')
	
	
	for child in get_children():
		if child.get_name() == '__area__':
			move_child(child, get_child_count())
			continue
			
		if child is Control:
			child.mouse_filter = Control.MOUSE_FILTER_IGNORE
			
		if child is CollisionShape2D:
			max_width = max(max_width, child.shape.extents.x)
			max_height = max(max_height, child.shape.extents.y)
			
		
		if 'width' in child:
			max_width = max(max_width, child.width)
			
		if 'height' in child:
			max_height = max(max_height, child.height)
			
		if child is Label or child is RichTextLabel:
			var longest_line = ""
			for line in child.text.split('\n'):
				if line.length() > longest_line.length():
					longest_line = line
			
			var font = child.get_font('normal_font')
			var size = font.get_string_size(longest_line)
			max_width = max(max_width, size.x / 2)
			max_height = max(max_height, child.text.split('\n').size() * size.y / 2)
		
	set_size()
	
func set_size(w = max_width, h = max_height):
	shape.shape.set_extents(Vector2(w, h))
	shape.transform.origin = Vector2(w, h)

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position() - shape.transform.origin, 25 * delta)
	elif drop_point:
		global_position = lerp(global_position, drop_point, 10 * delta)


func _input(event):
	if selected and event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
			get_nerest_point()
		
func _on___area___input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true


func _on___area___mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_DRAG)


func _on___area___mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
