extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")

var is_dead = false

func _ready():
	var death_zone_path = "../DeathZone"  # Adjust the path if necessary
	print("Attempting to find DeathZone at path: ", death_zone_path)
	var death_zone = get_node(death_zone_path)
	if death_zone:
		death_zone.connect("player_died", Callable(self, "_on_player_died"))
		print("Connected to DeathZone successfully.")
	else:
		print("DeathZone not found at path: ", death_zone_path)

func _process(delta):
	if is_dead:
		print("Player is dead!")
		# Additional death handling logic (e.g., stop movement, play animation, etc.)
		# Optionally restart the game or respawn the player
		# For example, respawn the player after 2 seconds
		await get_tree().create_timer(2.0).timeout
		is_dead = false
		global_transform.origin = Vector2(100, 100)  # Respawn position

func _on_player_died():
	is_dead = true
	get_tree().paused = true


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1: 
		get_node("AnimatedSprite2D").flip_h = false
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
	if velocity.y > 0:
		anim.play("Fall")

	move_and_slide()
