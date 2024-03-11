extends Node3D
class_name NPC
## When interacted with, it will speak this
@export var dialog_tree: DialogTreeData
## After being interacted with, it will speak this
@export var idle_dialog: DialogTreeData

var times_interacted: int = 0

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
		DialogManager.initialize_dialog(
			dialog_tree
			if (
				times_interacted <= 0 and idle_dialog
			) else idle_dialog,
			self
			)
		times_interacted += 1
		interactive = false

func _on_dialog_finished():
	# To prevent the whole click to exit then enter dialog loop
	await get_tree().create_timer(.3).timeout
	interactive = true