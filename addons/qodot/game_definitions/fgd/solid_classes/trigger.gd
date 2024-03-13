extends Area3D
var door_locked: AudioStream = preload ("res://assets/audio/sfx/321087__benjaminnelan__door-locked.wav")
# Forgive me Qodot team for what i have done
@export var properties: Dictionary:
	get:
		return properties # TODOConverter40 Non existent get function
	set(new_properties):
		if (properties != new_properties):
			properties = new_properties
			update_properties()

##To check if this has already been triggered and how many times
var triggered: int = 0
var already_open: bool = false
var item_name: String = ""
var consume_item: bool = false

signal trigger()

func _ready():
	connect("body_entered", handle_body_entered)

func update_properties():
	if "item_name" in properties:
		item_name = properties["item_name"]
	if "consume_item" in properties:
		consume_item = true

func handle_body_entered(body: Node):
	if body is Player:
		triggered += 1
		
		if item_name:
			if Player.item and Player.item.name == item_name:
				emit_signal("trigger")
				if consume_item:
					g.player.clear_pickups()
				already_open = true
			else:
				if not already_open:
					DialogManager.send_message(
						self,
						str("you need a [%s]" % [item_name]),
						"",
						1.5,
						false
					)
					AudioManager.play_sound(door_locked)
		else:
			emit_signal("trigger")

		if "message" in properties:
			DialogManager.send_message(
				self,
				properties.message,
				"",
				1.5,
				true
			)
