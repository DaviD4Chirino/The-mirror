extends Node3D

var interactive: bool = true

func interact():
	if not interactive: return
	# Display message
	DialogManager.send_message(
			self,
			"to play",
			"ACTION_INTERACT",
			0.01,
			false
		)
	if Input.is_action_just_released("ACTION_INTERACT"):
		interactive = false
		Utility.pause_game()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		Utility.create_consent_screen("You will spend the rest of the days like this, are you sure?").declined.connect(
			func():
				Utility.resume_game()
				Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
				await get_tree().create_timer(0.5).timeout
				interactive=true
		)
		pass
