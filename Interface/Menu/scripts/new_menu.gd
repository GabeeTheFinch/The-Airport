extends Control

@onready var MAP_SELECTOR := $MarginContainer/Menus/MAP_SELECTOR
@onready var SETTINGS := $MarginContainer/Menus/SETTINGS
@onready var CREDITS := $MarginContainer/Menus/CREDITS
@onready var TransitionScreen := $"Transition Screen"
@onready var Base_Button_Sound := $MarginContainer/Button_click
@onready var Start_Button_Sound := $MarginContainer/Start_Button

func Hide_All():
	MAP_SELECTOR.visible = false
	SETTINGS.visible = false
	CREDITS.visible = false

func _on_start_game_pressed():
	Base_Button_Sound.play()
	if MAP_SELECTOR.visible == true:
		MAP_SELECTOR.visible = false 
	else:
		Hide_All()
		MAP_SELECTOR.visible = true 

func _on_settings_pressed():
	Base_Button_Sound.play()
	if SETTINGS.visible == true:
		SETTINGS.visible = false 
	else:
		Hide_All()
		SETTINGS.visible = true 

func _on_credits_pressed():
	Base_Button_Sound.play()
	if CREDITS.visible == true:
		CREDITS.visible = false 
	else:
		Hide_All()
		CREDITS.visible = true 

func _on_map_test_pressed():
	Start_Button_Sound.play()
	Hide_All()
	TransitionScreen.Fade_Transition(0.5, "res://Maps/map_player_testing.tscn")

func _on_zone_1_blocky_pressed():
	Start_Button_Sound.play()
	Hide_All()
	TransitionScreen.Fade_Transition(0.5, "res://Maps/Zone1_blocky.tscn")
