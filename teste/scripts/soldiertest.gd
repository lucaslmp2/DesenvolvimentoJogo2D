extends CharacterBody2D

const SPEED_RUN = 200.0  # Velocidade ao correr
const SPEED_WALK = 100.0  # Velocidade ao andar
const JUMP_VELOCITY = -400.0

var gravity = 0.0
@onready var animacao := $AnimatedSprite2D as AnimatedSprite2D

func _ready():
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# Aplicando gravidade
	if not is_on_floor():
		velocity.y += gravity * delta

	# Controle do pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Definição da velocidade
	var direction := Input.get_axis("ui_left", "ui_right")
	var is_walking = Input.is_key_pressed(KEY_CTRL)  # Verifica se a tecla Ctrl está pressionada
	var speed = SPEED_WALK if is_walking else SPEED_RUN

	if direction != 0:
		velocity.x = direction * speed
		animacao.flip_h = direction < 0

		# Alternar entre "andando" e "correndo"
		if not is_on_floor():
			animacao.play("pulando")
		elif is_walking:
			animacao.play("andando")
		else:
			animacao.play("correndo")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED_RUN)
		animacao.play("parado")

	move_and_slide()
