extends CanvasLayer

signal Transition

var New_Map
var Wants_Transition = false

func Fade_in(speed: float):
	$AnimationPlayer.speed_scale = speed
	$AnimationPlayer.play("Fade_in")

func Fade_out(speed: float):
	$AnimationPlayer.speed_scale = speed
	$AnimationPlayer.play("Fade_out")
	
func Fade_Transition(speed: float, map):
	$AnimationPlayer.speed_scale = speed
	Wants_Transition = true
	New_Map = map
	$AnimationPlayer.play("Fade_in")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Fade_in" and Wants_Transition:
		emit_signal("Transition", New_Map)
		$AnimationPlayer.play("Fade_out")
		Wants_Transition = false

func _on_transition(map):
	get_tree().change_scene_to_file(map)
