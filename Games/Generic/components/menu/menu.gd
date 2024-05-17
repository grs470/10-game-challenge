extends Control

signal startPressed
signal restartPressed
signal quitPressed

@onready var label = $PanelContainer/MarginContainer/VBox/Label
@onready var start_button = $PanelContainer/MarginContainer/VBox/HBox/Start
@onready var restart_button = $PanelContainer/MarginContainer/VBox/HBox/Restart

var game_name = "Testing"

enum MenuType {START, PAUSE, GAMEOVER}

func set_game_name(game_name:String):
	print("name change")
	self.game_name = game_name

func _on_start_pressed():
	startPressed.emit()

func _on_restart_pressed():
	restartPressed.emit()
	
func _on_quit_pressed():
	quitPressed.emit()


func set_type(type:MenuType, score:int):
	match type:
		MenuType.START:
			print("START")
			label.text = game_name
			restart_button.visible = false
			start_button.visible = true
		MenuType.PAUSE:
			print("PAUSE")
			label.text = "Game Paused"
			restart_button.visible = true
			start_button.visible = true
		MenuType.GAMEOVER:
			print("GAMEOVER")
			label.text = "Score: " + str(score)
			restart_button.visible = true
			start_button.visible = false
