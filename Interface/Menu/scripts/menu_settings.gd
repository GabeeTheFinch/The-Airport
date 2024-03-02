extends Control

#Video Settings
@onready var Display_button = $MarginContainer/TabContainer/Video/MarginContainer/GridContainer/Button_Display
@onready var Vsync_button = $MarginContainer/TabContainer/Video/MarginContainer/GridContainer/Button_Vsync
@onready var MaxFPS_slider = $MarginContainer/TabContainer/Video/MarginContainer/GridContainer/Slider_MaxFPS
@onready var Bright_slider = $MarginContainer/TabContainer/Video/MarginContainer/GridContainer/Slider_Bright

#Audio Settings
@onready var MasterV_slider = $MarginContainer/TabContainer/Audio/MarginContainer/GridContainer/Slider_MasterV
@onready var MusicV_slider = $MarginContainer/TabContainer/Audio/MarginContainer/GridContainer/Slider_MusicV

#Gameplay Settings
@onready var MouseSens = $MarginContainer/TabContainer/WIP/MarginContainer/GridContainer/Slider_MouseSens
@onready var ControllerSens = $MarginContainer/TabContainer/WIP/MarginContainer/GridContainer/Slider_ControllerSens

func _ready():
	pass



#VIDEO
func _on_button_display_item_selected(index):
	GlobalSettings.toggle_fullscreen(true if index == 1 else  false)

func _on_button_vsync_toggled(toggled_on):
	GlobalSettings.toggle_vsync(toggled_on)

func _on_slider_max_fps_value_changed(value):
	pass # Replace with function body.

func _on_slider_bright_value_changed(value):
	pass # Replace with function body.


# VOLUME
func _on_slider_master_v_value_changed(value):
	GlobalSettings.update_master_volume(value)

func _on_slider_music_v_value_changed(value):
	GlobalSettings.update_music_volume(value)

func _on_slider_sfxv_value_changed(value):
	GlobalSettings.update_sfx_volume(value)


#GAMEPLAY
func _on_slider_mouse_sens_value_changed(value):
	GlobalSettings.update_mouse_sens(value)

func _on_slider_controller_sens_value_changed(value):
	GlobalSettings.update_controller_sens(value)

func _on_slider_fov_value_changed(value):
	GlobalSettings.update_FOV(value)


func _on_visibility_changed():
	if visible:
		Save.load_data()
	else :
		Save.save_data()
