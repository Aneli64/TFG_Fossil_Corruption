extends CharacterBody2D

var SPEED = 200.0
const JUMP_VELOCITY = -400.0
var points = 0
var contSaltos = 0
var maxSaltos = 1
var died = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Sprite de nuestro personaje
@onready var movementSprite = $MovementSprite
# Arma arrrojadiza de nuestro personaje
@export var arma_arroj:PackedScene
# Colision lateral de nuestro personaje
var ray_cast_dimension = 14.6

func _ready():
	$LateralCollision.target_position.x = ray_cast_dimension
	movementSprite.play("spawn")

func _input(event):
	if Global.weapon_ammun > 0:
		if event.is_action_pressed("pico_arma"):
			# Reducimos municion del arma
			Global.weapon_ammun -= 1
			var newArmaArroj = arma_arroj.instantiate()
			newArmaArroj.position = self.position
			newArmaArroj.isFlip = movementSprite.flip_h
			# Definimos orientacion del lanzamiento del arma arrojadiza
			if newArmaArroj.isFlip:
				newArmaArroj.velocity.x *= -1
			# Añadimos objeto a al escena
			add_sibling(newArmaArroj)
				
func movimiento():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and Global.hp > 0:
		velocity.y = JUMP_VELOCITY
		contSaltos += 1
	elif Input.is_action_just_pressed("ui_accept") and not is_on_floor() and contSaltos < maxSaltos:
		velocity.y = JUMP_VELOCITY
		contSaltos += 1
	
	if is_on_floor():
		contSaltos = 0  # Reseteo de saltos permitidos
		
	var direction = Input.get_axis("ui_left", "ui_right")
	if Global.hp > 0:
		if direction: # Invertimos personaje y colisión lateral
			if direction < 0 :
				movementSprite.flip_h = true
				$LateralCollision.target_position.x = -ray_cast_dimension
			else:
				movementSprite.flip_h = false
				$LateralCollision.target_position.x = ray_cast_dimension
			velocity.x = direction * SPEED
		else: # Definimos el suelo normal y resbaladizo determinado por nuestro RayCast
			if $DownCollision.get_collider():
				if $DownCollision.get_collider().is_in_group("resbaladizo"):
					velocity.x = move_toward(velocity.x, 0, 1)
				elif $DownCollision.get_collider().is_in_group("lentitud"):
					SPEED = 100
				else: 		
					velocity.x = move_toward(velocity.x, 0, SPEED)
					
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Basic movement of player   
	movimiento()
	
	move_and_slide()
	# Animaciones de nuestro player 
	choose_animation()

func choose_animation():
	if Global.hp > 0:
		if velocity.x == 0 and is_on_floor():
			movementSprite.play("parado")
		elif (velocity.x > 0 or velocity.x < 0) and is_on_floor():
			movementSprite.play("caminar")
		elif velocity.y < 0:
			movementSprite.play("saltar")
		else:
			movementSprite.stop()
		
	else:
		movementSprite.play("muerte")
		died = true
		
func _on_movement_sprite_animation_finished():
	if died == true:
		Global.respawn()
		

