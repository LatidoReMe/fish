extends SubWindow
class_name WaterWindow

#unneeded functions: bring to top,

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
  "Cavern", # Note: No fish in dex yet.
  "Crevice"
]
var deep_water_bodies: Array[String] = [
  "Deep Pond",
  "Sea",
  "Ravine",
  "Abyss",
  "Well"
]

var old_size : Vector2i = Vector2i(100, 100)

func _init(_name="BodyofWater", _title="Pond", _scene=null) -> void:
  super(_name, _title, _scene)
  position = Vector2i(570, 500)
  min_size = Vector2i(10,10)
  size = Vector2i(100, 100)

func _ready() -> void:
  # Setup drain (x button)
  self.close_requested.connect(self.queue_free)
  self.size_changed.connect(_resized)

# find a way to check only on button release instead?
func _resized() -> void:
  #while mouse pressed down, nothing?
  print("window resized")