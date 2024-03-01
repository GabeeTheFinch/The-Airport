extends SpotLight3D

@export_category("SETTINGS")
@export var LightIntensity:float = 7
@export var MAX_OFF_TIME: float = 4
@export var MIN_OFF_TIME: float = 0
@export var MAX_ON_TIME: float = 5
@export var MIN_ON_TIME: float = 0
var LIGHT_STATE: float = 1
var T: float = 0.0


func _process(delta):
	T += delta
	var RandomOFFtime := randf_range(MIN_OFF_TIME, MAX_OFF_TIME)
	var RandomONtime := randf_range(MIN_ON_TIME, MAX_ON_TIME)
	
	if LIGHT_STATE == 1 and T >= RandomONtime:
		LIGHT_STATE = 0
		T = 0.0
		light_energy = 0
	elif LIGHT_STATE == 0 and T >= RandomOFFtime:
		LIGHT_STATE = 1
		T = 0.0
		light_energy = LightIntensity
