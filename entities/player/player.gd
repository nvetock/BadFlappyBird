extends RigidBody2D

var player_sprite_paths: Array[String] = [
	"res://resources/bird_1.png",
	"res://resources/bird_2.png"
]
var player_sprites: Array[Texture2D] = []

@export var flap_strength: int = 100

@onready var scene_size: Vector2 = get_viewport().get_visible_rect().size

func _ready() -> void:
	for path in player_sprite_paths:
		var o = load(path) as Texture2D
		player_sprites.append(o)

func _process(delta: float) -> void:
	if get_input():
		$AudioWingFlap.play()
		linear_velocity = flap()
	
	if linear_velocity.y > 0.0:
		$Sprite2D.texture = player_sprites[1]
	else:
		$Sprite2D.texture = player_sprites[0]
	
	check_bounds()



func get_input() -> bool:
	return Input.is_action_just_pressed("flap")

## Returns upward velocity
func flap() -> Vector2:
	return Vector2.UP * flap_strength

func check_bounds() -> void:
	if position.x < 0 or position.x > scene_size.x \
	or position.y < 0 or position.y > scene_size.y:
		GameManager.game_over()
