# res://systems/TimeSystem.gd
extends Node

var heure = 8
var minute = 0
var jour = 1

func _process(delta):
    minute += delta * 60  # 1 min = 1 sec réel
    if minute >= 60:
        minute = 0
        heure += 1
        if heure >= 24:
            heure = 0
            jour += 1