extends Area2D

# Signal to notify when the player enters the death zone
signal player_died

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player":
		body.is_dead = true
		emit_signal("player_died")
		print("Player Has Died")
