extends Node2D

const BaseCellScene := preload("res://cells/base_cell.tscn")
const ReflectorCellScene := preload("res://cells/reflector_cell/reflector_cell.tscn")

var map: Map
var mouse_follower: MouseFollower

func _ready():
	map = $Map
	mouse_follower = $MouseFollower
	
func set_dimension(dim_string: String):
	map.resize_array(int(dim_string))
	
func add_reflector_cell():
	# Delete all existing children which are following the mouse
	mouse_follower.delete_children()
	
	# Add an a reflector cell as a child of the mouse follower
	var reflector: ReflectorCell = ReflectorCellScene.instantiate()
	mouse_follower.add_child(reflector)

func save_level():
	pass
	
func load_level():
	pass
