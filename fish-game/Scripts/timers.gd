extends Node
var day_tick : int = 0
var fish_tick : Array[int] = [4,0] # max tick, current tick
var flap_tick : Array[int] = [6,0] # max tick, current tick
var game : Node2D
var is_day : bool = true

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	game = get_parent()

func _on_logic_timer_timeout() -> void:
	if day_tick == 30:
		is_day = not is_day
		day_tick = 0
		if is_day:
			$DayNightLabel.text = "Day"
			$ColorRect.color = Color.YELLOW
			if fish_tick[0] != 1:
				fish_tick[0] -= 1
		else:
			$DayNightLabel.text = "Night"
			if flap_tick[0] != 1:
				flap_tick[0] -= 1
			$ColorRect.color = Color.MIDNIGHT_BLUE
	if is_day:
		if day_tick == 0:
			$ColorRect.size.x = 90
		else:
			$ColorRect.size.x -= 3
	else:
		$ColorRect.size.x += 3
	day_tick += 1
	if is_day:
		if fish_tick[0] > fish_tick[1]:
			fish_tick[1] += 1
		else:
			var new_fish = game.fish_inst()
			game.fishes.append(new_fish)
			game.make_new_fish(new_fish)
			fish_tick[1] = 1
	else:
		if flap_tick[0] > flap_tick[1]:
			flap_tick[1] += 1
		else:
			var flap = game.flap_inst()
			game.choose_flap_color(flap)
			flap_tick[1] = 1
			

func get_color() -> Color:
	var color_num : int = randi() % 3 + 1
	if color_num == 1:
		return Color.BLUE
	elif color_num == 2:
		return Color.RED
	elif color_num == 3:
		return Color.GREEN
	else: # should never happen
		return Color.WHITE

func game_over() -> void:
	$LogicTimer.stop()
