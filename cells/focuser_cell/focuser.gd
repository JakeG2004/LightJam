extends "res://cells/base_cell.gd"

# Get input laser. Default case is to pass it through
func laser_in(in_laser: Laser) -> void:
	# Handle laser reflections one way
	if(in_laser.direction == facing):
		laser_out(in_laser.direction, in_laser.color, increase_strength(in_laser))
		
# Decreases the strength of the laser by 1
func increase_strength(in_laser: Laser) -> int:
	match in_laser.strength:
		in_laser.WEAK_STRENGTH:
			return in_laser.NORMAL_STRENGTH
		in_laser.NORMAL_STRENGTH:
			return in_laser.STRONG_STRENGTH
		_:
			return in_laser.strength
