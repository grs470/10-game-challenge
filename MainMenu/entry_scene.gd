extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Force Unpause, if returning from a game that was in a paused state
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_flappy_godot_pressed():
	SceneTransition.change_scene("res://Games/FlappyGodot/scenes/game_running/game.tscn")


func _on_quit_pressed():
	get_tree().quit()
