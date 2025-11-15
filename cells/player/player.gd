extends "res://cells/base_cell.gd"

var cursor := Vector2.ZERO

func laser_in(_in_laser: Laser) -> void:
	GameEvents.game_over.emit()

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("shoot"):
		shoot()

func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		cursor = event.position

func shoot():
	var direction := Laser.rad_to_direction(global_position.direction_to(cursor).angle())
	laser_out(direction, Color.WHITE, Laser.NORMAL_STRENGTH)
