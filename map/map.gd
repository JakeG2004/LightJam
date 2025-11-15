class_name Map
extends Node2D

const Cell := preload("res://cells/base_cell.gd")
const BaseCellScene := preload("res://cells/base_cell.tscn")
const DEFAULT_TILE_TEXTURE := preload("res://map/default_tile.png")
const CELL_SIZE := 32.0

@export_range(0, 100) var width: int = 0
@export_range(0, 100) var height: int = 0

var cells: Array[Cell] = []
var tiles: Array[Texture] = []

func _enter_tree():
	cells.resize(width * height)
	tiles.resize(width * height)
	initialize_array()
	
# Dynamic resizing of the array. Also clears the array
func resize_array(dimension: int):
	clear_array()
	
	width = dimension
	height = dimension
	cells.resize(width * height)
	tiles.resize(width * height)
	
	initialize_array()
	
# Clears all of the old cells from the scene
func clear_array():
	for c in cells:
		if c != null and c.is_inside_tree():
			c.queue_free()

	cells.fill(null)
	tiles.fill(DEFAULT_TILE_TEXTURE)
	queue_redraw()

# Sets every cell to be the base cell by default
func initialize_array():
	for y in range(height):
		for x in range(width):
			var cell := BaseCellScene.instantiate()
			add_child(cell)

			var xy := Vector2i(x, y)
			cell.position = Vector2(xy) * CELL_SIZE + Vector2.ONE * CELL_SIZE / 2.0

			cells[xy_to_idx(xy)] = cell
	
	tiles.fill(DEFAULT_TILE_TEXTURE)
	queue_redraw()

## Returns the cell at the position.
## Returns `null` if there is no cell of it is out of bounds. 
func get_at(pos: Vector2) -> Cell:
	var xy := pos_to_xy(pos)
	var idx := xy_to_idx(xy)
	return cells[idx] if is_inbounds(xy) else null

## Sets the cell at the position, replacing any other cell at the position.
func set_at(pos: Vector2, cell: Cell):
	var xy := pos_to_xy(pos)
	if is_inbounds(xy):
		cells[xy_to_idx(xy)] = cell

func set_tile(pos: Vector2, txtr: Texture):
	var xy := pos_to_xy(pos)
	if is_inbounds(xy):
		tiles[xy_to_idx(xy)] = txtr if txtr != null else DEFAULT_TILE_TEXTURE
		queue_redraw()

## Returns the x and y index from the position.
func pos_to_xy(pos: Vector2) -> Vector2i:
	pos -= global_position
	return Vector2i(floor(pos.x / CELL_SIZE), floor(pos.y / CELL_SIZE))

## Returns the array index of the x and y cell.
func xy_to_idx(xy: Vector2i) -> int:
	return xy.x + xy.y * width

## Returns the position of the x and y cell.
func xy_to_pos(xy: Vector2i) -> Vector2:
	return Vector2(xy) * CELL_SIZE + Vector2.ONE * CELL_SIZE / 2.0 + global_position

## Returns `true` if the x and y is in the bounds of the map.
func is_inbounds(xy: Vector2i) -> bool:
	return xy.x >= 0 && xy.x < width && xy.y >= 0 && xy.y < height

## Returns the cell that the ray hits from the starting position to the direction.
func castray(start: Vector2, direction: int) -> Vector2:
	var dir := direction_to_vector(direction)
	var xy := pos_to_xy(start) + dir
	
	while is_inbounds(xy):
		var cell := cells[xy_to_idx(xy)]
		if cell != null:
			break
		xy += dir
	
	return xy_to_pos(xy)

# Returns the vector form of the direction.
static func direction_to_vector(d: int) -> Vector2i:
	d = posmod(d, 8)
	# sloppy, but works :)
	match d:
		0: return Vector2i.UP
		1: return Vector2i.UP + Vector2i.RIGHT
		2: return Vector2i.RIGHT
		3: return Vector2i.DOWN + Vector2i.RIGHT
		4: return Vector2i.DOWN
		5: return Vector2i.DOWN + Vector2i.LEFT
		6: return Vector2i.LEFT
		7: return Vector2i.UP + Vector2i.LEFT
	return Vector2i.UP

"""
0 - 000 = up
1 - 001 = up/right
2 - 010 = right
3 - 011 = down/right
4 - 100 = down
5 - 101 = down/left
6 - 110 = left
7 - 111 = up/left
"""

## Draws the tiles on the map.
func _draw():
	for x in width:
		for y in height:
			var xy := Vector2i(x, y)
			var pos := Vector2(xy) * CELL_SIZE + Vector2.ONE * CELL_SIZE / 2.0
			draw_texture(tiles[xy_to_idx(xy)], pos)
