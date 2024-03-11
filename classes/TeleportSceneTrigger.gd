extends Area3D
class_name TeleportSceneTrigger
## It thread loads the scene to change, then it changes while also
## teleports the player with position and rotation for a seamless
## map change

@export var change_scene_to: String

func _init():
	body_entered.connect(trigger)

func _ready():
	ResourceLoader.load_threaded_request(change_scene_to)

func trigger(_body: Node3D):
	g.teleport_scene(ResourceLoader.load_threaded_get(change_scene_to))