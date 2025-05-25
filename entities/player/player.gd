extends RigidBody2D

var player_sprite_paths: Array[String] = [
	"res://resources/bird_1.png",
	"res://resources/bird_2.png"
]
var player_sprites: Array[Texture2D] = []

@export var flap_strength: int = 100

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



func get_input() -> bool:
	return Input.is_action_just_pressed("flap")

## Returns upward velocity
func flap() -> Vector2:
	return Vector2.UP * flap_strength
