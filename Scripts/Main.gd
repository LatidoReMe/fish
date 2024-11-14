extends Node2D

@onready var gutscha_btn : Button = $CanvasLayer/FullRect/BtnToolbox/GutschaBtn
@onready var pond_btn : Button = $CanvasLayer/FullRect/BtnToolbox/PondBtn
@onready var idle_btn : Button = $CanvasLayer/FullRect/BtnToolbox/IdleBtn
@onready var gutscha : PackedScene = preload("res://Scenes/Gutscha.tscn")
@onready var music : AudioStreamPlayer = $Music

func _ready() -> void:
	music.set_volume_db(linear_to_db(Globals.MusicVolume))
	gutscha_btn.pressed.connect(_pressed_window_btn_for_sw.bind("Gutscha", gutscha))
	pond_btn.pressed.connect(_pressed_pond)
	idle_btn.toggled.connect(toggle_idle_mode)

# Pond (WIP)
func _pressed_pond() -> void:
	if get_node_or_null("BodyofWater")!=null:
		get_node("BodyofWater").emit_signal("close_requested")
	else:
		var _window=WaterWindow.new("BodyofWater", "Pond", null)
		add_child(_window)

# Subwindows
func _pressed_window_btn_for_sw(title:String,scene:PackedScene=null) -> void:
	if get_node_or_null(str(title,"SubWindow"))!=null:
		get_node(str(title,"SubWindow")).emit_signal("close_requested")
	else:
		var _window=SubWindow.new(str(title,"SubWindow"), title, scene)
		add_child(_window)

# Toggle Btn
func _input(event):
	if event.is_action_pressed("toggle_fishing_mode"):  # You'll need to set this up in your input map
		idle_btn.toggle_mode=(not idle_btn.toggle_mode)

func toggle_idle_mode(toggled:bool=(not Globals.idle_mode)):
	Globals.idle_mode = toggled
	emit_signal("toggled_idle_mode", Globals.idle_mode)
