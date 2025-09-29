extends CharacterBody2D

@export var speed := 120.0

var nearby_interactables: Array = []

func _physics_process(delta):
	var dir := Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		dir.x += 1
	if Input.is_action_pressed("move_left"):
		dir.x -= 1
	if Input.is_action_pressed("move_down"):
		dir.y += 1
	if Input.is_action_pressed("move_up"):
		dir.y -= 1

	velocity = dir.normalized() * speed
	move_and_slide()

func _input(event):
	if event.is_action_pressed("interact"):
		if nearby_interactables.size() > 0:
			# interact with the closest (first in list for now)
			var target = nearby_interactables[0]
			if target and target.has_method("interact"):
				target.interact()

# Signals from InteractZone (Area2D)
func _on_interact_zone_body_entered(body):
	if body and body.has_method("interact"):
		if not nearby_interactables.has(body):
			nearby_interactables.append(body)

func _on_interact_zone_body_exited(body):
	if body:
		nearby_interactables.erase(body)
