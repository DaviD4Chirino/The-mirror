extends Node3D
@export var dialog_tree: DialogTreeData

## This will be fired each physics frame
func interact():
	# Display message
	DialogManager.send_message(
			self,
			"to interact",
			"ACTION_INTERACT",
			0.01,
			false
		)

	pass