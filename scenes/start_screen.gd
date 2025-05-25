extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Start_Button.pressed.connect(_on_start_game)
	
	$LongestTime_Text.text = GameManager.int_to_time(GameManager.get_longest_time())
	$Highscore_Text.text = str(GameManager.get_high_score())


func _on_start_game() -> void:
	SceneManager.goto_scene("res://scenes/main/main.tscn")
	GameManager.start_game()
