extends Area3D

@export var dialog_tree: DialogTreeData

func _on_body_entered(body: Node3D):
	if body is Player:
		DialogManager.initialize_dialog(dialog_tree, self)
