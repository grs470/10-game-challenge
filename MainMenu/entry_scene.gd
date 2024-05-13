extends Node2D

@onready var button_container = $CanvasLayer/MainMenu/HBoxContainer/VBoxContainer/VBoxContainer/ButtonContainer

const QUIT_STATE_TITLE = "Quit"

# Dictionary of game/targets for button control
var game_dict = {
	"Flappy Godot": "res://Games/FlappyGodot/scenes/game_running/game.tscn",
	"GoPong": "res://Games/Pong/Controller/game.tscn",
	QUIT_STATE_TITLE: null,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	for game in game_dict:
		var new_button = generate_game_button(game)
		button_container.add_child(new_button)
	
	# Force Unpause, if returning from a game that was in a paused state
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_menu_button_pressed(target:String):
	# Exit on Quit State
	if target == QUIT_STATE_TITLE:
		get_tree().quit()
	
	var target_scene = game_dict.get(target)
	# Error on Null
	if target_scene == null:
		# TODO: Add Error Popup
		print("Error, game not found attached")
		return
	
	SceneTransition.change_scene(game_dict[target])

func generate_game_button(game_title:String) -> Button:
		var button = Button.new()
		button.text = game_title
		button.pressed.connect(
			_on_menu_button_pressed.bind(game_title)
		)
		return button
