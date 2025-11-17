extends "res://cells/base_cell.gd"

# Get input laser. Default case is to pass it through
func laser_in(in_laser: Laser) -> void:
	# Handle laser reflections one way
	if(((facing == 4 || facing == 0 ) && in_laser.direction == facing) || 
	((facing == 2 || facing == 6 ) && in_laser.direction == set_direction_in_bounds(facing + 4))):
		laser_out(in_laser.direction, in_laser.color, decrease_strength(in_laser))
		
# Decreases the strength of the laser by 1
func decrease_strength(in_laser: Laser) -> int:
	match in_laser.strength:
		in_laser.STRONG_STRENGTH:
			return in_laser.NORMAL_STRENGTH
		in_laser.NORMAL_STRENGTH:
			return in_laser.WEAK_STRENGTH
		_:
			return in_laser.strength
