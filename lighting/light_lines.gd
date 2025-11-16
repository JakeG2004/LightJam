extends Node2D

func _process(_dt):
	queue_redraw()

# Draws the line of the laser
func _draw():
	var lasers := get_tree().get_nodes_in_group("Laser")
	
	for laser: Laser in lasers:
		draw_laser(laser, 0.25, 30.0)
	
	for laser: Laser in lasers:
		draw_laser(laser, 0.5, 25.0)
		
	for laser: Laser in lasers:
		draw_laser(laser, 1.0, 20.0)

func draw_laser(laser: Laser, brightness: float, thickness: float):
	var c := laser.color * brightness
	c.a = 1.0
	draw_line(laser.position, laser.position + laser.end_pos, c, laser.strength * thickness)
	draw_circle(laser.position, laser.strength * thickness, c)
	draw_circle(laser.position + laser.end_pos, laser.strength * thickness / 2.0, c)
