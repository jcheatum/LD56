extends Node2D

signal finished
signal paused

func _input(event):
	if self.visible && event.is_action_pressed("pause"):
		paused.emit()

func _on_pause_menu_return_to_menu():
	# Do some cleanup
	pass # Replace with function body.
