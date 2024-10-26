extends Projectile

func _on_damage_area_area_entered(area):
	if area.get_parent() is Enemy:
		modulate[3] = 0
		area.get_parent().attacked(self)
		destroy()
