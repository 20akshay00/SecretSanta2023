extends Line2D

@export var MAX_POINTS: int = 100
@export var emulated_body: CharacterBody2D

func update(pos: Vector2, velocity: Vector2, gravity: Vector2, delta: float):
	clear_points()
	emulated_body.position = pos
	emulated_body.velocity = velocity
	
	for i in MAX_POINTS:
		add_point(emulated_body.position)
		emulated_body.velocity += Vector2(0., 980.) * delta
		
		var collision = emulated_body.move_and_collide(emulated_body.velocity * delta, false)
		if collision: break

	
		
