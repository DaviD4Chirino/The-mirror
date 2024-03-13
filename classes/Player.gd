extends CharacterBody3D
class_name Player
# we can check if theres an item in hand by checking

@export_category("Nodes")
@export var hand: Marker3D
@export var eyes: RayCast3D
@export var head: Node3D
@export var feet: Node3D

@export_group("Inner nodes")
@export var anim: AnimationPlayer
static var item: Item
@export_group("sounds")
@export var footsteps: CustomAudioStreamPlayer

static var can_move: bool = true

func _ready() -> void:
	g.player = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event) -> void:
	# if event.is_action_released("DEBUG_CLEAR"):
	# 	clear_pickups()
	if event.is_action_released("ACTION_ATTACK"):
		if item and item.name == "maze":
			anim.play("attack")

func _physics_process(_delta):
	handle_pickup()

## THis method is to be called by the animation player mid animation
func check_for_destructible():
	if !eyes.is_colliding(): return

	var destructible: Object = eyes.get_collider()
	# print(destructible.owner)

	if destructible.owner.has_method("destroy"):
		destructible.owner.destroy()

## if the player is seeing an item, it returns the item or null
func handle_pickup() -> void:
	if !eyes:
		push_error("no raycast selected")
		return

	var collider: Node = eyes.get_collider()

	if collider:
		if collider.owner.has_method("interact"):
			collider.owner.interact()
		else:
			print("no method interact in : ", collider)

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

func play_footstep():
	if not footsteps:
		printerr("NO FOOTSTEPS SOUND ")
		return

	footsteps.play()