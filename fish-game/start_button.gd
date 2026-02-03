extends Area2D

var count : int = 3

func _on_body_entered(_body: Node2D) -> void:
	if visible:
		$Timer.start()
		$Label.text = "Ready?"
	
func _on_body_exited(_body: Node2D) -> void:
	count = 3
	$Timer.stop()
	$Label.text = "Start Game?"

func _on_timer_timeout() -> void:
	if count != -1:
		if count == 3:
			$Label.text = "3"
		elif count == 0:
			$Label.text += " GO!"
			$"../Music".toggle_music(false)
		else:
			$Label.text += " " + str(count)
		count -= 1
			
	else:
		count = 3
		$Timer.stop()
		$Label.text = "Start Game?"
		visible = false
		get_parent().explanatory_text(false)
		get_parent().restart_sequence()
