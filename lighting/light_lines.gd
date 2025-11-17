extends Node2D

const LINE_SIZE := 32.0
var flashing: bool = false
var flash_time := 0.0
const FLASH_DURATION := .5
const FLASH_HOLD = 0.25
const FLASH_RADIUS = 150

func _ready():
	GameEvents.flash_level.connect(_on_flash_level)
	GameEvents.next_level.connect(_on_flash_level)
	
func _on_flash_level():
	flashing = true
	flash_time = FLASH_DURATION + FLASH_HOLD
	

func _process(dt):
	if(flashing):
		flash_time -= dt
		if(flash_time <= 0):
			flashing = false
	queue_redraw()

# Draws the line of the laser
func _draw():
	if(flashing):
		var vp_size = get_viewport().get_visible_rect().size
		var center = vp_size * 0.5
		draw_circle(center, FLASH_RADIUS, Color(1, 1, 1, (flash_time / FLASH_DURATION) * 0.25))
		draw_circle(center, FLASH_RADIUS * .8, Color(1, 1, 1, (flash_time / FLASH_DURATION) * 0.5))
		draw_circle(center, FLASH_RADIUS * .6, Color(1, 1, 1, flash_time / FLASH_DURATION))
		
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
