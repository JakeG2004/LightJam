class_name ShadowCell
extends "res://cells/base_cell.gd"

signal died(enemy)

func laser_in(in_laser: Laser) -> void:
	laser_out(in_laser.direction, in_laser.color, in_laser.strength)
	died.emit(self)
	queue_free()
