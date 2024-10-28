extends Enemy
var destination = Vector2.ZERO
var reached_destination = true
func ready():
	$Sprite.play("default")
	hp = 30
	speed = 30
	
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
	if (destination - global_position).length() < 3:
		reached_destination = true
	if !reached_destination:
		velocity = (destination - global_position).normalized() * speed
	else:
		reached_destination = false
		attack()
		destination = get_parent().get_parent().get_node("Player").global_position + Vector2(randf_range(-30,30),randf_range(-30,30))
	if ( global_position - get_parent().get_parent().get_node("Player").global_position).normalized().x < 0:
		for child in get_children():
			child.scale.x = -1
	else:
		for child in get_children():
			child.scale.x = 1

func attack():
	add_child(load("res://scenes/imp_projectile.tscn").instantiate())
	get_child(len(get_children())-1).direction = get_parent().get_parent().get_node("Player").global_position - global_position
	get_child(len(get_children())-1).reparent(get_parent().get_parent())

func choose_destination():
	destination = get_parent().get_parent().get_node("Player").global_position + Vector2(randf_range(-30,30),randf_range(-30,30))
