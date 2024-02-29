extends CharacterBody3D
class_name Player
@export_category("Nodes")
@export var head: Node3D

@export_category("")
@export var speed: float = 5
@export var acceleration: float = 15
var target_velocity: Vector3 = Vector3.ZERO
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	g.player = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	velocity.y += - gravity * delta
	movement(delta)

func movement(delta: float):
	var input_dir: Vector2 = Input.get_vector("MOVE_LEFT", "MOVE_RIGHT", "MOVE_FORWARD", "MOVE_BACKWARD")
	var movement_dir: Vector3 = transform.basis * Vector3(input_dir.x, 0, input_dir.y)

	target_velocity.x = (movement_dir.x * speed)
	target_velocity.z = (movement_dir.z * speed)

	velocity.x = lerpf(velocity.x, target_velocity.x, acceleration * delta)
	velocity.z = lerpf(velocity.z, target_velocity.z, acceleration * delta)

	move_and_slide()
