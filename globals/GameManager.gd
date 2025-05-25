extends Node

var _score: int = 0
var _game_time: int = 0
var _game_is_active = true
var _game_is_paused = false



@onready var hud: CanvasLayer = null

signal game_is_over


func _ready() -> void:
	pass
# ----------------- LOGIC ----------------- #

func get_score() -> int:
	return _score

func update_score(point: int) -> void:
	_score += point
	hud.update_score_text(get_score())

func start_game_time() -> void:
	while _game_is_active:
		await get_tree().create_timer(1.0).timeout
		
		if _game_is_paused:
			# Keep loop alive, but don't continue tracking time
			continue
		
		_game_time += 1
		hud.update_game_time_text(int_to_time(_game_time))
		print("int: " + str(_game_time))
		print(int_to_time(_game_time))

func get_is_game_active() -> bool:
	return _game_is_active

func int_to_time(time: int) -> String:
	var seconds: int = time % 60
	var minutes: int = time / 60
	
	return "%01d:%02d" % [minutes, seconds]

func set_hud(h: CanvasLayer) -> void:
	hud = h

# ----------------- GAME STATE LOGIC ----------------- #

func start_game() -> void:
	_game_is_active = true
	start_game_time()

func restart_game() -> void:
	update_score(0)
	_game_time = 0
	start_game()

func pause_game() -> void:
	_game_is_paused = !_game_is_paused

func game_over() -> void:
	_game_is_active = false
	
	# Activate game over menu
	
	print("Game Over!")
	print("Score: " + str(get_score()) + " | Time: " + str(_game_time))
	game_is_over.emit()

func quit_game() -> void:
	pass

func save_game() -> bool:
	return false
