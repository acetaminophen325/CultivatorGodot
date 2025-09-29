extends Node

var inventory: Dictionary = {}  # {item_id: qty}
var coins: int = 0
var cultivation_xp: int = 0
var known_recipes: Array[String] = []  # fill later

func add_item(id: String, qty: int = 1) -> void:
	inventory[id] = inventory.get(id, 0) + qty

func has_items(req: Array) -> bool:
	# req: [ {"item":"herb","qty":1}, ... ]
	for r in req:
		if inventory.get(r.item, 0) < r.qty:
			return false
	return true

func remove_items(req: Array) -> void:
	for r in req:
		var left = inventory.get(r.item, 0) - r.qty
		if left <= 0:
			inventory.erase(r.item)
		else:
			inventory[r.item] = left

func add_coins(amount: int) -> void:
	coins += amount

func add_xp(amount: int) -> void:
	cultivation_xp += amount
