//
//  GameLevel.swift
//  SoloMission
//
//  Created by Derek Harrison on 29/09/2023.
//

import Foundation
import SpriteKit

class GameLevel {
 
    var player = Player()
    
    var level_id : Int = 0
    
    var muted = false
    var highScore = 0
    var birds = [Bird]()
    var jellyfishes = [JellyFish]()
    var cheesy_bites = [Snack]()
    var cucumbers = [Snack]()
    var paprikas = [Snack]()
    var beggin_strips = [Snack]()
    var broccolis = [Snack]()
    
    var width_background : CGFloat = 0
    var black_background_bot = SKSpriteNode(imageNamed: BACKGROUND_OPAQUE_STR)
    var black_background_top = SKSpriteNode(imageNamed: BACKGROUND_OPAQUE_STR)
    var backgrounds = [SKSpriteNode]()
    
    var frito = Frito()
    var brownie = Brownie()
    var misty = Misty()
    var fish1 = GameObject()
    var fish2 = GameObject()
    var fish3 = GameObject()
    var fish4 = GameObject()
    var fish5 = GameObject()
    var fish6 = GameObject()
    var blow_fish = BlowFish()
    
    var background_speed: CGFloat = 0
    
    var currentGameState = gameState.preGame
    var num_backgrounds = 10
    
    var is_already_unlocked = false
    var sun_popup_frame_counter = 0
    var play_sun_pop_up = true

    var move_counter = 0
    var is_up = true

    var r_o = CGPoint(x: 0, y: 0)
    
    var play_misty_guard = 20
    
    var scene = SKScene()

    func didMove(scene: SKScene, id : Int) {
        
        num_birds = 2
        self.scene = scene
        
        // Add Player
        add_player()
        
        // Init common data
        init_common(scene: scene, id: id)
    }
    
    func didMove_ocean(scene: SKScene, id : Int) {
        
        num_jellyfish = 2
        self.scene = scene
                
        // Add Player
        add_player_ocean()
        
        // Add fish
        init_fish(width: scene.size.width, height: scene.size.height)
        
        // Init common data
        init_common(scene: scene, id: id)
    }
    
    func update(scene : SKScene) {

        //Update score text
        scoreLabel.text = String(gameScore)
        
        //Sun pop up
        sun_pop_up()
                
        if self.currentGameState == gameState.inGame {
            move_counter += 1
        }
        
        //Increase number of birds in game
        update_num_birds()
        
        if self.currentGameState == gameState.inGame {
            
            //Update player
            update_player()
            
            //Update positions of birds and detect overlap
            update_birds()
        
            //Update positions of snacks and detect eating snacks
            update_snacks()
            
            pop_frito()
            
            pop_brownie()
            
            pop_misty()
            
            update_backgrounds(scene : scene, backgrounds : backgrounds, vel_x : -background_speed)
        }
    }
    
    func update_ocean(scene : SKScene) {

        //Update score text
        scoreLabel.text = String(gameScore)
        
        if self.currentGameState == gameState.inGame {
            move_counter += 1
        }
        
        //Increase number of jellys in game
        update_num_jelly()
        
        if self.currentGameState == gameState.inGame {
            
            //Update player
            update_player_ocean()
            
            //Update positions of birds and detect overlap
            update_jellyfish()
            
            // Update fish1
            update_fish()
            
            update_blow_fish()
            
            update_snacks()
            
            pop_frito_ocean()
            
            pop_brownie_ocean()
            
            pop_misty_ocean()
            
            update_backgrounds(scene : scene, backgrounds : backgrounds, vel_x : -background_speed)
        }
    }
    
    func update_snacks() {
        //Update positions of snacks and detect eating snacks
        update_snack(cucumbers : cheesy_bites, background_speed : background_speed)

        //Update positions of cucumbers and detect eating cucumber
        update_snack(cucumbers : cucumbers, background_speed : background_speed)
        
        //Update positions of paprikas and detect eating paprika
        update_snack(cucumbers : paprikas, background_speed : background_speed)
        
        //Update positions of broccolis and detect eating broccoli
        update_snack(cucumbers : broccolis, background_speed : background_speed)
        
        //Update positions of beggin strips and detect eating beggin strip
        if gameScore >= points_at_which_beggin_strips_appear {
            update_snack(cucumbers : beggin_strips, background_speed : background_speed)
        }
    }
    
    func init_fish(width : CGFloat, height : CGFloat) {
        fish1.add_image(image: FISH_IMAGE_1)
        fish1.add_image(image: FISH_IMAGE_2)
        fish1.set_height(height : height)
        fish1.set_width(width : width)
        fish1.set_size(size: CGSize(width : width / 7.5, height : height / 7.5))
        fish1.set_pos(pos: CGPoint(x: -1000, y: 0))
        fish1.set_z_pos(z_pos: min_z_pos_fishes)
        fish1.add_childs(scene: scene)
        
        fish2.add_image(image: FISH_IMAGE_2A)
        fish2.add_image(image: FISH_IMAGE_2B)
        fish2.set_height(height : height)
        fish2.set_width(width : width)
        fish2.set_size(size: CGSize(width : width / 7.5, height : height / 7.5))
        fish2.set_pos(pos: CGPoint(x: -1000, y: 0))
        fish2.set_z_pos(z_pos: min_z_pos_fishes)
        fish2.add_childs(scene: scene)
        
        fish3.add_image(image: FISH_IMAGE_3A)
        fish3.add_image(image: FISH_IMAGE_3B)
        fish3.set_height(height : height)
        fish3.set_width(width : width)
        fish3.set_size(size: CGSize(width : width / 7.5, height : height / 7.5))
        fish3.set_pos(pos: CGPoint(x: -1000, y: 0))
        fish3.set_z_pos(z_pos: min_z_pos_fishes)
        fish3.add_childs(scene: scene)
        
        fish4.add_image(image: FISH_IMAGE_4A)
        fish4.add_image(image: FISH_IMAGE_4B)
        fish4.set_height(height : height)
        fish4.set_width(width : width)
        fish4.set_size(size: CGSize(width : width / 7.5, height : height / 7.5))
        fish4.set_pos(pos: CGPoint(x: -1000, y: 0))
        fish4.set_z_pos(z_pos: min_z_pos_fishes)
        fish4.add_childs(scene: scene)
        
        fish5.add_image(image: FISH_IMAGE_5A)
        fish5.add_image(image: FISH_IMAGE_5B)
        fish5.set_height(height : height)
        fish5.set_width(width : width)
        fish5.set_size(size: CGSize(width : width / 7.5, height : height / 7.5))
        fish5.set_pos(pos: CGPoint(x: 10 * width, y: 0))
        fish5.set_z_pos(z_pos: min_z_pos_fishes)
        fish5.add_childs(scene: scene)
        
        fish6.add_image(image: FISH_IMAGE_6A)
        fish6.add_image(image: FISH_IMAGE_6B)
        fish6.set_height(height : height)
        fish6.set_width(width : width)
        fish6.set_size(size: CGSize(width : width / 7.5, height : height / 7.5))
        fish6.set_pos(pos: CGPoint(x: 10 * width, y: 0))
        fish6.set_z_pos(z_pos: min_z_pos_fishes)
        fish6.add_childs(scene: scene)
        
        blow_fish.add_image(image: BLOW_FISH_IMAGE_1)
        blow_fish.add_image(image: BLOW_FISH_IMAGE_2)
        blow_fish.add_image_hit(image: BLOW_FISH_IMAGE_3)
        blow_fish.add_image_hit(image: BLOW_FISH_IMAGE_4)
        blow_fish.set_height(height : height)
        blow_fish.set_width(width : width)
        blow_fish.set_size(size: CGSize(width : width / 7.5, height : height / 7.5))
        blow_fish.set_pos(pos: CGPoint(x: -1000, y: 0))
        blow_fish.set_z_pos(z_pos: min_z_pos_fishes)
        blow_fish.add_childs(scene: scene)
    }
    
    func init_images_frito(images : [String], height : CGFloat, width : CGFloat) {
        for image in images {
            frito.add_image(image : image)
        }
        frito.set_height(height : height)
        frito.set_width(width : width)
        frito.set_size(size: CGSize(width : width / 7.5, height : height / 7.5))
        frito.set_vel(vel_x: -2 * background_speed, vel_y: -2 * background_speed)
        frito.set_z_pos(z_pos: z_pos_chars)
        frito.set_pos(pos: CGPoint(x : -width, y : height * 0.75 + frito.images[0].size.height / 2))
        frito.add_childs(scene: scene)
    }
    
    func init_images_brownie(images : [String], height : CGFloat, width : CGFloat) {
        for image in images {
            brownie.add_image(image : image)
        }
        brownie.set_height(height : height)
        brownie.set_width(width : width)
        brownie.set_size(size: CGSize(width : width / 7.5, height : height / 7.5))
        brownie.set_vel(vel_x: -2 * background_speed, vel_y: -2 * background_speed)
        brownie.set_z_pos(z_pos: 100000)
        brownie.set_pos(pos: CGPoint(x : -width, y : height * 0.75 + brownie.images[0].size.height / 2))
        
        brownie.add_childs(scene: scene)
    }
    
    func init_images_misty(images : [String], height : CGFloat, width : CGFloat) {
        for image in images {
            misty.add_image(image : image)
        }
        misty.set_height(height : height)
        misty.set_width(width : width)
        misty.set_size(size: CGSize(width : width / 7.5, height : height / 7.5))
        misty.set_vel_misty(vx: 0, vy: -background_speed)
        misty.set_z_pos(z_pos: 100000)
        misty.set_pos(pos: CGPoint(x : width / 2, y : height * 0.75 + misty.images[0].size.height / 2))
        
        misty.add_childs(scene: scene)
    }
    
    func init_common(scene : SKScene, id : Int) {
        
        level_id = id
        play_sun_pop_up = true
        sun_popup_frame_counter = 0
        gameScore = 0
        bound_tracker = 1
        background_speed = scene.size.width / 400
        
        let width = scene.size.width
        let height = scene.size.height
        
        add_snacks(scene : scene)
        
        pause_button.setScale(1)
        pause_button.size = CGSize(width: width / 28, height: height / 28)
        pause_button.position = CGPoint(x: width - width / 12, y: height / 2 + height * 1.9 / 5 / 2)
        pause_button.zPosition = z_pos_pause
        pause_button.removeFromParent()
        scene.addChild(pause_button)
        
        play_button.setScale(1)
        play_button.size = CGSize(width: width / 28, height: height / 28)
        play_button.position = pause_button.position
        play_button.zPosition = -1
        play_button.removeFromParent()
        scene.addChild(play_button)
        
        sun_popup_spr.setScale(1)
        sun_popup_spr.size = CGSize(width: width / 7, height: height / 7)
        sun_popup_spr.position = CGPoint(x: width / 2 + sun_popup_spr.size.width / 5, y: height / 2 + height / 4 - sun_popup_spr.size.height / 2 - width / 11)
        sun_popup_spr.zPosition = -1
        sun_popup_spr.removeFromParent()
        scene.addChild(sun_popup_spr)
        
        scoreLabel.text = "0"
        scoreLabel.fontSize = 100
        scoreLabel.fontColor = SKColor.gray
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position = CGPoint(x: scene.size.width/12, y: scene.size.height/2 + scene.size.height*1.8/5/2)
        
        scoreLabel.zPosition = z_pos_pause
        scoreLabel.removeFromParent()
        scene.addChild(scoreLabel)
        
        let defaults = UserDefaults()
        if level_id == LEVEL_ID_1 {
            highScore = defaults.integer(forKey: HIGH_SCORE_ID_1)
        }
        if level_id == LEVEL_ID_2 {
            highScore = defaults.integer(forKey: HIGH_SCORE_ID_2)
        }
        if level_id == LEVEL_ID_3 {
            highScore = defaults.integer(forKey: HIGH_SCORE_ID_3)
        }
        if level_id == LEVEL_ID_4 {
            highScore = defaults.integer(forKey: HIGH_SCORE_ID_4)
        }
        if level_id == LEVEL_ID_5 {
            highScore = defaults.integer(forKey: HIGH_SCORE_ID_5)
        }

        is_already_unlocked = highScore >= unlock_level_points
        muted = defaults.bool(forKey: GAME_MUTED)

        mute_bubbles(bubbles : player.bubbles, mute : muted)
        mute_bubbles(bubbles : frito.bubbles, mute : muted)
        mute_bubbles(bubbles : brownie.bubbles, mute : muted)
        mute_bubbles(bubbles : misty.bubbles, mute : muted)
        
        startGame()
    }
    
    func mute_bubbles(bubbles : Bubbles, mute : Bool) {
        bubbles.is_muted = mute
    }
    
    func update_player_ocean() {
        player.update_pos_api()
        
        player.bubbles.pop_bubbles_api(pos : player.get_pos(), scene : scene, sound : [bubbles_sounds])
    }
    
    func init_background(scene : SKScene, num_backgrounds : Int, string1 : String) {
        black_background_top.size = CGSize(width: scene.size.width, height: scene.size.height / 4)
        black_background_top.position = CGPoint(x: scene.size.width / 2, y: scene.size.height * 0.75 + scene.size.height / 4 / 2)
        black_background_top.zPosition = 10000
        black_background_bot.size = CGSize(width: scene.size.width, height: scene.size.height / 4)
        black_background_bot.position = CGPoint(x: scene.size.width / 2, y: scene.size.height * 0.25 - scene.size.height / 4 / 2)
        black_background_bot.zPosition = 10000
        scene.addChild(black_background_top)
        scene.addChild(black_background_bot)
        
        self.num_backgrounds = num_backgrounds
        
        for i in 0..<num_backgrounds {
            let string2 = String(i + 1)
            let image_name = string1 + string2
            let background = SKSpriteNode(imageNamed: image_name)
            
            background.size = CGSize(width: scene.size.width, height: scene.size.height / 2)
                        
            width_background = background.size.width
            
            background.anchorPoint = CGPoint(x: 0, y: 0.5)
            background.position = CGPoint(x: width_background * CGFloat(i) - CGFloat(background_overlap * i), y: scene.size.height / 2)
            
            background.zPosition = 0
            backgrounds.append(background)
            scene.addChild(background)
        }
    }
    
    func init_snack(bite : String, points : Int, num_cheesy_bites : Int, cheesy_bites : inout [Snack], scene : SKScene) {
        for _ in 0..<num_cheesy_bites {
            
            let size = CGSize(width: scene.size.width / 14, height: scene.size.height / 14)
            let bite_image = bite
            
            let cheesy_bite = Snack(bite: bite_image, points: points_cheesy_bite, size: size, z_pos: z_pos_snacks)
            
            cheesy_bite.add_childs(scene: scene)

            let factor = 1.0 - (cheesy_bite.get_size().height) / (scene.size.height / 2)
            let pos_x = get_rand_num() * scene.size.width * 2
            let pos_y = get_rand_num() * scene.size.height / 2 * factor + scene.size.height / 4 + 1/2 * (1 - factor) * scene.size.height / 2
            
            cheesy_bite.set_pos(pos: CGPoint(x: pos_x, y: pos_y))
            cheesy_bite.set_vel(vel_x: -background_speed, vel_y: 0)
            cheesy_bite.points_snack = points
            cheesy_bites.append(cheesy_bite)
        }
    }
    
    func update_backgrounds(scene : SKScene, backgrounds : [SKSpriteNode], vel_x : CGFloat) {

        let n = backgrounds.count
        
        for j in 0..<n {
            backgrounds[j].position.x += vel_x
            if(backgrounds[j].position.x < -backgrounds[j].size.width && j > 0) {
                backgrounds[j].position.x = backgrounds[j - 1].position.x + backgrounds[j - 1].size.width - backgrounds[j].size.width / 100
            }
            if(backgrounds[j].position.x < -backgrounds[j].size.width && j == 0) {
                backgrounds[j].position.x = backgrounds[n - 1].position.x + backgrounds[n - 1].size.width - backgrounds[j].size.width / 100
            }
        }
    }
    
    func add_bubbles(bubbles_char : Bubbles, bubble_image : String) {
        bubbles_char.add_bubble(image_id: bubble_image)
        bubbles_char.add_bubble(image_id: bubble_image)
        bubbles_char.add_bubble(image_id: bubble_image)
    }
    
    func add_birds(images : [String]) {
        for j in 0..<num_birds {
            
            var bird_images = [String]()
            
            for x in images {
                bird_images.append(x)
            }
            
            let z_pos = CGFloat(j) + min_z_pos_birds
            let size = CGSize(width: scene.size.width / 10, height: scene.size.height / 10)
            
            let bird = Bird(birds: bird_images, size: size, z_pos: z_pos)
            
            bird.add_childs(scene : scene)

            birds.append(bird)
            
        }
    }
    
    func add_jellyfish(images : [String]) {
        for j in 0..<num_jellyfish {
            
            var jelly_images = [String]()
            
            for x in images {
                jelly_images.append(x)
            }
            
            let z_pos = CGFloat(j) + min_z_pos_jelly_fish
            let size = CGSize(width: scene.size.width / 10, height: scene.size.height / 10)
            
            let jelly = JellyFish(jelly_fish: jelly_images, size: size, z_pos: z_pos)
            jelly.add_childs(scene : scene)

            jellyfishes.append(jelly)
        }
    }
    
    func add_player() {
        let size = CGSize(width: scene.size.width / 5, height: scene.size.height / 7.5)
        
        var player_images : [String] = [String]()
        player_images.append(PLAYER_IMAGE_1)
        player_images.append(PLAYER_IMAGE_2)
        
        player = Player(images: player_images, size: size, z_pos: z_pos_player)
        player.add_image_hit(image: PLAYER_IMAGE_HIT, size: size, z_pos: -1)
        player.add_childs(scene : scene)
        player.set_vel(vel_x: 0, vel_y: 0)
        player.set_pos(pos: CGPoint(x : scene.size.width / 5, y : scene.size.height / 2))
        player.set_height(height : scene.size.height)
        player.set_width(width : scene.size.width)
    }
    
    func add_player_ocean() {
        let size = CGSize(width: scene.size.width / 5, height: scene.size.height / 7.5)
        
        var player_images : [String] = [String]()
        player_images.append(PLAYER_SNORKEL)
        
        
        player = Player(images: player_images, size: size, z_pos: z_pos_player)
        player.add_image_hit(image: PLAYER_SNORKEL_HIT, size: size, z_pos: -1)
        player.set_vel(vel_x: 0, vel_y: 0)
        player.set_pos(pos: CGPoint(x : scene.size.width / 5, y : scene.size.height / 2))
        player.set_height(height : scene.size.height)
        player.set_width(width : scene.size.width)
        player.bubbles.add_bubble(image_id: BUBBLE_IMAGE_STR)
        player.bubbles.add_bubble(image_id: BUBBLE_IMAGE_STR)
        player.bubbles.add_bubble(image_id: BUBBLE_IMAGE_STR)
        
        for x in player.bubbles.bubbles {
            scene.addChild(x)
        }
        player.add_childs(scene : scene)
    }
    
    func add_snacks(scene : SKScene) {
        init_snack(bite : CHEESY_BITE_IMAGE, points: points_cheesy_bite, num_cheesy_bites : num_cheesy_bites, cheesy_bites : &cheesy_bites, scene : scene)
        
        init_snack(bite : PAPRIKA_IMAGE, points: points_paprika, num_cheesy_bites : num_paprikas, cheesy_bites : &paprikas, scene : scene)
        
        init_snack(bite : BROCCOLI_IMAGE, points: points_broccoli, num_cheesy_bites : num_broccolis, cheesy_bites : &broccolis, scene : scene)
        
        init_snack(bite : CUCUMBER_IMAGE, points: points_cucumber, num_cheesy_bites : num_cucumbers, cheesy_bites : &cucumbers, scene : scene)
        
        init_snack(bite : BEGGIN_IMAGE, points: points_beggin_strip, num_cheesy_bites : num_beggin_strips, cheesy_bites : &beggin_strips, scene : scene)
        
        // Move beggin strips out of bounds
        for strip in beggin_strips {
            strip.set_pos(pos: CGPoint(x : -1000, y : 0))
        }
    }
    
    func update_snack(cucumbers : [Snack], background_speed : CGFloat) {
        for cucumber in cucumbers {
            cucumber.update_pos(scene: scene)
            cucumber.set_vel(vel_x: -background_speed, vel_y: 0)
            
            if check_collision(bird : cucumber, player : player, den : 2.5) {
                cucumber.set_pos(pos: CGPoint(x: -scene.size.width * 10, y: 0))
                
                if muted == false {
                    play_sound_api(scene: scene, sound: [eat_sound1])
                }
                
                gameScore += cucumber.points_snack
            }
        }
    }
    
    func pop_frito() {
        if frito.appeared  {

            if muted == false && frito.play_sound {
                play_sound_api(scene: scene, sound: [frito_sound_appearing])
                frito.play_sound = false
            }
        }

        frito.update_pos_api(scene: scene)
        
        if check_collision(bird : frito, player : player, den : 2.5) {
            frito.hit = true

            if muted == false && frito.play_hit_sound {
                play_sound_api(scene: scene, sound: [frito_sound])
                frito.play_hit_sound = false
            }
        }
    }
    
    func pop_brownie() {
        if brownie.appeared  {

            if muted == false && brownie.play_sound {
                play_sound_api(scene: scene, sound: [brownie_sound_appearing])
                brownie.play_sound = false
            }
        }

        brownie.update_pos_api(scene: scene)
        
        if check_collision(bird : brownie, player : player, den : 2.5) {
            brownie.hit = true

            if muted == false && brownie.play_hit_sound {
                play_sound_api(scene: scene, sound: [brownie_sound])
                brownie.play_hit_sound = false
            }
        }
    }
    
    func pop_misty() {
        misty.pop_misty(height : misty.height, speed : background_speed)
        
        if check_collision(bird : misty, player : player, den : 2.5) {
            misty.hit = true
            
            if muted == false && misty.play_sound {
                misty.play_sound = false
                play_sound_api(scene: scene, sound: [misty_sound])
            }
        }
        
        if gameScore >= play_misty_guard {
            play_misty_guard += 20
            misty.play_misty(bool: Bool.random())
            if misty.top {
                misty.set_pos(pos: CGPoint(x : misty.width / 2, y : misty.height * 0.75 + misty.images[0].size.height / 2))
                misty.set_vel_misty(vx: misty.vel_x, vy: -background_speed)
            }
            else {
                misty.set_pos(pos: CGPoint(x : misty.width / 2, y : misty.height * 0.25 - misty.images[0].size.height / 2))
                misty.set_vel_misty(vx: misty.vel_x, vy: background_speed)
            }
            
            misty.play_sound = true
            misty.hit = false
            
            if muted == false {
                play_sound_api(scene: scene, sound: [misty_sound_appearing])
            }
        }
    }
    
    func pop_frito_ocean() {
        if frito.appeared  {

            if muted == false && frito.play_sound {
                play_sound_api(scene: scene, sound: [frito_sound_appearing])
                frito.play_sound = false
            }
            
            frito.bubbles.pop_bubbles_api(pos: frito.get_pos(), scene : scene, sound : [bubbles_sounds])
        }
        else {
            frito.bubbles.set_pos_bubbles(pos: CGPoint(x: -1000, y: 0))
        }

        frito.update_pos_api(scene: scene)
        
        if check_collision(bird : frito, player : player, den : 2.5) {
            frito.hit = true

            if muted == false && frito.play_hit_sound {
                play_sound_api(scene: scene, sound: [frito_sound])
                frito.play_hit_sound = false
            }
        }
    }
    
    func pop_brownie_ocean() {
        if brownie.appeared  {

            if muted == false && brownie.play_sound {
                play_sound_api(scene: scene, sound: [brownie_sound_appearing])
                brownie.play_sound = false
            }
            
            brownie.bubbles.pop_bubbles_api(pos: brownie.get_pos(), scene : scene, sound : [bubbles_sounds])

        }
        else {
            brownie.bubbles.set_pos_bubbles(pos: CGPoint(x: -1000, y: 0))
        }

        brownie.update_pos_api(scene: scene)
        
        if check_collision(bird : brownie, player : player, den : 2.5) {
            brownie.hit = true

            if muted == false && brownie.play_hit_sound {
                play_sound_api(scene: scene, sound: [brownie_sound])
                brownie.play_hit_sound = false
            }
        }
    }
    
    func pop_misty_ocean() {
        misty.pop_misty(height : misty.height, speed : background_speed)
        
        if check_collision(bird : misty, player : player, den : 2.5) {
            misty.hit = true
            
            if muted == false && misty.play_sound {
                play_sound_api(scene: scene, sound: [misty_sound])
                misty.play_sound = false
            }
        }
        
        if gameScore >= play_misty_guard {
            play_misty_guard += 20
            misty.play_misty(bool: Bool.random())
            if misty.top {
                misty.set_pos(pos: CGPoint(x : misty.width / 2, y : misty.height * 0.75 + misty.images[0].size.height / 2))
                misty.set_vel_misty(vx: misty.vel_x, vy: -background_speed)
            }
            else {
                misty.set_pos(pos: CGPoint(x : misty.width / 2, y : misty.height * 0.25 - misty.images[0].size.height / 2))
                misty.set_vel_misty(vx: misty.vel_x, vy: background_speed)
            }
            
            misty.play_sound = true
            misty.hit = false
            
            if muted == false {
                play_sound_api(scene: scene, sound: [misty_sound_appearing])
            }
        }
        else if gameScore < play_misty_guard - 15 {
            misty.bubbles.pop_bubbles_api(pos: misty.get_pos(), scene : scene, sound : [bubbles_sounds])
        }
        else {
            misty.set_pos(pos: CGPoint(x: -1000, y: 0))
            misty.bubbles.set_pos_bubbles(pos: CGPoint(x: -1000, y: 0))
        }
    }
    
    func update_jellyfish() {
        for jelly in jellyfishes {
            jelly.update_pos(scene : scene, bk_speed: -background_speed)
            jelly.update_pos_api()
            
            if check_collision(bird : jelly, player : player, den : 3.5) {

                if muted == false {
                    play_sound_api(scene: scene, sound: [endSound])
                }
                
                self.currentGameState = gameState.afterGame
                runGameOver(high_score_id: HIGH_SCORE_ID_4)
            }
        }
    }
    
    func update_fish() {
        fish1.update_pos(scene : scene, bk_speed : -background_speed)
        fish2.update_pos(scene : scene, bk_speed : -background_speed)
        fish3.update_pos(scene : scene, bk_speed : -background_speed)
        fish4.update_pos(scene : scene, bk_speed : -background_speed)
        fish5.update_pos_rev(scene : scene, bk_speed : background_speed)
        fish6.update_pos_rev(scene : scene, bk_speed : background_speed)
    }
    
    func update_blow_fish() {
        
        blow_fish.update_pos_api(scene: scene, bk_speed: -background_speed)
        
        if check_collision(bird : blow_fish, player : player, den : 3.5) {

            if muted == false && blow_fish.play_hit_sound {
                play_sound_api(scene: scene, sound: [blowfish_sound])
            }
            blow_fish.play_sound = false
            blow_fish.play_hit_sound = false
            blow_fish.hit = true
        }
    }
    
    func update_player() {
        player.update_pos_api()
    }
    
    func update_birds() {
        for bird in birds {
            bird.update_pos(scene : scene, bk_speed: -background_speed)

            if check_collision(bird : bird, player : player, den : 3.5) {

                if muted == false {
                    play_sound_api(scene: scene, sound: [endSound])
                }
                
                self.currentGameState = gameState.afterGame
                
                if(level_id == LEVEL_ID_1) {
                    runGameOver(high_score_id: HIGH_SCORE_ID_1)
                }
                if(level_id == LEVEL_ID_2) {
                    runGameOver(high_score_id: HIGH_SCORE_ID_2)
                }
                if(level_id == LEVEL_ID_3) {
                    runGameOver(high_score_id: HIGH_SCORE_ID_3)
                }
                if(level_id == LEVEL_ID_5) {
                    runGameOver(high_score_id: HIGH_SCORE_ID_5)
                }
            }
        }
    }
    
    func sun_pop_up() {
        if gameScore >=  unlock_level_points && !is_already_unlocked && sun_popup_frame_counter <= num_frames_sun_popup {
            sun_popup_frame_counter += 1
            if muted == false && play_sun_pop_up {
                play_sound_api(scene: scene, sound: [sun_popup_sound])
                play_sun_pop_up = false
            }
            
            sun_popup_spr.zPosition = 20
        }
        else {
            //Reset sun popup zposition
            sun_popup_spr.zPosition = -1
        }
    }
    
    func update_num_birds() {
        if gameScore >= bound_tracker * num_points_when_birds_appear && birds.count < tot_num_birds {
            
            let image_names = self.birds[0].image_names
            let size = self.birds[0].images[0].size
            
            let bird = Bird(birds: image_names, size: size, z_pos: CGFloat(birds.count) + min_z_pos_birds)
            bird.add_childs(scene : scene)
            
            birds.append(bird)
            
            bound_tracker += 1
        }
    }
    
    func update_num_jelly() {
        if gameScore >= bound_tracker * num_points_when_birds_appear && jellyfishes.count < tot_num_birds {
            
            let image_names = self.jellyfishes[0].image_names
            let size = self.jellyfishes[0].images[0].size
            
            let jelly = JellyFish(jelly_fish: image_names, size: size, z_pos: CGFloat(jellyfishes.count) + min_z_pos_birds)
            jelly.add_childs(scene : scene)
            
            jellyfishes.append(jelly)
            
            bound_tracker += 1
        }
    }
    
    func runGameOver(high_score_id : String) {
        
        if gameScore > highScore {
            let defaults = UserDefaults()
            defaults.set(gameScore, forKey: high_score_id)
        }
        
        player.set_z_pos(z_pos: -1)
        player.image_hit.zPosition = z_pos_player
        
        let changeSceneAction = SKAction.run(changeScene)
        let waitToChangeScene = SKAction.wait(forDuration: 1)
        let changeSceneSequence = SKAction.sequence([waitToChangeScene, changeSceneAction])
        scene.run(changeSceneSequence)
    }
    
    func changeScene() {
        
        let sceneToMoveTo = MainMenuScene(size: scene.size)
        sceneToMoveTo.scaleMode = scene.scaleMode
        let myTransition = SKTransition.fade(withDuration: 0.5)
        scene.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func startGame() {
        currentGameState = gameState.inGame
    }
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if currentGameState == gameState.preGame {
            startGame()
            player.set_vel(vel_x: 0, vel_y: 0)
        }
        else if currentGameState == gameState.inGame {
            
            for touch: AnyObject in touches {
                let pointOfTouch = touch.location(in: scene)
                
                let position = CGPoint(x: scene.size.width - 2 * scene.size.width / 12, y: scene.size.height / 2 + scene.size.height * 1.5 / 10)
                
                let touch_in_game_area = pointOfTouch.x > 0 && pointOfTouch.x < scene.size.width && pointOfTouch.y > scene.size.height / 4 && pointOfTouch.y < 0.75 * scene.size.height
                
                if pointOfTouch.x > position.x && pointOfTouch.y > position.y {
                    currentGameState = gameState.gamePaused
                    pause_button.zPosition = -1
                    play_button.zPosition = z_pos_pause
                }
                else if touch_in_game_area {
                    player.set_pos_api(pos: pointOfTouch)
                    player.set_vel(vel_x: 0, vel_y: 0)
                }
            }
        }
        else if currentGameState == gameState.gamePaused {
            
            for touch: AnyObject in touches {
                let pointOfTouch = touch.location(in: scene)
                
                let position = CGPoint(x: scene.size.width - 2*scene.size.width/12, y: scene.size.height/2 + scene.size.height*1.5/5/2)
                
                if pointOfTouch.x > position.x  && pointOfTouch.y > position.y {
                    currentGameState = gameState.inGame
                    pause_button.zPosition = z_pos_pause
                    play_button.zPosition = -1
                }
            }
        }
    }
    
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.r_o = player.images[0].position
        
        if currentGameState == gameState.preGame {
            startGame()
            player.set_vel(vel_x: 0, vel_y: 0)
        }
        else if currentGameState == gameState.inGame && move_counter > 10 {
            
            move_counter = 11
            
            for touch: AnyObject in touches {
                let pointOfTouch = touch.location(in: scene)
                
                let position = CGPoint(x: scene.size.width - 3 * scene.size.width / 12, y: scene.size.height / 2 + scene.size.height * 1.5 / 10)
                
                let touch_in_game_area = pointOfTouch.x > 0 && pointOfTouch.x < scene.size.width && pointOfTouch.y > scene.size.height / 4 && pointOfTouch.y < 0.75 * scene.size.height
                
                if pointOfTouch.x > position.x  && pointOfTouch.y > position.y {
                    // Do nothing
                }
                else if touch_in_game_area {
                    player.set_pos_api(pos: pointOfTouch)
                    
                    var vel_x = (self.player.images[0].position.x - self.r_o.x) / 2
                    var vel_y = (self.player.images[0].position.y - self.r_o.y) / 2
                    
                    let min_speed2 = 3.1
                    let speed2 = vel_x * vel_x + vel_y * vel_y

                    if speed2 < CGFloat(min_speed2) {
                        vel_x = 0
                        vel_y = 0
                    }
                    
                    player.set_vel(vel_x: vel_x, vel_y: vel_y)
                }
            }
        }
    }
}
