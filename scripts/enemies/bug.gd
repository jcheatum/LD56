class_name Bug extends Area2D

signal bug_died(bug_type: String, position: Vector2)

@export var speed: float = 70.0
@export var burn_damage: float = 10.0
var navigator: NavigationAgent2D
@onready var velocity: Vector2 = Vector2.ZERO
@onready var slowed_speed: float = speed * 0.5
@onready var unslowed_speed: float = speed
var health_bar: HealthBar
var direction_container
var burned: bool = false
var bug_type: String = "Ant"

func _physics_process(delta: float) -> void:
	for area in get_overlapping_areas():
		if area is Sugar and area.is_active():
			area.eat_sugar(delta)
			return
		elif area.owner != null and area.owner is PicnicBasket:
			return
	# Update velocity according to navigation and move
	var direction = navigator.get_next_path_position() - global_position
	velocity = Global.exp_decay(velocity, direction.normalized() * speed, 16, delta)
	navigator.set_velocity(velocity)
	self.position += velocity * delta
	if velocity.x < 0:
		direction_container.flip_h = false
	elif velocity.x > 0:
		direction_container.flip_h = true
	# Burn damage
	if burned:
		damage(burn_damage*delta)
	# z index
	z_as_relative = false
	z_index = global_position.y


# Sets the navigation target for this bug to `location`
func set_target(location: Vector2) -> void:
	navigator.target_position = location


# Pretty self explanitory
func die() -> void:
	bug_died.emit(self.bug_type, position)
	SfxPlayer.PlaySoundEffect(preload("res://assets/sfx/bug_death.wav"))
	self.queue_free()

# Do `value` points of damage to this bug
func damage(value: float) -> void: 
	health_bar.damage(value)
	
func slow(seconds: float):
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = seconds
	timer.start()
	timer.timeout.connect(unslow)
	speed = slowed_speed
		
func unslow():
	speed = unslowed_speed

func burn(seconds: float):
	if !burned:
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = seconds
		timer.start()
		timer.timeout.connect(unburn)
		burned = true
		direction_container.modulate = Color.RED
		SfxPlayer.PlaySoundEffect(preload("res://assets/sfx/sizzle.wav"),0.25,2)
		
func unburn():
	burned = false
	direction_container.modulate = Color.WHITE
