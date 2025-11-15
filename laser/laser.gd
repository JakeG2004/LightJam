extends Node2D

@export var color: Color = Color.WHITE
@export var direction: int = 0 # 0 for straight up, 1 for upper right, 2 for straight right, etc... range is 0 - 7
@export var end_pos: Vector2 = Vector2.ZERO
@export var strength: int = 1

# Function to set the end pos and draw the laser
func set_end_pos(pos: Vector2) -> void:
	end_pos = pos
	draw_laser()

# Tells the draw function to redraw	
func draw_laser() -> void:
	queue_redraw()
	
# Draws the line of the laser
func _draw():
	draw_line(self.global_position, end_pos, color, strength)
