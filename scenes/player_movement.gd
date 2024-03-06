extends Node3D

@export var player: Player

@export_category("Configuration")
@export var speed: float = 5
@export var acceleration: float = 15
var target_velocity: Vector3 = Vector3.ZERO
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	player.velocity.y += - gravity * delta
	if not player.can_move:
		player.velocity = Vector3.ZERO
		return
	movement(delta)
	
func movement(delta: float):
	var input_dir: Vector2 = Input.get_vector("MOVE_LEFT", "MOVE_RIGHT", "MOVE_FORWARD", "MOVE_BACKWARD")
	var movement_dir: Vector3 = player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)

	target_velocity.x = (movement_dir.x * speed)
	target_velocity.z = (movement_dir.z * speed)

	player.velocity.x = lerpf(player.velocity.x, target_velocity.x, acceleration * delta)
	player.velocity.z = lerpf(player.velocity.z, target_velocity.z, acceleration * delta)

	player.move_and_slide()