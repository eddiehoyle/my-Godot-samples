class_name Entity
extends KinematicBody2D


export(float) var max_speed = 80
export(float) var acceleration = 1800
export(float) var air_acceleration = 200
export(float) var friction = 1200
export(float) var air_friction = 800
export(float) var jump_power = 220
export(float) var gravity = -600

onready var pivot = $Pivot

var velocity: Vector2 = Vector2.ZERO
