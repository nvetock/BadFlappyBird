extends Node


@export var pipe_amount: int = 8
var pipe_pool: Array[Node2D] = []
var pipe_y_spawn_variance: float = 50.0

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
		deactivate_pipe(pipe)

		add_child(pipe)
		pipe.add_to_group("pipes")
		pipe_pool.append(pipe)
	
	spawner()

func spawner() -> void:
	spawn_clock.start()
	while clocktest <= 20:
		await spawn_clock.timeout
		print("Clock loop" + str(clocktest + 1))
		
		activate_pipe()
		
		clocktest += 1

func deactivate_pipe(p: Node2D) -> void:
	p.global_position = Vector2(spawn_point.x + 32, spawn_point.y + randf_range(-pipe_y_spawn_variance, pipe_y_spawn_variance))
	p.visible = false

func activate_pipe() -> void:
	for pipe in pipe_pool:
		if pipe.visible:
			continue
		pipe.visible = true
		pipe.randomize_pipe_pass_through()
		return

func return_to_pool(pipe: Node2D) -> void:
	deactivate_pipe(pipe)
	print("returned to pool")
