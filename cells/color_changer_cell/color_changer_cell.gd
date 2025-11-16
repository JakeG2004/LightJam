extends "res://cells/base_cell.gd"

enum CellColor { WHITE, RED, GREEN, YELLOW }

@export var cell_color: CellColor = CellColor.WHITE

func change_color():
	cell_color = (cell_color + 1) % 4 as CellColor
	var icon: Sprite2D = get_child(1)
	
	var color : Color
	match cell_color:
		CellColor.WHITE: color = Color.WHITE
		CellColor.RED: color = Color.RED
		CellColor.GREEN: color = Color.GREEN
		CellColor.YELLOW: color = Color.YELLOW
		
	icon.modulate = color
	
	

func laser_in(in_laser: Laser) -> void:
	var color : Color
	match cell_color:
		CellColor.WHITE: color = Color.WHITE
		CellColor.RED: color = Color.RED
		CellColor.GREEN: color = Color.GREEN
		CellColor.YELLOW: color = Color.YELLOW

	laser_out(in_laser.direction, color, in_laser.strength)
