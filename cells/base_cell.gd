extends Node2D

# Define laser type
const Laser = preload("res://laser/laser.gd")
const LaserScene = preload("res://laser/laser.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Get input laser. Default case is to pass it through
func laser_in(in_laser: Laser) -> void:
	laser_out(in_laser.direction, in_laser.color)
	

# Creates an output laser for the cell based on a given direction and color
func laser_out(direction: int, color: Color) -> Laser:
	var out_laser: Laser = LaserScene.instantiate()
	out_laser.direction = direction
	out_laser.color = color
	
	return out_laser
