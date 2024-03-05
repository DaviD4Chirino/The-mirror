extends CanvasLayer

@export var message_label: Label
@export var input_icon: InputIconTextureRect

var displaying_message: bool = false
var current_message: String
var current_duration: float = 0.0

var send_message_properties = {
	message = "",
	duration = 3.0,
	unique = true,
	action_name = &""
}

## A list of all the nodes that called 
var messengers: Array[Node] = []

signal message_displayed
signal message_finished
func _ready():
	message_finished.connect(_clear_messages)
			  
func _physics_process(delta):
	if not displaying_message:
		return

	current_duration -= delta
	print_debug("left ", current_duration)

	if current_duration <= 0:
		displaying_message = false
		message_finished.emit()

func send_message(
	## You MUST call yourself if you have unique in the properties
	node: Node=self,
	## See send_message_properties for params
	message="",
	action_name=&"",
	duration=3.0,
	unique=true,
	) -> void:
	if unique:
		if was_a_messenger(node):
			return
		messengers.append(node)
	input_icon.action_name = action_name
	
	current_message = message
	current_duration = duration

	message_label.text = current_message
	displaying_message = true

func _clear_messages():
	message_label.text = ""
	input_icon.action_name = ""

func was_a_messenger(node_to_compare: Node) -> bool:
	for node in messengers:
		if node == node_to_compare:
			return true
	return false