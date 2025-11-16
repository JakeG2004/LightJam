class_name Level
extends Node2D

@export var title: String = "Level Title"

static var map: Map
static var instance

var enemies: Array[Node]
@onready var viewport := $Lighting/SubViewport

func _enter_tree():
	map = $Map
	instance = self

func _ready():
	enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy: ShadowCell in enemies:
		enemy.died.connect(on_enemy_death)

func _process(_dt):
	center_on_screen()

func on_enemy_death(enemy: Node):
	enemies.erase(enemy)
	if(enemies.size() <= 0):
		GameEvents.next_level.emit()
		
func set_children_owner(node: Node, new_owner: Node):
	# Set the owner for the current node
	node.owner = new_owner
	
	# Recursively call this function for all children
	for child in node.get_children():
		set_children_owner(child, new_owner)

func save_as_scene():
	var base_dir := "res://levels/"
	var dir := DirAccess.open(base_dir)
	if dir == null:
		DirAccess.make_dir_recursive_absolute(base_dir)
		dir = DirAccess.open(base_dir)

	# Find the next available level number
	var level_index := 0
	while true:
		var file_name := "level%d.tscn" % level_index
		if not dir.file_exists(file_name):
			break
		level_index += 1

	var final_path := base_dir + "level%d.tscn" % level_index
	print("Saving to: ", final_path)

	set_children_owner(map, map)
		
	var scene := PackedScene.new()
	scene.pack(map)
	var err = ResourceSaver.save(scene, final_path)
	if err != OK:
		push_error("Failed to save scene: %s" % final_path)


func center_on_screen():
	var screen_size := Vector2(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_height"),
	)
	global_position = (screen_size - map.render_size()) / 2.0
	
	if viewport.size != Vector2i(map.render_size()):
		viewport.size = Vector2i(map.render_size())
