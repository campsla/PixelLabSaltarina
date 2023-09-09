extends Control

func _ready():
	DatosPlayer.reset()

func _on_BtnIniciarJuego_pressed():
	MusicaGlobal.replay()
	get_tree().change_scene("res://Juego/niveles/Lvl_1.tscn")
