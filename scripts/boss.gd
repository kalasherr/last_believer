extends Enemy
var destination = Vector2.ZERO
var reached_destination = true
func _ready():
	$Sprite.play("default")
	hp = 500
	speed = 20
	
	
func _process(delta):
	$Sprite.play("default")
	if !pushed:
		move_controller()
	else:
		push_process()
	if hp <= 0:
		death()
	else:
		move_and_slide()

func move_controller():
	get_parent().get_parent().get_node("Timers/LevelTimer").paused = true
	get_parent().get_parent().get_node("GUI/TimerLabel").text = "66:66"
	if (destination - global_position).length() < 3:
		reached_destination = true
	if !reached_destination:
		velocity = (destination - global_position).normalized() * speed
	else:
		reached_destination = false
		attack()
		destination = get_parent().get_parent().get_node("Player").global_position + Vector2(randf_range(-30,30),randf_range(-30,30))
	

func attack():
	$AnimationPlayer.play("spawn")

func choose_destination():
	destination = get_parent().get_parent().get_node("Player").global_position + Vector2(randf_range(-30,30),randf_range(-30,30))


func _on_animation_player_animation_finished(anim_name):
	var random = randf_range(0,2.0)
	if random > 1.5:
		var angle = 0
		while angle < 360:
			add_child(load("res://scenes/imp_projectile.tscn").instantiate())
			get_child(len(get_children())-1).direction = Vector2(sin(angle),cos(angle))
			angle += 30
	elif random > 1.0:
		var angle = 0
		while angle < 360:
			get_parent().add_child(load("res://scenes/imp.tscn").instantiate())
			get_parent().get_child(len(get_parent().get_children())-1).global_position = global_position + Vector2(sin(angle),cos(angle)) * 20
			angle += 120
	else:
		var angle = 0
		while angle < 360:
			get_parent().add_child(load("res://scenes/common_ghost.tscn").instantiate())
			get_parent().get_child(len(get_parent().get_children())-1).global_position = global_position + Vector2(sin(angle),cos(angle)) * 20
			angle += 72
func death():
	$Sprite.visible = false
	get_parent().get_parent()._on_level_timer_timeout()
	queue_free()
	
