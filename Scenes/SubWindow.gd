extends Window

func _ready() -> void:
	print(self.name)
	print(self)
	self.close_requested.connect(Globals._swapSubWindow.bind(self.name, self))
