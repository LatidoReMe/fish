extends Node
class_name WindowManager

var viewport : Viewport
var data : Dictionary # [id, title, size, position, z-index but for window (focus?)]
var count : int = 0

func _init(_viewport:Viewport) -> void:
  viewport=_viewport

func _ready() -> void:
  data=get_current_data()
  count=data.size()
  print(str(count))
  print("wm gttn rdy")

func evaluate_windows(args:Dictionary={}) -> void:
  for keys in args:
    pass
  get_window_count()
  # data=get_current_data()
  # if(viewport.get_embedded_subwindows().size()!=count):
  #   count=data.size()
  #   print(data)
  #   print(count)
  var _sw_positions : Dictionary = {}
  var overlapping : Array
  for key in data.keys():
    print(key)
    _sw_positions[key]=Rect2(data[key][2],data[key][1])
    print(_sw_positions)
  # seperate by body types
  # for each body type arr
  for rect in _sw_positions:
    pass
  #   # get list of same body type
  #   for rect2 in _sw_positions:
  #     if rect.value.intersects(rect2.value):
  #       overlapping.append(rect2.key())

func get_window_count() -> void:
  data=get_current_data()
  count=data.size()
  print(data)
  print(count)

func get_current_data() -> Dictionary:
  var _sw_data : Dictionary = {}
  for _window in viewport.get_embedded_subwindows():
    _sw_data[_window.get_instance_id()]=[_window.type, _window.size, _window.position]
  print_rich(_sw_data)
  return _sw_data
