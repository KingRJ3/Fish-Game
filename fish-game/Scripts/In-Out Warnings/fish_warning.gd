extends Node2D

var fish_node : Node2D
var visual_size_y : float

func _ready() -> void:
	visual_size_y = $FishColor.size.y
	
func set_associated_fish(fish : Node2D):
	fish_node = fish

func set_warning_color(color : Color):
	$FishColor.color = color

func set_warning_position(position_x: int):
	position.x = position_x
	position.y = 0

func _on_warning_timer_timeout() -> void:
	fish_node.new_fish(position.x)
	queue_free()


func _on_visual_timer_timeout() -> void:
	if get_parent().game_over:
		queue_free()
	else:
		$FishColor.size.y -= visual_size_y / $WarningTimer.wait_time
