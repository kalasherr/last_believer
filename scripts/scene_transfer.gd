extends TileMap

func transfer(scene1,scene2):
	for i in range(0,125):
		for j in range(0,i):
			i = i - j
			set_cell(0,Vector2(i,j),0,Vector2i(0,0),0)
		await get_tree().process_frame
	get_tree().get_root().add_child(load(scene2).instantiate())
	if scene1:
		get_parent().remove_child(scene1)
	for i in range(0,125):
		for j in range(0,i):
			i = i - j
			set_cell(0,Vector2(i,j),-1,Vector2i(0,0),0)
		await get_tree().process_frame
