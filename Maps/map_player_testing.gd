extends Node

var paused = false

signal pause
signal unpause


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func pause_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true #In case you want to pause the game
	paused = true
	pause.emit()

func unpause_game():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	paused = false
	unpause.emit()

func _process(_delta):
	if Input.is_action_just_released("Game_Pause"):
		paused = !paused
		if paused:
			pause_game()
		else:
			unpause_game()
