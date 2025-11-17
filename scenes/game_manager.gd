class_name GameManager
extends Node

var MainMenuScene = preload("res://scenes/UI/main_menu.tscn")
var GameScene = preload("res://level_manager/level_manager.tscn")

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
		child.queue_free()
		
	var new_scene
	match scene_name:
		"main menu":
			new_scene = MainMenuScene
		"game":
			new_scene = GameScene
		_: print("Invalid scene name!")
		
	add_child(new_scene.instantiate())
	
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
