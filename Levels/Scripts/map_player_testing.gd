extends Node

var paused = false

signal pause
signal unpause


func _ready():
	$"Transition Screen".Fade_out(0.8)

func pause_game():
	paused = true
	pause.emit()
	get_tree().paused = true #In case you want to pause the game

func unpause_game():
	paused = false
	unpause.emit()
	get_tree().paused = false

func _process(_delta):
	if Input.is_action_just_pressed("Game_Pause") and !paused:
		pause_game()
	elif Input.is_action_just_pressed("Game_Pause") and paused: 
		unpause_game()
		
