extends CharacterBody2D


var win_size : Vector2
var max_speed : int
var min_speed : int
const ACCEL : int = 50
var speed : int
var dir : Vector2
var color : Color
var hp : int
var last_fish_was_same : bool = false

var fish := {
	Color.RED : [200, 400, 12], 
	Color.BLUE : [100, 300, 11], 
	Color.GREEN : [50, 400, 10],
	} # [min_speed, max_speed, starting_hp]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	win_size = get_viewport_rect().size
	
func new_fish(new_position_x):
	#make speed dependent on color
	min_speed = fish[color][0]
	max_speed = fish[color][1]
	hp = fish[color][2]
	position.y = 100
	position.x = new_position_x + 150
	#randomize start position and direction
	speed = max_speed
	dir = random_direction()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(dir * speed * delta)
	var collider
	if collision:
		collider = collision.get_collider()
		#if ball hits paddle
		if collider == $"../Player/GrabBody":
			collider.save_and_set(color, dir.bounce(collision.get_normal()), self)
		elif collider == $"../Player":
			dir = dir.bounce(collision.get_normal())
		#if it hits a wall
		elif collider == $"../Border":
			if not last_fish_was_same and dir.x == 0:
				dir.x = 1
				if speed < max_speed:
					speed += ACCEL
			dir = dir.bounce(collision.get_normal())
			last_fish_was_same = false
		elif not collider in get_parent().fishes:
			if collider.color == color:
				get_parent().give_score(collider)
			else:
				get_parent().give_strike(collider)
			change_check_hp(self, 1000000)
		#if it hits another fish
		else:
			if not check_bichromatic(collider):
				if last_fish_was_same:
					dir = collider.dir
					dir.y = 0
					collider.dir.y = 0
					if speed < min_speed:
						speed = min_speed
					speed = collider.speed
				else:
					speed = collider.speed
					dir = collider.dir
					last_fish_was_same = true
			elif last_fish_was_same:
				collider.dir = collider.dir.bounce(collision.get_normal())
				last_fish_was_same = false
			else:
				if collider.dir.y == 0:
					collider.dir.y = 1
				dir = dir.bounce(collision.get_normal())
				last_fish_was_same = false
		
func random_direction():
	var new_dir := Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(0, 1) # down is positive (+y) for some reason
	return new_dir.normalized()

func change_check_hp(victim : CharacterBody2D, hp_taken : int):
	victim.hp -= hp_taken
	if victim.hp <= 0:
		get_parent().remove_fish(victim)
		victim.queue_free()

func check_bichromatic(collider):
	if color == collider.color:
		return false
	if color == Color.RED and collider.speed < collider.max_speed:
		collider.speed += ACCEL
	return true
	

func set_color(new_color: Color):
	color = new_color
	$ColorRect.color = color
