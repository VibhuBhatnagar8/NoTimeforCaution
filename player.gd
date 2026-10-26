extends CharacterBody3D

@export var speed: float = 6.0
@export var jump_velocity: float = 4.5
@export var mouse_sensitivity: float = 0.003
@export var touch_sensitivity: float = 0.005
@export var tilt_multiplier: float = 1.4
@export var time_left: float = 120.0

@onready var spring_arm: SpringArm3D = $SpringArm3D
@onready var robot_node: Node3D = $Robot
@onready var move_audio: AudioStreamPlayer3D = %AudioStreamPlayer3D
@onready var coyote_timer: Timer = $Timer
@onready var timer_label: Label3D = %TimerLabel

var camera_touch_index: int = -1

func _ready() -> void:
	# Only lock mouse cursor if running on desktop OS
	if OS.get_name() in ["Windows", "macOS", "Linux", "FreeBSD", "NetBSD", "OpenBSD", "BSD"]:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	# 1. Desktop Mouse Look
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		spring_arm.rotation.y -= event.relative.x * mouse_sensitivity
		spring_arm.rotation.x = clamp(
			spring_arm.rotation.x - event.relative.y * mouse_sensitivity,
			deg_to_rad(-75),
			deg_to_rad(30)
		)

	# 2. Mobile Touch Screen Look
	if event is InputEventScreenTouch:
		var screen_width = get_viewport().get_visible_rect().size.x
		if event.pressed:
			# Only capture touches starting on the right 60% of the screen (away from joystick)
			if event.position.x > screen_width * 0.4 and camera_touch_index == -1:
				camera_touch_index = event.index
		else:
			# Release touch index when finger is lifted
			if event.index == camera_touch_index:
				camera_touch_index = -1

	elif event is InputEventScreenDrag:
		# Process dragging only if it's from the camera-assigned finger
		if event.index == camera_touch_index:
			spring_arm.rotation.y -= event.relative.x * touch_sensitivity
			spring_arm.rotation.x = clamp(
				spring_arm.rotation.x - event.relative.y * touch_sensitivity,
				deg_to_rad(-75),
				deg_to_rad(30)
			)

func _process(delta: float) -> void:
	# Tick down the timer
	if time_left > 0:
		time_left -= delta
		if time_left < 0:
			time_left = 0
			%Panel.visible = true
			%"game over".play("RESET")
			%Debris.emitting = true
			%explode.play()
			%Fire.emitting = true
			%Robot.visible = false
			%Player.set_physics_process(false)
		
		var seconds := int(time_left) % 60
		var minutes := int(time_left) / 60
		timer_label.text = "%02d:%02d" % [minutes, seconds]

func _physics_process(delta: float) -> void:
	# 1. Track floor state before movement
	var was_on_floor: bool = is_on_floor()

	# 2. Apply gravity if in the air
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# 3. Handle movement inputs & rotation
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var camera_basis := spring_arm.global_transform.basis
	var direction := (camera_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction.y = 0
	var horizontal_speed = Vector2(velocity.x, velocity.z).length()
	if horizontal_speed > 0.1 and is_on_floor():
		if not move_audio.playing:
			move_audio.play()
	else:
		if move_audio.playing:
			move_audio.stop()
	
	if direction.length() > 0:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		
		var target_yaw = atan2(-direction.x, -direction.z) + PI
		robot_node.rotation.y = lerp_angle(robot_node.rotation.y, target_yaw, 15.0 * delta)
		
		var target_tilt = 0.0
		if is_on_floor():
			var normal = get_floor_normal()
			var fwd = -robot_node.global_transform.basis.z
			target_tilt = -asin(clamp(fwd.dot(normal), -1.0, 1.0)) * tilt_multiplier
		
		robot_node.rotation.x = lerp_angle(robot_node.rotation.x, target_tilt, 8.0 * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		
		var target_tilt = 0.0
		if is_on_floor():
			var normal = get_floor_normal()
			var fwd = -robot_node.global_transform.basis.z
			target_tilt = -asin(clamp(fwd.dot(normal), -1.0, 1.0)) * tilt_multiplier
			
		robot_node.rotation.x = lerp_angle(robot_node.rotation.x, target_tilt, 8.0 * delta)

	# 4. Handle Jump input (Ground or Coyote Time)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or not coyote_timer.is_stopped():
			velocity.y = jump_velocity
			coyote_timer.stop()
			print("Jump executed!")
			%Fire2.restart()
			$jump.play()

	# 5. Move character
	move_and_slide()
	
	if was_on_floor and not is_on_floor() and velocity.y <= 0:
		coyote_timer.start()
		print("Coyote timer started!")

	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
