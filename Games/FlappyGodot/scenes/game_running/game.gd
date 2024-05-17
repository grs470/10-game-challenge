extends GameController

@onready var player = $Player
@onready var canvas = $Foreground
@onready var generator = $Generator
@onready var initial_column = $"High Pass"
@onready var score_label = $Foreground/PanelContainer/MarginContainer/Score

# Overrides
func _ready():
	set_score_label()
	super()

func _on_player_body_entered(_body):
	show_game_over_screen()

func _on_player_player_left_screen():
	show_game_over_screen()

func _on_score_zone_body_exited(_body):
	score += 1
	set_score_label()

# Class Functions
func set_score_label():
	score_label.text = "Score: " + str(score)
