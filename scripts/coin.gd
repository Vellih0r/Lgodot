extends Node2D

@onready var sprite := $AnimatedSprite2D

func _ready():
	sprite.play("idle")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.add_coin()
		queue_free()
