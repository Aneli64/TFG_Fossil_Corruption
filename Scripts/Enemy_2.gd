extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -400.0
var enemy_hp_2 = 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var movementSprite = $MovementSprite

func respawn_enemy():
	if enemy_hp_2 == 0:
		$MovementSprite.play("muerte")

func _ready():
	# Iniciamos el sprite de estado estatico una vez inicie el juego
	movementSprite.play("caminar")
	# Movimiento por defecto
	velocity.x = SPEED
	
func orientation():
	if velocity.x >= 0:
		$MovementSprite.flip_h = false
	else:
		$MovementSprite.flip_h = true
func colission():
	if not $FloorRay.is_colliding() || $CollisionShape2D/ColissionRay.is_colliding():
		velocity.x *=  -1
		$FloorRay.position.x  *= -1
		$CollisionShape2D/ColissionRay.target_position.x *= -1
		
	
func _physics_process(delta):
	if enemy_hp_2 > 0:
		orientation()
		# Comprobamos colisiones de izquierda y derecha (y no permitimos que caiga )
		colission()
		# Controlamos la gravedad
		if not is_on_floor():
			velocity.y += gravity * delta
		move_and_slide()

func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		# Ataque que realiza el enemigo al contacto con el player
		Global.reducir_vida(20)
		Global.enemy_hit = true
	if area.is_in_group("ArmaArroj"):
		$MovementSprite.play("golpe")
		enemy_hp_2 -= 20
	# Si pierde todos sus hp, desaparece de la escena
	if (enemy_hp_2 <= 0):
		$Enemy_HUD_2/ProgressBar.visible = false
		$MovementSprite.play("muerte")
		

# Mientras que la animación finalizada sea la de muerte, este hara despawn
func _on_movement_sprite_animation_finished():
	if movementSprite.animation == "muerte":
		self.queue_free()
	else: 
		movementSprite.play("caminar")
