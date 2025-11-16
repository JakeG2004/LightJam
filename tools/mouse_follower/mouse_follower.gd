class_name MouseFollower

extends Node2D

var map: Map

func _ready() -> void:
	map = get_parent().get_child(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_position = map.fit_to_grid(get_global_mouse_position())


func delete_children():
	for child in get_children():
		child.queue_free()
		
		
func rotate_piece():
	if(get_child_count() <= 0):
		return
		
	var child: Cell = get_child(0)
	child.facing = (child.set_direction_in_bounds(child.facing + 2))
	child.rotate(-PI / 2)
	
func change_piece_color():
	if(get_child_count() <= 0):
		return
		
	var child: Cell = get_child(0)
	child.change_color()

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT && get_child_count() > 0 && map.is_inbounds_at(global_position):
			var child: Cell = get_child(0)
			map.set_at(global_position, child)
			child.reparent(map)
			child.on_place()
			
	if event is InputEventKey:
		# Get R Keycode to rotate object
		if event.pressed and event.keycode == KEY_R:
			rotate_piece()
			
		if event.pressed and event.keycode == KEY_C:
			change_piece_color()
			
