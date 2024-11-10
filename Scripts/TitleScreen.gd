extends Node

@onready var load : Button = $CanvasLayer/Control/BoxContainer/VBoxContainer/LoadGameButton
@onready var new : Button = $CanvasLayer/Control/BoxContainer/VBoxContainer/NewGameButton
@onready var settings : Button = $CanvasLayer/Control/BoxContainer/VBoxContainer/SettingsButton
@onready var quit : Button = $CanvasLayer/Control/BoxContainer/VBoxContainer/QuitButton

func _ready() -> void:
	load.pressed.connect(get_tree().change_scene_to_file.bind("res://Scenes/game_background.tscn"))
	new.pressed.connect(get_tree().change_scene_to_file.bind("res://Scenes/NewGame.tscn"))
	quit.pressed.connect(get_tree().quit)
