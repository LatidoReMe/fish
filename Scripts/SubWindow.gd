extends Window
class_name SubWindow

@export var scene : PackedScene

func _init(_name:String="SubWindow",_title:String="",_scene:PackedScene=null) -> void:
	max_size=Vector2i(1260,700)
	min_size=Vector2i(400,400)
	name=_name
	position=Vector2i(50,50)
	size=Vector2i(400,400)
	title=_title
	scene=_scene
	
func _ready() -> void:
	if scene:
		var node=scene.instantiate()
		self.add_child(node)
	self.close_requested.connect(self.queue_free)
