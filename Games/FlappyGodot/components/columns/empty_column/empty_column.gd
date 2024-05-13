extends RigidBody2D

@onready var top_collision = $TopCollision
@onready var top_poly = $TopPoly
@onready var bottom_collision = $BottomCollision
@onready var bottom_poly = $BottomPoly

var opening_size = 200
var column_width = 100

signal column_despawned(column)

func _ready():
	pass

func create(vertical_offset : int, view_max : int):
	if vertical_offset + opening_size > view_max:
		vertical_offset = view_max - opening_size

	var top_vector_array = [
		Vector2(0, 0),
		Vector2(0, vertical_offset),
		Vector2(column_width, vertical_offset),
		Vector2(column_width, 0)
	]
	var bottom_vector_array = [
		Vector2(0, vertical_offset + opening_size),
		Vector2(0, view_max),
		Vector2(column_width, view_max),
		Vector2(column_width, vertical_offset + opening_size)
	]
	top_collision.polygon = top_vector_array
	top_poly.polygon = top_vector_array
	bottom_collision.polygon = bottom_vector_array
	bottom_poly.polygon = bottom_vector_array


func _on_visible_on_screen_notifier_2d_screen_exited():
	column_despawned.emit(self)
	await get_tree().create_timer(1).timeout
	queue_free()
