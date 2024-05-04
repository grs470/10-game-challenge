extends Node

signal column_spawned(column)
signal column_despawn(column)

var empty_column = preload("res://Games/FlappyGodot/components/columns/empty_column/empty_column.tscn")

func _on_timer_timeout():
	print("timer called")
	spawn_column()


func spawn_column():
	var viewport_size = get_viewport().size
	var hight_offset = randi_range(0, viewport_size.y)
	
	var column = empty_column.instantiate()
	column.connect("column_despawned", on_column_despawn)
	add_child(column)
	column.global_position = Vector2(viewport_size.x, 0)
	column.create(hight_offset, viewport_size.y)
	
	column_spawned.emit(column)

func on_column_despawn(column):
	column_despawn.emit(column)

func stop():
	$Timer.set_paused(true)
	
func start():
	$Timer.set_paused(false)
