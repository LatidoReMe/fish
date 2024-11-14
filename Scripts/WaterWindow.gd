extends SubWindow
class_name WaterWindow

var water_bodies: Array[String] = [
  "Pond",
  "Lake",
  "River",
  "Ocean",
  "Waterfall",
  "Puddle"
]
var cave_types: Array[String] = [
  "Cave",
  "Cavern",
  "Crevice"
]
var deep_water_bodies: Array[String] = [
  "Deep Pond",
  "Sea",
  "Ravine",
  "Abyss",
  "Well"
]

func _ready():
	# Setup drain (x button)
	self.close_requested.connect(self.queue_free)

