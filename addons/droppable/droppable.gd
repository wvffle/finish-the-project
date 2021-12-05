tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("Droppable", "ColorRect", preload("droppable_node.gd"), preload("droppable.svg"))
	
	
func _exit_tree():
	remove_custom_type("Droppable")
