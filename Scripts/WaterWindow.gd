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

var type : String
var resize_timer : Timer = Timer.new()
var default_size : Vector2i = Vector2i(200, 200)

#from scene
var path2d : Path2D
var cave_btn : TextureButton

func _init(_name="WaterWindow", _title="Pond", _scene=preload("res://Scenes/WaterWindowInner.tscn")) -> void:
  super(str(_name,self.get_instance_id()), _title, _scene)
  type=_title
  min_size = Vector2i(100,100)
  size = Vector2i(200, 200)

func _ready() -> void:
  super()
  var center_screen = get_tree().get_root().get_visible_rect().size / 2
  position=Vector2i(center_screen.x-size.x/2,center_screen.y-size.y/2)
  resize_timer.one_shot=true
  add_child(resize_timer)
  tree_exiting.connect(_on_drain)
  tree_exited.connect(Globals.waterwindow_in_out.emit)
  size_changed.connect(while_resize)
  resize_timer.timeout.connect(_resized)

func _on_in_out() -> void:
  Globals.waterwindow_in_out.emit()
  print("nnout")

func _input(event: InputEvent) -> void:
  if Input.get_current_cursor_shape()==13 or Input.get_current_cursor_shape()==6:
    Globals.waterwindow_moved.emit()
    print("mooove")

# since size_changed fires off a ton, limit function call to half a sec
func while_resize():
  title="???"
  resize_timer.start(.5)
  size_changed.disconnect(while_resize)

func _resized() -> void:
  title=get_current_type()
  type=title
  Globals.waterwindow_resized.emit({"win_id": get_instance_id()})
  size_changed.connect(while_resize)

func get_current_type() -> String:
  var _size_wh_ratio = size.x / size.y
  var _size_hw_ratio = size.y / size.x
  var deep_water_conditions : Array[Array] = [
    [_size_wh_ratio >= 4.0, "Ravine"],
    [size>=5*default_size, "Abyss"],
    [size>=2*default_size, "Sea"],
    [size<=default_size/2, "Well"]
  ]
  var water_conditions : Array[Array] = [
    [_size_wh_ratio >= 4.0, "River"],
    [size>=5*default_size, "Ocean"],
    [_size_hw_ratio >= 4.0, "Waterfall"],
    [size>=default_size*2, "Lake"],
    [size<=default_size/2, "Puddle"]
  ]
  if type in deep_water_bodies:
    for arr in deep_water_conditions:
      if arr[0]:
        return arr[1]
    return "Deep Pond"
  if type in water_bodies:
    for arr in water_conditions:
      if arr[0]:
        return arr[1]
  return "Pond"

func _on_drain() -> void:
  print("draining")
  size_changed.disconnect(while_resize) #will throw minor error elsewise
