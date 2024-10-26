extends Weapon

func load_stats():
	bullets_per_shot = 6
	cooldown = 1.0
	attack_power = 4.0
	spread = 20.0
	range = 80.0

func attack():
	if $CooldownTimer.time_left == 0:
		$Animation.play("shotgun_back_move")
		$CooldownTimer.start(cooldown)
		for i in range(0,bullets_per_shot):
			spawn_bullet()
		for bullet in get_node("Bullets").get_children():
			bullet.reparent(get_parent().get_parent().get_parent())
	
func spawn_bullet():
	var bullet_angle = (get_global_mouse_position() - global_position).angle() + deg_to_rad(randf_range(-spread/2, spread/2))
	get_node("Bullets").add_child(load("res://scenes/shotgun_bullet.tscn").instantiate())
	var bullet = get_node("Bullets").get_child(len(get_node("Bullets").get_children()) - 1)
	bullet.position = Vector2(0,0)
	bullet.direction = Vector2(cos(bullet_angle),sin(bullet_angle))
	bullet.max_range = range
	bullet.attack_power = attack_power
