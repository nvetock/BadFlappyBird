extends Node2D

func _on_pipe_hit(body: Node2D) -> void:
	GameManager.game_over()
