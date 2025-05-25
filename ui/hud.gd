extends CanvasLayer


func _ready() -> void:
	GameManager.set_hud(self)
	update_score_text(0)
	update_game_time_text("0:00")
	GameManager.start_game_time()


func update_score_text(total: int) -> void:
	$Score_Text.text = str(total)

func update_game_time_text(txt: String) -> void:
	$GameTime_Text.text = txt
