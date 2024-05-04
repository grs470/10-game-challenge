extends Control

signal startPressed
signal restartPressed
signal quitPressed

func _on_start_pressed():
	startPressed.emit()

func _on_quit_pressed():
	quitPressed.emit()

func _on_restart_pressed():
	restartPressed.emit()
