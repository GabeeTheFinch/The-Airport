extends Node3D

@export var IsLocked = false
@onready var Animator = $AnimationPlayer

func _on_detector_body_entered(body):
	Open_Door()


func _on_detector_body_exited(body):
	Close_Door()

func Open_Door():
	if !IsLocked:
		Animator.play("Open")

func Close_Door():
	Animator.play("Close")
