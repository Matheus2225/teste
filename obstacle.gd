extends StaticBody2D

func is_obstacle():
    return true # Método para identificar este nó como um obstáculo

func _ready():
    # Opcional: Alguma inicialização específica do obstáculo
    pass

func _process(delta):
    # Movimentar o obstáculo para a esquerda
    position.x -= get_node("../Main/Ground").speed * delta # Assumindo que o chão tem uma velocidade

    # Remover o obstáculo quando sair da tela (otimização)
    if position.x < -100: # Ajuste esse valor conforme a largura da sua tela e do obstáculo
        queue_free() # Remove o nó da árvore, liberando a memória