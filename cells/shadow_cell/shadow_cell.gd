class_name ShadowCell
extends "res://cells/base_cell.gd"

var weak_tex = preload("res://cells/shadow_cell/shadow_cell_weak.png")
var normal_tex = preload("res://cells/shadow_cell/shadow_cell_normal.png")
var strong_tex = preload("res://cells/shadow_cell/shadow_cell_strong.png")

signal illuminated(enemy)

enum CellColor { WHITE, RED, GREEN, YELLOW }

@export var cell_color: CellColor = CellColor.WHITE
@export var strength: int = 3 # 2 for weak, 3 for normal, 4 for strong
var icon: Sprite2D

func _ready() -> void:
	super()
	icon = get_child(1)
	
	var color : Color
	match cell_color:
		CellColor.WHITE: color = Color(Color.WHITE, 0.5)
		CellColor.RED: color = Color(Color.RED, 0.5)
		CellColor.GREEN: color = Color(Color.GREEN, 0.5)
		CellColor.YELLOW: color = Color(Color.YELLOW, 0.5)
		
	icon.modulate = color
	add_to_group("Enemies")
	if(Level.instance):
		Level.instance.gems.append(self)
		
	for x in range(get_child_count()):
		if(x <= 1):
			continue
		get_child(x).queue_free()
		

func change_strength():
	strength = strength + 1
	if(strength > 4):
		strength = 2

	match strength:
		2:
			icon.texture = weak_tex
		3:
			icon.texture = normal_tex
		4:
			icon.texture = strong_tex
		_: return
		
func change_color():
	cell_color = (cell_color + 1) % 4 as CellColor
	
	var color : Color
	match cell_color:
		CellColor.WHITE: color = Color(Color.WHITE, 0.5)
		CellColor.RED: color = Color(Color.RED, 0.5)
		CellColor.GREEN: color = Color(Color.GREEN, 0.5)
		CellColor.YELLOW: color = Color(Color.YELLOW, 0.5)
		
	icon.modulate = color

func laser_in(in_laser: Laser) -> void:
	laser_out(in_laser.direction, in_laser.color, in_laser.strength)
	if(equal_colors(in_laser.color, icon.modulate) && in_laser.strength >= strength):
		illuminated.emit(self)
		icon.modulate = Color(icon.modulate, 1)
		
func equal_colors(c1: Color, c2: Color) -> bool:
	if(c1.r == c2.r && c1.g == c2.g && c1.b == c2.b):
		return true
	return false
