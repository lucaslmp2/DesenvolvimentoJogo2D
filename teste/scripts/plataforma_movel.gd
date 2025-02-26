extends Node2D
const WAIT_DURATION := 1.0
@onready var plataforma_movel := $plataforma as AnimatableBody2D
@export var movie_speed := 3.0
@export var distance := 192
@export var movie_horizontal := true

var follow := Vector2.ZERO
var plataform_centre := 16
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_plataform()
	pass # Replace with function body.
func move_plataform():
	var move_direction = Vector2.RIGHT * distance if movie_horizontal else Vector2.UP * distance
	var duration = move_direction.length() / float(movie_speed * plataform_centre)
	
	var plataform_tween = create_tween().set_loops()
	plataform_tween.tween_property(self, "follow", move_direction, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).set_delay(WAIT_DURATION)
	plataform_tween.tween_property(self, "follow", Vector2.ZERO, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).set_delay(duration + WAIT_DURATION * 1.5)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	plataforma_movel.position = plataforma_movel.position.lerp(follow, 0.5)
