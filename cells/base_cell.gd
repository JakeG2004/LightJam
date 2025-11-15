class_name BaseCell

extends Node2D

# Define laser type
const Laser = preload("res://laser/laser.gd")
const LaserScene = preload("res://laser/laser.tscn")

# Publicly accessible variables
@export var facing: int = 0

func _enter_tree() -> void:
	if Level.map:
		Level.map.set_at(global_position, self)

func _exit_tree():
	if Level.map:
		Level.map.set_at(global_position, null)

# Get input laser. Default case is to pass it through
func laser_in(in_laser: Laser) -> void:
	laser_out(in_laser.direction, in_laser.color, in_laser.strength)
	

# Creates an output laser for the cell based on a given direction and color
func laser_out(direction: int, color: Color, strength: int, offset: Vector2 = Vector2.ZERO) -> Laser:
	var out_laser: Laser = LaserScene.instantiate()
	out_laser.direction = direction
	out_laser.color = color
	out_laser.strength = strength
	out_laser.position = position + offset
	
	get_parent().add_child(out_laser)
	
	return out_laser
	

func set_direction_in_bounds(in_direction: int) -> int:
	while(in_direction < 0):
		in_direction += 8
		
	while(in_direction > 7):
		in_direction -= 8
		
	return in_direction
