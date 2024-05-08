extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var movementSprite = $MovementSprite

func _ready():
	# Iniciamos el sprite de estado estatico una vez inicie el juego
	movementSprite.play("parado")
	# Movimiento por defecto
	velocity.x = SPEED
func orientation():
	if velocity.x >= 0:
		$MovementSprite.flip_h = false
	else:
		$MovementSprite.flip_h = true
func colission():
	if not $FloorRay.is_colliding() || $ColissionRay.is_colliding():
		velocity.x *= -1
		$FloorRay.position.x *= -1
		$ColissionRay.target_position.x *= -1
		
	
func _physics_process(delta):
	orientation()
	# Comprobamos colisiones de izquierda y derecha (y no permitimos que caiga )
	colission()
	# Controlamos la gravedad
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
