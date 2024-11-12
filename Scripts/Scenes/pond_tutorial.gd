extends RichTextLabel

func _ready():
	visible = Globals.total_fish_caught > 0 and Globals.total_locations_discovered <= 0
	if  Globals.total_locations_discovered <= 0:
		Globals.fish_caught.connect(_show_tutorial)

func _show_tutorial(_delta):
	visible = Globals.total_fish_caught > 0 and Globals.total_locations_discovered <= 0
	Globals.fish_caught.disconnect(_show_tutorial)
