@tool
extends RigidBody3D
class_name Pickup
## A pickup contains a 3D Model for the item it represents. The player handles the rest
@export var holder: Node3D
## For the player to lerp the model to its hand
var model: Node = null: get = get_model

@export var item: Item = null:
	set(new_item):
		item = new_item
		if not holder:
			return

		clear_models()
		if item and item.model:
			holder.add_child(item.model.instantiate())

func display_pickup_message():
	DialogManager.send_message(
			self,
			"to pick up",
			"ACTION_INTERACT",
			0.05,
			false
		)

func _ready():
	if not holder:
		return

	clear_models()
	if item and item.model:
		holder.add_child(item.model.instantiate())

func clear_models():
	for child in holder.get_children():
		child.queue_free()

func get_model():
	if not holder:
		return null
	return model.get_children()[0]
