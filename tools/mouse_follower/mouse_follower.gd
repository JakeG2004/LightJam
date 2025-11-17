class_name MouseFollower

extends Node2D

var map: Map
var placing: bool = false

func _ready() -> void:
	map = get_parent().get_child(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_position = map.fit_to_grid(get_global_mouse_position())
	if(placing):
		place_piece()

func delete_children():
	for child in get_children():
		child.queue_free()
		
		
func rotate_piece():
	if(get_child_count() <= 0):
		return
		
	var child: Cell = get_child(0)
	child.rotate_piece()
	
func change_piece_color():
	if(get_child_count() <= 0):
		return
		
	var child: Cell = get_child(0)
	child.change_color()
	
func change_cell_strength():
	if(get_child_count() <= 0):
		return
		
	var child: Cell = get_child(0)
	child.change_strength()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			placing = event.pressed

			
	if event is InputEventKey:
		# Get R Keycode to rotate object
		if event.pressed and event.keycode == KEY_R:
			rotate_piece()
			
		if event.pressed and event.keycode == KEY_C:
			change_piece_color()
			
		if event.pressed and event.keycode == KEY_S:
			change_cell_strength()
			

func place_piece():
	if(get_child_count() == 0 || !map.is_inbounds_at(global_position)):
		return
	var child:= get_child(0)
	if(child is not Cell):
		return
	map.set_at(global_position, child)
	child.reparent(map)
	child.on_place()
			
	await get_tree().create_timer(.1).timeout
	
	if(child == null):
		return
		
	var new_piece: Cell = child.duplicate()
	add_child(new_piece)
	new_piece.global_position = global_position
