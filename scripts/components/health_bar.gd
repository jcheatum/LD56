class_name HealthBar extends ProgressBar

signal empty


func damage(value: float) -> void:
	self.value -= value


func _on_value_changed(value: float) -> void:
	if value == 0:
		empty.emit()
