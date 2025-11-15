class_name Level
extends Node2D

const Map := preload("res://map/map.gd")

@export var title: String = "Level Title"

static var map: Map
var enemies: Array[Node]

func _enter_tree():
	map = $Map
	
func _ready():
	enemies = get_tree().get_nodes_in_group("Enemies")
	
func on_enemy_death(enemy: Node):
	enemies.erase(enemy)
	if(enemies.size() <= 0):
		GameEvents.next_level.emit()
