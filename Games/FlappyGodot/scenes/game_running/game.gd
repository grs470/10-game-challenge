extends Node2D

@onready var player = $Player
@onready var canvas = $Foreground
@onready var generator = $Generator
@onready var initial_column = $"High Pass"
@onready var score_label = $Foreground/PanelContainer/MarginContainer/Score

var generic_menu = preload("res://Games/FlappyGodot/components/menus/generic/menu.tscn")

@onready var generic = generic_menu.instantiate()
var score = 0

# Overrides
func _ready():
	set_score_label()
	generic.connect("startPressed", _on_menu_start_pressed)
	generic.connect("restartPressed", _on_menu_restart_pressed)
	generic.connect("quitPressed", _on_menu_quit_pressed)
	connect_menu(generic.MenuType.START)

func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		show_pause_menu()


# Signal Functions
func _on_menu_start_pressed():
	disconnect_menu()

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
func connect_menu(type):
	get_tree().paused = true
	canvas.add_child(generic)
	generic.set_type(type, score)
	
func disconnect_menu():
	get_tree().paused = false
	canvas.remove_child(generic)

func show_game_over_screen():
	#game_over.connect("restartPressed", _on_menu_restart_pressed)
	#game_over.connect("quitPressed", _on_menu_quit_pressed)
	connect_menu(generic.MenuType.GAMEOVER)

func show_pause_menu():
	#pause.connect("startPressed", _on_menu_start_pressed)
	#pause.connect("restartPressed", _on_menu_restart_pressed)
	#pause.connect("quitPressed", _on_menu_quit_pressed)
	connect_menu(generic.MenuType.PAUSE)

func set_score_label():
	score_label.text = "Score: " + str(score)
