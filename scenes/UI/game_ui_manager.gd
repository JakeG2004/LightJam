class_name GameBG
extends Control

@export var level_text: Label
@export var timer_text: Label
@export var hint_text: Label
@export var laser_container: HBoxContainer
const LaserIconScene = preload("res://scenes/UI/laser_icon.tscn")

static var instance
var timer: float = 5
var time_up: bool = false
var lasers_remaining = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_text = $VBoxContainer/LevelCounter
	timer_text = $Timer
	hint_text = $Hint
	laser_container = $VBoxContainer/LaserIconContainer
	
	GameEvents.player_shot.connect(shot_laser)
	instance = self
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(timer <= 0):
		if(time_up == false):
			timer_expired()
			timer_text.text = "0.00"
		time_up = true
		return
		
	timer -= maxf(delta, 0)
	timer_text.text = str(snapped(timer, 0.01))
	
func timer_expired():
	GameEvents.game_over.emit()

	
func new_level(level_num: int, num_lasers: int, time: float, hint: String):
	level_text.text = "Level: " + str(level_num)
	hint_text.text = hint
	timer = time
	lasers_remaining = num_lasers
	
	for x in range(num_lasers - laser_container.get_child_count()):
		var new_laser_icon := LaserIconScene.instantiate()
		laser_container.add_child(new_laser_icon)
	
func shot_laser():
	if(lasers_remaining <= 0 || laser_container.get_child_count() <= 0):
		GameEvents.out_of_lasers.emit()
		return
		
	lasers_remaining -= 1
	laser_container.get_child(0).queue_free()
	
