class_name Bug extends Area2D

@export var speed: float = 70.0
var navigator: NavigationAgent2D
var velocity: Vector2 = Vector2.ZERO
var health_bar: HealthBar

func _physics_process(delta: float) -> void:
	# Update velocity according to navigation and move
	var direction = navigator.get_next_path_position() - global_position
	velocity = Global.exp_decay(velocity, direction.normalized() * speed, 16, delta)
	navigator.set_velocity(velocity)
	self.position += velocity * delta


# Sets the navigation target for this bug to `location`
func set_target(location: Vector2) -> void:
	navigator.target_position = location


# Pretty self explanitory
func die() -> void:
	self.queue_free()


# Do `value` points of damage to this bug
func damage(value: float) -> void: 
	health_bar.damage(value)
