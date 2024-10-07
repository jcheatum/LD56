class_name Spray extends Flamethrower

#func ACTIVE_ENTER():
	#pass
#
#func ACTIVE_UPDATE(delta):
	#if FlameZone.has_overlapping_areas():
		#for collider in FlameZone.get_overlapping_areas():
			#if collider != null and collider.has_method("damage"):
				#$AnimatedSprite2D.frame = 1
				#collider.damage(damage*delta)

func flame_on():
	SfxPlayer.PlaySoundEffect(preload("res://assets/sfx/spray.wav"))
	print("FLAME ON!")
	Flame.visible = true
	timer = on_timer

func _on_area_exited(area: Area2D) -> void:
	if area is Bug:
		$AnimatedSprite2D.frame = 0
