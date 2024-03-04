extends Control

@export var IsMainMenu := false

@onready var BackToMenu := $Button
@onready var TransitionScreen := $"Transition Screen"

@onready var Shadows := $SETTINGS/Video/MarginContainer/GridContainer/Option_Shadows
@onready var Textures :=  $SETTINGS/Video/MarginContainer/GridContainer/Option_Textures
@onready var Antialiasing :=  $SETTINGS/Video/MarginContainer/GridContainer/Option_Antialiasing

@onready var Display := $SETTINGS/Display/MarginContainer2/GridContainer/Option_Display 
@onready var Resolution := $SETTINGS/Display/MarginContainer2/GridContainer/Option_Resolution
@onready var Vsync := $SETTINGS/Display/MarginContainer2/GridContainer/Check_Vsync
@onready var Brightness := $SETTINGS/Display/MarginContainer2/GridContainer/Slider_Brightness

@onready var Master := $SETTINGS/Audio/MarginContainer2/GridContainer/Slider_Master
@onready var Music := $SETTINGS/Audio/MarginContainer2/GridContainer/Slider_Music
@onready var SFX := $SETTINGS/Audio/MarginContainer2/GridContainer/Slider_SFX

@onready var MouseSens := $SETTINGS/Controls/MarginContainer2/GridContainer/Slider_Mouse
@onready var ControllerSens := $SETTINGS/Controls/MarginContainer2/GridContainer/Silder_Controller

# Called when the node enters the scene tree for the first time.
func _ready():
	Load_Saved_Settings()
	print("Loaded Save Data")
	if IsMainMenu == true:
		BackToMenu.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func Load_Saved_Settings():
	Master.value = AudioServer.get_bus_volume_db(0)
	Music.value = AudioServer.get_bus_volume_db(1)
	SFX.value = AudioServer.get_bus_volume_db(2)
	MouseSens.value = ProjectSettings.get_setting("Player/Mouse_sensitivity")
	ControllerSens.value = ProjectSettings.get_setting("Player/Controller_sensitivity")


func _on_slider_master_value_changed(value):
	GlobalSettings.update_master_volume(value)
func _on_slider_music_value_changed(value):
	GlobalSettings.update_music_volume(value)
func _on_slider_sfx_value_changed(value):
	GlobalSettings.update_sfx_volume(value)


func _on_slider_mouse_value_changed(value):
	GlobalSettings.update_mouse_sens(value)
	print(value)
func _on_silder_controller_value_changed(value):
	GlobalSettings.update_controller_sens(value)
	print(value)



func _on_option_display_item_selected(index):
	GlobalSettings.Display_Mode(index)

func _on_check_vsync_toggled(toggled_on):
	GlobalSettings.toggle_vsync(toggled_on)


func _on_button_pressed():
	TransitionScreen.Fade_Transition(0.5, "res://Interface/Menu/new_menu.tscn")
	get_tree().paused = false


func _on_visibility_changed():
	if visible == false:	
		Save.save_data()
	else:
		Save.load_data()
