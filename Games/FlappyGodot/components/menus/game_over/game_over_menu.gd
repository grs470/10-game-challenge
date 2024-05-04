extends Control

signal restartPressed
signal quitPressed

@onready var label = $PanelContainer/MarginContainer/VBoxContainer/Score

func _on_quit_pressed():
	quitPressed.emit()

func _on_restart_pressed():
	restartPressed.emit()
