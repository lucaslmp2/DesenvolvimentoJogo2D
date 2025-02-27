extends Sprite2D

@export var animacao: AnimatedSprite2D  # Arrasta o AnimatedSprite2D para essa variável no editor

func _ready() -> void:
	if animacao:
		animacao.play("andando")  # Começa a animação andando assim que o jogo inicia

func explodir():
	animacao.play("explodindo")  # Altera para a animação de explosão
	await animacao.animation_finished  # Espera a animação terminar
	get_parent().queue_free()  # Remove o tanque da cena
