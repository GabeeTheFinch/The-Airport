extends Control

@export var IsMainMenu := false

@onready var BackToMenu := $Button
@onready var TransitionScreen := $"Transition Screen"
# Called when the node enters the scene tree for the first time.
func _ready():
	if IsMainMenu == true:
		BackToMenu.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


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
