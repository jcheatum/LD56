extends Control

signal exit

func _on_exit_pressed() -> void:
	exit.emit()
