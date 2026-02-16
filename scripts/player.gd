extends CharacterBody2D

@onready var sprite := $AnimatedSprite2D

enum states {IDLE, JUMP, RUN, FALL, DEAD, JUMP_PAD}

const jump_pad_coef = 1.3
const SPEED = 300.0
const JUMP_VELOCITY = -600.0

var player_state := states.IDLE:
	set(value):
		player_state = value
		action()

var coins := 0
var direction := 0
var global_delta = 0

signal score_update

func _ready():
	player_state = states.IDLE

func die():
	coins = 0
	sprite.play("death")
	player_state = states.DEAD

func add_coin():
	coins += 1
	score_update.emit(coins)

func _physics_process(delta: float) -> void:
	global_delta = delta
	# Stop game
	if player_state == states.DEAD:
		return
	
	# Add the gravity.
	if not is_on_floor():
		player_state = states.FALL

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		player_state = states.JUMP

	# Handle movement
	direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		player_state = states.RUN
	else:
	# not moving
		player_state = states.IDLE
	move_and_slide()


func idle():
	sprite.play("idle")
	velocity.x = move_toward(velocity.x, 0, SPEED)

func jump():
	sprite.play("jump")
	velocity.y = JUMP_VELOCITY
	
func jump_pad():
	sprite.play("jump")
	velocity.y = JUMP_VELOCITY*jump_pad_coef

func fall():
	sprite.play("fall")
	velocity += get_gravity() * global_delta
	
func run():
	sprite.play("run")
	velocity.x = direction * SPEED
	if direction == -1:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

	
func action():
	match player_state:
		states.IDLE:
			idle()
		states.RUN:
			run()
		states.FALL:
			fall()
		states.JUMP:
			jump()
		states.DEAD:
			die()
		states.JUMP_PAD:
			jump_pad()
	
	

	
	
