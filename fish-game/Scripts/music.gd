extends Node

var is_menu : bool

func toggle_music(menu : bool):
	is_menu = menu
	if menu == true:
		$Fishsong.stop()
		$Fishmenusong.playing = is_menu
	else:
		$Fishmenusong.stop()
		$Fishsong.playing = not is_menu
	


func _on_fishsong_finished() -> void:
	$Fishsong.playing = not is_menu


func _on_fishmenusong_finished() -> void:
	$Fishmenusong.playing = is_menu
