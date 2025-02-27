extends Area2D

@export var velocidade: float = 100.0  # Velocidade de movimento
@export var distancia: float = 300.0   # Distância que ele vai patrulhar

var direcao: int = 1  # 1 = Direita | -1 = Esquerda
var distancia_percorrida: float = 0.0

func _ready() -> void:
	$AnimatedSprite2D.play("andando")  # Começa a animação andando

func _process(delta: float) -> void:
	position.x += direcao * velocidade * delta
	distancia_percorrida += velocidade * delta

	# Inverte a direção quando atingir a distância máxima
	if distancia_percorrida >= distancia:
		direcao *= -1
		distancia_percorrida = -1.0
		$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h  # Espelha a animação

func _on_body_entered(body: Node2D) -> void:
	$AnimatedSprite2D.play("explodiu")  # Toca a animação de explosão
	velocidade = 0.0
	# Espera o tempo da animação + delay
	await get_tree().create_timer(1.0).timeout
	$AnimatedSprite2D.stop()  # Para a animação para garantir que não fique tocando em loop
	queue_free()  # Apaga o objeto
