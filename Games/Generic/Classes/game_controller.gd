class_name GameController extends Node2D

var generic_menu = preload("res://Games/Generic/components/menu/menu.tscn")

@onready var generic = generic_menu.instantiate()
var menu_canvas
@export var GAME_TITLE = "Title"
var input_dictionary = {}
var score = 0

func _init():
	# Build Controls
	for input in input_dictionary:
		var ev = InputEventKey.new()
		ev.keycode = input_dictionary[input]
		ev.pressed = true
		InputMap.add_action(input)
		InputMap.action_add_event(input, ev)

func _exit_tree():
	# Clean Up Controls
	for input in input_dictionary:
		InputMap.erase_action(input)

func _ready():
	menu_canvas = CanvasLayer.new()
	self.add_child(menu_canvas)
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

# Class Functions
func connect_menu(type):
	get_tree().paused = true
	menu_canvas.add_child(generic)
	generic.set_game_name(GAME_TITLE)
	generic.set_type(type, score)
	
func disconnect_menu():
	get_tree().paused = false
	menu_canvas.remove_child(generic)

func show_game_over_screen():
	connect_menu(generic.MenuType.GAMEOVER)

func show_pause_menu():
	connect_menu(generic.MenuType.PAUSE)
