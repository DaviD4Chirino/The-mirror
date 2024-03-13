extends Level

@export var exit_door: CharacterBody3D
@export var music: AudioStream

var first_mirror_destroyed: bool = true

func ready():
	if AudioManager.current_music:
		AudioManager.current_music.stop()
	SignalBus.mirror_destroyed.connect(_on_mirror_destroyed)

func _on_mirror_destroyed(count: int):
	if first_mirror_destroyed:
		AudioManager.play_music(music)
		first_mirror_destroyed = false
		
	if count <= 0:
		g.player.clear_pickups()
		exit_door.use()

func _on_credits_trigger_body_entered(body: Node3D):
	if not body is Player: return
	SceneManager.change_scene(Scenes.levels.final)
