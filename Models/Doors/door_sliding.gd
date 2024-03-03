extends Node3D

@export var IsLocked = false
@onready var Animator = $AnimationPlayer

func _on_detector_body_entered():
	Open_Door()


func _on_detector_body_exited():
	Close_Door()

func Open_Door():
	if !IsLocked:
		Animator.play("Open")

func Close_Door():
	Animator.play("Close")
