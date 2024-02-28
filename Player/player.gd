extends CharacterBody3D

@export var BASE_SPEED: float = 3
@export var SPRINT_SPEED: float = 6
@export var CROUCH_SPEED: float = 1
@export var JUMP_VELOCITY: float = 4.5
@export var Sensitivity: float = 0.1
@export var Controller_Sensitivity: float = 5
@export var Acceleration: float = 10.0

@export var sprint_enabled: bool = true
@export var crouch_enabled: bool = true

@onready var neck := $Neck
@onready var camera := $Neck/Camera3D
@onready var body := $MeshInstance3D
@onready var collision := $CollisionShape3D
@onready var world: SceneTree = get_tree()

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var state: String = "Normal" #Normal, Sprinting, Crouching
var Normal_Player_Y_Scale: float = 1.0
var Crouch_Player_Y_Scale: float = 0.6
var SPEED: float = BASE_SPEED
var look_dir: Vector2

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED: _handle_joypad_camera_rotation(delta)
	move_character(delta)
	
func apply_crouch_transform(delta: float) -> void:
	collision.scale.y = lerp(collision.scale.y, Crouch_Player_Y_Scale, 10 * delta)
	collision.scale.z = lerp(collision.scale.y, Crouch_Player_Y_Scale, 10 * delta)
	collision.scale.x = lerp(collision.scale.y, Crouch_Player_Y_Scale, 10 * delta)

func reset_transforms(delta: float) -> void:
	collision.scale.y = lerp(collision.scale.y, Normal_Player_Y_Scale, 10 * delta)
	collision.scale.z = lerp(collision.scale.y, Normal_Player_Y_Scale, 10 * delta)
	collision.scale.x = lerp(collision.scale.y, Normal_Player_Y_Scale, 10 * delta)

func move_character(delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector("Move_Left", "Move_Right", "Move_Forward", "Move_Backward")
	var _forward: Vector3 = camera.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)
	var direction: Vector3 = Vector3(_forward.x, 0, _forward.z).normalized()
	
	if Input.is_action_pressed("Move_Jump") and is_on_floor():
		velocity.y += JUMP_VELOCITY
	
	if Input.is_action_pressed("Action_Sprint") and !Input.is_action_pressed("Action_Crouch") and sprint_enabled:
		if !$Roof_Detector.is_colliding():
			state = "Sprinting"
			SPEED = SPRINT_SPEED
	elif Input.is_action_pressed("Action_Crouch") and !Input.is_action_pressed("Action_Sprint") and crouch_enabled:
		state = "Crouching"
		SPEED = CROUCH_SPEED
		apply_crouch_transform(delta)
	else:
		if !$Roof_Detector.is_colliding():
			state = "Normal"
			SPEED = BASE_SPEED
			reset_transforms(delta)
		
	if is_on_floor():
		velocity = velocity.move_toward(direction * SPEED * input_dir.length(), Acceleration * delta)
	move_and_slide()

func _handle_joypad_camera_rotation(delta):
	var joypad_dir: Vector2 = Input.get_vector("Camera_Left", "Camera_Right", "Camera_Up", "Camera_Down")
	if joypad_dir.length() > 0:
		look_dir += joypad_dir * delta
		camera.rotation.y -= look_dir.x * Controller_Sensitivity
		camera.rotation.x = clamp(camera.rotation.x - look_dir.y * Controller_Sensitivity, deg_to_rad(-90), deg_to_rad(90))
		look_dir = Vector2.ZERO

func _input(event):
	if event is InputEventMouseMotion:
		handle_mouse_movement(event)


func handle_mouse_movement(event):
	if !world.paused:
		camera.rotation_degrees.y -= event.relative.x * Sensitivity
		camera.rotation_degrees.x -= event.relative.y * Sensitivity
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		#neck.rotation.x = clamp(neck.rotation.x, deg_to_rad(-90), deg_to_rad(90))
