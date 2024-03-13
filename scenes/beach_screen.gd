extends Node3D
@export var scroll_speed: float = 2
@export_group("sounds")
@export var music: AudioStream
@export var ambient: AudioStream
@export_category("nodes")
@export var credits: Node3D

@onready var text: MeshInstance3D = credits.get_node("Text")
@onready var credits_size: Vector3 = text.get_aabb().size
var changing_scene: bool = false
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	AudioManager.play_sound(
		ambient, 0, 0, 0, 2,
		AudioManager.Buses.SFX)
	AudioManager.play_music(music, 2, 0, 3, 5)

func _physics_process(delta):
	text.position.z -= delta * scroll_speed

func _input(event):
	if event.is_action_released("ACTION_PAUSE"):
		Utility.quit_game()