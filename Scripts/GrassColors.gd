extends Sprite
func _ready():
	_change_color()

func _change_color():
	self.modulate = globalVars.colors[globalVars.color_index]