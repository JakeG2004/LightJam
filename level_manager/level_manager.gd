extends Node2D

const dir_path: String = "res://levels/"
var cur_lvl_idx: int = 0
var level: Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_next_level()
	for child in get_children():
		if(child is Level):
			level = child


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func load_next_level():
	# Delete current map
	if(Level.instance.map != null):
		Level.instance.map.queue_free()
		
	# Get the new one
	var next_level := get_next_level()
	
	# Out of levels
	if(next_level == null):
		pass
		
	# Load the next level
	var new_level := next_level.instantiate()
	Level.instance.map = new_level
	Level.instance.add_child(new_level)
	
	# Trigger the level flash at the start
	GameEvents.flash_level.emit()

func get_next_level() -> PackedScene:
	# Specify the levels folder
	var dir := DirAccess.open(dir_path)
	
	# Check that its not null
	if(dir == null):
		push_error("Could not open levels directory %s" % dir_path)
		return null
		
	# Generate the filename
	var expected_name := "level%d.tscn" % cur_lvl_idx
	var path = dir_path + expected_name
	
	# Check that that level exists
	if(!dir.file_exists(expected_name)):
		push_error("Level does not exist at: %s" % path)
		return null
		
	# Load dynamically
	var scene := load(path)
	if(scene == null):
		push_error("Failed to load %s" % path)
		return null
		
	return scene
