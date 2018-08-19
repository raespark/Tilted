extends Area2D

func _physics_process(delta):
	var colliding_bodies = get_overlapping_bodies()
	for body in colliding_bodies:
		if body.get_groups().find("Player") != -1:
			globalVars.current_level += 1
			globalVars.music_time = get_parent().get_parent().find_node("Music").get_playback_position()
			get_tree().reload_current_scene()
