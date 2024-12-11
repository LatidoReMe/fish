extends Node

@onready var path2d = $CL/Path2D
@onready var cave_follow = $CL/Path2D/PathFollow2D
@onready var cave_btn = $CL/Path2D/PathFollow2D/TextureButton
@onready var water = $CL/Parallax2D/AnimatedSprite2D
@onready var pxbg = $CL/Parallax2D
@onready var parent_ww : WaterWindow = get_parent()
@onready var parent_id = parent_ww.get_instance_id()

func _ready() -> void:
  Globals.waterwindow_resized.connect(_on_resize)
  pxbg.position=get_viewport().get_visible_rect().size/2
  set_bg_pos_repeat()

func _on_resize(args:Dictionary):
  set_bg_pos_repeat()
  pxbg.autoscroll=Vector2(0,0)
  path2d.curve=null
  cave_btn.visible=false
  cave_follow.progress_ratio=0.0
  cave_follow.progress=0
  if args.has("win_id") and args["win_id"]==parent_id:
    if parent_ww.type=="Waterfall":
      pxbg.autoscroll=Vector2(0,1250)
      path2d.curve=make_curve()
      cave_btn.visible=true
    elif parent_ww.type=="Ravine" or parent_ww.type=="River":
      pxbg.autoscroll=Vector2(1250,0)
    elif parent_ww.type=="Ocean" or parent_ww.type=="Sea":
      pxbg.autoscroll=Vector2(15,75)
  
func make_curve() -> Curve2D:
  var curve = Curve2D.new()
  curve.bake_interval=50
  var window_size=get_viewport().get_visible_rect().size
  for y in roundf(fmod(window_size.y,50)):
    if y*50 >= window_size.y:
      break
    curve.add_point(Vector2(randi_range(0,window_size.x),y*50))
  curve.add_point(Vector2(randi_range(0,window_size.x),window_size.y))
  return curve

func set_bg_pos_repeat() -> void:
  water.position=get_viewport().get_visible_rect().size/2

  #changing this is slow, maybe keeping at max screen size better?
  if water.position.x>water.position.y:
    pxbg.repeat_times=roundi(get_viewport().size.x/35)
  else:
    pxbg.repeat_times=roundi(get_viewport().size.y/35)

func _physics_process(delta):
  if cave_btn.visible:
    cave_follow.progress_ratio=cave_follow.progress_ratio + (delta * .2)
