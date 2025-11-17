class_name GameManager
extends Node

var MainMenuScene = preload("res://scenes/UI/main_menu.tscn")
var GameScene = preload("res://level_manager/level_manager.tscn")
var CustomScene = preload("res://scenes/UI/custom_menu.tscn")
var CustomLevelEditor = preload("res://level_maker/level_maker_ingame.tscn")
var LevelScene = preload("res://levels/level.tscn")

static var instance
var high_score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	instance = self
	load_high_score()
	add_child(MainMenuScene.instantiate())

	
func quit():
	save_high_score()
	get_tree().quit()


func load_scene(scene_name: String):
	# Delete all current scenes
	for child in get_children():
		if(child is SoundManager):
			continue
		child.queue_free()
		
	var new_scene
	match scene_name:
		"main menu":
			new_scene = MainMenuScene
		"game":
			new_scene = GameScene
		"custom":
			new_scene = CustomScene
		"editor":
			new_scene = CustomLevelEditor
		_: print("Invalid scene name!")
		
	add_child(new_scene.instantiate())
	
func load_scene_from_path(path: String):
	# Delete all current scenes
	for child in get_children():
		if(child is SoundManager):
			continue
		child.queue_free()
		
	var level_scene = LevelScene.instantiate()
	var new_scene := load(path)
	add_child(level_scene)
	level_scene.add_child(new_scene.instantiate())
	
func set_high_score(score: int):
	if(score > high_score):
		high_score = score
		
func get_high_score() -> int:
	return high_score
		
func save_high_score():
	var file = FileAccess.open("user://score.save", FileAccess.WRITE)
	file.store_var(high_score)
	
func load_high_score():
	if(FileAccess.file_exists("user://score.save")):
		var file = FileAccess.open("user://score.save", FileAccess.READ)
		high_score = file.get_var()
		
func _input(event):
	if event is InputEventKey:
		# Get R Keycode to rotate object
		if event.pressed and event.keycode == KEY_ESCAPE:
			load_scene("main menu")
