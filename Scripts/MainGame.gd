extends Node2D

@onready var indicator_normal: Sprite2D = $CanvasLayer/HBoxContainer/Control2/Fishman/Indicator1
@onready var indicator_active: Sprite2D = $CanvasLayer/HBoxContainer/Control2/Fishman/Indicator2
@onready var fish_caught: RichTextLabel = $CanvasLayer/Center/FishCaught
#@onready var fisher_stats: Node = $FisherStats
@onready var level_label: Label = $CanvasLayer/Stats/Leveling/Level
@onready var exp_bar: ProgressBar = $CanvasLayer/Stats/Leveling/EXP/EXPBar
@onready var time: Label = $CanvasLayer/Stats/SeasonTime/Time
@onready var season: Label = $CanvasLayer/Stats/SeasonTime/Season
@onready var hooked_stinger : Sprite2D = $CanvasLayer/Center/HookedSprite
@onready var gutscha_btn : Button = $CanvasLayer/HBoxContainer/ButtonGroup/VBoxContainer/HBoxContainer/Gutscha

@onready var gutscha : PackedScene = preload("res://Scenes/Gutscha.tscn")

# Timers
var fish_spawn_timer: Timer
var catch_window_timer: Timer
var caught_message_timer: Timer

var overlay_layer: CanvasLayer

func _ready():
	
	#gutscha button. turn into function
	gutscha_btn.pressed.connect(
		Globals._swapSubWindow.bind("GutschaSubWindow", Globals.newSubWindow("Gutscha", gutscha))
	)
	print(gutscha_btn.pressed.get_connections())

	# Hide the active indicator at start
	indicator_normal.visible = true
	indicator_active.visible = false
	
	# Hide "HOOKED" Stinger on at start
	hooked_stinger.visible = false

	# Setup fish spawn timer
	fish_spawn_timer = Timer.new()
	add_child(fish_spawn_timer)
	fish_spawn_timer.one_shot = true  # Timer only runs once
	fish_spawn_timer.timeout.connect(spawn_fish)

	# Setup catch window timer
	catch_window_timer = Timer.new()
	add_child(catch_window_timer)
	catch_window_timer.one_shot = true
	catch_window_timer.timeout.connect(miss_fish)

	# Setup caught timer
	caught_message_timer = Timer.new()
	add_child(caught_message_timer)
	caught_message_timer.one_shot = true
	caught_message_timer.timeout.connect(hide_catch_message)

	# Start the first fish spawn timer
	start_fish_timer()

	# Display a message if we just left the Fishing Game
	if Globals.IsFishing:
		if Globals.FishWasCaught:
			var format_string : String= "Caught a {name}! It's about {size}{size_unit}!"
			fish_caught.text = format_string.format({"name":Globals.DexInstance.tracked_fish.fish_name, "size": snapped(Globals.DexInstance.tracked_fish.current_size,Globals.SizeDecimalPlaces), "size_unit": Globals.DexInstance.tracked_fish.size_unit})
		else:
			fish_caught.text = "Looks like that one got away!"
		# Clean up state.
		Globals.FishWasCaught = false
		Globals.IsFishing = false

		# Free the Fish ref for memeory management
		Globals.DexInstance.free_fish()

		# Display notice
		fish_caught.visible = true
		caught_message_timer.start(5.0)

func start_fish_timer():
	# Random time between 5-10 seconds
	var random_time: float = randf_range(5.0, 10.0)
	fish_spawn_timer.start(random_time)

func spawn_fish():
	print("A fish appeared!")
	indicator_normal.visible = false
	indicator_active.visible = true

	# Start the catch window timer (5 seconds to catch)
	catch_window_timer.start(5.0)

func miss_fish():
	print("Failed to catch the fish!")
	indicator_normal.visible = true
	indicator_active.visible = false

	# Start the next fish spawn timer
	start_fish_timer()

func hide_catch_message():
	fish_caught.visible = false

func _input(event):
	# Check for space key press
	if event.is_action_pressed("ui_accept"):  # Space bar by default
		try_catch_fish()

		# Check for mouse click
	elif event.is_action_pressed("ui_click"):
		if event is InputEventMouseButton:
			# Check if click is within fisher or indicator area
			if is_click_in_area(event.position):
				try_catch_fish()

func is_click_in_area(click_pos: Vector2) -> bool:
	# Convert click position to local coordinates if needed
	var local_pos: Vector2 = to_local(click_pos)

	# Check if click is within fisher or indicator sprites
	# You'll need to adjust these based on your sprite sizes
	var click_rect: Rect2 = Rect2(Vector2(-50, -50), Vector2(100, 100))
	return click_rect.has_point(local_pos)

func try_catch_fish():
	if indicator_active.visible:
		print("fish. start!")
		# Stop both timers
		catch_window_timer.stop()


		fish_spawn_timer.stop()
		hooked_stinger.visible = true
		hooked_stinger._hooked()
		await get_tree().create_timer(1).timeout
		var window_scene = preload("res://Scenes/window.tscn")
		var window = window_scene.instantiate()
		add_child(window)
		window.load_scene("res://Scenes/fishing.tscn", "Fishing")
		indicator_normal.visible = true
		indicator_active.visible = false
		hooked_stinger.visible = false

		# Connect the window_closed signal to a method in this scene
		window.connect("window_closed", Callable(self, "_on_fishing_window_closed"))

func _on_fishing_window_closed():
	print("fishing window closed")
	if not fish_spawn_timer.time_left > 0:
		start_fish_timer()

func _process(delta: float) -> void:
	var TimeText: String = "Time of Day: {time}"
	time.text = TimeText.format({"time":Globals.current_time})
	var SeasonText: String = "Current Season: {season}"
	season.text = SeasonText.format({"season": Globals.current_season})
