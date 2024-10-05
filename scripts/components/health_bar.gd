class_name HealthBar extends ProgressBar

# Emitted when the health bar hits 0
signal empty


# Do `value` percentage points of damage to this health bar
func damage(amount: float) -> void:
	self.value -= amount


func _on_value_changed(new_value: float) -> void:
	if new_value == 0:
		empty.emit()
