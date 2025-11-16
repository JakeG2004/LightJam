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

func save_as_scene(path: String):
	var scene = PackedScene.new()
	scene.pack(self)
	ResourceSaver.save(scene, path)

func center_on_screen():
	var screen_size := Vector2(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_height"),
	)
	global_position = (screen_size - map.render_size()) / 2.0
	
	if viewport.size != Vector2i(map.render_size()):
		viewport.size = Vector2i(map.render_size())
