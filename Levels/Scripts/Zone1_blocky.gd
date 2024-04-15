extends Node3D

var paused = false

signal pause
signal unpause


func _ready():
	pass
	
func pause_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	paused = true
	pause.emit()
	get_tree().paused = true #In case you want to pause the game

func unpause_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	paused = false
	unpause.emit()
	get_tree().paused = false

func _process(_delta):
	pass
