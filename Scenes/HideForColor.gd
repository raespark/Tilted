extends Node2D

export(int) var color_index_to_show

func _ready():
	if globalVars.color_index == color_index_to_show:
		hide()

func determine_if_show():
	if globalVars.color_index != color_index_to_show:
		show()
	else:
		hide()