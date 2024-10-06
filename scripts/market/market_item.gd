class_name MarketItem extends Button

@export var tower_path: String
@export var cost: int
@export var sell_value: int

@onready var tower_scene: Resource = load(tower_path)
@onready var market: Market = $".."

func _on_button_down() -> void:
	if market.enable_market and market.money >= cost:
		var instance = tower_scene.instantiate()
		instance.sell_tower.connect(_on_sell_tower)
		instance.place_tower.connect(_on_place_tower)
		instance.pickup_tower.connect(_on_pickup_tower)
		owner.add_sibling(instance)
		market.money -= cost

func _on_sell_tower():
	if market.enable_market:
		market.money += sell_value

func _on_place_tower():
	market.enable_market = true
	
func _on_pickup_tower():
	market.enable_market = false
