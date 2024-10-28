extends Enemy

var destination = Vector2.ZERO
var reached_destination = true
var destination_changed = false
var additional_position = Vector2.ZERO
func ready():
	$Sprite.play("default")
	hp = 50
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
		velocity = Vector2.ZERO
		

func move_controller():
	if (destination - global_position).length() < 3:
		reached_destination = true
	if !reached_destination and !$AnimationPlayer.is_playing():
		velocity = (destination - global_position).normalized() * speed
	else:
		reached_destination = false
		if destination_changed:
			attack()
		destination_changed = true
		destination = get_parent().get_parent().get_node("Player").global_position + Vector2(randf_range(-10,10),randf_range(-10,10))
func attack():
	$AnimationPlayer.play("pentagramma")

func choose_destination():
	destination = get_parent().get_parent().get_node("Player").global_position + Vector2(randf_range(-10,10),randf_range(-10,10))


func _on_animation_player_animation_finished(anim_name):
	add_child(load("res://scenes/common_ghost.tscn").instantiate())
	add_child(load("res://scenes/common_ghost.tscn").instantiate())
	add_child(load("res://scenes/common_ghost.tscn").instantiate())
	var vector = Vector2.ZERO
	for child in get_children():
		if child is Enemy:
			child.reparent(get_parent())
			child.global_position = global_position + vector
			vector.x += 20
	queue_free()

func push(direction,speed):
	pass
