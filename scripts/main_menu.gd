extends Control

signal game_start
signal open_settings

# Called when the node enters the scene tree for the first time.
func _ready():
	$ButtonsContainer/Start.grab_focus()


func _on_start_pressed():
	game_start.emit()


func _on_settings_pressed():
	open_settings.emit()


func _on_exit_pressed():
	get_tree().quit()


func focus_settings():
	$ButtonsContainer/Settings.grab_focus()


func _on_pause_menu_return_to_menu():
	$ButtonsContainer/Start.grab_focus()
