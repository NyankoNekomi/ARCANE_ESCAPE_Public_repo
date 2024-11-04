extends Node

var ambient_sound = preload("res://sounds/ambience_dungeon.wav")
var BGM = preload("res://sounds/bgm.mp3")
var BGM_2 = preload("res://sounds/bgm_2.mp3")

var BUTTON_CLICK = preload("res://sounds/button_click.mp3")
const COIN = preload("res://sounds/coin.wav")
const GAME_OVER = preload("res://sounds/game_over.mp3")
const KEY_PICK = preload("res://sounds/key_pick.ogg")
const SPELL = preload("res://sounds/spell.ogg")
const UNLOCK = preload("res://sounds/unlock.ogg")
const SHORT_WHOOSH = preload("res://sounds/short-whoosh.wav")
const POISON = preload("res://sounds/poison.wav")
const BOOK_01 = preload("res://sounds/book_01.ogg")

@onready var bgm = $bgm
@onready var amb = $amb


func _ready():
	
	bgm.stream = BGM
	bgm.play()
	bgm.volume_db = -10
func _process(delta):
	pass

func play_sfx(sfx_name: String):
	
	
	var stream = null
	
	if sfx_name == "button_click.mp3":
		stream = BUTTON_CLICK
	elif sfx_name == "coin.wav":
		stream = COIN
	elif sfx_name == "spell.ogg":
		stream = SPELL
	elif sfx_name == "game_over.mp3":
		stream = GAME_OVER
	elif sfx_name == "key_pick.wav":
		stream = KEY_PICK
	elif sfx_name == "unlock.wav":
		stream = UNLOCK
	elif sfx_name == "short-whoosh.wav":
		stream = SHORT_WHOOSH
	elif sfx_name == "poison.wav":
		stream = POISON
	elif sfx_name == "book_01.ogg":
		stream = BOOK_01
	else:
		print("invalid")
		return
	
	var asp = AudioStreamPlayer.new()
	asp.stream = stream
	asp.name = "SFX"
	add_child(asp)
	asp.play()
	
	await asp.finished
	asp.queue_free()
