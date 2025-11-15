class_name Level
extends Node2D

const Map := preload("res://map/map.gd")

@export var title: String = "Level Title"

static var map: Map
static var instance
var enemies: Array[Node]

func _enter_tree():
	map = $Map
	instance = self

func _ready():
	enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy: ShadowCell in enemies:
		enemy.died.connect(on_enemy_death)

func on_enemy_death(enemy: Node):
	enemies.erase(enemy)
	if(enemies.size() <= 0):
		GameEvents.next_level.emit()

func save_as_scene(path: String):
	var scene = PackedScene.new()
	scene.pack(self)
	ResourceSaver.save(scene, path)
