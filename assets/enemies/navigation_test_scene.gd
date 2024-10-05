extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Ant.set_target($Target.position)
	$Roach.set_target($Target.position)
	$Fly.set_target($Target.position)

var time = 0
var do_damage = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	if int(time) % 5 == 0 && do_damage:
		do_damage = false
		if $Ant: $Ant.damage(10)
	elif int(time) % 5 == 1:
		do_damage = true
