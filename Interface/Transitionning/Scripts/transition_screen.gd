extends CanvasLayer

signal Transition

func Fade_in(speed: float):
	$AnimationPlayer.speed_scale = speed
	$AnimationPlayer.play("Fade_in")

func Fade_out(speed: float):
	$AnimationPlayer.speed_scale = speed
	$AnimationPlayer.play("Fade_out")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Fade_in":
		emit_signal("Transition")
		$AnimationPlayer.play("Fade_out")
