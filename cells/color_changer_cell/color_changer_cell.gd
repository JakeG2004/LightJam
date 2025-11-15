extends "res://cells/base_cell.gd"

var color: Color = Color.RED

func laser_in(in_laser: Laser) -> void:
	laser_out(in_laser.direction, color, in_laser.strength)
