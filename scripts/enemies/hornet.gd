class_name Hornet extends Bug


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.navigator = $NavigationAgent2D
	self.health_bar = $HealthBar
	self.direction_container = $Sprite2D


# Ants die when they are killed
func _on_health_bar_empty() -> void:
	die()
