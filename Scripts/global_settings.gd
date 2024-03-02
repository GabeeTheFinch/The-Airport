extends Node
signal mouse_sens_update(value)

func toggle_fullscreen(value):
	if value:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func toggle_vsync(value):
	if value:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func update_master_volume(vol):
	if vol == -10:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)
	AudioServer.set_bus_volume_db(0, vol)	

func update_music_volume(vol):
	if vol == -10:
		AudioServer.set_bus_mute(1, true)
	else:
		AudioServer.set_bus_mute(1, false)
	AudioServer.set_bus_volume_db(1, vol)	

func update_sfx_volume(vol):
	if vol == -10:
		AudioServer.set_bus_mute(2, true)
	else:
		AudioServer.set_bus_mute(2, false)
	AudioServer.set_bus_volume_db(2, vol)	

func update_mouse_sens(value):
	ProjectSettings.set_setting("Player/Mouse_sensitivity",value)
	print(value)
	emit_signal("mouse_sens_update", value)

func update_controller_sens(value):
	ProjectSettings.set_setting("Player/Controller_sensitivity", value)

func update_FOV(value):
	ProjectSettings.set_setting("Player/Mouse_sensitivity",value)
