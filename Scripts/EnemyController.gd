extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var raycast_left: RayCast2D
var raycast_right: RayCast2D
var raycast_down: RayCast2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var movementSprite = $MovementSprite

func _ready():
	# Iniciamos el sprite de estado estatico una vez inicie el juego
	movementSprite.play("parado")
	
	# Inicializamos los raycast con su correspondiente vector
	raycast_left = $LeftRay
	raycast_right = $RightRay
	raycast_down = $MovementSprite/FloorRay
	
	# Movimiento por defecto
	velocity.x = SPEED

func colission():
	if raycast_right.is_colliding() or !raycast_down.is_colliding():
		movementSprite.flip_h = true
		velocity.x = -SPEED
	elif raycast_left.is_colliding() or !raycast_down.is_colliding():
		movementSprite.flip_h = false
		velocity.x = SPEED

func _physics_process(delta):
	# Comprobamos colisiones de izquierda y derecha (y no permitimos que caiga )
	colission()
	# Controlamos la gravedad
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	
	move_and_slide()
