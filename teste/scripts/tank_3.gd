extends Area2D

@onready var sprite_andando = $Andando
@onready var sprite_explodindo = $Explodindo

func _on_body_entered(body):
	if body.is_in_group("player"):  # Se o objeto que colidiu for o player
		sprite_andando.visible = false  # Esconde o sprite andando
		sprite_explodindo.visible = true  # Ativa o sprite explodindo
		sprite_explodindo.explodir()  # Chama a função explodir
