extends CharacterBody2D

const SPEED_RUN = 200.0  # Velocidade ao correr
const SPEED_WALK = 100.0  # Velocidade ao andar
const JUMP_VELOCITY = -400.0

var gravity = 0.0
var colidiu_com_tank = false  # Flag para controlar a colisão

@onready var animacao := $AnimatedSprite2D as AnimatedSprite2D

func _ready():
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# Aplicando gravidade
	if not is_on_floor():
		velocity.y += gravity * delta

	# Se colidiu com o tanque, apenas joga a animação e para o movimento
	if colidiu_com_tank:
		velocity.x = 0
		return  # Sai da função para evitar novas movimentações

	# Pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movimento
	var direction = Input.get_axis("ui_left", "ui_right")
	var is_walking = Input.is_key_pressed(KEY_CTRL)
	var speed = SPEED_WALK if is_walking else SPEED_RUN

	if direction != 0:
		velocity.x = direction * speed
		animacao.flip_h = direction < 0

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

func _on_area_2d_body_entered(body):
	if body.is_in_group("tank"):  # Se o objeto estiver no grupo 'tank'
		colidiu_com_tank = true
		velocity.x = 0  # Para o movimento
		animacao.play("player")  # Animação de vitória
		await get_tree().create_timer(1.0).timeout  # Tempo para a animação rodar
		animacao.play("parado")  # Volta para a animação parada
