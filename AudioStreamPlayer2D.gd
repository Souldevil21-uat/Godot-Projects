extends AudioStreamPlayer2D

@onready var music_player = $AudioStreamPlayer

func _ready():
	# Play the music on scene load
	music_player.play()
	# Ensure the music loops
	music_player.loop = true
