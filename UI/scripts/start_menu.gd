extends Control
var Zone1 = "res://Levels/Zone1_blocky.tscn"
var Testing = "res://Levels/map_player_testing.tscn"
var Node3DM = "res://Levels/node_3d.tscn"

func _on_zone_1_pressed():
	get_tree().change_scene_to_file(Zone1)


func _on_testing_pressed():
	get_tree().change_scene_to_file(Testing)


func _on_node_3d_pressed():
	get_tree().change_scene_to_file(Node3DM)
