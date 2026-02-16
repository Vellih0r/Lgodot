extends Area2D

@onready var sprite = $AnimatedSprite2D

func _on_body_entered(body: Node2D) -> void:
	if (body == get_tree().get_first_node_in_group("player")):
		body.player_state = body.states.JUMP_PAD
		print("YES")
	else: 
		body.velocity.y += -800
	sprite.play("push")
