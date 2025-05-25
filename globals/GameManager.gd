extends Node

var _score: int = 0
var _game_time: int = 0
var _game_is_active = true
var _game_is_paused = false

var _high_score: int = 0
var _longest_game_time: int = 0

@onready var hud: CanvasLayer = null

signal game_is_over


func _ready() -> void:
	SaveManager.load_data()



# ----------------- GETTERS ----------------- #

func get_score() -> int:
	return _score

func get_game_time() -> int:
	return _game_time

func get_high_score() -> int:
	return _high_score

func get_longest_time() -> int:
	return _longest_game_time


# ----------------- SETTERS ----------------- #

func set_score(score: int) -> void:
	_score = score

func set_game_time(game_time: int) -> void:
	_game_time = game_time

func set_hud(h: CanvasLayer) -> void:
	hud = h

func set_highscore(highscore: int) -> void:
	_high_score = highscore

func set_longest_game_time(game_time: int) -> void:
	_longest_game_time = game_time


# ----------------- LOGIC ----------------- #

func update_score(point: int) -> void:
	_score += point
	hud.update_score_text(get_score())

func start_game_time() -> void:
	while _game_is_active:
		await get_tree().create_timer(1.0).timeout
		
		if not _game_is_active:
			# Check that game hasn't ended since timer stopped
			break
		
		if _game_is_paused:
			# Keep loop alive on pause, but don't continue tracking time
			continue
		
		_game_time += 1
		if is_instance_valid(hud): # prevent calling if node has been freed on game over
			hud.update_game_time_text(int_to_time(_game_time))

func get_is_game_active() -> bool:
	return _game_is_active

func int_to_time(time: int) -> String:
	var seconds: int = time % 60
	var minutes: int = time / 60
	
	return "%01d:%02d" % [minutes, seconds]



# ----------------- GAME STATE LOGIC ----------------- #

func start_game() -> void:
	_game_is_active = true
	start_game_time()

func restart_game() -> void:
	set_score(0)
	set_game_time(0)
	start_game()

func pause_game() -> void:
	_game_is_paused = !_game_is_paused

func game_over() -> void:
	_game_is_active = false
	
	if get_score() > _high_score:
		set_highscore(get_score())
	
	if get_game_time() > _longest_game_time:
		set_longest_game_time(get_game_time())
	
	
	# Save data and activate game over menu
	SaveManager.save_data()
	SceneManager.goto_scene("res://scenes/StartScreen.tscn")

func quit_game() -> void:
	save_game()

func save_game() -> bool:
	return SaveManager.save_data()
