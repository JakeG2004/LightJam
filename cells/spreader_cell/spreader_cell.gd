extends "res://cells/base_cell.gd"

# Get input laser. Default case is to pass it through
func laser_in(in_laser: Laser) -> void:
	create_out_lasers(in_laser, 3)

# Spawn n lasers where n is odd
func create_out_lasers(in_laser: Laser, n: int) -> void:
	for i in range(n):
		if(facing == 0 || facing == 4):
			@warning_ignore("integer_division")
			laser_out(in_laser.direction, in_laser.color, in_laser.strength, Vector2(i - (n / 2), 0))
			
		if(facing == 2 || facing == 6):
			@warning_ignore("integer_division")
			laser_out(in_laser.direction, in_laser.color, in_laser.strength, Vector2(0, i - (n / 2)))
