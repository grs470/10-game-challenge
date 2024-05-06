extends Control

signal startPressed
signal quitPressed

func _on_start_pressed():
	startPressed.emit()

func _on_quit_pressed():
	quitPressed.emit()
