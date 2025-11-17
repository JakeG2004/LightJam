class_name SoundManager
extends Node2D

static var instance

@onready var music_player := $MusicPlayer
# @onready var sfx_player is now OBSOLETE - we will use the built-in function

# Preload all your SFX
var sounds := {
	"laser": preload("res://sounds/sfx/laser.wav"),
	"win": preload("res://sounds/sfx/win.wav"),
	"lose": preload("res://sounds/sfx/lose.wav"),
	"game_won": preload("res://sounds/sfx/game_won.wav")
}

func _ready():
	instance = self

	# Music setup
	music_player.stream = preload("res://sounds/music/music.mp3")
	music_player.play()

# Use the built-in play_clip for polyphonic SFX
func play_clip(clip: String):
	# 1. Check if the sound key exists in the dictionary
	if sounds.has(clip):
		# Retrieve the preloaded AudioStream resource (e.g., AudioStreamWAV)
		var sound_stream: AudioStream = sounds[clip]
		
		# 2. Create a new AudioStreamPlayer node dynamically
		var player = AudioStreamPlayer.new()
		player.stream = sound_stream
		
		# 3. Add the player to the scene tree as a child of SoundManager
		add_child(player)
		
		# 4. Start playing the sound
		player.play()
		
		# 5. Crucial: Connect the 'finished' signal to automatically remove the player
		# This prevents memory leaks by deleting the node after the sound is done.
		player.finished.connect(player.queue_free)
	else:
		print("Error: SFX clip '%s' not found." % clip)
