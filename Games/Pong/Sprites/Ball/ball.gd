extends Area2D

var direction := Vector2(-1, 0)
var speed = 250

#func _ready():
	#linear_velocity = Vector2(-1, 0)
#
func _physics_process(delta):
	position += speed * delta * direction
