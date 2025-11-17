extends Node2D

const dir_path: String = "res://levels/"
var cur_lvl_idx: int = 0
var level: Level
var dead: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.next_level.connect(wait_and_load_next_level)
	GameEvents.game_over.connect(game_over)
	load_next_level()
	for child in get_children():
		if(child is Level):
			level = child


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func game_over():
	if(dead):
		return
	dead = true
	SoundManager.instance.play_clip("lose")
	await get_tree().create_timer(5).timeout
	GameManager.instance.set_high_score(cur_lvl_idx)
	GameManager.instance.load_scene("main menu")
	
func win_game():
	SoundManager.instance.play_clip("game_won")
	await get_tree().create_timer(1).timeout
	GameManager.instance.set_high_score(cur_lvl_idx)
	GameManager.instance.load_scene("main menu")
	
func wait_and_load_next_level():
	await get_tree().create_timer(.5).timeout
	if(dead):
		return
	load_next_level()

func load_next_level():
	# Delete current map
	if(Level.instance.map != null):
		Level.instance.map.queue_free()
		
	# Get the new one
	var next_level := get_next_level()
	
	# Out of levels
	if(next_level == null):
		dead = true
		win_game()
		return
		
	# Load the next level
	var new_level := next_level.instantiate()
	Level.instance.map = new_level
	Level.instance.add_child(new_level)
	Level.instance.add_gems()
	Level.instance.level_finished = false
	
	# Trigger the level flash at the start
	GameEvents.flash_level.emit()
	SoundManager.instance.play_clip("win")
	
	cur_lvl_idx += 1
	GameBG.instance.new_level(cur_lvl_idx, Level.instance.map.num_lasers, Level.instance.map.time, Level.instance.map.hint)

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
	if !ResourceLoader.exists(path):
		push_error("Level does not exist at: %s" % path)
		return null

		
	# Load dynamically
	var scene := load(path)
	if(scene == null):
		push_error("Failed to load %s" % path)
		return null
		
	return scene
