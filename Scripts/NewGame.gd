extends Control

@onready var sign_it : Button = $FishingLicense/Buttons/SignBtn
@onready var random_btn : Button = $FishingLicense/Buttons/RandomName
@onready var dialog : Label = $Dialog
@onready var fisher_name : LineEdit = $FishingLicense/FisherName
var hand_bad : bool = false

var random_btn_text : Array[String] = [
	"Try again?",
	"Not rod enough.",
	"No thanks.",
	"Give me another siggy.",
	"Throw me another line."
]
var dialog_text : Array[String] = [
	"Does this hook ya?",
	"This sig rod enough for you?",
	"Next in line is sure to please."
]
var names_first : Array[String] = [
	"Gill",
	"Finn",
	"Poseidon",
	"Aqua",
	"Lily",
	"Marlin",
	"Koi",
	"Pearl",
	"Mahi"
]
var names_second : Array[String] = [
	"Finley",
	"Arrowhead",
	"Marlin",
	"of Atlantis",
	"Perch",
	"Mahi"
]
	
func _ready() -> void:
	sign_it.pressed.connect(_signed_it)
	random_btn.pressed.connect(_hand_bad)
	
#make new save file eventually, goes to game for now
func _signed_it() -> void:
	get_tree().change_scene_to_file("res://Scenes/game_background.tscn")

func _hand_bad() -> void:
	if not hand_bad:
		dialog.visible=true
		random_btn.custom_minimum_size=Vector2i(300,36)
		hand_bad=true
	else:
		dialog.text=str(
			"Don't worry. We have plenty more signatures you can borrow. ", dialog_text.pick_random()
		)
	fisher_name.text=str(names_first.pick_random(), " ", names_second.pick_random())
	random_btn.text=random_btn_text.pick_random()
