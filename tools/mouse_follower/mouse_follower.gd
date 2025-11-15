class_name MouseFollower

extends Node2D

const Map := preload("res://map/map.gd")

var map: Map

func _ready() -> void:
	map = get_parent().get_child(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = get_global_mouse_position()
	if(map != null):
		snap_children_to_grid()
	
func delete_children():
	for child in get_children():
		child.queue_free()

func snap_children_to_grid():
	for child in get_children():
		child.global_position = map.xy_to_pos(child.global_position)
