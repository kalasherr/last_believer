extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	$AudioStreamPlayer2D2.play()
	Global.remaining_buffs = []
	Global.remaining_debuffs = []
	Global.active_effects = []
	Global.fill_buff_array()
	Global.fill_debuff_array()
	Global.current_floor = 1
	SceneTransfer.transfer(self, "res://scenes/postulate_scene.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
	$AudioStreamPlayer2D2.play()

func _on_options_button_pressed():
	SceneTransfer.transfer(self, "res://scenes/effect_descriptions.tscn")
	$AudioStreamPlayer2D2.play()

func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()
	


func _on_credits_button_pressed():
	SceneTransfer.transfer(self,"res://scenes/credits.tscn" )
