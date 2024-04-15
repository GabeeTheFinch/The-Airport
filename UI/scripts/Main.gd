extends Control

@export var LevelSelectMenu: Node
@export var SettingsMenu: Node
@export var CreditsMenu: Node
@onready var Clicked := $ButtonClick
@onready var Animator := $AnimationTree


func ClearAll():
	SettingsMenu.visible = false
	CreditsMenu.visible = false

func OpenMenu(UINode: Node):
	Clicked.play()
	if UINode.visible == true:
		UINode.visible = false
	else:
		ClearAll()
		UINode.visible = true

func _on_start_pressed():
	pass

func _on_settings_pressed():
	OpenMenu(SettingsMenu)

func _on_credits_pressed():
	OpenMenu(CreditsMenu)
