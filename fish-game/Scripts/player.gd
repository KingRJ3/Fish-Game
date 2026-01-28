extends CharacterBody2D

var win_height : int
var p_height : int
var win_width : int
var p_width : int
var game_started : bool

var toggled_left : bool = false
var fish : Node2D
var holding_fish : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	@warning_ignore("narrowing_conversion")
	win_height = get_viewport_rect().size.y
	p_height = $ColorRect.get_size().y
	@warning_ignore("narrowing_conversion")
	win_width = get_viewport_rect().size.x
	p_width = $ColorRect.get_size().x
	game_started = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("right") and toggled_left:
		$GrabBody.position.x *= -1
		toggled_left = false
		$GrabDirection.text = "Right"
	elif Input.is_action_just_pressed("left") and not toggled_left:
		$GrabBody.position.x *= -1
		toggled_left = true
		$GrabDirection.text = "Left"
	if Input.is_action_pressed("click"):
		if holding_fish:
			if not toggled_left and position.x < win_width - p_width and fish:
				fish.global_position = global_position # apply adjustions afterwards
				fish.global_position.x += 205
				fish.global_position.y += 90
				$GrabBody.set_color_rect(false)
			elif toggled_left and position.x > p_width and fish:
				fish.global_position = global_position # apply adjustions afterwards
				fish.global_position.x += 85
				fish.global_position.y += 90
				$GrabBody.set_color_rect(false)
	if game_started:
		position = get_global_mouse_position()
	
	#limit paddle movement to window
	@warning_ignore("integer_division")
	position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)
	@warning_ignore("integer_division")
	position.x = clamp(position.x, p_width / 2, win_width - p_width / 2)
