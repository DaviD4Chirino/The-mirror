extends Node
##Put all your signals here

func _ready():
	process_mode = PROCESS_MODE_ALWAYS

## Engine State Signals
signal game_paused
signal game_resumed
signal game_restarted
signal level_paused
signal level_resumed
signal level_restarted
##
signal dialog_finished
signal dialog_started
##

signal settings_changed

##use this to check if the signal was emitted
func test_signal():
	print("test signal")
