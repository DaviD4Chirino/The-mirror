extends Level
const pickup_empty: String = "res://scenes/pickup_empty.tscn"
@export var key_spawns_holder: Node3D

func ready():
	SignalBus.dialog_finished.connect(_on_dialog_finished)

func _on_dialog_finished():
	var key: Pickup = create_key()
	var rand_position: Marker3D = key_spawns_holder.get_children().pick_random()

	add_child(key)
	key.global_transform = rand_position.global_transform

func create_key() -> Pickup:
	var new_pickup = load(pickup_empty).instantiate()
	new_pickup.item = load("res://resources/items/key.tres")
	return new_pickup

func clear_keys():
	for child in get_children():
		if child is Pickup and child.item.name == "key":
			child.queue_free()
			