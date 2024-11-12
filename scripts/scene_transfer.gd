extends TileMap

func transfer(scene1,scene2):
	scene1.get_tree().paused = true
	for i in range(0,125):
		for j in range(0,i+1):
			i = i - j
			set_cell(0,Vector2(i,j),0,Vector2i(0,0),0)
		await get_tree().process_frame
		
	get_tree().get_root().add_child(load(scene2).instantiate())
	get_tree().get_root().get_child(len(get_tree().get_root().get_children()) - 1).get_tree().paused = true
	if scene1:
		get_parent().remove_child(scene1)
	for i in range(0,125):
		for j in range(0,i+1):
			i = i - j
			set_cell(0,Vector2(i,j),-1,Vector2i(0,0),0)
		await get_tree().process_frame
		
	get_tree().get_root().get_child(len(get_tree().get_root().get_children()) - 1).get_tree().paused = false
