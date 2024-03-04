extends Area3D
@export var properties: Dictionary:
	get:
		return properties # TODOConverter40 Non existent get function
	set(new_properties):
		if (properties != new_properties):
			properties = new_properties
			update_properties()

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
		
		if item_name:
			if Player.item and Player.item.name == item_name:
				emit_signal("trigger")
				if consume_item:
					g.player.clear_pickups()
		else:
			emit_signal("trigger")

		if "message" in properties:
			DialogManager.send_message({
				message=properties.message,
				duration=2.0,
				unique=true,
				action_name=&"ACTION_INTERACT"
			}, self)
