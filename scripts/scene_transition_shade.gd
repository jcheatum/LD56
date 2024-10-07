extends Node2D

signal entrance_finished
signal exit_finished


func enter() -> void:
	$AnimationPlayer.play("enter")
	

func exit() -> void:
	$AnimationPlayer.play("exit")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "enter":
		entrance_finished.emit()
	elif anim_name == "exit":
		exit_finished.emit()
