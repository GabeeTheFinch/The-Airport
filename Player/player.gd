extends CharacterBody3D

@export var SPEED: float = 5.0
@export var JUMP_VELOCITY: float = 4.5
@export var Sensitivity: float = 0.1
@export var Acceleration: float = 10.0

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var neck := $Neck
@onready var Camera := $Neck/Camera3D
@onready var world: SceneTree = get_tree()

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Camera.current = true
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		handle_mouse_movement(event)

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
