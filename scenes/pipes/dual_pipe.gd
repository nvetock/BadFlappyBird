extends Node2D


@export var pipe_speed: float = 80.0

var top_pipe_min_y: float = -100.0
var top_pipe_max_y: float = -130.0

var bot_pipe_min_y: float = 100.0
var bot_pipe_max_y: float = 130.0

signal pipe_cleared


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PassThrough.body_entered.connect(_on_pass_through)
	$Pipe_Top.position.y = randf_range(top_pipe_min_y, top_pipe_max_y)
	$Pipe_Bot.position.y = randf_range(bot_pipe_min_y, bot_pipe_max_y)

func _process(delta: float) -> void:
	position += Vector2.LEFT * pipe_speed * delta

func _on_pass_through(body: Node2D) -> void:
	pipe_cleared.emit()
