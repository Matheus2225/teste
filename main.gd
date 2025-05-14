extends Node2D # Ou o tipo do seu nó raiz principal

var score = 0
var score_timer = 0.0
export var score_interval = 0.1 # Intervalo para adicionar pontos (em segundos)

func _ready():
	update_score_label()

func _process(delta):
	# Atualizar a pontuação a cada intervalo
	score_timer += delta
	if score_timer >= score_interval:
		score_timer -= score_interval
		score += 1
		update_score_label()

func update_score_label():
	if is_instance_valid($ScoreLabel): # Verifica se o nó ainda existe
		$ScoreLabel.text = "Score: " + str(score)

func game_over():
	# ... (seu código de game over existente) ...
	set_process(false) # Para de atualizar a pontuação no game over

    extends Node2D # Ou o tipo do seu nó raiz principal

var score = 0
var score_timer = 0.0
export var score_interval = 0.1 # Intervalo para adicionar pontos (em segundos)

@onready var player = get_node("Player") # Assumindo que seu nó do jogador se chama "Player"
@onready var game_over_screen = get_node("GameOverScreen") # Referência à tela de game over
@onready var score_label = get_node("ScoreLabel") # Referência ao label de pontuação

func _ready():
    update_score_label()
    game_over_screen.visible = false # Garante que a tela de game over esteja inicialmente oculta
    if player:
        player.connect("game_over", self, "_on_player_game_over")

func _process(delta):
    # Atualizar a pontuação a cada intervalo
    score_timer += delta
    if score_timer >= score_interval:
        score_timer -= score_interval
        score += 1
        update_score_label()

func update_score_label():
    if is_instance_valid(score_label):
        score_label.text = "Score: " + str(score)

func _on_player_game_over():
    # Lógica a ser executada quando o sinal de game_over é emitido pelo jogador
    set_process(false) # Para o loop de _process (parando a pontuação)
    game_over_screen.visible = true # Exibe a tela de game over
    # Aqui você pode adicionar mais lógica, como exibir a pontuação final
    var final_score_label = game_over_screen.get_node_or_null("FinalScoreLabel") # Se você tiver um label na tela de game over para a pontuação final
    if is_instance_valid(final_score_label):
        final_score_label.text = "Your Score: " + str(score)

    # Para o movimento do chão e a geração de obstáculos
    if is_instance_valid(get_node("Ground")):
        get_node("Ground").set_process(false)
    if is_instance_valid(get_node("ObstacleGenerator")):
        get_node("ObstacleGenerator").set_process(false)

func _on_RestartButton_pressed():
    # Lógica para reiniciar o jogo (será conectada ao botão de restart na tela de game over)
    score = 0
    update_score_label()
    game_over_screen.visible = false
    set_process(true) # Reinicia o loop de _process
    if is_instance_valid(player):
        player.set_physics_process(true) # Reinicia a física do jogador
        # Resetar a posição do jogador para o início (opcional)
        player.position = Vector2(50, 0) # Exemplo de posição inicial

    # Reiniciar o movimento do chão e a geração de obstáculos
    if is_instance_valid(get_node("Ground")):
        get_node("Ground").set_process(true)
        get_node("Ground").position.x = 0 # Resetar a posição do chão (se necessário)
    if is_instance_valid(get_node("ObstacleGenerator")):
        get_node("ObstacleGenerator").set_process(true)
        # Talvez limpar os obstáculos existentes na tela
        for node in get_tree().get_nodes_in_group("obstacles"):
            node.queue_free()