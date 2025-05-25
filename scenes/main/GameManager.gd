extends Node

var pipe_pool: Array[PackedScene] = []


@onready var pipe_object := preload("res://scenes/pipes/DualPipe.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
