extends Node


func save_file(filename, data):
	var file = File.new()
	file.open(filename,File.WRITE)
	file.store_line(to_json(data))
	file.close()


func file_exists(filename):
	var file = File.new()
	return file.file_exists(filename)
	
	
func load_file(filename):
	var file = File.new()
	file.open(filename, File.READ)
	var data = parse_json(file.get_line())
	file.close()
	return data
	
	
func file_delete(path):
	var dir = Directory.new() 
	dir.remove(path)
