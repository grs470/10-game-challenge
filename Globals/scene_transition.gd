extends CanvasLayer

signal after_scene_change

# source: https://www.youtube.com/watch?v=yZQStB6nHuI

func change_scene(target: String) -> void:
	$AnimationPlayer.play("dissolve")

	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	
	$AnimationPlayer.play_backwards("dissolve")

	after_scene_change.emit()
