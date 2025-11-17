class_name Level
extends Node2D

@export var title: String = "Level Title"

static var map: Map
static var instance
const VERTICAL_FILL_PERCENTAGE: float = .9

var gems: Array[Node]

@onready var viewport := $Lighting/SubViewport
@onready var game_camera := $Camera as Camera2D

func _enter_tree():
	map = $Map
	instance = self

func _ready():
	add_gems()
	apply_screen_fit()

func _process(_dt):
	center_on_screen()
	apply_screen_fit()
	
func add_gems():
	await get_tree().create_timer(0.1).timeout
	for gem: ShadowCell in gems:
		gem.illuminated.connect(on_gem_illuminated)

func on_gem_illuminated(gem: Node):
	gems.erase(gem)
	if(gems.size() <= 0):
		GameEvents.next_level.emit()
		print("Next level")
		

func get_all_gems(node: Node):
	if node is ShadowCell:
		gems.append(node)
	for child in node.get_children():
		get_all_gems(child)
		
func set_children_owner(node: Node, new_owner: Node):
	# Set the owner for the current node
	node.owner = new_owner
	
	# Recursively call this function for all children
	for child in node.get_children():
		if(child is Laser):
			continue
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
	if(map == null):
		return
		
	var screen_size := Vector2(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_height"),
	)
		
	global_position = (screen_size - map.render_size()) / 2.0
	
	if viewport.size != Vector2i(map.render_size()):
		viewport.size = Vector2i(map.render_size())

func apply_screen_fit():
	if(map == null):
		return
		
	game_camera.position = map.render_size() / 2
	game_camera.zoom = Vector2(ProjectSettings.get_setting("display/window/size/viewport_height") / map.render_size().x, ProjectSettings.get_setting("display/window/size/viewport_height") / map.render_size().y) * VERTICAL_FILL_PERCENTAGE
