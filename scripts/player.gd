extends CharacterBody2D
var speed = 60
var diagonalized_movement = false
var hp = 1

func _ready():
	pass

func _process(delta):
	if hp <= 0:
		SceneTransfer.transfer(get_parent(), "res://scenes/projectile.tscn")
	movement_process()

func movement_process():
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if velocity != Vector2.ZERO:
		$Sprites/MainSprite.play()
		if diagonalized_movement == false:
			diagonalized_movement = true
			position = Vector2(round(position.x), round(position.y))
		else:
			diagonalized_movement = false
	else:
		position = Vector2(round(position.x), round(position.y))
		$Sprites/MainSprite.stop()
	velocity = velocity.normalized() * speed
	sprite_controller()
	move_and_slide()
	velocity = Vector2.ZERO

	if Input.is_action_pressed("fire"):
		$Weapon.get_child(0).attack()

func sprite_controller():
	if velocity != Vector2.ZERO:
		$Sprites/MainSprite.play()
	if (global_position - get_global_mouse_position()).x < 0:
		$Sprites.scale = Vector2(1,1)
	else:
		$Sprites.scale = Vector2(-1,1)
	if (get_global_mouse_position() - global_position).angle() > -PI/2 and (get_global_mouse_position() - global_position).angle() < PI/2:
		$Weapon.scale.x = 1
		$Weapon.rotation = (get_global_mouse_position() - global_position).angle() + PI/2
	else:
		$Weapon.scale.x = -1
		$Weapon.rotation = (get_global_mouse_position() - global_position).angle() + PI/2



func _on_hit_box_area_entered(area):
	if area.get_parent() is Enemy:
		hp -= 1
		for enemy in $KnockbackArea.get_overlapping_areas():
			if enemy.get_parent() is Enemy:
				enemy.get_parent().push((enemy.get_parent().global_position - global_position).normalized(), 100)
