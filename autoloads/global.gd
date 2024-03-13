extends Node
##Autoload global script, access it as g

var playground: Node3D
var player: Player = null: set = set_player
var player_transform: Transform3D

signal player_changed

func _ready():
	process_mode = PROCESS_MODE_ALWAYS

func teleport_scene(scene: Resource):
	var _player = player.global_transform
	var _player_head = player.head.global_transform
	## TO the player
	get_tree().call_deferred("change_scene_to_packed", scene)

	await player_changed
	var new_translate = player.global_position

	player.global_transform = _player
	player.head.global_transform = _player_head

	player.global_position = new_translate
	player.rotate_y(90)

func set_player(new_player: Player):
	player = new_player
	if player:
		player_changed.emit()
