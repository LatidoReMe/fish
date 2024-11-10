extends Sprite2D

@onready var hooked : AudioStreamPlayer = get_node("/root/Game Background Node/Hooked")

func _hooked():	
	hooked.play()
