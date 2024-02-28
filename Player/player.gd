extends CharacterBody3D

@export var BASE_SPEED: float = 3.0
@export var SPRINT_SPEED: float = 6
@export var CROUCH_SPEED: float = 1
@export var JUMP_VELOCITY: float = 4.5
@export var Sensitivity: float = 0.1
@export var Acceleration: float = 10.0

@export var sprint_enabled: bool = true
@export var crouch_enabled: bool = true

@onready var neck := $Neck
@onready var Camera := $Neck/Camera3D
@onready var Body := $CollisionShape3D/MeshInstance3D
@onready var Collision := $CollisionShape3D
@onready var world: SceneTree = get_tree()

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var state: String = "Normal" #Normal, Sprinting, Crouching
var Normal_Player_Y_Scale: float = 1.0
var Crouch_Player_Y_Scale: float = 0.6
var SPEED: float = BASE_SPEED

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Camera.current = true
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		handle_mouse_movement(event)
		

func apply_crouch_transform(delta: float) -> void:
	#Body.scale.y = lerp(Body.scale.y, Crouch_Player_Y_Scale, 10 * delta)
	Collision.scale.y = lerp(Collision.scale.y, Crouch_Player_Y_Scale, 10 * delta)

func reset_transforms(delta: float) -> void:
	#Body.scale.y = lerp(Body.scale.y, Normal_Player_Y_Scale, 10 * delta)
	Collision.scale.y = lerp(Collision.scale.y, Normal_Player_Y_Scale, 10 * delta)

func _process(delta: float) -> void:
	if Input.is_action_pressed("Action_Sprint") and !Input.is_action_pressed("Action_Crouch") and sprint_enabled:
		if !$Roof_Detector.is_colliding():
			state = "Sprinting"
			SPEED = SPRINT_SPEED
	elif  Input.is_action_pressed("Action_Crouch") and !Input.is_action_pressed("Action_Sprint") and crouch_enabled:
		state = "Crouching"
		SPEED = CROUCH_SPEED
		apply_crouch_transform(delta)
	else:
		if !$Roof_Detector.is_colliding():
			state = "Normal"
			SPEED = BASE_SPEED
			reset_transforms(delta)
		

func _physics_process(delta: float):
	#Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	#Handle Jump.
	if Input.is_action_pressed("Move_Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var input_dir := Input.get_vector("Move_Left","Move_Right","Move_Forward","Move_Backward")
	var direction := input_dir.normalized().rotated(-neck.rotation.y)
	
	if is_on_floor():
		velocity.x = lerp(velocity.x, direction.x * SPEED, Acceleration * delta)
		velocity.z = lerp(velocity.z, direction.y * SPEED, Acceleration * delta)
	
	move_and_slide()

func handle_mouse_movement(event: InputEventMouseMotion) -> void:
	if !world.paused:
		neck.rotation_degrees.y -= event.relative.x * Sensitivity
		neck.rotation_degrees.x -= event.relative.y * Sensitivity
		neck.rotation.x = clamp(neck.rotation.x, deg_to_rad(-90), deg_to_rad(90))
