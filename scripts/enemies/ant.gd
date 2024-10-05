extends Bug


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.navigator = $NavigationAgent2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_health_bar_empty() -> void:
	die()
