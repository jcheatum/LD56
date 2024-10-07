class_name Market extends Control

@export var initial_money: int
@export var enable_market: bool

@onready var money: int = initial_money

func _ready():
	$TowerInfoPanel/Container/Name.text = ""
	$TowerInfoPanel/Container/Cost.text = ""
	$TowerInfoPanel/Container/SellPrice.text = ""
	$TowerInfoPanel/Container/Description.text = ""

func _process(_delta):
	$MoneyLabel.text = "$" + str(money)

func show_tower_info(name: String, cost: int, sell_price: int, description: String):
	$TowerInfoPanel/Container.show()
	$TowerInfoPanel/Controls.hide()
	$TowerInfoPanel/Container/Name.text = name
	$TowerInfoPanel/Container/Cost.text = "Cost: $" + str(cost)
	$TowerInfoPanel/Container/SellPrice.text = "Sell Price: $" + str(sell_price)
	$TowerInfoPanel/Container/Description.text = description

func set_background_texture(index: int):
	index = index % 3
	$TextureRect.texture.region.position.x = index * $TextureRect.texture.region.size.x


func _on_market_item_mouse_exited() -> void:
	$TowerInfoPanel/Container.hide()
	$TowerInfoPanel/Controls.show()
