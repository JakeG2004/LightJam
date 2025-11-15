extends Node2D

const Cell := preload("res://cells/base_cell.gd")
const CELL_SIZE := 32.0

var cells: Array[Cell] = []
var width: int = 0
var height: int = 0

## Returns the cell at the position.
## Returns `null` if there is no cell of it is out of bounds. 
func get_at(pos: Vector2) -> Cell:
	var xy := pos_to_xy(pos)
	var idx := xy_to_idx(xy)
	return cells[idx] if is_inbounds(xy) else null

# Returns the x and y index from the position.
func pos_to_xy(pos: Vector2) -> Vector2i:
	return Vector2i(floor(pos.x / CELL_SIZE), floor(pos.y / CELL_SIZE))

# Returns the array index of the x and y cell.
func xy_to_idx(xy: Vector2i) -> int:
	return xy.x + xy.y * width

# Returns `true` if the x and y is in the bounds of the map.
func is_inbounds(xy: Vector2i) -> bool:
	return xy.x >= 0 && xy.x < width && xy.y >= 0 && xy.y < height

# Returns the cell that the ray hits from the starting position to the direction.
# Returns `null` if the ray hits nothing or out of bounds.
func castray(start: Vector2, direction: float) -> Cell:
	return null
