extends Area2D

@onready var screen_size_y = get_viewport_rect().size.y

@export var player_side = "player_1"
@export var bounce_direction = 1

const speed := 350.0
const offset := 80

var direction := 0.0
var up_input: String
var down_input: String

func _ready():
	up_input = player_side + "_up"
	down_input = player_side + "_down"

func _physics_process(delta):
	get_input()
	var adjusted_speed = (speed * direction * delta)
	position.y = clamp(
		position.y + adjusted_speed,
		offset,
		screen_size_y-offset
	)

func get_input():
	direction = Input.get_axis(up_input, down_input)


func _on_area_entered(area):
	if (area.name == "Ball"):
		area.direction = (Vector2(0, area.direction.y) + Vector2(bounce_direction, direction)).normalized()
