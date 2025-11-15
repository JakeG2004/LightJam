extends Node2D

@export var color: Color = Color.WHITE
@export var direction: int = 0 # 0 for straight up, 1 for upper right, 2 for straight right, etc... range is 0 - 7
@export var end_pos: Vector2 = Vector2.ZERO
@export var strength: int = 3

# Laser strengths
const NORMAL_STRENGTH: int = 3
const WEAK_STRENGTH: int = 2
const STRONG_STRENGTH: int = 4


# Set the end position to be global for safety
func _ready() -> void:
	#set_end_pos(end_pos)
	cast_ray_and_hit()

# Sets the end position to hit a map cell and calls the cell `laser_in` method.
func cast_ray_and_hit():
	if Level.map:
		var pos := Level.map.castray(global_position, direction)
		set_end_pos(pos)
		var cell := Level.map.get_at(pos)
		if cell:
			cell.laser_in(self)

# Function to set the end pos and draw the laser
func set_end_pos(pos: Vector2) -> void:
	end_pos = to_local(pos)
	draw_laser()

# Tells the draw function to redraw	
func draw_laser() -> void:
	queue_redraw()
	
# Draws the line of the laser
func _draw():
	draw_line(Vector2.ZERO, end_pos, color, strength)

# Returns the integer direction of the given radian angle.
static func rad_to_direction(rad: float) -> int:
	return int(roundf((fposmod(rad, TAU)) / TAU * 8.0) + 2.0) % 8
