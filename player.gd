extends CharacterBody2D

var fire_count = 0

	
const SPEED = 400.0
const JUMP_VELOCITY = -900.0
	
func _physics_process(delta: float) -> void:


	if not is_on_floor():
		velocity += get_gravity() * delta
			
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 12)
	
	move_and_slide()
	if fire_count == 3:
		get_tree().change_scene_to_file("res://menu.tscn")

func _on_pickup_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("fire") and not $Heldfire.visible:
		area.queue_free()
		$Heldfire.visible = true

	if area.is_in_group("basket") and $Heldfire.visible:
		$Heldfire.visible = false
		fire_count += 1
		$CanvasLayer/FireCountDisplay.text = "fires: " + str(fire_count)
