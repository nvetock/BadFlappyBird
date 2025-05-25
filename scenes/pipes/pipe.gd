extends Node2D

signal pipe_hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.body_entered.connect(_on_pipe_hit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pipe_hit(body: Node2D) -> void:
	pipe_hit.emit()
