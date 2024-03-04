extends CharacterBody3D
class_name Player
# we can check if theres an item in hand by checking

@export_category("Nodes")
@export var hand: Marker3D
@export var eyes: RayCast3D

static var item: Item

func _ready() -> void:
	g.player = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event) -> void:
	if event.is_action_released("DEBUG_CLEAR"):
		clear_pickups()

func _physics_process(_delta):
	handle_pickup()

## if the player is seeing an item, it returns the item or null
func handle_pickup() -> void:
	if !eyes:
		push_error("no raycast selected")
		return

	var collider: Node = eyes.get_collider()

	if collider:
		if Input.is_action_just_released("ACTION_INTERACT"):
			var pickup_item = collider.owner.item
			add_pickup_to_hand(pickup_item)
			collider.owner.queue_free()

## It takes care of making sure that the previous grabbed object
## is cleared before adding another
func add_pickup_to_hand(_item: Item):
	clear_pickups()
	item = _item
	hand.add_child(item.model.instantiate())

## Clears the hand
func clear_pickups() -> void:
	if hand.get_child_count() > 0:
		for child in hand.get_children():
			child.queue_free()
		item = null