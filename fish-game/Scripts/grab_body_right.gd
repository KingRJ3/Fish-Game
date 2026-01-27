extends StaticBody2D



func save_and_set(color, dir, fish):
	if get_parent().holding_fish:
		fish.dir = dir
		fish.dir.y = fish.dir.y / 2
		if $ColorRect.color == Color.WHITE:
			get_parent().holding_fish = false
	else:
		set_color_rect(true, color)
		fish.global_position = Vector2(-100,-100)
		get_parent().fish = fish
		get_parent().holding_fish = true

func set_color_rect(input : bool, color : Color = Color.WHITE):
	$ColorRect.set_visible(input)
	$ColorRect.color = color
	
