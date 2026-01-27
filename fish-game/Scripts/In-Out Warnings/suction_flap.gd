extends StaticBody2D

var win_size : Vector2
var background_size : Vector2
var color : Color
var visual_size_y : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visual_size_y = $FishColor.size.y
	win_size = get_viewport_rect().size
	background_size = $Background.get_rect().size
	set_vent_position()

func set_vent_color(new_color : Color):
	color = new_color
	$FishColor.color = color

func set_vent_position():
	@warning_ignore("narrowing_conversion")
	position.x = randi_range(background_size.y / 2 , win_size.x - background_size.y / 2)
	position.y = win_size.y
	

func _on_flap_timer_timeout() -> void:
	get_parent().give_strike(self)

func _on_visual_timer_timeout() -> void:
	if get_parent().game_over:
		queue_free()
	else:
		$FishColor.size.y -= visual_size_y / $FlapTimer.wait_time
