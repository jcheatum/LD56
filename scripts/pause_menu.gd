extends Control

signal resume
signal open_settings
signal return_to_menu
signal restart_level


func _on_resume_pressed():
	SfxPlayer.PlaySoundEffect(preload("res://assets/sfx/ui_select.wav"))
	resume.emit()


func _on_settings_pressed():
	SfxPlayer.PlaySoundEffect(preload("res://assets/sfx/ui_select.wav"))
	open_settings.emit()


func _on_to_menu_pressed():
	SfxPlayer.PlaySoundEffect(preload("res://assets/sfx/ui_select.wav"))
	return_to_menu.emit()


func _on_quit_pressed():
	SfxPlayer.PlaySoundEffect(preload("res://assets/sfx/ui_select.wav"))
	get_tree().quit()


func focus_settings():
	$ButtonsContainer/Settings.grab_focus()


func _on_restart_pressed() -> void:
	SfxPlayer.PlaySoundEffect(preload("res://assets/sfx/ui_select.wav"))
	get_tree().paused = false
	hide()
	restart_level.emit()

func _on_visibility_changed() -> void:
	SfxPlayer.PlaySoundEffect(preload("res://assets/sfx/ui_select.wav"))
