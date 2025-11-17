extends "res://cells/base_cell.gd"

var cursor := Vector2.ZERO
@export var preview_laser_distance: int = 250
var direction: int
var can_shoot: bool = true

func _ready():
	super()
	GameEvents.out_of_lasers.connect(stop_shooting)

func laser_in(_in_laser: Laser) -> void:
	GameEvents.game_over.emit()

func _input(event: InputEvent) -> void:
	# Track mouse movement for cursor
	if event is InputEventMouseMotion:
		cursor = event.position
		preview_laser_direction()

	# Shoot on left mouse click
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and can_shoot:
			shoot()

func stop_shooting():
	can_shoot = false

func shoot():
	laser_out(direction, Color.WHITE, Laser.NORMAL_STRENGTH)
	if(SoundManager.instance):
		SoundManager.instance.play_clip("laser")
	GameEvents.player_shot.emit()

# Automatically draws a line to represent the direction that the laser will go in
func preview_laser_direction():
	direction = Laser.rad_to_direction(global_position.direction_to(cursor).angle())
	queue_redraw()


func _draw():
	var angle := set_direction_in_bounds(direction - 2) * PI / 4.0
	var dir_vec := Vector2(cos(angle), sin(angle))
	draw_line(Vector2.ZERO, dir_vec * preview_laser_distance, Color(Color.WHITE, 0.5), 3)
