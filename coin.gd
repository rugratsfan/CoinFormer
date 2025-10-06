extends Node2D

@onready var detection_area = $Area2D

func _ready():
	detection_area.body_entered.connect(_on_body_entered)

func _on_body_entered(body_that_touched_me):
	if body_that_touched_me.name == "Player":
		body_that_touched_me.collect_coin()
		queue_free()
