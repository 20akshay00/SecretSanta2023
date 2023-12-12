extends RigidBody2D

@export var IMPULSE: float = 800.
@export var MAX_INPUT_LIMIT: float = 100.

@export var sprite: AnimatedSprite2D
@export var trajectory_guide: Line2D

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var _state = Enums.State.IDLE :
	set (value):
		_state = value
		if value == Enums.State.IDLE:
			trajectory_guide.hide()
		elif value == Enums.State.AIM:
			trajectory_guide.show()
		 
var _anchor_point := Vector2.ZERO
var _input_vector := Vector2.ZERO

func _process(_delta: float) -> void:		
	if _state == Enums.State.AIM:
		_input_vector = (
			_anchor_point - get_viewport().get_mouse_position()
			).limit_length(MAX_INPUT_LIMIT) / MAX_INPUT_LIMIT
		trajectory_guide.update(global_position, IMPULSE * _input_vector, gravity * Vector2(0, 1), _delta)
		
		sprite.flip_v = (_input_vector.x < 0.)
			
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_released("Aim") and _state == Enums.State.AIM:
		_launch()
		_state = Enums.State.IDLE

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if _state == Enums.State.AIM:
		rotation = lerp_angle(rotation, _input_vector.angle(), 0.3)
	elif _state == Enums.State.IDLE and get_contact_count() <= 1:
		rotation = lerp_angle(rotation, linear_velocity.angle(), 0.3)
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Aim"):
		_anchor_point = get_viewport().get_mouse_position()
		_state = Enums.State.AIM
	elif event.is_action_released("Aim") and _state == Enums.State.AIM:
		_launch()
		_state = Enums.State.IDLE
	elif event.is_action_pressed("Cancel"):
		_state = Enums.State.IDLE
		
func _launch() -> void:
	apply_impulse(IMPULSE * _input_vector)
	sprite.play("move")

func _on_body_entered(body: Node) -> void:
	sprite.play("idle")
