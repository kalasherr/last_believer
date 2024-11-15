extends Node2D
var boss_spawned = false
var level_timer = 40
var spawn_timer = 2
var enemy_hp_multiplier = 1.0
var enemy_speed_multiplier = 1.0
var fearmonium_active = false
var imp_chance = 0
var summoner_chance = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play()
	check_hp()
	$Timers/SpawnTimer.start(level_timer)
	$Timers/SpawnTimer.start(spawn_timer)
	$GUI/LevelLabel.text = "Act " + str(Global.current_floor)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawn_timer_timeout():
	if Global.current_floor < 8:
		var enemy_random = randf_range(0,100)
		if enemy_random < imp_chance:
			$Enemies.add_child(load("res://scenes/imp.tscn").instantiate())
		elif enemy_random < imp_chance + summoner_chance:
			$Enemies.add_child(load("res://scenes/summoner.tscn").instantiate())
		else:
			$Enemies.add_child(load("res://scenes/common_ghost.tscn").instantiate())
		var angle = randf_range(0,PI * 2)
		$Enemies.get_child(len($Enemies.get_children()) - 1).fearmonium_active = fearmonium_active
		$Enemies.get_child(len($Enemies.get_children()) - 1).hp *= enemy_hp_multiplier
		$Enemies.get_child(len($Enemies.get_children()) - 1).speed *= enemy_speed_multiplier
		$Enemies.get_child(len($Enemies.get_children()) - 1).position = Vector2(160,136) + Vector2(cos(angle),sin(angle)) * 220
	elif !boss_spawned:
		boss_spawned = true
		var angle = randf_range(0,PI * 2)
		$Enemies.add_child(load("res://scenes/boss.tscn").instantiate())
		$Enemies.get_child(len($Enemies.get_children()) - 1).position = Vector2(160,136) + Vector2(cos(angle),sin(angle)) * 220


func _on_level_timer_timeout():
	Global.current_floor += 1
	if Global.current_floor < 8:
		get_tree().paused = true
		SceneTransfer.transfer(self, "res://scenes/choice_scene.tscn")
	else:
		SceneTransfer.transfer(self, "res://scenes/postulate_scene.tscn")

func check_hp():
	if get_node("Player").hp == 3:
		$GUI/HBoxContainer/TextureRect.texture = load("res://sprites/gui/crux.png")
		$GUI/HBoxContainer/TextureRect2.texture = load("res://sprites/gui/crux.png")
		$GUI/HBoxContainer/TextureRect3.texture = load("res://sprites/gui/crux.png")
	if get_node("Player").hp == 2:
		$GUI/HBoxContainer/TextureRect.texture = load("res://sprites/gui/crux.png")
		$GUI/HBoxContainer/TextureRect2.texture = load("res://sprites/gui/crux.png")
		$GUI/HBoxContainer/TextureRect3.texture = load("res://sprites/gui/bloody_crux.png")
	if get_node("Player").hp == 1:
		$GUI/HBoxContainer/TextureRect.texture = load("res://sprites/gui/crux.png")
		$GUI/HBoxContainer/TextureRect2.texture = load("res://sprites/gui/bloody_crux.png")
		$GUI/HBoxContainer/TextureRect3.texture = load("res://sprites/gui/bloody_crux.png")
	if get_node("Player").hp == 0:
		$GUI/HBoxContainer/TextureRect.texture = load("res://sprites/gui/bloody_crux.png")
		$GUI/HBoxContainer/TextureRect2.texture = load("res://sprites/gui/bloody_crux.png")
		$GUI/HBoxContainer/TextureRect3.texture = load("res://sprites/gui/bloody_crux.png")
	


func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()
