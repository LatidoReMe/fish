extends Node
class_name FishingManager

@export var discovered_locations = [] #get from save file
@export var current_fishing_locations = []
var locations: Array[String] = [
  "Air", 
  "Pond",
  "Lake",
  "River",
  "Ocean",
  "Waterfall",
  "Puddle",
  "Cave",
  "Cavern", # Note: No fish in dex yet.
  "Crevice",
  "Deep Pond",
  "Sea",
  "Ravine",
  "Abyss",
  "Well"
]

func _init() -> void: pass 

func _ready() -> void: pass

func location_discovered(location:String) -> bool: 
  return discovered_locations.has(location)

# adds location to current, if undiscovered adds to discovered
func set_fishing_location(window=null,type:String="Air") -> void:
  current_fishing_locations.append({
    "window": window,
    "type": type,
  })
  print(str("A line was cast into ", type, " from", window))
  if !location_discovered(type):
    discovered_locations.append(type)
    print(str(type, " has been discovered!"))
  if current_fishing_locations.size()>=Globals.amount_of_lines:
    Globals.cast_end.emit()
