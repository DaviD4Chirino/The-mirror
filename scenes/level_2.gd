extends Level
const pickup_empty: String = "res://scenes/pickup_empty.tscn"

@export var music: AudioStream
@export var key_spawns_holder: Node3D
var already_spawned: bool = false

func ready():
	AudioManager.play_music(music, 0, 0, 0, 3, 2)
	SignalBus.dialog_finished.connect(_on_dialog_finished)

func _on_dialog_finished():
	if already_spawned:
		return
	var key: Pickup = create_key()
	var rand_position: Marker3D = key_spawns_holder.get_children().pick_random()

	add_child(key)
	key.global_transform = rand_position.global_transform
	already_spawned = true
	#Debug
	# for child in key_spawns_holder.get_children():
	# 	var _key: Pickup = create_key()
	# 	add_child(_key)
	# 	_key.global_transform = child.global_transform

func create_key() -> Pickup:
	var new_pickup = load(pickup_empty).instantiate()
	new_pickup.item = load("res://resources/items/key.tres")
	return new_pickup

func clear_keys():
	for child in get_children():
		if child is Pickup and child.item.name == "key":
			child.queue_free()
			