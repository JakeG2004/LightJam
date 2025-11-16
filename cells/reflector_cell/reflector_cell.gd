class_name ReflectorCell

extends "res://cells/base_cell.gd"

# Get input laser. Default case is to pass it through
func laser_in(in_laser: Laser) -> void:
	var d = in_laser.direction

	print("in laser: %s, facing %s" % [d, facing])
	
	if(facing == 0):
		match d:
			0: laser_out(2, in_laser.color, in_laser.strength)
			6: laser_out(4, in_laser.color, in_laser.strength)

	if(facing == 2):
		match d:
			4: laser_out(2, in_laser.color, in_laser.strength)
			6: laser_out(0, in_laser.color, in_laser.strength)

	if(facing == 4):
		match d:
			2: laser_out(0, in_laser.color, in_laser.strength)
			4: laser_out(6, in_laser.color, in_laser.strength)
			
	if(facing == 6):
		match d:
			2: laser_out(4, in_laser.color, in_laser.strength)
			0: laser_out(6, in_laser.color, in_laser.strength)
