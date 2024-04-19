extends TabBar
@export var SettingsNode: Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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

func _on_option_shadow_filter_item_selected(index):
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

func _on_option_model_quality_item_selected(index):
	if index == 0: # Very Low
		get_viewport().mesh_lod_threshold = 8.0
	elif index == 1: # Low
		get_viewport().mesh_lod_threshold = 4.0
	elif index == 2: # Medium
		get_viewport().mesh_lod_threshold = 2.0
	elif index == 3: # High ( Default )
		get_viewport().mesh_lod_threshold = 1.0

func _on_option_ao_item_selected(index):
	if SettingsNode.world_environment : 
		if index == 0: # Disabled
			SettingsNode.world_environment.environment.ssao_enabled = false
		elif index == 1: # Low
			SettingsNode.world_environment.environment.ssao_enabled = true
			RenderingServer.environment_set_ssao_quality(RenderingServer.ENV_SSAO_QUALITY_VERY_LOW, true, 0.5, 2, 50, 300)
		elif index == 2: # Medium
			SettingsNode.world_environment.environment.ssao_enabled = true
			RenderingServer.environment_set_ssao_quality(RenderingServer.ENV_SSAO_QUALITY_VERY_LOW, true, 0.5, 2, 50, 300)
		elif index == 3: # High ( Default)
			SettingsNode.world_environment.environment.ssao_enabled = true
			RenderingServer.environment_set_ssao_quality(RenderingServer.ENV_SSAO_QUALITY_HIGH, true, 0.5, 2, 50, 300)
	else :
		pass

func _on_option_vol_fog_item_selected(index):
	if SettingsNode.world_environment : 
		if index == 0: # Disabled 
			SettingsNode.world_environment.environment.volumetric_fog_enabled = false
		if index == 1: # Low
			SettingsNode.world_environment.environment.volumetric_fog_enabled = true
			RenderingServer.environment_set_volumetric_fog_filter_active(false)
		if index == 2: # High ( Default )
			SettingsNode.world_environment.environment.volumetric_fog_enabled = true
			RenderingServer.environment_set_volumetric_fog_filter_active(true)
	else :
		pass

