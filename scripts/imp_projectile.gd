extends Projectile
class_name ImpProjectile
func _ready():
	start_point = global_position
	speed = 70
	max_range = 1000
