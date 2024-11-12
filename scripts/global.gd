extends Node
var remaining_buffs = []
var remaining_debuffs = []
var active_effects = []
var current_floor = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if len(remaining_debuffs) < 6 :
		refill_debuff_array()
	if len(remaining_buffs) < 2:
		refill_buff_array()
func release_effects():
	var main_scene = get_parent().get_node("MainGameScene")
	var player = main_scene.get_node("Player")
	var weapon = player.get_node("Weapon").get_child(0)
	weapon.load_stats()
	for effect in active_effects:
		if effect == "Silver bullets: + 4 damage":
			weapon.attack_power += 2
		if effect == "Faith surge: + 15% movespeed":
			player.speed *= 1.15
			weapon.cooldown *= 0.92
		if effect == "Reload blessing: + 25% fire rate":
			weapon.cooldown *= 0.8
		if effect == "Sawed-off: + damage, + bullets, + spread, - range":
			weapon.attack_power += 2
			weapon.range *= 0.6
			weapon.bullets_per_shot += 1
			if weapon.spread < 90:
				weapon.spread *= 2
			else:
				weapon.spread = 180
		if effect == "Prophet: any damage kills you, + 200% damage":
			player.hp = 1
			weapon.attack_power *= 2
		if effect == "Sniper shotgun: + 100% range, - 20% spread":
			weapon.range *= 1.5
			weapon.spread *= 0.5
			weapon.attack_power += 1
		if effect == "Holy bomb: bullets have 10% chance to explode":
			weapon.explosion_chance += 10
		
		if effect == "Devil's extension: + 20 sec to floor timer":
			main_scene.level_timer += 10
			main_scene.get_node("Timers/LevelTimer").start(main_scene.level_timer)
		if effect == "Unholy duplication: + 50% spawnrate":
			main_scene.spawn_timer *= 0.80
		if effect == "Imps: add ranged mobs":
			main_scene.imp_chance += 20
		if effect == "Prayerproof: + 30% enemies hp":
			main_scene.enemy_hp_multiplier *= 1.2
		if effect == "Blazing speed: + 20% enemies speed":
			main_scene.enemy_speed_multiplier *= 1.15
		if effect == "Fan shooter: + 50% damage, + 200% spread":
			weapon.attack_power *= 1.3
			if weapon.spread < 60:
				weapon.spread *= 3
			else:
				weapon.spread = 180
		if effect == "Pentagramma: -20% spawnrate, add summoners":
			main_scene.summoner_chance += 20
			main_scene.spawn_timer *= 1.20
		if effect == "Fearmonium: enemies speed depends on distance to you":
			main_scene.fearmonium_active = true
		
func give_card_effect(card):
	if current_floor == 2:
		add_buff(card)
		add_buff(card)
		add_debuff(card)
	if current_floor == 3:
		add_buff(card)
		add_debuff(card)
		add_debuff(card)
	if current_floor >= 4:
		add_buff(card)
		add_debuff(card)
		add_debuff(card)
		add_debuff(card)

func add_buff(card):
	var randomized_element = abs(round(randf_range(0,len(remaining_buffs) - 1)))
	card.buffs.append(remaining_buffs[randomized_element])
	card.get_node("Psalm/Label").text += fill_card_text(remaining_buffs[randomized_element]) + "\n"
	remaining_buffs.pop_at(randomized_element)

func add_debuff(card):
	var randomized_element = abs(round(randf_range(0,len(remaining_debuffs) - 1)))
	card.debuffs.append(remaining_debuffs[randomized_element])
	card.get_node("Psalm/Label2").text += fill_card_text(remaining_debuffs[randomized_element]) + "\n"
	remaining_debuffs.pop_at(randomized_element)

func refill_buff_array():
	remaining_buffs.append("Silver bullets: + 4 damage")
	remaining_buffs.append("Silver bullets: + 4 damage")
	remaining_buffs.append("Faith surge: + 15% movespeed")
	remaining_buffs.append("Reload blessing: + 25% fire rate")
	remaining_buffs.append("Reload blessing: + 25% fire rate")
	#remaining_buffs.append("Sawed-off: + damage, + bullets, + spread, - range")
	#remaining_buffs.append("Prophet: any damage kills you, + 200% damage")
	#remaining_buffs.append("Sniper shotgun: + 100% range, - 20% spread")
	#remaining_buffs.append("Holy bomb: bullets have 10% chance to explode")
	remaining_buffs.append("Faith surge: + 15% movespeed")
	if active_effects.find("Prophet: any damage kills you, + 200% damage") == -1  and remaining_buffs.find("Prophet: any damage kills you, + 200% damage") == -1:
		remaining_buffs.append("Prophet: any damage kills you, + 200% damage")

	if active_effects.find("Sawed-off: + damage, + bullets, + spread, - range") == -1  and remaining_buffs.find("Sawed-off: + damage, + bullets, + spread, - range") == -1:
		remaining_buffs.append("Sawed-off: + damage, + bullets, + spread, - range")



func refill_debuff_array():
	remaining_debuffs.append( "Devil's extension: + 20 sec to floor timer")
	remaining_debuffs.append( "Devil's extension: + 20 sec to floor timer")
	remaining_debuffs.append("Unholy duplication: + 50% spawnrate")
	remaining_debuffs.append("Unholy duplication: + 50% spawnrate")
	#remaining_debuffs.append("Imps: add ranged mobs")
	remaining_debuffs.append("Prayerproof: + 30% enemies hp")
	remaining_debuffs.append("Prayerproof: + 30% enemies hp")
	remaining_debuffs.append("Blazing speed: + 20% enemies speed")
	remaining_debuffs.append("Blazing speed: + 20% enemies speed")
	if active_effects.find("Imps: add ranged mobs") == -1 and remaining_debuffs.find("Imps: add ranged mobs") == -1:
		remaining_debuffs.append("Imps: add ranged mobs")
	if active_effects.find("Fearmonium: enemies speed depends on distance to you") == -1 and remaining_debuffs.find("Fearmonium: enemies speed depends on distance to you") == -1:
		remaining_debuffs.append("Fearmonium: enemies speed depends on distance to you")
	if active_effects.find("Pentagramma: -20% spawnrate, add summoners") == -1 and remaining_debuffs.find("Pentagramma: -20% spawnrate, add summoners") == -1:
		remaining_debuffs.append("Pentagramma: -20% spawnrate, add summoners")
	#remaining_debuffs.append("Pentagramma: -20% spawnrate, add summoners")
	#remaining_debuffs.append("Fearmonium: enemies speed depends on distance to you")

func fill_buff_array():
	remaining_buffs.append("Silver bullets: + 4 damage")
	remaining_buffs.append("Silver bullets: + 4 damage")
	remaining_buffs.append("Faith surge: + 15% movespeed")
	remaining_buffs.append("Reload blessing: + 25% fire rate")
	remaining_buffs.append("Reload blessing: + 25% fire rate")
	remaining_buffs.append("Sawed-off: + damage, + bullets, + spread, - range")
	remaining_buffs.append("Prophet: any damage kills you, + 200% damage")
	remaining_buffs.append("Sniper shotgun: + 100% range, - 20% spread")
	#remaining_buffs.append("Holy bomb: bullets have 10% chance to explode")
	remaining_buffs.append("Faith surge: + 15% movespeed")

func fill_debuff_array():
	remaining_debuffs.append("Fan shooter: + 50% damage, + 200% spread")
	remaining_debuffs.append( "Devil's extension: + 20 sec to floor timer")
	remaining_debuffs.append( "Devil's extension: + 20 sec to floor timer")
	remaining_debuffs.append( "Devil's extension: + 20 sec to floor timer")
	remaining_debuffs.append("Unholy duplication: + 50% spawnrate")
	remaining_debuffs.append("Unholy duplication: + 50% spawnrate")
	remaining_debuffs.append("Imps: add ranged mobs")
	remaining_debuffs.append("Prayerproof: + 30% enemies hp")
	remaining_debuffs.append("Blazing speed: + 20% enemies speed")
	remaining_debuffs.append("Pentagramma: -20% spawnrate, add summoners")
	remaining_debuffs.append("Fearmonium: enemies speed depends on distance to you")

func fill_card_text(text):
	var output = ""
	for a in text:
		if a != ":":
			output += a
		else:
			return output
	
