extends Node2D


# Called when the node enters the scene tree for the first time.
@onready var music_player = $AudioStreamPlayer

func _ready():
	# Play the music on scene load
	music_player.play()
	# Ensure the music loops
	music_player.loop = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
