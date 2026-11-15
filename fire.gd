extends Area2D

func change_image(file):
	$Sprite2D.texture = file

func scale(factor):
	$Sprite2D.scale = Vector2(factor, factor)
