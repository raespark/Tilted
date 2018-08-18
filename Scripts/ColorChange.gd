extends ColorRect

func _ready():
	print(globalVars)

func _change_color():
	self.color = globalVars.colors[globalVars.color_index]
