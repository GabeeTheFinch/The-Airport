extends CharacterBody3D

@export_category("Player Settings")
@export var walk_speed := 2
@export var acceleration := 15
@export var run_speed := 4
@export var crouch_speed := 1
@export var jump_strength := 3
@export var flashlight_Intensity := 7
@export var crouched_height := 1.0

@export_group("Features")
@export var Can_Run := true
@export var Can_Crouch := true
@export var Can_Jump := true
@export var Can_Use_Light := true

@onready var Neck := $Neck
@onready var Camera := $Neck/Camera3D
@onready var RoofDetect := $ShapeCast3D #$Roof_Detector
@onready var Collision := $CollisionShape3D
@onready var Flashlight := $Neck/Camera3D/SpotLight3D
@onready var Flashlight_audio := $Neck/Camera3D/AudioStreamPlayer

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_sens = ProjectSettings.get_setting("Player/Mouse_sensitivity")
var controller_sens = ProjectSettings.get_setting("Player/Controller_sensitivity")

var look_dir: Vector2
var Normal_Player_Scale: Vector3 = Vector3(1,1,1)
var Crouch_Player_Scale: Vector3 = Vector3(0.6,0.6,0.6)

var speed = walk_speed
var IsLightOn = false
var IsCrouched = false
var IsRunning = false
var normal_fov:float  = ProjectSettings.get_setting("Player/FOV")
var run_fov: float = normal_fov + 10
var crouch_fov: float = normal_fov - 15


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print(mouse_sens)

func _physics_process(delta):
	controls_handler(delta)	
	actions_Handler(delta)
	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		Camera.rotation_degrees.y -= event.relative.x * mouse_sens
		Camera.rotation_degrees.x -= event.relative.y * mouse_sens
		Camera.rotation.x = clamp(Camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func controls_handler(delta):
	var input_vect: = Input.get_vector("Move_Left","Move_Right","Move_Forward","Move_Backward")	
	var rotation_input: Vector2 = Input.get_vector("Camera_Left", "Camera_Right", "Camera_Up", "Camera_Down")
	
	var _forward: Vector3 = Camera.global_transform.basis * Vector3(input_vect.x, 0, input_vect.y)
	var direction: Vector3 = Vector3(_forward.x, 0, _forward.z).normalized()
	
	if is_on_floor():
		velocity = velocity.move_toward(direction * speed * input_vect.length(), acceleration * delta)
		if Input.is_action_just_pressed("Action_Jump") and !RoofDetect.is_colliding() and Can_Jump: 
			velocity.y += jump_strength
	else:
		velocity.y -= gravity * delta
	
	if rotation_input.length() > 0:
		look_dir += rotation_input * delta
		Camera.rotation.y -= look_dir.x * controller_sens
		Camera.rotation.x = clamp(Camera.rotation.x - look_dir.y * controller_sens, deg_to_rad(-90), deg_to_rad(90))
		look_dir = Vector2.ZERO


func actions_Handler(delta):
	if Input.is_action_pressed("Action_Sprint") and !IsCrouched and Can_Run:
		if !RoofDetect.is_colliding():
			print(RoofDetect.is_colliding())
			IsRunning = true
			speed = run_speed
			Camera.fov = lerp(Camera.fov, run_fov, 5 * delta)
	elif Input.is_action_pressed("Action_Crouch") and !IsRunning and Can_Crouch:
		print(RoofDetect.is_colliding())
		IsCrouched = true
		speed = crouch_speed
		Collision.shape.height = lerp(Collision.shape.height, crouched_height, 5 * delta)
		Camera.fov = lerp(Camera.fov, crouch_fov, 5 * delta)
	elif !RoofDetect.is_colliding():
		print(RoofDetect.is_colliding())
		speed = walk_speed
		IsRunning = false
		IsCrouched = false
		Collision.shape.height = lerp(Collision.shape.height, 2.0, 5 * delta)
		Camera.fov = lerp(Camera.fov, normal_fov, 5 * delta)
		
	if Input.is_action_just_pressed("Action_Flashlight") and Can_Use_Light:
		Flashlight_audio.play()
		if IsLightOn:
			IsLightOn = false
			Flashlight.light_energy = 0
		else:
			IsLightOn = true
			Flashlight.light_energy = flashlight_Intensity
	
