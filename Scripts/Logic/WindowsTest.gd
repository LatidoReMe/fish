# TestScene.gd
extends Globals

@onready var gutscha_btn : Button = $Button
@onready var gutscha_btn2 : Button = $Button2
@onready var gutscha : PackedScene= preload("res://Scenes/Gutscha.tscn")
#@onready var SWscene = preload("res://Scenes/SubWindow.tscn")
#@onready var subwindow : Window

func _ready() -> void:
	print("ready?")
	#subwindow = SWscene.instantiate()
	gutscha_btn.pressed.connect(newSubWindow.bind("Gutscha", gutscha))
	print(gutscha_btn.pressed.get_connections())
	gutscha_btn2.pressed.connect(newSubWindow.bind("Gutscha", gutscha))
	print(gutscha_btn2.pressed.get_connections())
	print("ready")

#func newSubWindow(window : Window, title : String, scene : PackedScene = null) -> void:
	#print("btn pressed")	
	#print("subby wins")
	#window.title=title
	#if scene:
		#var node := scene.instantiate()
		#window.add_child(node)
	#add_child(window)
	
	
#func _on_pond_pressed():  # Fixed function name formatting
	#var new_window := window_scene.instantiate()
	#add_child(new_window)
	## Spawn window at random position
	#new_window.position = Vector2(
		#randf_range(0, get_viewport_rect().size.x - 200),
		#randf_range(0, get_viewport_rect().size.y - 150)
	#)
#
	#get_tree().call_group("window_buttons", "release_focus")
