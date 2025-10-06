extends Node

#keep track of score
var score: int = 0

#grab label
@onready var scoreLabel = get_node("../UI/ScoreLabel")

#function to increase score
func add_to_score(points: int) -> void:
	#add incomping points to current score
	score = score + points 
	
	if scoreLabel:
		scoreLabel.text = "Score:" + str(score)
	else:
		print("Score label not found, but score is now" + str(score))
