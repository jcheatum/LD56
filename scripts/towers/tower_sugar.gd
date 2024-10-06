class_name Sugar extends TowerBase

func _on_health_bar_empty() -> void:
	self.queue_free()
	
func eat_sugar(damage: float):
	$HealthBar.damage(damage * 5)
