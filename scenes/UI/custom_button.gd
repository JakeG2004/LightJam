extends Button

var path: String = "path"

func _on_pressed() -> void:
	GameManager.instance.load_scene_from_path(path)
