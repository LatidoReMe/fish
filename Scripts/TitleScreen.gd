extends Node

@onready var load : Button = $CanvasLayer/Control/BoxContainer/VBoxContainer/LoadGameButton
@onready var new : Button = $CanvasLayer/Control/BoxContainer/VBoxContainer/NewGameButton
@onready var settings : Button = $CanvasLayer/Control/BoxContainer/VBoxContainer/SettingsButton
@onready var quit : Button = $CanvasLayer/Control/BoxContainer/VBoxContainer/QuitButton
@onready var music : AudioStreamPlayer = $TitleMusic

func _ready() -> void:
	music.set_volume_db(linear_to_db(Globals.MusicVolume))
	load.pressed.connect(get_tree().change_scene_to_file.bind("res://Scenes/Main.tscn"))
	new.pressed.connect(get_tree().change_scene_to_file.bind("res://Scenes/NewGame.tscn"))
	settings.pressed.connect(print.bind("Coming soon to fish. near you."))
	quit.pressed.connect(get_tree().quit)
