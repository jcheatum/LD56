class_name Sugar extends TowerBase

func _on_health_bar_empty() -> void:
	self.queue_free()
	
func eat_sugar(damage: float):
	$HealthBar.damage(damage * 5)
	var interval = $HealthBar.max_value / 6
	if $HealthBar.value < interval:
		$AnimatedSprite2D.frame = 5
	elif $HealthBar.value < 2 * interval:
		$AnimatedSprite2D.frame = 4
	elif $HealthBar.value < 3 * interval:
		$AnimatedSprite2D.frame = 3
	elif $HealthBar.value < 4 * interval:
		$AnimatedSprite2D.frame = 2
	elif $HealthBar.value < 5 * interval:
		$AnimatedSprite2D.frame = 1
	else:
		$AnimatedSprite2D.frame = 0
