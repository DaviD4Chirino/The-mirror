extends HBoxContainer
var enable_shadows: bool = false: get = get_shadows_state
@export var check: CheckBox

func _ready():
	check.button_pressed = enable_shadows
	pass

func get_shadows_state():
	return SaveSystem.get_var(SavePaths.enable_shadows, false)

func _on_check_box_toggled(toggled_on: bool):
	SaveSystem.set_var(SavePaths.enable_shadows, toggled_on)
	SignalBus.settings_changed.emit()

func _restore_config():
	SaveSystem.set_var(SavePaths.enable_shadows, true)
	SignalBus.settings_changed.emit()