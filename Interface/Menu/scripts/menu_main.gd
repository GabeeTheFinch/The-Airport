extends CanvasLayer

@onready var Audio_Start = $Control/Audio_start
@onready var Audio_Base = $Control/Audio_Base
@onready var Settings_Menu = $Menu_settings
@onready var TransitionScreen := $"Transition Screen"

const Map_test = preload("res://Maps/map_player_testing.tscn")

func _on_btn_start_pressed():
	Audio_Start.play()
	TransitionScreen.Fade_in(0.5)



func _on_transition_screen_transition():
	get_tree().change_scene_to_file("res://Maps/map_player_testing.tscn")

func _on_btn_settings_pressed():
	Audio_Base.play()
	if Settings_Menu.visible == true:
		Settings_Menu.visible = false
	else:
		Settings_Menu.visible = true
