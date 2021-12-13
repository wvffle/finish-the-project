extends Node2D


onready var x1 = $__track__.rect_global_position.x
onready var x2 = $__track__.rect_global_position.x + $__track__.rect_size.x
onready var w = $__track__.rect_size.x
var tick
var x
var p

func _ready ():
	var a = (randi() % 7)
	var b = (7 - a)
	
	# === DEV START ===
	var l = 71
	# dev:blank-next-line
	var c = floor(l/2)
	p = b - a
	# dev:wrong-answer:var c = l / 2
	# dev:blank-next-line
	var g = p + c
	# dev:wrong-answer:var g = 8 + c
	# dev:blank-next-line
	var f = c - p
	# dev:wrong-answer:var f = c - 8
	var dL = w / 2 / g
	var dP = w / 2 / f
	# === DEV END ===
	
	var offset =  -$__track__/__tick__.rect_size.x / 2
	tick = {
		str(-c): 0 + offset,
		str(c): w + offset,
		str(p): w / 2 + offset
	}
	
	for i in range(1, g):
		tick[str(-c + i)] = i * dL + offset
		
	for i in range(1, f):
		tick[str(c - f + i)] = i * dP + w/2 + offset
		
	x = tick['0']
	
	print(p, ' ', tick)
	
	for child in get_children():
		if 'draggable' in child.name:
			child.get_nerest_point()
			
	for child in $__devs__.get_children():
		child.connect('selected', self, '_on_selected')
		
	for child in $__testers__.get_children():
		child.connect('selected', self, '_on_selected')
			
func _on_selected(draggable):
	calc()
	
var devs = 0
var testers = 0
func calc():
	devs = 0
	for child in $__devs__.get_children():
		if not child.can_select():
			devs += 1
	
	testers = 0
	for child in $__testers__.get_children():
		if not child.can_select():
			testers += 1
			
	x = tick[str(devs - testers)]


func _physics_process(delta):
	$__track__/__tick__.rect_global_position = lerp(
		$__track__/__tick__.rect_global_position, 
		Vector2(x, $__track__/__tick__.rect_global_position.y), 
		delta
	)
	
	if devs + testers == 7 and p == devs - testers and abs($__track__/__tick__.rect_global_position.x - x) < 1:
		get_parent().stage_won()
	
