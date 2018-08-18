extends Node2D

export(int) var color_index_to_hide

func _ready():
	if globalVars.color_index != color_index_to_hide:
		hide()

func determine_if_show():
	if globalVars.color_index == color_index_to_hide:
		show()
	else:
		hide()