extends "res://levels/level.gd"

const BaseCellScene := preload("res://cells/base_cell.tscn")
const ReflectorCellScene := preload("res://cells/reflector_cell/reflector_cell.tscn")
const PlayerCellScene := preload("res://cells/player/player.tscn")
const BlockerCellScene := preload("res://cells/blocker_cell/blocker_cell.tscn")
const ColorChangerCellScene := preload("res://cells/color_changer_cell/color_changer_cell.tscn")
const DefocuserCellScene := preload("res://cells/defocuser_cell/defocuser_cell.tscn")
const FocuserCellScene := preload("res://cells/focuser_cell/focuser.tscn")
const ShadowCellScene := preload("res://cells/shadow_cell/shadow_cell.tscn")
const SpreaderCellScene := preload("res://cells/spreader_cell/spreader_cell.tscn")

var mouse_follower: MouseFollower

func _ready():
	mouse_follower = $MouseFollower
	
func set_dimension(dim_string: String):
	map.resize_array(int(dim_string))
	
func add_reflector_cell():
	# Delete all existing children which are following the mouse
	mouse_follower.delete_children()
	
	# Add an a reflector cell as a child of the mouse follower
	var reflector: ReflectorCell = ReflectorCellScene.instantiate()
	mouse_follower.add_child(reflector)
	
func add_base_cell():
	mouse_follower.delete_children()
	
	var base_cell: Cell = BaseCellScene.instantiate()
	mouse_follower.add_child(base_cell)
	
func add_player_cell():
	mouse_follower.delete_children()
	
	var player_cell: Cell = PlayerCellScene.instantiate()
	mouse_follower.add_child(player_cell)
	
func add_blocker_cell():
	mouse_follower.delete_children()
	
	var blocker_cell: Cell = BlockerCellScene.instantiate()
	mouse_follower.add_child(blocker_cell)
	
func add_color_changer_cell():
	mouse_follower.delete_children()
	
	var color_changer_cell: Cell = ColorChangerCellScene.instantiate()
	mouse_follower.add_child(color_changer_cell)
	
func add_defocuser_cell():
	mouse_follower.delete_children()
	
	var defocuser_cell: Cell = DefocuserCellScene.instantiate()
	mouse_follower.add_child(defocuser_cell)
	
func add_focuser_cell():
	mouse_follower.delete_children()
	
	var focuser_cell: Cell = FocuserCellScene.instantiate()
	mouse_follower.add_child(focuser_cell)
	
func add_shadow_cell():
	mouse_follower.delete_children()
	
	var shadow_cell: Cell = ShadowCellScene.instantiate()
	mouse_follower.add_child(shadow_cell)
	
func add_spreader_cell():
	mouse_follower.delete_children()
	
	var spreader_cell: Cell = SpreaderCellScene.instantiate()
	mouse_follower.add_child(spreader_cell)

func save_level():
	save_as_scene()
	
func load_level():
	pass
	
func apply_screen_fit():
	pass
