extends Node2D

@onready var player = $Player
@onready var canvas = $Foreground
@onready var generator = $Generator
@onready var initial_column = $"High Pass"
@onready var score_label = $Foreground/Score

var pause_menu = preload("res://Games/FlappyGodot/components/menus/pause/menu.tscn")
var game_over_menu = preload("res://Games/FlappyGodot/components/menus/game_over/game_over_menu.tscn")

var pause
var game_over
var score = 0


# Overrides
func _ready():
	set_score_label()
	pause = pause_menu.instantiate()
	pause.connect("startPressed", _on_menu_start_pressed)
	pause.connect("restartPressed", _on_menu_restart_pressed)
	pause.connect("quitPressed", _on_menu_quit_pressed)
	connect_menu(pause)

func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		connect_menu(pause)


# Signal Functions
func _on_menu_start_pressed():
	disconnect_menu(pause)

func _on_menu_quit_pressed():
	SceneTransition.change_scene("res://MainMenu/entry_scene.tscn")

func _on_menu_restart_pressed():
	get_tree().reload_current_scene()

func _on_player_body_entered(_body):
	show_game_over_screen()

func _on_player_player_left_screen():
	show_game_over_screen()

func _on_score_zone_body_exited(_body):
	score += 1
	set_score_label()

# Class Functions
func connect_menu(menu):
	get_tree().paused = true
	canvas.add_child(menu)
	
func disconnect_menu(menu):
	get_tree().paused = false
	canvas.remove_child(menu)

func show_game_over_screen():
	#generator.stop()
	game_over = game_over_menu.instantiate()
	game_over.connect("restartPressed", _on_menu_restart_pressed)
	game_over.connect("quitPressed", _on_menu_quit_pressed)
	connect_menu(game_over)
	game_over.label.text = "Score: " + str(score)

func set_score_label():
	score_label.text = "Score: " + str(score)
