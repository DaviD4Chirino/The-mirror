extends NPC
@export var room_door: Node

@export var destruction_sound: AudioStream

func destroy():
	AudioManager.play_sound(destruction_sound)
	$destructable.destroy()
	# I manipulate the door directly cus lazy
	if room_door:
		room_door.use()
	
	SignalBus.mirror_destroyed.emit(
		get_tree()
		.get_nodes_in_group("mirror")
		.size() - 1
		)
