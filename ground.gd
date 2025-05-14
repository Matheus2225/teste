extends Sprite2D

export var speed = 150 # Velocidade de movimento do chão

var texture_width: float

func _ready():
	if texture != null:
		texture_width = texture.get_width() * scale.x # Considera a escala do sprite
	else:
		printerr("A textura do chão não foi atribuída!")

func _process(delta):
	if texture == null:
		return

	# Move a posição do sprite para a esquerda
	position.x -= speed * delta

	# Cria a ilusão de repetição
	if position.x < -texture_width:
		position.x += texture_width * 2 # Move para a direita o dobro da largura