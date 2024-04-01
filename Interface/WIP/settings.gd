extends Control

@onready var world_environment := $WorldEnvironment

## DISPLAY OPTIONS ##

func _on_h_slider_res_value_changed(value):
	get_viewport().scaling_3d_mode = value

func _on_option_vsync_item_selected(index):
	if index == 0: # Disabled
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	elif index == 1: # Adaptive
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
	elif index == 2: # Enabled
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)

func _on_option_full_screen_item_selected(index):
	if index == 0: # Disabled
		get_tree().root.set_mode(Window.MODE_WINDOWED)
	elif index == 1: # Fullscreen
		get_tree().root.set_mode(Window.MODE_FULLSCREEN)
	elif index == 2: # Exclusive Fullscreen
		get_tree().root.set_mode(Window.MODE_EXCLUSIVE_FULLSCREEN)


## SCREEN ADJUSTMENTS ##
# Settings here are attached to the environment
# IF the game changes those settings
# The functions below must be ran again

func _on_h_slider_bright_value_changed(value):
	world_environment.environment.set_adjustment_brightness(value)

func _on_h_slider_contrast_value_changed(value):
	world_environment.environment.set_adjustment_contrast(value)

func _on_h_slider_saturation_value_changed(value):
	world_environment.environment.set_adjustment_saturation(value)


## GRAPHICS OPTIONS ##
# Settings here are attached to the environment
# IF the game changes those settings
# The functions below must be ran again

func _on_option_shadow_res_item_selected(index):
	if index == 0: # Very Low
		RenderingServer.directional_shadow_atlas_set_size(512, true)
		get_viewport().positional_shadow_atlas_size = 0
	elif index == 1: # Low
		RenderingServer.directional_shadow_atlas_set_size(1024, true)
		get_viewport().positional_shadow_atlas_size = 1024
	elif index == 2: # Medium
		RenderingServer.directional_shadow_atlas_set_size(4096, true)
		get_viewport().positional_shadow_atlas_size = 4096
	elif index == 3: # High ( Default )
		RenderingServer.directional_shadow_atlas_set_size(8192, true)
		get_viewport().positional_shadow_atlas_size = 8192

func _on_option_shadow_filter_2_item_selected(index):
	if index == 0: # Very Low
		RenderingServer.directional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_HARD)
		RenderingServer.positional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_HARD)
	elif index == 1: # Low 
		RenderingServer.directional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_LOW)
		RenderingServer.positional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_LOW)
	elif index == 2: # Medium 
		RenderingServer.directional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_MEDIUM)
		RenderingServer.positional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_MEDIUM)
	elif index == 3: # High ( Default )
		RenderingServer.directional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_HIGH)
		RenderingServer.positional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_HIGH)

func _on_option_model_q_item_selected(index):
	if index == 0: # Very Low
		get_viewport().mesh_lod_threshold = 8.0
	elif index == 1: # Low
		get_viewport().mesh_lod_threshold = 4.0
	elif index == 2: # Medium
		get_viewport().mesh_lod_threshold = 2.0
	elif index == 3: # High ( Default )
		get_viewport().mesh_lod_threshold = 1.0

func _on_option_bloom_item_selected(index):
	if index == 0: # Disabled ( Default )
		world_environment.environment.glow_enabled = false
	else:
		world_environment.environment.glow_enabled = true

func _on_option_ao_item_selected(index):
	if index == 0: # Disabled
		world_environment.environment.ssao_enabled = false
	elif index == 1: # Low
		world_environment.environment.ssao_enabled = true
		RenderingServer.environment_set_ssao_quality(RenderingServer.ENV_SSAO_QUALITY_VERY_LOW, true, 0.5, 2, 50, 300)
	elif index == 2: # Medium
		world_environment.environment.ssao_enabled = true
		RenderingServer.environment_set_ssao_quality(RenderingServer.ENV_SSAO_QUALITY_VERY_LOW, true, 0.5, 2, 50, 300)
	elif index == 3: # High ( Default)
		world_environment.environment.ssao_enabled = true
		RenderingServer.environment_set_ssao_quality(RenderingServer.ENV_SSAO_QUALITY_HIGH, true, 0.5, 2, 50, 300)

func _on_option_ssr_item_selected(index):
	if index == 0: # Disabled ( Default )
		world_environment.environment.set_ssr_enabled(false)
	elif index == 1: # Low
		world_environment.environment.set_ssr_enabled(true)
		world_environment.environment.set_ssr_max_steps(8)
	elif index == 2: # Medium
		world_environment.environment.set_ssr_enabled(true)
		world_environment.environment.set_ssr_max_steps(32)
	elif index == 3: # High
		world_environment.environment.set_ssr_enabled(true)
		world_environment.environment.set_ssr_max_steps(64)

func _on_option_vol_fog_item_selected(index):
	if index == 0: # Disabled 
		world_environment.environment.volumetric_fog_enabled = false
	if index == 1: # Low
		world_environment.environment.volumetric_fog_enabled = true
		RenderingServer.environment_set_volumetric_fog_filter_active(false)
	if index == 2: # High ( Default )
		world_environment.environment.volumetric_fog_enabled = true
		RenderingServer.environment_set_volumetric_fog_filter_active(true)
