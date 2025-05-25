extends Node

var current_scene = null

func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(-1)

func goto_scene(path: String) -> void:
	_deferred_goto_scene.call_deferred(path)

func _deferred_goto_scene(path: String):
	# remove the current scene safely
	current_scene.free()
	
	# Load the new scene
	var new_scene = ResourceLoader.load(path)
	
	# Instantiate the newly loaded scene and add to currently active scene
	current_scene = new_scene.instantiate()
	
	get_tree().root.add_child(current_scene)
	
	# Make compatible with SceneTree.change_scene_to_file() API
	get_tree().current_scene = current_scene
