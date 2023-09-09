extends Control

func _ready():
	$Label2.text = "Puntaje: {p}".format({"p": DatosPlayer.generar_puntaje()}) 


func _on_BtnMenuPrincipal_pressed():
	get_tree().change_scene("res://Juego/menues/MenuPrincipal.tscn")
