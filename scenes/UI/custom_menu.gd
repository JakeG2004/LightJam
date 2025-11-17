extends Control

var ButtonScene = preload("res://scenes/UI/custom_button.tscn")
var vbox: VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vbox = $CanvasLayer/ScrollContainer/VBoxContainer
	var dir_path = "user://levels/"

	# Try to open the directory
	var dir := DirAccess.open(dir_path)
	if dir == null:
		push_error("Could not open directory: " + dir_path)
		return

	dir.list_dir_begin()

	while true:
		var file_name = dir.get_next()
		if file_name == "":
			break  # No more files

		# Skip folder names
		if dir.current_is_dir():
			continue

		# Optional: filter by extension (.tscn)
		if file_name.ends_with(".tscn"):
			print("Found level:", file_name)

			# Create a button for it
			var btn = ButtonScene.instantiate()
			btn.path = dir_path + file_name
			btn.text = file_name
			vbox.add_child(btn)

	dir.list_dir_end()
	
func load_custom_editor():
	GameManager.instance.load_scene("editor")
	
func import_tscn():
	var dialog := FileDialog.new()
	dialog.access = FileDialog.ACCESS_FILESYSTEM
	dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	dialog.filters = ["*.tscn"]

	# Make sure the directory exists
	ensure_levels_dir()

	# Set the starting path
	dialog.current_dir = ProjectSettings.globalize_path("user://levels")

	add_child(dialog)

	dialog.file_selected.connect(func(path):
		print("Selected scene:", path)
		load_imported_scene(path)
	)

	dialog.popup_centered()
	
func ensure_levels_dir() -> void:
	var da := DirAccess.open("user://")
	if da == null:
		push_error("Could not open user:// directory")
		return
	
	if not da.dir_exists("levels"):
		da.make_dir_recursive("levels")


func load_imported_scene(path: String):
	var scene := load(path)
	if scene == null:
		push_error("Error: could not load scene at path " + path)
		return

	GameManager.instance.load_scene_from_path(path)
	print("Imported scene loaded successfully!")
