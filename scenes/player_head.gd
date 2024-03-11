extends Node3D
@export var player: Player
@export var mouse_sensitivity: float = 0.002
## How much is the player allowed to look up and down
@export var max_view: float = 90
@export var camera: Camera3D
# @export var weapon_camera: Camera3D

# func _process(_delta):
# 	weapon_camera.global_transform = camera.global_transform

func _input(event):
	if not Player.can_move:
		return
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		player.rotate_y( - event.relative.x * mouse_sensitivity)
		rotate_x( - event.relative.y * mouse_sensitivity)
		rotation.x = clampf(
			rotation.x,
			- deg_to_rad(max_view),
			deg_to_rad(max_view)
		)
	