class_name Spray extends Flamethrower

func ACTIVE_ENTER():
	pass

func ACTIVE_UPDATE(delta):
	if FlameZone.has_overlapping_areas():
		for collider in FlameZone.get_overlapping_areas():
			if collider != null and collider.has_method("damage"):
				collider.damage(damage*delta)
