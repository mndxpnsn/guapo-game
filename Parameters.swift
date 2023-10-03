//
//  Parameters.swift
//  SoloMission
//
//  Created by Derek Harrison on 25/09/2023.
//

import Foundation
import SpriteKit

let tot_num_birds = 12
var num_birds = 1
var num_jellyfish = 1
let num_cheesy_bites = 5
let num_cucumbers = 1
let num_paprikas = 1
let num_broccolis = 1
let num_beggin_strips = 1
let points_cheesy_bite = 1
let points_cucumber = 1
let points_paprika = 1
let points_broccoli = 3
let points_beggin_strip = 5
let num_frames_bird = 15
let num_points_when_birds_appear = 35
var gameScore = 0
var muted = false
let num_frames_change = 5
var bound_tracker = 1
let num_screen_lengths_for_disp = 10
let points_at_which_beggin_strips_appear = 50
let num_frames_sun_popup = 180
let bubble_vel_y = 5.0

let pause_button = SKSpriteNode(imageNamed: "pause_button_bitmap_cropped")
let play_button = SKSpriteNode(imageNamed: "play_button_bitmap_cropped")

let sun_popup_spr = SKSpriteNode(imageNamed: "sun_popup_bitmap_cropped")

let scoreLabel = SKLabelNode(fontNamed: "Courier-Bold")
let background_overlap = 10

let z_pos_player : CGFloat = CGFloat(tot_num_birds) * 5
let z_pos_snacks : CGFloat = CGFloat(tot_num_birds) * 2
let z_pos_chars : CGFloat = CGFloat(tot_num_birds) * 1
let z_pos_pause : CGFloat = CGFloat(tot_num_birds) * 5 + 1

let min_z_pos_jelly_fish = CGFloat(tot_num_birds) * 3
let min_z_pos_fishes = CGFloat(tot_num_birds) * 1
let min_z_pos_birds = min_z_pos_jelly_fish

let bulletSound = SKAction.playSoundFileNamed("sound_effect.wav", waitForCompletion: true)
let endSound = SKAction.playSoundFileNamed("tutti_0.wav", waitForCompletion: true)
let eat_sound1 = SKAction.playSoundFileNamed("tutti_eating_knaagstok.wav", waitForCompletion: true)
let eat_sound2 = SKAction.playSoundFileNamed("tutti_eating_tosti.wav", waitForCompletion: true)
let eat_sound3 = SKAction.playSoundFileNamed("tutti_eating_pathe.wav", waitForCompletion: true)
let frito_sound = SKAction.playSoundFileNamed("tutti_3.wav", waitForCompletion: true)
let brownie_sound = SKAction.playSoundFileNamed("tutti_6.wav", waitForCompletion: true)
let misty_sound = SKAction.playSoundFileNamed("tutti_1.wav", waitForCompletion: true)
let frito_sound_appearing = SKAction.playSoundFileNamed("cat_sound1.wav", waitForCompletion: true)
let brownie_sound_appearing = SKAction.playSoundFileNamed("tutti_5.wav", waitForCompletion: true)
let misty_sound_appearing = SKAction.playSoundFileNamed("misty_sounds.wav", waitForCompletion: true)
let sun_popup_sound = SKAction.playSoundFileNamed("sun_popup_sound.wav", waitForCompletion: true)
let bubbles_sounds = SKAction.playSoundFileNamed("bubble_sounds.wav", waitForCompletion: false)
let blowfish_sound = SKAction.playSoundFileNamed("tutti_4.wav", waitForCompletion: false)
