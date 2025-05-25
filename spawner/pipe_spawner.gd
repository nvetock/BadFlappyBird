extends Node


var pipe_pool: Array[Node2D] = []
@export var pipe_amount: int = 8


var clocktest := 0

@onready var pipe_object := preload("res://scenes/pipes/DualPipe.tscn")
@onready var scene_size: Vector2 = get_viewport().size
@onready var spawn_point: Vector2 = Vector2(scene_size.x, scene_size.y / 2)

@onready var spawn_clock = $SpawnClock


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_point = Vector2(scene_size.x, scene_size.y / 2)
	
	for i in range(pipe_amount):
		var pipe = pipe_object.instantiate()
		assert(pipe != null)
		
		pipe_pool.append(pipe)
	
	spawner()

func spawner() -> void:
	spawn_clock.start()
	while clocktest <= 4:
		await spawn_clock.timeout
		print("Clock loop" + str(clocktest + 1))
		
		var p = pipe_pool.pop_front()
		p.global_position = spawn_point
		add_child(p)
		
		clocktest += 1
