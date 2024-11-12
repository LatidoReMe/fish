extends Button

var window_scene := preload("res://Scenes/WindowTest.tscn")  # Adjust path as needed

func _ready():
	self.pressed.connect(_on_pond_pressed)
	visible = Globals.total_locations_discovered > 0
	if visible == false:
		Globals.fish_caught.connect(_show_pond_btn)

func _on_pond_pressed():  # Fixed function name formatting
	var new_window := window_scene.instantiate()
	add_child(new_window)
	# Spawn window at random position
	new_window.position = Vector2(
		randf_range(0, get_viewport_rect().size.x - 200),
		randf_range(0, get_viewport_rect().size.y - 150)
	)

	get_tree().call_group("window_buttons", "release_focus")
	
func _show_pond_btn() -> void:
	visible=true
	Globals.fish_caught.disconnect(_show_pond_btn)
