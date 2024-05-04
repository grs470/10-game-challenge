extends RigidBody2D

var up_force = -350
var max_speed = 1000

signal player_left_screen

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	
func _physics_process(_delta):
	
	linear_velocity = linear_velocity.clamp(
		Vector2(0, -max_speed),
		Vector2(0, max_speed)
	)
	
	if Input.is_action_just_pressed("Flap"):
		apply_impulse(Vector2(0, up_force))

func _on_visible_on_screen_notifier_2d_screen_exited():
	player_left_screen.emit()
