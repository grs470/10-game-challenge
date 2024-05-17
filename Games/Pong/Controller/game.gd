extends GameController

@onready var player1 = $Player1

# Overrides
func _init():
	input_dictionary = {
		"player_1_up": KEY_W,
		"player_1_down": KEY_S,
		"player_2_up": KEY_UP,
		"player_2_down": KEY_DOWN,
	}
	score = 0
	super()
