extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var raycast_left: RayCast2D
var raycast_right: RayCast2D
var raycast_forward: RayCast2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var movementSprite = $MovementSprite

func _ready():
	# Iniciamos el sprite de estado estatico una vez inicie el juego
	movementSprite.play("parado")
	raycast_left = $LeftRay
	raycast_right = $RightRay
	raycast_forward = $RayCastForward

func _left_collision() -> bool:
	return raycast_left.is_colliding()
func _right_collision() -> bool:
	return raycast_right.is_colliding()


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	var move_dir = Vector2.ZERO
	
	if _left_collision():
		print("colision izq")
		move_dir.x = 1
	else:
		move_dir.x = -1
	if _right_collision():
		print("colision derech")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		#move_dir.x = 1
		velocity.x = move_toward(velocity.x, 0, SPEED)

	position += move_dir.normalized() * SPEED * delta
	move_and_slide()
