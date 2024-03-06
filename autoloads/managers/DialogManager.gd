extends CanvasLayer

@export var message_label: Label
@export var input_icon: InputIconTextureRect
@export var dialog_popup: Control

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
var dialog_messengers: Array[Node] = []
signal message_displayed
signal message_finished

func _ready():
	message_finished.connect(_clear_messages)
			  
func _physics_process(delta):
	if not displaying_message:
		return

	current_duration -= delta

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
		if _was_a_messenger(node):
			return
		messengers.append(node)
	input_icon.action_name = action_name
	
	current_message = message
	current_duration = duration

	message_label.text = current_message
	displaying_message = true

func initialize_dialog(tree: DialogTreeData, node: Node, unique=false):
	if unique:
		if node in dialog_messengers:
			return
		dialog_messengers.append(node)

	dialog_popup.dialog_tree = null
	dialog_popup.dialog_tree = tree
	Player.can_move = false
	dialog_popup.show_dialog()

	await dialog_popup.dialog_finished
	Player.can_move = true

func _clear_messages():
	message_label.text = ""
	input_icon.action_name = ""

func _was_a_messenger(node_to_compare: Node) -> bool:
	for node in messengers:
		if node == node_to_compare:
			return true
	return false