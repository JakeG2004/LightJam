class_name Level
extends Node2D

const Map := preload("res://map/map.gd")

@export var title: String = "Level Title"

static var map: Map

func _enter_tree():
	map = $Map
