extends KinematicBody2D

export var velocidad = Vector2(150.0,150.0)
export var aceleracion_caida = 400 
export var fuerza_salto = 3000
export var fuerza_rebote = 350
export var impulso = -3800


var movimiento = Vector2.ZERO
var fuerza_salto_original
var aceleracion_caida_original
var puede_moverse = true

onready var animacion = $AnimatedSprite
onready var audioSalto = $AudioSalto
onready var camara = $Camera2D
onready var enfriamiento_power_up = $TimerPowerUpSalto
onready var timer_powerup_volar = $TimerpowerUpVolar
onready var animacion_personaje = $AnimationPlayer

func _ready():
	animacion_personaje.play("aclarar")
	fuerza_salto_original = fuerza_salto
	aceleracion_caida_original = aceleracion_caida

func _physics_process(_delta):
	movimiento.x = velocidad.x * tomar_direccion()
	caer()
	saltar()
	colision_techo()
	caida_al_vacio()

# warning-ignore:return_value_discarded
	move_and_slide(movimiento, Vector2.UP)
	
func tomar_direccion():
	var direccion = 0
	if puede_moverse:
		direccion = Input.get_action_strength("movDerecha") - Input.get_action_strength("movIzquierda")
		if direccion == 0:
			animacion.play("idle")
		else:
			if direccion < 0:
				animacion.flip_h = true
			else:
				animacion.flip_h = false
				
			animacion.play("correr")
		
	return direccion
	
func caer():
	if not is_on_floor():
		animacion.play("saltar")
		movimiento.y += aceleracion_caida
		movimiento.y = clamp(movimiento.y, impulso, velocidad.y)
	
func saltar():
	if Input.is_action_just_pressed("salto") and is_on_floor() and puede_moverse:
		audioSalto.play()
		animacion.play("saltar")
		saltar_movimiento()

		
func saltar_movimiento():
	movimiento.y = 0
	movimiento.y -= fuerza_salto
	
func volar():
	timer_powerup_volar.start()
	aceleracion_caida = 60
	animacion_personaje.play("volar")
	saltar_movimiento()
	
func colision_techo():
	if is_on_ceiling():
		movimiento.y = fuerza_rebote
		
		
func impulsar():
	movimiento.y = impulso
	
func cambiar_fuerza_salto():
	enfriamiento_power_up.start()
	fuerza_salto = -impulso * 0.9
		
func respawn():
	DatosPlayer.restar_vidas()
	animacion_personaje.play("oscurecer")
	if DatosPlayer.vidas >= 1:
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
	
func caida_al_vacio():
	if position.y > camara.limit_bottom:
		respawn()


func _on_EnfriamientoPowerUp_timeout():
	fuerza_salto = fuerza_salto_original


func _on_TimerpowerUpVolar_timeout():
	animacion_personaje.play("default")
	aceleracion_caida = aceleracion_caida_original
	
func play_entrar_portal(posicion_portal):
	puede_moverse = false
	animacion_personaje.play("entrar_portal")
	$Tween.interpolate_property(
		self,
		"global_position",
		global_position,
		posicion_portal,
		0.8,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	$Tween.start()
	
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "entrar_portal":
		animacion_personaje.play("oscurecer")