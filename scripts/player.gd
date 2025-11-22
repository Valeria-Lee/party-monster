extends CharacterBody3D

@onready var anim = $AnimatedSprite3D
@onready var walking_particles = $CPUParticles3D
const SPEED = 40.0
var inv = load("res://inventory/player_inventory.tres")

var just_stop_walking = false

func _ready():
	pass

func _physics_process(delta):
	var input = Input.get_axis("move_back", "move_forward")
	
	velocity.x = input * SPEED * delta
	
	play_anim(input)
	
	#if velocity.x != 0:
	#	add_walking_particles()
	
	move_and_slide()

func play_anim(dir:int):
	if dir == -1:
		anim.flip_h = true
	if dir == 1:
		anim.flip_h = false
	
	if velocity.x != 0:
		anim.play("walk")
	else:
		anim.play("idle")
		just_stop_walking = true

func collect_item(item:Item):
	if Money.money - item.price >= 0:
		pay(item)
		inv.add_item(item)
	print(inv)

func pay(item:Item):
	Money.money = Money.money - item.price
