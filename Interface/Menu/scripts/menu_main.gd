extends CanvasLayer

@onready var Audio_Start = $Control/Audio_start
@onready var Audio_Base = $Control/Audio_Base
@onready var Settings_Menu = $Menu_settings
@onready var TransitionScreen := $"Transition Screen"
@onready var MapSelectScreen := $Control/Map_Selector


func _on_btn_start_pressed():
	Audio_Base.play()
	MapSelectScreen.visible = true

func _on_btn_settings_pressed():
	Audio_Base.play()
	if Settings_Menu.visible == true:
		Settings_Menu.visible = false
	else:
		Settings_Menu.visible = true


func _on_test_map_pressed():
	Audio_Start.play()
	TransitionScreen.Fade_Transition(0.5, "res://Maps/map_player_testing.tscn")
	pass # Replace with function body.
func _on_zone_1_blocky_pressed():
	Audio_Start.play()
	TransitionScreen.Fade_Transition(0.5, "res://Maps/Zone1_blocky.tscn")
	pass # Replace with function body.
