extends Node3D
class_name NPC

@export var dialog_tree: DialogTreeData

static var interactive: bool = true

func _ready():
	SignalBus.dialog_finished.connect(_on_dialog_finished)

## This will be fired each physics frame
func interact():
	if not interactive: return
	# Display message
	DialogManager.send_message(
			self,
			"to interact",
			"ACTION_INTERACT",
			0.01,
			false
		)

	if Input.is_action_just_released("ACTION_INTERACT"):
		DialogManager.initialize_dialog(dialog_tree, self)
		interactive = false

func _on_dialog_finished():
	await get_tree().create_timer(.3).timeout
	interactive = true