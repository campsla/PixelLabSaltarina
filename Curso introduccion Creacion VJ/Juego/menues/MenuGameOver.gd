extends Control

var nivel_actual = ""

func _ready():
	nivel_actual = DatosPlayer.nivel_actual
	DatosPlayer.reset()
	

func _on_BtnMenuPrincipal_pressed():
	get_tree().change_scene("res://Juego/menues/MenuPrincipal.tscn")


func _on_BtnReintentar_pressed():
	get_tree().change_scene(nivel_actual)
