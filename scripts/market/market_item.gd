class_name MarketItem extends Button

@export var tower_path: String
@export var tower_name: String
@export var cost: int
@export var sell_value: int
@export var tower_desc: String

@onready var tower_scene: Resource = load(tower_path)
@onready var market: Market = $".."

var sold: bool = false

func _process(_delta):
	sold = false

func _on_button_down() -> void:
	if market.enable_market and market.money >= cost:
		var instance = tower_scene.instantiate()
		instance.sell_tower.connect(_on_sell_tower)
		instance.place_tower.connect(_on_place_tower)
		instance.pickup_tower.connect(_on_pickup_tower)
		owner.add_sibling(instance)
		print(name + ": create tower")
		market.money -= cost
		SfxPlayer.PlaySoundEffect(preload("res://assets/sfx/buy_tower.wav"))

func _on_sell_tower():
	if !sold:
		print("Sold tower: +$" + str(sell_value))
		market.money += sell_value
		sold = true

func _on_place_tower():
	market.enable_market = true
	
func _on_pickup_tower():
	market.enable_market = false

func _on_mouse_entered() -> void:
	market.show_tower_info(tower_name,cost,sell_value,tower_desc)
