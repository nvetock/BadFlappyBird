extends Node2D

func _ready() -> void:
	$Area2D.body_entered.connect(_on_pipe_hit)


## This function can be called to double check that the collision signals were setup correctly.
## If not, then they will be connected.
func setup_signal_connection() -> void:
	if not $Area2D.is_connected("body_entered", _on_pipe_hit):
		$Area2D.body_entered.connect(_on_pipe_hit)


func _on_pipe_hit(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.game_over()
