extends KinematicBody2D

signal game_over

export var jump_force = -400
export var gravity = 1200
export var speed = 100

var velocity = Vector2.ZERO
var is_on_floor = false

func _physics_process(delta):
	# Detectar se o personagem está no chão
	is_on_floor = is_on_floor()

	# Aplicar gravidade
	if not is_on_floor:
		velocity.y += gravity * delta

	# Controle de pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor:
		velocity.y = jump_force

	# Movimento horizontal (mantendo a velocidade constante para a direita)
	velocity.x = speed

	# Movimentar o personagem
	velocity = move_and_slide(velocity, Vector2.UP)

	# Animação (exemplo básico - você precisaria configurar as animações no AnimationPlayer)
	if not is_on_floor:
		$Sprite2D.frame = 1 # Frame da animação de pulo
	else:
		$Sprite2D.frame = 0 # Frame da animação de corrida (ou parado)

func _on_Player_body_entered(body):
    # Lógica de colisão com obstáculos
    if body.has_method("is_obstacle"): # Supondo que obstáculos tenham um método para identificação
        emit_signal("game_over") # Emite o sinal de game over
        set_physics_process(false) # Parar a física do personagem

func game_over():
	# Sinalizar o fim do jogo (você precisaria conectar isso a um sistema de gerenciamento de jogo)
	print("Game Over!")
	set_physics_process(false) # Parar a física do personagem
