extends State
class_name EntityState

onready var entity: Entity = owner as Entity


func enter():
	print("%s state: %s.enter()" % [owner.name, self.name])


func exit():
	print("%s state: %s.exit()" % [owner.name, self.name])
