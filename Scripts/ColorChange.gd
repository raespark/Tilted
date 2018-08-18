extends ColorRect
func _ready():
	_change_color()

func _change_color():
	self.color = globalVars.colors[globalVars.color_index]
