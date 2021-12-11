extends Node2D


const Draggable = preload('res://src/scenes/Draggable.tscn')
const Droppable = preload('res://addons/droppable/droppable_node.gd')
onready var font = DynamicFont.new()

var all_blanks = 0
var question
func _ready():
	font.font_data = preload('res://assets/fonts/MiniPixel7-6LKv.ttf')
	font.size = 32
	
	var questions = []
	var files = []
	var paths = ['src/scripts']
	while paths.size() > 0:
		var dir = Directory.new()
		
		var path = paths.pop_back()
		if dir.open(path) == OK:
			dir.list_dir_begin(true, true)
			
			var file = dir.get_next()
			while file != '':
				if dir.current_is_dir():
					paths.push_back(path + '/' + file)
				else:
					files.push_back(path + '/' + file)
				file = dir.get_next()

	for path in files:
		var file = File.new()
		file.open(path, File.READ)
		var text = file.get_as_text()
		file.close()
		
		var question_lines = []
		var answers = []
		var wrong_answers = []
		
		var reading_dev = false
		var indent = 0
		var skip_next = false
		var blank_next = false
		for line in text.split('\n'):
			if skip_next:
				skip_next = false
				continue
				
			if not reading_dev and '# === DEV' + ' START ===' in line:
				reading_dev = true
				indent = line.findn(line.dedent())
				continue
				
			if reading_dev and '# === DEV' + ' END ===' in line:
				reading_dev = false
				
				wrong_answers.shuffle()
				questions.push_back({
					'file': path,
					'lines': question_lines,
					'answers': answers,
					'wrong_answers': wrong_answers
				})
				
				question_lines = []
				wrong_answers = []
				answers = []
				continue
				
			if reading_dev:
				line = line.strip_edges(false).substr(indent)
				var dedented = line.dedent()
				
				if blank_next:
					blank_next = false
					question_lines.push_back(line[0].repeat(line.findn(dedented)) + '__BLANK__')
					answers.push_back(dedented)
					continue
				
				if dedented.findn('# dev:') == 0:
					var parts = dedented.split(':')
					var command = parts[1]
					if command == 'skip-next-line':
						skip_next = true
						continue
					
					if command == 'blank-next-line':
						blank_next = true
						continue
						
					if command == 'wrong-answer':
						wrong_answers.push_back(parts[2])
						continue
				
				if dedented.length() > 0 and dedented[0] == '#':
					continue
				
				if dedented == '':
					if question_lines[question_lines.size() - 1] != '':
						question_lines.push_back(line)
				else:
					question_lines.push_back(line)
			
	questions.shuffle()
	question = questions[0]
	
	find_node('__filename__').text = question.file
	var editor = find_node('__editor__')
	

	var blank_line = find_node('__blank_line__')
	remove_child(blank_line)

	var answer_line = find_node('__answer__')
	#remove_child(answer_line)
	

	var y = 0
	for line in question.lines:
		if '__BLANK__' in line:
			var droppable = blank_line.duplicate(DUPLICATE_GROUPS | DUPLICATE_SCRIPTS | DUPLICATE_SIGNALS)
			droppable.set_position(Vector2(line.findn(line.dedent()) * font.size, y))
			editor.add_child(droppable)
			y += 32
			all_blanks += 1
			continue
			
		var label = Label.new()
		label.text = line
		label.set_position(Vector2(line.findn(line.dedent()) * font.size, y))
		label.set("custom_fonts/font", font)
		editor.add_child(label)
		y += label.get_line_height()
		
	var answers = question.answers + question.wrong_answers
	answers.shuffle()
	
	var x = 0
	y = 0
	var answers_shape = find_node('__answers__').find_node('__shape__')
	var container_width = answers_shape.shape.extents.x * 2 - 100
	var base_width = container_width / answers.size()
	for answer in answers:
		var node = _create_answer()
		var background = node.get_child(1)
		var text = node.get_child(2)
		text.text = answer
		text.set_position(Vector2(16, 0))
		
		print(base_width, ' ', font.get_string_size(answer).x)
		var width = max(base_width, font.get_string_size(answer).x) + 32
		background.rect_size = Vector2(width, 32)
		
		if container_width < x + width:
			x = 0
			y += 32 + 8

		node.set_position(Vector2(x, y))
		x += width + 8
		
		find_node('__answers__').add_child(node)
		
func _create_answer ():
	var draggable = Draggable.instance()
	
	var rect = ColorRect.new()
	rect.color = 0x999999ff
	
	var label = Label.new()
	label.set('custom_fonts/font', font)
	
	draggable.add_child(rect)
	draggable.add_child(label)
	return draggable
	

var selected = 0
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = 0
			for child in $__editor__.get_children():
				if child is Droppable and child.selected:
					selected += 1
			
			if all_blanks == selected:
				$__next__.modulate.a = 1
			else:
				$__next__.modulate.a = 0.14
				
	
	if all_blanks == selected and event is InputEventKey:
		if event.scancode == KEY_ENTER and event.pressed:
			next_stage()


func _on___next___gui_input(event):
	if all_blanks == selected and event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			next_stage()

func next_stage():
	var i = 0
	var passes = true
	for child in $__editor__.get_children():
		if child is Droppable:
			if child.selected.get_child(1).text != question.answers[i]:
				passes = false
				break
			i += 1
	
	if passes:
		get_parent().stage_won()
	else:
		get_parent().stage_lost()
