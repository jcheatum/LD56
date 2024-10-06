class_name Market extends Control

@export var initial_money: int
@export var enable_market: bool

@onready var money: int = initial_money

func _process(_delta):
	$MoneyLabel.text = "$" + str(money)
