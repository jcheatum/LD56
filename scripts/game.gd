extends Node2D

signal finished
signal paused

func _input(event):
    if self.visible && event.is_action_pressed("pause"):
        paused.emit()