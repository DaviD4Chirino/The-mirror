extends Node3D

@export var mouse_sensitivity: float = 0.002
## How much is the player allowed to look up and down
@export var max_view: float = 90
@export var camera: PhantomCamera3D

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		g.player.rotate_y( - event.relative.x * mouse_sensitivity)
		camera.rotate_x( - event.relative.y * mouse_sensitivity)
		camera.rotation.x = clampf(
			camera.rotation.x,
			- deg_to_rad(max_view),
			deg_to_rad(max_view)
		)
	