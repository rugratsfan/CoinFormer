extends CharacterBody2D

# player stats
@export var walk_speed = 180
@export var jump_power = -420
@export var gravity_power = 750

 #health, spawn, objects
var health = 3
var spawn_position = Vector2(0, 0)
var coins = 0
# animation pt1
@onready var player_sprite = $AnimatedSprite2D
@onready var coin_label = $CoinLabel
func _physics_process(delta):
	# GRAVITY
	if not is_on_floor():
		velocity.y += gravity_power * delta
	
	# get left/right input
	var left_right_input = Input.get_axis("ui_left", "ui_right")
	velocity.x = left_right_input * walk_speed
	
	# JUMP
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_power
	
	# move the player
	move_and_slide()
	
	# ANIMATIONS pt2
	if not is_on_floor():
		# If player is in the air, play jump animation
		player_sprite.play("jump")
	elif left_right_input != 0:
		# If player is moving left or right, play run animation
		player_sprite.play("run")
		# Flip the sprite to face the direction we're moving
		if left_right_input < 0:
			player_sprite.flip_h = true   # facing left
		else:
			player_sprite.flip_h = false  # facing right
	else:
		# If player is standing still on ground, play idle animation
		player_sprite.play("idle")
	
	# CHECK IF FELL OFF MAP - if player falls too far down
	if position.y > get_viewport_rect().size.y + 100:
		take_damage()
# This function runs when the player collects a coin
func collect_coin():
	# Increase our coin count by 1
	coins = coins + 1
	 # Show a message with the new total
	print("You now have " + str(coins) + " coins!")
	
	#updating the label:
	coin_label.text = "Coins: " + str(coins)
func take_damage():
	health -= 1
	print("Got hurt! Health left: " + str(health))
	
	if health > 0:
		# Still alive - go back to spawn point
		position = spawn_position
		velocity = Vector2.ZERO
	else:
		# Game ovev
		print("Ur ded! Starting over...")
		health = 3
		position = spawn_position
		velocity = Vector2.ZERO

# New you, New Place
func set_spawn_point(new_position: Vector2):
	spawn_position = new_position
