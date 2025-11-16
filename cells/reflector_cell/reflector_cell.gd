class_name ReflectorCell

extends "res://cells/base_cell.gd"

# Get input laser. Default case is to pass it through
func laser_in(in_laser: Laser) -> void:
	# Handle laser reflections one way
	if(in_laser.direction == facing):
		laser_out(set_direction_in_bounds(in_laser.direction - 2), in_laser.color, in_laser.strength)
		
	# Handle laser reflections the other way
	if(set_direction_in_bounds(in_laser.direction + 2) == facing):
		laser_out(set_direction_in_bounds(in_laser.direction + 2), in_laser.color, in_laser.strength)
