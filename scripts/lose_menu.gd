extends Control

signal retry
signal exit

func _on_exit_pressed() -> void:
	exit.emit()


func _on_retry_pressed() -> void:
	hide()
	get_tree().paused = false
	retry.emit()
