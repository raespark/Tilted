extends Sprite
func _ready():
	_change_color()

func _change_color():
	self.modulate = globalVars.dark_colors[globalVars.color_index]
