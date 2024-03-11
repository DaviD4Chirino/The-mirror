extends OmniLight3D

var _enable_shadows: bool = false: get = get_shadows_state

func _init():
	SignalBus.settings_changed.connect(_on_settings_changed)

func _ready():
	shadow_enabled = _enable_shadows

func _on_settings_changed():
	shadow_enabled = _enable_shadows
	pass

func get_shadows_state():
	return SaveSystem.get_var(SavePaths.enable_shadows, false)