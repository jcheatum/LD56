extends Node2D

var enemies_attacking: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_damage_timer_timeout() -> void:
	$HealthBar.damage(10 * enemies_attacking)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Bug:
		enemies_attacking += 1


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area is Bug:
		enemies_attacking -= 1
