extends "res://cells/base_cell.gd"

func laser_in(in_laser: Laser) -> void:
	laser_out(in_laser.direction, in_laser.color, in_laser.strength)
	#Level.on_enemy_death(self)
	queue_free()
