class_name PicnicBasket extends Node2D

var enemies_attacking: int = 0

signal dead

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_damage_timer_timeout() -> void:
	$HealthBar.damage(10 * enemies_attacking)
	if enemies_attacking > 0: SfxPlayer.PlaySoundEffect(preload("res://assets/sfx/bite.wav"))
	$AnimatedSprite2D.frame = ceil(($HealthBar.value/$HealthBar.max_value) * 5)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Bug:
		enemies_attacking += 1


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area is Bug:
		enemies_attacking -= 1


func _on_health_bar_empty() -> void:
	dead.emit()
