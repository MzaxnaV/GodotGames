extends Node

onready var state_map = {
	'start' : $StartState,
	'play' : $PlayState
}

var current_state = null
var params = null

func _ready():
	change_state('start')

func change_state(stateName):
	if (current_state):
		params = current_state.exit()
	current_state = state_map[stateName]
	current_state.enter(params)

func _physics_process(delta):
	current_state.update_physics(delta)

func _process(delta):
	current_state.update(delta)

func _input(event):
	current_state.handle_event(event)