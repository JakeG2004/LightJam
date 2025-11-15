extends Node2D

const Map := preload("res://map/map.gd")

var map: Map

func _ready():
	map = $Map
	
func set_dimension(dim_string: String):
	map.resize_array(int(dim_string))
