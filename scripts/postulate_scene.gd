extends Control
var text_to_print = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	match Global.current_floor:
		1: text_to_print = "Beati pauperes spiritu, \n quoniam ipsorum est regnum caelorum."
		2: text_to_print = "Beati, qui lugent,\n quoniam ipsi consolabuntur."
		3: text_to_print = "Beati mites, quoniam\n ipsi possidebunt terram."
		4: text_to_print = "Beati, qui esuriunt\n et sitiunt iustitiam,\n quoniam ipsi saturabuntur."
		5: text_to_print = "Beati misericordes,\n quia ipsi misericordiam consequentur."
		6: text_to_print = "Beati mundo corde,\n quoniam ipsi Deum videbunt."
		7: text_to_print = "Beati pacifici,\n quoniam filii Dei vocabuntur."
		8: text_to_print = "Beati, qui persecutionem\n patiuntur propter iustitiam,\n quoniam ipsorum est regnum caelorum."
	$CenterContainer/Label.text = text_to_print
	await get_tree().create_timer(3).timeout
	SceneTransfer.transfer(self, "res://scenes/main_game_scene.tscn")
