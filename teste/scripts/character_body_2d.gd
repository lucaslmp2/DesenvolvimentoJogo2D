extends CharacterBody2D

const SPEED = 80.0
const MOVE_DISTANCE = 150.0  # Distância máxima para o movimento

var direction = 1  # Direção inicial (1 para direita, -1 para esquerda)
var start_position: Vector2  # Posição inicial
@onready var sprite: AnimatedSprite2D  # Agora, sprite é do tipo AnimatedSprite2D

func _ready() -> void:
	start_position = position

	# Acessando o AnimatedSprite2D diretamente
	if has_node("Sprite2D"):
		sprite = get_node("Sprite2D")
	else:
		print("Erro: Sprite2D não encontrado!")  # Mensagem de erro se o Sprite2D não existir

func _physics_process(_delta: float) -> void:
	velocity.x = SPEED * direction
	
	# Verificar se o tanque atingiu o limite de movimentação
	if abs(position.x - start_position.x) >= MOVE_DISTANCE:
		# Inverter a direção
		direction *= -1

		# Garantir que o flip_h seja invertido apenas uma vez
		if sprite and sprite.flip_h == (direction == 1):
			sprite.flip_h = !sprite.flip_h  # Inverter a imagem do tanque

		# Atualizar a posição inicial para o novo limite
		start_position.x = position.x

	move_and_slide()


func _on_sprite_2d_animation_finished(anim_name: StringName) -> void:
	if anim_name == "destruido":
		queue_free()
