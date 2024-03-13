extends HBoxContainer
@export var slider: HSlider
@export var value_label: Label

func _ready():
	slider.value = SaveSystem.get_var(SavePaths.mouse_sensitivity, 0.002)

func _on_custom_h_slider_value_changed(value: float):
	value_label.text = str(value * 1000)
	save_settings(value)
	pass # Replace with function body.

func save_settings(value: float):
	SaveSystem.set_var(SavePaths.mouse_sensitivity, value)
	SaveSystem.save()
	SignalBus.settings_changed.emit()

func _restore_config():
	SaveSystem.set_var(SavePaths.mouse_sensitivity, 0.002)
	SaveSystem.save()
	SignalBus.settings_changed.emit()
	pass