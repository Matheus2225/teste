extends Node

export var obstacle_scene: PackedScene
export var spawn_interval = 1.5
export var min_spawn_y = -50
export var max_spawn_y = 50

var spawn_timer = 0.0
var rng = RandomNumberGenerator.new()

func _ready():
    rng.randomize() # Inicializa o gerador de números aleatórios

func _process(delta):
    spawn_timer += delta
    if spawn_timer >= spawn_interval:
        spawn_timer -= spawn_interval
        spawn_obstacle()

func spawn_obstacle():
    if obstacle_scene != null:
        var new_obstacle = obstacle_scene.instantiate()
        # Posicionar o obstáculo na borda direita da tela com uma altura aleatória
        var viewport_rect = get_viewport_rect()
        new_obstacle.position.x = viewport_rect.end.x + 50 # Um pouco além da borda
        new_obstacle.position.y = rng.randf_range(min_spawn_y, max_spawn_y) # Altura aleatória

        # Adicionar o novo obstáculo como filho da cena principal
        get_parent().add_child(new_obstacle)