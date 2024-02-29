extends Control

@onready var PlaySound := $Play_Button
@onready var TransitionScreen := $"Transition Screen"

const Map_test = preload("res://Maps/map_player_testing.tscn")

func _on_start_button_pressed():
	TransitionScreen.Fade_in(0.5)
	PlaySound.play()
	#get_tree().change_scene_to_file("res://Maps/map_player_testing.tscn")



func _on_transition_screen_transition():
	get_tree().change_scene_to_file("res://Maps/map_player_testing.tscn")
