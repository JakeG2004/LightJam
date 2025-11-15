extends Node2D

const Map := preload("res://map/map.gd")

@export var title: String = "Level Title"

static var map: Map

func _ready():
	map = $Map
