extends Node

const SAVEFILE = "user://Config_file.ini"

var game_data = {}

func _ready():
	load_data()

func save_data():
	var config := ConfigFile.new()
	
	config.set_value("Settings", "FOV", ProjectSettings.get_setting("Player/FOV"))
	config.set_value("Settings", "Mouse_Sensitivity", ProjectSettings.get_setting("Player/Mouse_sensitivity"))
	config.set_value("Settings", "Controller_Sensitivy", ProjectSettings.get_setting("Player/Controller_sensitivity"))
	config.set_value("Settings", "Master_Volume", AudioServer.get_bus_volume_db(0))
	config.set_value("Settings", "Master_Mute", AudioServer.is_bus_mute(0))
	config.set_value("Settings", "Music_Volume", AudioServer.get_bus_volume_db(1))
	config.set_value("Settings", "Music_Mute", AudioServer.is_bus_mute(1))
	config.set_value("Settings", "SFX_Volume", AudioServer.get_bus_volume_db(2))
	config.set_value("Settings", "SFX_Mute", AudioServer.is_bus_mute(2))
	
	config.save(SAVEFILE)

func load_data():
	var config := ConfigFile.new()
	if FileAccess.file_exists(SAVEFILE):
		config.load(SAVEFILE)
		ProjectSettings.set_setting("Player/FOV",config.get_value("Settings", "FOV"))
		ProjectSettings.set_setting("Player/Mouse_sensitivity",config.get_value("Settings", "Mouse_Sensitivity"))
		ProjectSettings.set_setting("Player/Controller_sensitivity", config.get_value("Settings", "Controller_Sensitivy"))
		AudioServer.set_bus_volume_db(0, config.get_value("Settings", "Master_Volume"))
		AudioServer.set_bus_mute(0, config.get_value("Settings", "Master_Mute"))
		AudioServer.set_bus_volume_db(1, config.get_value("Settings", "Music_Volume"))
		AudioServer.set_bus_mute(1, config.get_value("Settings", "Music_Mute"))
		AudioServer.set_bus_volume_db(2, config.get_value("Settings", "SFX_Volume"))
		AudioServer.set_bus_mute(2, config.get_value("Settings", "SFX_Mute"))
	else:
		print("No data")
		save_data()
