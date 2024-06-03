extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var points = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Sprite de nuestro personaje
@onready var movementSprite = $MovementSprite
# Arma arrrojadiza de nuestro personaje
@export var arma_arroj:PackedScene

func _input(event): # Estaria bien que tuviera una municion vista en HUD
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

func respawn_player():
	if Global.hp == 0:
		$MovementSprite.play("muerte")
		
				
func movimiento():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and Global.hp > 0:
		velocity.y = JUMP_VELOCITY
		
	var direction = Input.get_axis("ui_left", "ui_right")
	if Global.hp > 0:
		if direction:
			if direction < 0: movementSprite.flip_h = true
			else: movementSprite.flip_h = false
			velocity.x = direction * SPEED
			movementSprite.play("caminar")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			movementSprite.play("parado")
		
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Basic movement of player   
	movimiento()
	# Respawn de nuestro personaje cuando su vida llegue a 0
	respawn_player()
		
	move_and_slide()

func _on_movement_sprite_animation_finished():
	Global.respawn()


func _on_area_2d_area_entered(area):
# Ataque que realiza el enemigo al contacto con el player
	Global.reducir_vida(20)
