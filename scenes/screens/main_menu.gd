extends Control

@export var configuration_screen: CanvasLayer
@export var credits: Control
@export var menu_music: AudioStream
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	AudioManager.play_music(menu_music)

func _on_start_button_pressed():
	AudioManager.current_music.stop()
	SceneManager.change_scene(Scenes.levels.one)

func _on_options_button_pressed():
	configuration_screen.show()

func _on_credits_button_pressed():
	credits.show()
	pass # Replace with function body.
	
func _on_credits_close_button_pressed():
	credits.hide()

func _on_exit_button_pressed():
	Utility.quit_game()
