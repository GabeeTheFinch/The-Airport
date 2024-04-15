extends TabBar
@export var SettingsNode: Control


func _on_slider_resolution_value_changed(value):
	get_viewport().scaling_3d_mode = value

func _on_option_fullscreen_item_selected(index):
	if index == 0: # Windowed
		get_tree().root.set_mode(Window.MODE_WINDOWED)
	elif index == 1: # Fullscreen
		get_tree().root.set_mode(Window.MODE_FULLSCREEN)

func _on_option_vsync_item_selected(index):
	if index == 0: # Disabled
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	elif index == 1: # Adaptive
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
	elif index == 2: # Enabled
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)

func _on_slider_fov_value_changed(value):
	pass # Replace with function body.


## SCREEN ADJUSTMENTS ##
# If statements are necessary
# They prevent the game from crashing 
# if there are no WorldEnvironment set

func _on_slider_brightness_value_changed(value):
	if SettingsNode.world_environment : 
		SettingsNode.world_environment.environment.set_adjustment_brightness(value)
	else:
		pass

func _on_slider_contrast_value_changed(value):
	if SettingsNode.world_environment :
		SettingsNode.world_environment.environment.set_adjustment_contrast(value)
	else:
		pass

func _on_slider_saturation_value_changed(value):
	if SettingsNode.world_environment :
		SettingsNode.world_environment.environment.set_adjustment_saturation(value)
	else:
		pass
