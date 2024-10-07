class_name Market extends Control

@export var initial_money: int
@export var enable_market: bool

@onready var money: int = initial_money

func _ready():
	$TowerInfoPanel/Name.text = ""
	$TowerInfoPanel/Cost.text = ""
	$TowerInfoPanel/SellPrice.text = ""
	$TowerInfoPanel/Description.text = ""

func _process(_delta):
	$MoneyLabel.text = "$" + str(money)

func show_tower_info(name: String, cost: int, sell_price: int, description: String):
	$TowerInfoPanel/Name.text = name
	$TowerInfoPanel/Cost.text = "Cost: $" + str(cost)
	$TowerInfoPanel/SellPrice.text = "Sell Price: $" + str(sell_price)
	$TowerInfoPanel/Description.text = description

func set_background_texture(index: int):
	index = index % 3
	$TextureRect.texture.region.position.x = index * $TextureRect.texture.region.size.x
