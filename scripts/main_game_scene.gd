extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timers/SpawnTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawn_timer_timeout():
	$Enemies.add_child(load("res://scenes/common_ghost.tscn").instantiate())
	var angle = randf_range(0,PI * 2)
	$Enemies.get_child(len($Enemies.get_children()) - 1).position = Vector2(160,136) + Vector2(cos(angle),sin(angle)) * 220
