extends CharacterBody2D
class_name Projectile
var speed = 700
var attack_power
var direction = Vector2(1,0)
var start_point = Vector2.ZERO
var max_range = 100.0
var explosive = false
# Called when the node enters the scene tree for the first time.
func _ready():
	start_point = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = direction.normalized() * speed
	rotation = velocity.angle()
	move_and_slide()
	velocity = Vector2.ZERO
	if (start_point - global_position).length() > max_range:
		destroy()

func destroy():
	#modulate[3] = 0
	queue_free()
