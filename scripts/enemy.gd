extends CharacterBody2D
class_name Enemy
var hp = 100
var speed = 40
var pushed = false
var default_push_speed = 150
var push_speed = default_push_speed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if !pushed:
		move_controller()
	else:
		push_process()
	if hp <= 0:
		death()
	else:
		move_and_slide()

func attacked(body):
	modulate = Color(100,100,100,1)
	hp -= body.attack_power
	await get_tree().create_timer(0.1).timeout
	modulate = Color(1,1,1,1)

func death():
	modulate = Color(100,100,100,1)
	await get_tree().create_timer(0.1).timeout
	queue_free()

func move_controller():
	velocity = (get_parent().get_parent().get_node("Player").global_position - global_position).normalized() * speed
	if velocity.x < 0:
		for child in get_children():
			child.scale.x = -1
	else:
		for child in get_children():
			child.scale.x = 1
	
	if hp <= 0:
		death()

func push(direction,speed):
	pushed = true
	velocity = direction * speed

func push_process():
	velocity = velocity.normalized() * push_speed
	push_speed -= 5
	$Collision.disabled = true
	if push_speed <= 0:
		pushed = false
		push_speed = default_push_speed
		$Collision.disabled = false
