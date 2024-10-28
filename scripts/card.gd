extends Control
var buff_text = ""
var debuff_text = ""
var buffs = []
var debuffs = []

func _ready():
	Global.give_card_effect(self)
	
func add_effect():
	for effect in buffs:
		Global.active_effects.append( effect)
	for effect in debuffs:
		Global.active_effects.append( effect)


func _on_button_pressed():
	add_effect()
	SceneTransfer.transfer(get_parent().get_parent().get_parent(),"res://scenes/postulate_scene.tscn")
