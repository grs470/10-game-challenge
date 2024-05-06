extends Node2D

@onready var player = $Player
@onready var canvas = $Foreground
@onready var generator = $Generator
@onready var initial_column = $"High Pass"
@onready var score_label = $Foreground/PanelContainer/MarginContainer/Score

var start_menu = preload("res://Games/FlappyGodot/components/menus/start/menu.tscn")
var pause_menu = preload("res://Games/FlappyGodot/components/menus/pause/menu.tscn")
var game_over_menu = preload("res://Games/FlappyGodot/components/menus/game_over/game_over_menu.tscn")

@onready var pause = pause_menu.instantiate()
@onready var game_over = game_over_menu.instantiate()
@onready var start = start_menu.instantiate()
var score = 0
var current_menu

# Overrides
func _ready():
	set_score_label()
	start.connect("startPressed", _on_menu_start_pressed)
	start.connect("quitPressed", _on_menu_quit_pressed)
	connect_menu(start)

func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		show_pause_menu()


# Signal Functions
func _on_menu_start_pressed():
	disconnect_menu(current_menu)

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
	current_menu = menu
	get_tree().paused = true
	canvas.add_child(menu)
	
func disconnect_menu(menu):
	current_menu = null
	get_tree().paused = false
	canvas.remove_child(menu)

func show_game_over_screen():
	game_over.connect("restartPressed", _on_menu_restart_pressed)
	game_over.connect("quitPressed", _on_menu_quit_pressed)
	connect_menu(game_over)
	game_over.label.text = "Score: " + str(score)

func show_pause_menu():
	pause.connect("startPressed", _on_menu_start_pressed)
	pause.connect("restartPressed", _on_menu_restart_pressed)
	pause.connect("quitPressed", _on_menu_quit_pressed)
	connect_menu(pause)

func set_score_label():
	score_label.text = "Score: " + str(score)
