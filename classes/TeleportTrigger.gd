extends Area3D
class_name TeleportTrigger
##TODO: You have more important thing to do, do those
@export var properties: Dictionary
## It moves the player to this position, use a [class Marker3D]
@export var teleport_to: Marker3D
## If this is not zero, it moves the player to these global coordinates
@export var teleport_by_coordinates: Vector3 = Vector3.ZERO