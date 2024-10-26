extends Node2D
class_name Weapon
var cooldown = 1.0
var attack_power = 10.0
var spread = 20.0
var bullets_per_shot = 1
var range = 100
func load_stats():
	pass

func _ready():
	add_cooldown()
	load_stats()

func attack():
	pass

func check_stats():
	pass

func add_cooldown():
	add_child(Timer.new())
	get_child(len(get_children()) - 1).name = "CooldownTimer"
	get_node("CooldownTimer").one_shot = true
