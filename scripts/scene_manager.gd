extends Node2D

signal return_to_menu

var scenes: Dictionary
var active_scene: Node2D = null

func _ready():
	# List Scenes
	scenes["test_level"] = preload("res://assets/game/levels/test_level.tscn")

func change_scene(scene_name: String):
	assert(scenes.has(scene_name), "Scene " + scene_name + " not found in SceneManager!")
	var instance: Node2D = scenes[scene_name].instantiate()
	add_child(instance)
	if (active_scene != null):
		active_scene.queue_free()
	active_scene = instance
	active_scene.change_scene.connect(change_scene)
	active_scene.return_to_main_menu.connect(return_to_main_menu)
	
func return_to_main_menu():
	return_to_menu.emit()
