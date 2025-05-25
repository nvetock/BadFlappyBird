extends Node

var high_score: int = 0
var longest_time: int = 0

const SAVE_PATH := "user://save_data.json"


func save_data() -> bool:
	var save = {
		"high_score": GameManager.get_high_score(),
		"longest_time": GameManager.get_longest_time()
	}
	
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save))
		file.close()
		return true
	
	return false

func load_data() -> bool:
	var success: bool = false
	
	if not FileAccess.file_exists(SAVE_PATH):
		return false
	
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var content := file.get_as_text()
		var result = JSON.parse_string(content)
		if result:
			GameManager.set_highscore(result.get("high_score"))
			GameManager.set_longest_game_time(result.get("longest_time"))
			success = true
		file.close()
	
	return success
