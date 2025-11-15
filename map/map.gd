extends Node2D

const Cell := preload("res://cells/base_cell.gd")
const CELL_SIZE := 32.0

var cells: Array[Cell] = []
var width: int = 0
var height: int = 0

func get_at(pos: Vector2) -> Cell:
	var xy := pos_to_xy(pos)
	var idx := xy_to_idx(xy)
	return cells[idx] if is_inbounds(xy) else null

func pos_to_xy(pos: Vector2) -> Vector2i:
	return Vector2i(floor(pos.x / CELL_SIZE), floor(pos.y / CELL_SIZE))

func xy_to_idx(xy: Vector2i) -> int:
	return xy.x + xy.y * width

func is_inbounds(xy: Vector2i) -> bool:
	return xy.x >= 0 && xy.x < width && xy.y >= 0 && xy.y < height
