extends Node2D

const LINE_SIZE := 32.0

func _process(_dt):
	queue_redraw()

# Draws the line of the laser
func _draw():
	var lasers := get_tree().get_nodes_in_group("Laser")
	
	for laser: Laser in lasers:
		draw_laser(laser, 0.25, LINE_SIZE * 1.5)
	
	for laser: Laser in lasers:
		draw_laser(laser, 0.5, LINE_SIZE * 1.25)
		
	for laser: Laser in lasers:
		draw_laser(laser, 1.0, LINE_SIZE)

func draw_laser(laser: Laser, brightness: float, thickness: float):
	thickness = laser.strength * laser.brightness * thickness
	var c := laser.color * brightness
	c.a = 1.0
	draw_line(laser.position, laser.position + laser.end_pos, c, thickness)
	draw_circle(laser.position, thickness, c)
	draw_circle(laser.position + laser.end_pos, thickness / 2.0, c)
