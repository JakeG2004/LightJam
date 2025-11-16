extends "res://cells/base_cell.gd"

@export var left_wing: Cell
@export var right_wing: Cell

func _ready() -> void:
	left_wing = get_child(2)
	right_wing = get_child(1)
	
func _process(_delta: float) -> void:
	if(left_wing == null || right_wing == null):
		queue_free()
		if(left_wing != null):
			left_wing.queue_free()
		if(right_wing != null):
			right_wing.queue_free()
		
func on_place():
		left_wing.reparent(get_parent())
		right_wing.reparent(get_parent())
			
		match facing:
			0: # input facing down
				Level.map.set_at(Level.map.xy_to_pos(Level.map.pos_to_xy(global_position) - Vector2i(1, 0)), left_wing)
				Level.map.set_at(Level.map.xy_to_pos(Level.map.pos_to_xy(global_position) + Vector2i(1, 0)), right_wing)
			2: # input facing right
				Level.map.set_at(Level.map.xy_to_pos(Level.map.pos_to_xy(global_position) - Vector2i(0, 1)), left_wing)
				Level.map.set_at(Level.map.xy_to_pos(Level.map.pos_to_xy(global_position) + Vector2i(0, 1)), right_wing)
			4: # input facing up
				Level.map.set_at(Level.map.xy_to_pos(Level.map.pos_to_xy(global_position) + Vector2i(1, 0)), left_wing)
				Level.map.set_at(Level.map.xy_to_pos(Level.map.pos_to_xy(global_position) - Vector2i(1, 0)), right_wing)
			6: # input facing left
				Level.map.set_at(Level.map.xy_to_pos(Level.map.pos_to_xy(global_position) + Vector2i(0, 1)), left_wing)
				Level.map.set_at(Level.map.xy_to_pos(Level.map.pos_to_xy(global_position) - Vector2i(0, 1)), right_wing)
			_: # other
				pass

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
