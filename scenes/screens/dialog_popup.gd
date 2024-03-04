extends Control

@export var dialog_tree: DialogTreeData
@export_category("Nodes")
@export var character_label: Label
@export var dialog_label: Label
@export var input_icon_rect: InputIconTextureRect
@export var continue_timer: Timer

@export var anim: AnimationPlayer

var current_character: String
var current_dialog_index: int = -1

signal dialog_finished

func _ready():
	self.hide()
	input_icon_rect.hide()
	await show_dialog()

func _input(event):
	if event.is_action_released("ACTION_INTERACT") and not anim.is_playing():
		update_text()

func show_dialog():
	self.show()
	input_icon_rect.hide()
	update_text()
	anim.play("show_dialog")
	await anim.animation_finished
	continue_timer.start()

func hide_dialog():
	await hide_continue_button()
	anim.play_backwards("show_dialog")
	await anim.animation_finished

	self.hide()

func show_continue_button():
	input_icon_rect.show()
	anim.play("show_continue")

func hide_continue_button():
	anim.play_backwards("show_continue")
	
	input_icon_rect.hide()

func update_text():
	current_dialog_index += 1
	if current_dialog_index >= dialog_tree.tree.size():
		finish_dialog()
		return

	if input_icon_rect.modulate.a >= 0.8:
		hide_continue_button()
	continue_timer.start()

	var current_dialog: DialogData = dialog_tree.tree[current_dialog_index]

	if current_dialog.character:
		current_character = current_dialog.character

	character_label.text = current_character

	dialog_label.text = current_dialog.dialog

	pass

func finish_dialog():
	dialog_finished.emit()
	await hide_dialog()

func _on_continue_timer_timeout():
	show_continue_button()
