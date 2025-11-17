extends Control

@export var high_score_text: RichTextLabel

func _ready():
	if(GameManager.instance):
		high_score_text.text = "High Score: " + str(GameManager.instance.get_high_score())
	GameEvents.flash_level.emit()

func play_game():
	await get_tree().create_timer(1).timeout
	GameManager.instance.load_scene("game")
	
func custom():
	GameManager.instance.load_scene("custom")
	
func quit():
	GameManager.instance.quit()
