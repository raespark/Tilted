extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	var colliding_bodies = get_overlapping_bodies()
	for body in colliding_bodies:
		if body.get_groups().find("Player") != -1:
			globalVars.current_level += 1
			globalVars.music_time = get_parent().get_parent().find_node("Music").get_playback_position()
			get_tree().change_scene("res://Scenes/" + globalVars.levels[globalVars.current_level])
