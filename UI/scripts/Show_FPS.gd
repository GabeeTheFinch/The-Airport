extends Control
@onready var fps_label := $Label
var counter := 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter += delta
	# Hide FPS label until it's initially updated by the engine (this can take up to 1 second).
	fps_label.visible = counter >= 1.0
	fps_label.text = "%d FPS (%.2f mspf)" % [Engine.get_frames_per_second(), 1000.0 / Engine.get_frames_per_second()]
