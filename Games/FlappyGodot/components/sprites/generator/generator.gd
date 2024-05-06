extends Node

var empty_column = preload("res://Games/FlappyGodot/components/columns/empty_column/empty_column.tscn")

func _on_timer_timeout():
	spawn_column()


func spawn_column():
	var viewport_size = get_viewport().size
	var hight_offset = randi_range(0, viewport_size.y)
	
	var column = empty_column.instantiate()
	add_child(column)
	column.global_position = Vector2(viewport_size.x, 0)
	column.create(hight_offset, viewport_size.y)
