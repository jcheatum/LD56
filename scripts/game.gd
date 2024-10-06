extends Node2D

signal finished
signal paused

var current_level: String

func _input(event):
	if self.visible && event.is_action_pressed("pause"):
		paused.emit()

func _on_pause_menu_return_to_menu():
	# Do some cleanup
	pass # Replace with function body.

func start_game():
	current_level = "level_1"
	$SceneManager.change_scene(current_level)
	$SceneManager.return_to_menu.connect(return_to_menu)
	
func return_to_menu():
	finished.emit()


func _on_lose_menu_exit() -> void:
	get_tree().paused = false
	finished.emit()


func _on_scene_manager_player_lost() -> void:
	get_tree().paused = true
	$LoseMenu.show()


func _on_lose_menu_retry() -> void:
	$SceneManager.change_scene(current_level)


func _on_scene_manager_scene_changed(scene_name: String) -> void:
	current_level = scene_name
