extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var boolRayCastLeft = false
var boolRayCastRight = false
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

func _physics_process(delta):
	
	if raycast_left.is_colliding():
		boolRayCastLeft = true
		boolRayCastRight = false
		
	if raycast_right.is_colliding():
		boolRayCastRight = true
		boolRayCastLeft = false
		
	# Movimiento
	velocity.x = -SPEED
	
	# Gravedad
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if boolRayCastLeft:
		#movementSprite.flip_h = true
		velocity.x = SPEED
	
	if boolRayCastRight:
		velocity.x = -SPEED
		
	
	move_and_slide()
