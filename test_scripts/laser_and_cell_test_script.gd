extends Node2D

const Laser = preload("res://laser/laser.gd")
const BaseCell = preload("res://cells/base_cell.gd")
const ColorCell = preload("res://cells/color_changer_cell/color_changer_cell.gd")

@export var initial_laser: Laser
@export var base_cell: BaseCell
@export var color_cell: ColorCell

func _ready() -> void:
	initial_laser = $Laser
	base_cell = $BaseCell
	color_cell = $ColorCell

func SimulateLaserHit():
	base_cell.laser_in(initial_laser)
	
func SimulateColorCellHit():
	color_cell.laser_in(initial_laser)


func RedrawAllLasers():
	get_tree().call_group("Laser", "set_end_pos", Vector2(100, 0))
