class_name ReflectorCell

extends "res://cells/base_cell.gd"

func rotate_piece():
	facing = (set_direction_in_bounds(facing + 1))
	get_child(1).rotate(-PI / 4)

# Get input laser. Default case is to pass it through
func laser_in(in_laser: Laser) -> void:
	var d = in_laser.direction
	
	if(facing == 0):
		match d:
			0: laser_out(2, in_laser.color, in_laser.strength)
			6: laser_out(4, in_laser.color, in_laser.strength)
			7: laser_out(3, in_laser.color, in_laser.strength)
	
	if(facing == 1):
		match d:
			5: laser_out(3, in_laser.color, in_laser.strength)
			6: laser_out(2, in_laser.color, in_laser.strength)
			7: laser_out(1, in_laser.color, in_laser.strength)
			
	if(facing == 2):
		match d:
			4: laser_out(2, in_laser.color, in_laser.strength)
			6: laser_out(0, in_laser.color, in_laser.strength)
			5: laser_out(1, in_laser.color, in_laser.strength)

	if(facing == 3):
		match d:
			3: laser_out(1, in_laser.color, in_laser.strength)
			4: laser_out(0, in_laser.color, in_laser.strength)
			5: laser_out(7, in_laser.color, in_laser.strength)

	if(facing == 4):
		match d:
			2: laser_out(0, in_laser.color, in_laser.strength)
			4: laser_out(6, in_laser.color, in_laser.strength)
			3: laser_out(7, in_laser.color, in_laser.strength)
			
	if(facing == 5):
		match d:
			1: laser_out(7, in_laser.color, in_laser.strength)
			2: laser_out(6, in_laser.color, in_laser.strength)
			3: laser_out(5, in_laser.color, in_laser.strength)

	if(facing == 6):
		match d:
			2: laser_out(4, in_laser.color, in_laser.strength)
			0: laser_out(6, in_laser.color, in_laser.strength)
			1: laser_out(5, in_laser.color, in_laser.strength)

	if(facing == 7):
		match d:
			7: laser_out(5, in_laser.color, in_laser.strength)
			0: laser_out(4, in_laser.color, in_laser.strength)
			1: laser_out(3, in_laser.color, in_laser.strength)
