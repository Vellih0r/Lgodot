extends Node2D
@onready var player := $player
@onready var score_label := $score

func _on_small_spike_hit(body) -> void:
	body.die()
	if body == player:
		update_score(0)

func _on_player_score_update(coins) -> void:
	update_score(coins)

func update_score(value):
	score_label.text = str("Score: ", value)
	
	


func _on_kill_zone_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
