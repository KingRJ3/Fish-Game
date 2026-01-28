extends Area2D

var count : int = 3

func _on_body_entered(_body: Node2D) -> void:
	if get_parent().visible:
		$Timer.start()
		$"../Label".text = "Ready?"
	
func _on_body_exited(_body: Node2D) -> void:
	count = 3
	$Timer.stop()
	$"../Label".text = "Restart?"

func _on_timer_timeout() -> void:
	if count != -1:
		if count == 3:
			$"../Label".text = "3"
		elif count == 0:
			$"../Label".text += " GO"
		else:
			$"../Label".text += " " + str(count)
		count -= 1
			
	else:
		count = 3
		$Timer.stop()
		$"../Label".text = "Restart?"
		get_parent().visible = false
		get_parent().get_parent().restart_sequence()
