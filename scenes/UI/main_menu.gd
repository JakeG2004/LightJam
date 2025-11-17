extends Control

@export var high_score_text: RichTextLabel

func _ready():
	if(GameManager.instance):
		high_score_text.text = "[center]High Score: " + str(GameManager.instance.get_high_score()) + "[/center]"

func play_game():
	GameManager.instance.load_scene("game")
	
func quit():
	GameManager.instance.quit()
