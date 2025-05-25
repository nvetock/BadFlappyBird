extends Node

var score: int = 0
var game_time: int = 0

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_game() -> void:
	pass

func restart_game() -> void:
	score = 0
	game_time = 0

func pause_game() -> void:
	pass

func quit_game() -> void:
	pass

func save_game() -> bool:
	return false
