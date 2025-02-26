extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var is_jumping := false
@onready var animacao := $Animação as AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
	elif is_on_floor():
		is_jumping = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animacao.scale.x = direction
		if !is_jumping:
			animacao.play("correndo")
	elif is_jumping:
		animacao.play("pulando")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animacao.play("parado")

	move_and_slide()
