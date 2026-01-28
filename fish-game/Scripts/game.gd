extends Node2D


var fishnode = preload("res://Scenes/fish.tscn")
var warningnode = preload("res://Scenes/fish_warning.tscn")
var suctionnode = preload("res://Scenes/suction_flap.tscn")


var fishes : Array = []
var next_new_fish : Array[Node2D]
var game_over : bool = false
var score : int = 0
var strikes : int = 3

func make_new_fish(fish):
	fish.set_color($Timers.get_color())
	next_new_fish.append(fish)
	var new_fish_position_x = randi_range(50, fish.win_size.x - 50)
	var warning_node = warning_inst()
	warning_node.set_associated_fish(fish)
	warning_node.set_warning_color(fish.color)
	warning_node.set_warning_position(new_fish_position_x)


func warning_inst():
	var instance = warningnode.instantiate()
	add_child(instance)
	return instance

func fish_inst():
	var instance = fishnode.instantiate()
	add_child(instance)
	return instance
	
func flap_inst():
	var instance = suctionnode.instantiate()
	add_child(instance)
	return instance
	
func choose_flap_color(flap : StaticBody2D):
	flap.set_vent_color(fishes.pick_random().color)
	
func remove_fish(fish):
	fishes.erase(fish)

func give_score(flap : StaticBody2D):
	score += 1
	$Labels/Score.text = "Current Score: " + str(score)
	flap.queue_free()

func give_strike(flap : StaticBody2D):
	strikes -= 1
	$Labels/StrikesLeft.text = "Strikes Left: " + str(strikes)
	if strikes <= 0:
		$Labels/StrikesLeft.text = "Strikes Left: 0 - Game Over"
		$Labels/Score.text = "Final Score: " + str(score)
		$Timers.game_over()
		game_over = true
		$RestartButton.visible = true
	flap.queue_free()
	

func restart_sequence():
	game_over = false
	$Timers.reset_timer_properties()
	score = 0
	$Labels/Score.text = "Current Score: " + str(score)
	strikes = 3
	$Labels/StrikesLeft.text = "Strikes Left: " + str(strikes)
	
