extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var movementSprite = $MovementSprite

func _ready():
	# Iniciamos el sprite de estado estatico una vez inicie el juego
	movementSprite.play("parado")
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		if direction < 0: movementSprite.flip_h = true
		else: movementSprite.flip_h = false
		velocity.x = direction * SPEED
		movementSprite.play("caminar")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		movementSprite.stop() 
		movementSprite.play("parado")

	move_and_slide()
