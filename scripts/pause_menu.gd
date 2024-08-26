extends Control

signal resume
signal open_settings
signal return_to_menu


func _on_resume_pressed():
	resume.emit()


func _on_settings_pressed():
	open_settings.emit()


func _on_to_menu_pressed():
	return_to_menu.emit()


func _on_quit_pressed():
	get_tree().quit()


func focus_settings():
	$ButtonsContainer/Settings.grab_focus()
