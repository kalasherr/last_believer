extends Node2D
class_name Weapon
var cooldown = 1.0
var attack_power = 10.0
var spread = 20.0
var bullets_per_shot = 1
var range = 100
var explosion_chance = 0
var changed = false
func load_stats():
	pass

func _ready():
	load_stats()
	add_cooldown()
	Global.release_effects()

func attack():
	pass

func check_stats():
	pass

func add_cooldown():
	add_child(Timer.new())
	get_child(len(get_children()) - 1).name = "CooldownTimer"
	get_node("CooldownTimer").one_shot = true
