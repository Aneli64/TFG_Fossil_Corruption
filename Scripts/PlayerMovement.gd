extends CharacterBody2D

const SPEED = 350.0
const JUMP_VELOCITY = 400.0

var motion := Vector2()

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Inicialización del sprite de movimiento
@onready var movementSprite = $MovementSprite

func _ready():
	# Iniciamos el sprite de estado estatico una vez inicie el juego
	movementSprite.play("parado")
	
# REVISAR, IS COLLIDING NO FUNCIONA
# https://www.youtube.com/watch?v=ffdYBT0BTXk&t=255s
func _left_colission() -> bool:
	return $LeftRay.is_colliding()

func _right_colission() -> bool:
	return $RightRay.is_colliding()
	
func _floor_colission() -> bool:
	return $MovementSprite/FloorRay.is_colliding()

func _flip():
	if _left_colission() or _right_colission() or _floor_colission():
		motion.x *= -1
		$MovementSprite.scale.x *= -1

func _physics_process(delta):
	motion.y += gravity
	_flip()
	#motion = move_and_slide(motion)
	pass
