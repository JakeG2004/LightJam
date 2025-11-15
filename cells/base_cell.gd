extends Node2D

# Define laser type
const Laser = preload("res://laser/laser.gd")
const LaserScene = preload("res://laser/laser.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func laser_in(in_laser: Laser) -> void:
	pass
	

func laser_out(direction: int, color: Color) -> Laser:
	var out_laser: Laser = LaserScene.instantiate()
	out_laser.direction = direction
	out_laser.color = color
	
	return out_laser
