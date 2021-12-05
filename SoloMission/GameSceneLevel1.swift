//
//  GameSceneLevel1.swift
//  SoloMission
//
//  Created by Derek Harrison on 07/08/2021.
//

import SpriteKit
import GameplayKit

class WaraWara {
    var bird1 = SKSpriteNode(imageNamed: "warawara1_bitmap_custom_mod_cropped")
    var bird2 = SKSpriteNode(imageNamed: "warawara2_bitmap_custom_mod_cropped")
    var bird3 = SKSpriteNode(imageNamed: "warawara3_bitmap_custom_mod_cropped")
    var bird_counter = 1
    var speed: CGFloat = 0
    var z_pos: CGFloat = -1
    
    func set_z_pos(z_pos: CGFloat) {
        self.z_pos = z_pos
    }
    
    func bird1_on_top() {
        bird1.zPosition = z_pos
        bird2.zPosition = -1
        bird3.zPosition = -1
    }
    
    func bird2_on_top() {
        bird1.zPosition = -1
        bird2.zPosition = z_pos
        bird3.zPosition = -1
    }
    
    func bird3_on_top() {
        bird1.zPosition = -1
        bird2.zPosition = -1
        bird3.zPosition = z_pos
    }
    
    func advance_bird_counter() {
        bird_counter += 1
        if bird_counter > 0 && bird_counter < num_frames_bird {
            bird1_on_top()
            bird_counter += 1
        }
        else if bird_counter >= num_frames_bird && bird_counter < 2 * num_frames_bird {
            bird2_on_top()
            bird_counter += 1
        }
        else if bird_counter >= 2 * num_frames_bird && bird_counter < 3 * num_frames_bird {
            bird3_on_top()
            bird_counter += 1
        }
        else { bird_counter = 1 }
    }
}

class GameSceneLevel1: SKScene {

    let player = SKSpriteNode(imageNamed: "guapo_1_bitmap_cropped")
    let player2 = SKSpriteNode(imageNamed: "guapo_2_bitmap_cropped")
    let player_hit = SKSpriteNode(imageNamed: "guapo_3_bitmap_cropped")
    
    let pause_button = SKSpriteNode(imageNamed: "pause_button_bitmap_cropped")
    let play_button = SKSpriteNode(imageNamed: "play_button_bitmap_cropped")
    
    let sun_popup_spr = SKSpriteNode(imageNamed: "sun_popup_bitmap_cropped")
    
    var muted = false
    var misty_appeared = false
    var frito_appeared = false
    var brownie_appeared = false
    var play_misty_appeared_allowed = true
    var play_frito_appeared_allowed = true
    var play_brownie_appeared_allowed = true
    var misty_comes_from_top = false
    var misty_bot_going_up = true
    var misty_top_going_up = false
    var sun_popup_frame_counter = 0
    var play_sun_pop_up = true
    var highScoreNumberLevel1 = 0
    
    let scoreLabel = SKLabelNode(fontNamed: "Courier-Bold")
    let background_overlap = 10
    var birds = [WaraWara]()
    var cheesy_bites = [CheesyBites]()
    var cucumbers = [Cucumbers]()
    var paprikas = [Paprikas]()
    var beggin_strips = [BegginStrips]()
    var broccolis = [Broccolis]()
    
    var width_background : CGFloat = 0
    var black_background_bot = SKSpriteNode(imageNamed: "black_background")
    var black_background_top = SKSpriteNode(imageNamed: "black_background")
    
    let bulletSound = SKAction.playSoundFileNamed("sound_effect.wav", waitForCompletion: false)
    let endSound = SKAction.playSoundFileNamed("tutti_0.wav", waitForCompletion: false)
    let eat_sound1 = SKAction.playSoundFileNamed("tutti_eating_knaagstok.wav", waitForCompletion: false)
    let eat_sound2 = SKAction.playSoundFileNamed("tutti_eating_tosti.wav", waitForCompletion: false)
    let eat_sound3 = SKAction.playSoundFileNamed("tutti_eating_pathe.wav", waitForCompletion: false)
    let frito_sound = SKAction.playSoundFileNamed("tutti_3.wav", waitForCompletion: false)
    let brownie_sound = SKAction.playSoundFileNamed("tutti_6.wav", waitForCompletion: false)
    let misty_sound = SKAction.playSoundFileNamed("tutti_1.wav", waitForCompletion: false)
    let frito_sound_appearing = SKAction.playSoundFileNamed("cat_sound1.wav", waitForCompletion: false)
    let brownie_sound_appearing = SKAction.playSoundFileNamed("tutti_5.wav", waitForCompletion: false)
    let misty_sound_appearing = SKAction.playSoundFileNamed("misty_sounds.wav", waitForCompletion: false)
    let sun_popup_sound = SKAction.playSoundFileNamed("sun_popup_sound.wav", waitForCompletion: false)
    
    var frito = Frito()
    var brownie = Brownie()
    var misty = Misty()

    let tapToStartLabel = SKLabelNode()
    
    var background_speed: CGFloat = 0
    
    enum gameState {
        case preGame
        case inGame
        case afterGame
        case gamePaused
    }
    
    var currentGameState = gameState.preGame
    let num_backgrounds = 10
    let screenSize = UIScreen.main.bounds
    
    var is_already_unlocked = false
    
    override func didMove(to view: SKView) {
        
        play_sun_pop_up = true
        sun_popup_frame_counter = 0
        gameScore = 0 //Reset score
        bound_tracker = 1 //Reset bound_tracker
        num_birds = 2 //Reset number of birds
        misty_appeared = false
        background_speed = self.size.width/400
                
        for j in 0...(tot_num_birds-1) {
            
            let bird = WaraWara()

            bird.bird1.position = CGPoint(x: -self.size.width * 5, y: self.size.height/2)
            bird.speed = background_speed
            bird.bird2.position = bird.bird1.position
            bird.bird3.position = bird.bird1.position
            bird.set_z_pos(z_pos: CGFloat(j) + min_z_pos_birds)
            bird.advance_bird_counter()
         
            let width = self.size.width/10
            let height = self.size.height/10
            bird.bird1.size = CGSize(width: width, height: height)
            bird.bird2.size = CGSize(width: width, height: height)
            bird.bird3.size = CGSize(width: width, height: height)
            
            birds.append(bird)
            
            self.addChild(birds[j].bird1)
            self.addChild(birds[j].bird2)
            self.addChild(birds[j].bird3)
        }
        
        for j in 0...(num_cheesy_bites-1) {
            let cheesy_bite = CheesyBites()
            
            cheesy_bite.speed = background_speed
         
            let width = self.size.width/14
            let height = self.size.height/14
            cheesy_bite.cheesy_bite.size = CGSize(width: width, height: height)

            let factor = 1.0 - (cheesy_bite.cheesy_bite.size.height) / (self.size.height/2)
            cheesy_bite.cheesy_bite.position.x = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.width * 2
            cheesy_bite.cheesy_bite.position.y = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.height/2 * factor  + self.size.height/4 + 1/2 * (1 - factor) * self.size.height/2
            
            cheesy_bites.append(cheesy_bite)
            self.addChild(cheesy_bites[j].cheesy_bite)
        }
        
        
        for j in 0...(num_paprikas-1) {
            let paprika = Paprikas()
            
            paprika.speed = background_speed
         
            let width = self.size.width/14
            let height = self.size.height/14
            paprika.paprika.size = CGSize(width: width, height: height)

            let factor = 1.0 - (paprika.paprika.size.height) / (self.size.height/2)
            paprika.paprika.position.x = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.width * 2
            paprika.paprika.position.y = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.height/2 * factor  + self.size.height/4 + 1/2 * (1 - factor) * self.size.height/2
            
            paprikas.append(paprika)
            self.addChild(paprikas[j].paprika)
        }
        
        
        for j in 0...(num_broccolis-1) {
            let broccoli = Broccolis()
            
            broccoli.speed = background_speed
         
            let width = self.size.width/14
            let height = self.size.height/14
            broccoli.broccoli.size = CGSize(width: width, height: height)

            let factor = 1.0 - (broccoli.broccoli.size.height) / (self.size.height/2)
            broccoli.broccoli.position.x = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.width * 2
            broccoli.broccoli.position.y = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.height/2 * factor  + self.size.height/4 + 1/2 * (1 - factor) * self.size.height/2
            
            broccolis.append(broccoli)
            self.addChild(broccolis[j].broccoli)
        }
        
        
        for j in 0...(num_cucumbers-1) {
            let cucumber = Cucumbers()
            
            cucumber.speed = background_speed
         
            let width = self.size.width/14
            let height = self.size.height/14
            cucumber.cucumber.size = CGSize(width: width, height: height)

            let factor = 1.0 - (cucumber.cucumber.size.height) / (self.size.height/2)
            cucumber.cucumber.position.x = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.width * 2
            cucumber.cucumber.position.y = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.height/2 * factor  + self.size.height/4 + 1/2 * (1 - factor) * self.size.height/2
            
            cucumbers.append(cucumber)
            self.addChild(cucumbers[j].cucumber)
        }
        
        
        for j in 0...(num_beggin_strips-1) {
            let beggin_strip = BegginStrips()
            
            beggin_strip.speed = background_speed
         
            let width = self.size.width/14
            let height = self.size.height/14
            beggin_strip.beggin_strip.size = CGSize(width: width, height: height)

            beggin_strip.beggin_strip.position.x = -self.size.width
            beggin_strip.beggin_strip.position.y = self.size.height/2
            
            beggin_strips.append(beggin_strip)
            self.addChild(beggin_strips[j].beggin_strip)
        }
        
        
        var width = self.size.width
        var height = self.size.height/4
        
        black_background_top.size = CGSize(width: width, height: height)
        black_background_top.position = CGPoint(x: width/2, y: self.size.height*0.75 + height/2)
        black_background_top.zPosition = 20
        black_background_bot.size = CGSize(width: width, height: height)
        black_background_bot.position = CGPoint(x: width/2, y: self.size.height*0.25 - height/2)
        black_background_bot.zPosition = 20
        self.addChild(black_background_top)
        self.addChild(black_background_bot)
        
        for i in 0...(num_backgrounds-1) {
            let string1 = "background_guapo_game_nr"
            let string2 = String(i+1)
            let image_name = string1 + string2
            let background = SKSpriteNode(imageNamed: image_name)
            
            let width = background.size.width
            let height = self.size.height/2
            
            background.size = CGSize(width: width, height: height)
                        
            width_background = background.size.width
            
            background.anchorPoint = CGPoint(x: 0, y: 0.5)
            background.position = CGPoint(x: width_background*CGFloat(i) - CGFloat(background_overlap*i), y: self.size.height/2)
            
            background.zPosition = 0
            background.name = "Background2"
            self.addChild(background)
        
        }

        width = self.size.width/5
        height = self.size.height/7.5
        
        player.size = CGSize(width: width, height: height)
        player.position = CGPoint(x: self.size.width/5, y: self.size.height/2)
        player.zPosition = z_pos_player
        self.addChild(player)
        
        player2.size = player.size
        player2.position = player.position
        player2.zPosition = -1
        self.addChild(player2)
        
        player_hit.size = player.size
        player_hit.position = player.position
        player_hit.zPosition = -1
        self.addChild(player_hit)
        
        width = self.size.width/28
        height = self.size.height/28

        pause_button.setScale(1)
        pause_button.size = CGSize(width: width, height: height)
        pause_button.position = CGPoint(x: self.size.width - self.size.width/12, y: self.size.height/2 + self.size.height*1.9/5/2)
        pause_button.zPosition = z_pos_pause
        self.addChild(pause_button)
        
        play_button.setScale(1)
        play_button.size = CGSize(width: width, height: height)
        play_button.position = pause_button.position
        play_button.zPosition = -1
        self.addChild(play_button)
        
        width = self.size.width/7
        height = self.size.height/7
        
        sun_popup_spr.setScale(1)
        sun_popup_spr.size = CGSize(width: width, height: height)
        sun_popup_spr.position = CGPoint(x: sun_popup_spr.size.width/2 + sun_popup_spr.size.width/5, y: self.size.height/2 + self.size.height/4 - sun_popup_spr.size.height/2 - self.size.width/11)
        sun_popup_spr.zPosition = -1
        self.addChild(sun_popup_spr)
        
        
        tapToStartLabel.text = "Tap To Begin"
        tapToStartLabel.fontSize = 100
        tapToStartLabel.fontColor = SKColor.white
        tapToStartLabel.zPosition = 1
        tapToStartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(tapToStartLabel)
        
        
        startGame()
        
        scoreLabel.text = "0"
        scoreLabel.fontSize = 100
        scoreLabel.fontColor = SKColor.gray
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position = CGPoint(x: self.size.width/12, y: self.size.height/2 + self.size.height*1.8/5/2)
        
        scoreLabel.zPosition = z_pos_pause
        self.addChild(scoreLabel)
        
        let defaults = UserDefaults()
        highScoreNumberLevel1 = defaults.integer(forKey: "HighScoreLevel1Saved")
        is_already_unlocked = highScoreNumberLevel1 >= unlock_level_points
        muted = defaults.bool(forKey: "gameMuted")
        
        
        
        
        width = self.size.width/7.5
        height = self.size.height/7.5
        
        frito.image_frito.size = CGSize(width: width, height: height)
        frito.image_frito_hit.size = frito.image_frito.size
        frito.image_frito.position = CGPoint(x: -self.size.width * 5, y: self.size.height/2)
        frito.speed = 2.5 * background_speed
        frito.vel_y = frito.speed
        frito.image_frito.position.x = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.width + self.size.width * CGFloat(num_screen_lengths_for_disp)
        frito.image_frito_hit.position = frito.image_frito.position
        self.addChild(frito.image_frito)
        self.addChild(frito.image_frito_hit)

        
        
        width = self.size.width/7.5
        height = self.size.height/7.5
        
        brownie.image_brownie.size = CGSize(width: width, height: height)
        brownie.image_brownie_hit.size = brownie.image_brownie.size
        brownie.image_brownie.position = CGPoint(x: -self.size.width * 5, y: self.size.height/2)
        brownie.image_brownie_hit.position = brownie.image_brownie.position
        brownie.speed = 2.5 * background_speed
        brownie.vel_y = brownie.speed
//        brownie.image_brownie.position.x = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.width + self.size.width * CGFloat(num_screen_lengths_for_disp) * 2
        brownie.image_brownie.position.x = -self.size.width * CGFloat(num_screen_lengths_for_disp) * 2
        brownie.image_brownie_hit.position = brownie.image_brownie.position
        
        self.addChild(brownie.image_brownie)
        self.addChild(brownie.image_brownie_hit)
        
        
        width = self.size.width/7.5
        height = self.size.height/7.5
        
        misty.image_misty.size = CGSize(width: width, height: height)
        misty.image_misty_hit.size = misty.image_misty.size
        misty.image_misty_rotated.size = misty.image_misty.size
        misty.image_misty_hit_rotated.size = misty.image_misty.size
        let y_c_bot = self.size.height * 0.25 - misty.image_misty.size.height/2 - 2
        let y_c_top = self.size.height * 0.75 + misty.image_misty_rotated.size.height/2 + 2
        misty.image_misty.position = CGPoint(x: -self.size.width * 5, y: y_c_bot)
        misty.image_misty_hit.position = misty.image_misty.position
        misty.image_misty_rotated.position = CGPoint(x: -self.size.width * 5, y: y_c_top)
        misty.image_misty_hit_rotated.position = misty.image_misty_rotated.position
        misty.speed = 2.5 * background_speed
        misty.vel_y_bot = misty.speed
        misty.vel_y_top = -misty.speed
        misty.x_tracker = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.width + self.size.width * CGFloat(num_screen_lengths_for_disp) * 3
        misty.image_misty.position.x = misty.x_tracker
        misty.image_misty_hit.position = misty.image_misty.position
        misty.image_misty_rotated.position.x = misty.image_misty.position.x
        misty.image_misty_hit_rotated.position.x = misty.image_misty.position.x
        
        misty_comes_from_top = Bool.random()
        misty.x_pos = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.width * 0.9 + 0.05 * self.size.width
        
        self.addChild(misty.image_misty)
        self.addChild(misty.image_misty_hit)
        self.addChild(misty.image_misty_rotated)
        self.addChild(misty.image_misty_hit_rotated)
        
    }
    
    func doOverlap(l1: CGPoint ,r1: CGPoint, l2: CGPoint, r2: CGPoint) -> Bool {
     
        // To check if either rectangle is actually a line
        // For example :  l1 ={-1,0}  r1={1,1}  l2={0,-1}
        // r2={0,1}
     
        if (l1.x == r1.x || l1.y == r1.y || l2.x == r2.x
            || l2.y == r2.y) {
            // the line cannot have positive overlap
            return false;
        }
     
        // If one rectangle is on left side of other
        if (l1.x >= r2.x || l2.x >= r1.x) {
            return false;
        }
     
        // If one rectangle is above other
        if (r1.y >= l2.y || r2.y >= l1.y) {
            return false;
        }
     
        return true
    }
    
    var lastUpdateTime: TimeInterval = 0
    var deltaFrameTime: TimeInterval = 0
    var counter = 0
    var move_counter = 0
    var is_up = true

    var vel = CGPoint(x: 0, y: 0)
    var r_o = CGPoint(x: 0, y: 0)
 
    override func update(_ currentTime: TimeInterval) {

        //Update score text
        scoreLabel.text = String(gameScore)
        
        //Pop up mechanism
        if gameScore >=  unlock_level_points && !is_already_unlocked && sun_popup_frame_counter <= num_frames_sun_popup {
            sun_popup_frame_counter += 1
            if muted == false && play_sun_pop_up {
                let unlock_level = SKSpriteNode()
                self.addChild(unlock_level)
 
                let unlock_level_biteSequence = SKAction.sequence([sun_popup_sound])
                unlock_level.run(unlock_level_biteSequence)
                play_sun_pop_up = false
            }
            
            sun_popup_spr.zPosition = 20
            
        }
        else {
            //Reset sun popup zposition
            sun_popup_spr.zPosition = -1
        }
        
        self.enumerateChildNodes(withName: "Background2") { background, stop in
            
            if self.currentGameState == gameState.inGame {
                background.position.x -= self.background_speed
            }
            
            let width = self.width_background

            if background.position.x < -width {
                background.position.x += width*CGFloat(self.num_backgrounds) - CGFloat(self.background_overlap*self.num_backgrounds)
            }
            
        }
        
        if is_up {
            player.zPosition = z_pos_player
            player2.zPosition = -1
        }
        else {
            player.zPosition = -1
            player2.zPosition = z_pos_player
        }
        
        if self.currentGameState == gameState.preGame {
            player2.zPosition = -1
            player.zPosition = -1
        }
        
        if self.currentGameState == gameState.afterGame {
            player_hit.zPosition = z_pos_player
            player2.zPosition = -1
            player.zPosition = -1
        }
                
        if self.currentGameState == gameState.inGame {
            counter += 1
            move_counter += 1
        }
        
        if counter > num_frames_change {
            counter = 0
            is_up = !is_up
        }
        
        //Increase number of birds in game
        if ((bound_tracker - 1) * num_points_when_birds_appear) <= gameScore && gameScore < (bound_tracker * num_points_when_birds_appear) && num_birds < tot_num_birds {
            num_birds += 1
            bound_tracker += 1
        }
        
        
        if self.currentGameState == gameState.inGame {
            
            //Update positions of birds and detect overlap
            for j in 0...(num_birds-1) {
                birds[j].bird1.position.x -= birds[j].speed
                birds[j].bird2.position = birds[j].bird1.position
                birds[j].bird3.position = birds[j].bird1.position
                birds[j].advance_bird_counter()
                var l1 = birds[j].bird1.position
                var r1 = birds[j].bird1.position
                l1.x -= birds[j].bird1.size.width/3.5
                l1.y += birds[j].bird1.size.height/3.5
                r1.x += birds[j].bird1.size.width/3.5
                r1.y -= birds[j].bird1.size.height/3.5
                var l2 = player.position
                var r2 = player.position
                l2.x -= player.size.width/3.5
                l2.y += player.size.height/3.5
                r2.x += player.size.width/3.5
                r2.y -= player.size.height/3.5
                                
                let there_is_overlap = doOverlap(l1: l1 ,r1: r1, l2: l2, r2: r2)
                
                if there_is_overlap == true {

                    if muted == false {
                        let hit_bird = SKSpriteNode()
                        self.addChild(hit_bird)
         
                        let hit_birdSequence = SKAction.sequence([endSound])
                        hit_bird.run(hit_birdSequence)
                    }
                    
                    self.currentGameState = gameState.afterGame
                    runGameOver()
                }
                
                if birds[j].bird1.position.x < -birds[j].bird1.size.width {
                    let factor = 1.0 - (birds[j].bird1.size.height) / (self.size.height/2)
                    birds[j].bird1.position.x = self.size.width + 30
                    birds[j].speed = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (3 - 1.5) * background_speed + 1.5 * background_speed
                    
                    birds[j].bird1.position.y = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.height/2 * factor  + self.size.height/4 + 1/2 * (1 - factor) * self.size.height/2
                }
            }
        
            //Update positions of snacks and detect eating snacks
            for j in 0...(num_cheesy_bites-1) {
                cheesy_bites[j].cheesy_bite.position.x -= background_speed
 
                var l1 = cheesy_bites[j].cheesy_bite.position
                var r1 = cheesy_bites[j].cheesy_bite.position
                l1.x -= cheesy_bites[j].cheesy_bite.size.width/2
                l1.y += cheesy_bites[j].cheesy_bite.size.height/2
                r1.x += cheesy_bites[j].cheesy_bite.size.width/2
                r1.y -= cheesy_bites[j].cheesy_bite.size.height/2
                
                var l2 = player.position
                var r2 = player.position
                l2.x -= player.size.width/2
                l2.y += player.size.height/2
                r2.x += player.size.width/2
                r2.y -= player.size.height/2
                                
                let there_is_overlap_with_cheesy_bite = doOverlap(l1: l1 ,r1: r1, l2: l2, r2: r2)
                
                if there_is_overlap_with_cheesy_bite == true {
                    cheesy_bites[j].cheesy_bite.position.x = -self.size.width * 10
                    
                    if muted == false {
                        let ate_cheesy_bite = SKSpriteNode()
                        self.addChild(ate_cheesy_bite)
         
                        let ate_cheesy_biteSequence = SKAction.sequence([eat_sound1])
                        ate_cheesy_bite.run(ate_cheesy_biteSequence)
                    }
                    
                    gameScore += points_cheesy_bite
                }

                if cheesy_bites[j].cheesy_bite.position.x < -cheesy_bites[j].cheesy_bite.size.width {
                    
                    let factor = 1.0 - (cheesy_bites[j].cheesy_bite.size.height) / (self.size.height/2)
                    
                    cheesy_bites[j].cheesy_bite.position.x = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.width * 2 + self.size.width
                    
                    cheesy_bites[j].cheesy_bite.position.y = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.height/2 * factor  + self.size.height/4 + 1/2 * (1 - factor) * self.size.height/2
                }
            }
            
            //Update positions of cucumbers and detect eating cucumber
            for j in 0...(num_cucumbers-1) {
                cucumbers[j].cucumber.position.x -= background_speed
 
                var l1 = cucumbers[j].cucumber.position
                var r1 = cucumbers[j].cucumber.position
                l1.x -= cucumbers[j].cucumber.size.width/2.5
                l1.y += cucumbers[j].cucumber.size.height/2.5
                r1.x += cucumbers[j].cucumber.size.width/2.5
                r1.y -= cucumbers[j].cucumber.size.height/2.5
                
                var l2 = player.position
                var r2 = player.position
                l2.x -= player.size.width/2.5
                l2.y += player.size.height/2.5
                r2.x += player.size.width/2.5
                r2.y -= player.size.height/2.5
                
                let there_is_overlap_with_cucumber = doOverlap(l1: l1 ,r1: r1, l2: l2, r2: r2)
                
                if there_is_overlap_with_cucumber == true {
                    cucumbers[j].cucumber.position.x = -self.size.width * 10
                    
                    if muted == false {
                        let ate_cucumber = SKSpriteNode()
                        self.addChild(ate_cucumber)
         
                        let ate_cucumber_biteSequence = SKAction.sequence([eat_sound1])
                        ate_cucumber.run(ate_cucumber_biteSequence)
                    }
                    
                    gameScore += points_cucumber
                }
                
                if cucumbers[j].cucumber.position.x < -cucumbers[j].cucumber.size.width {
                    
                    let factor = 1.0 - (cucumbers[j].cucumber.size.height) / (self.size.height/2)
                    
                    cucumbers[j].cucumber.position.x = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.width * 2 + self.size.width
                    
                    cucumbers[j].cucumber.position.y = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.height/2 * factor  + self.size.height/4 + 1/2 * (1 - factor) * self.size.height/2
                }
                
            }
            
            //Update positions of paprikas and detect eating paprika
            for j in 0...(num_paprikas-1) {
                paprikas[j].paprika.position.x -= background_speed
 
                var l1 = paprikas[j].paprika.position
                var r1 = paprikas[j].paprika.position
                l1.x -= paprikas[j].paprika.size.width/2.5
                l1.y += paprikas[j].paprika.size.height/2.5
                r1.x += paprikas[j].paprika.size.width/2.5
                r1.y -= paprikas[j].paprika.size.height/2.5
                
                var l2 = player.position
                var r2 = player.position
                l2.x -= player.size.width/2.5
                l2.y += player.size.height/2.5
                r2.x += player.size.width/2.5
                r2.y -= player.size.height/2.5
                
                let there_is_overlap_with_paprika = doOverlap(l1: l1 ,r1: r1, l2: l2, r2: r2)
                
                if there_is_overlap_with_paprika == true {
                    paprikas[j].paprika.position.x = -self.size.width * 10
                    
                    if muted == false {
                        let ate_paprika = SKSpriteNode()
                        self.addChild(ate_paprika)
         
                        let ate_paprika_biteSequence = SKAction.sequence([eat_sound1])
                        ate_paprika.run(ate_paprika_biteSequence)
                    }
                    
                    gameScore += points_paprika
                }
                
                
                if paprikas[j].paprika.position.x < -paprikas[j].paprika.size.width {
                    
                    let factor = 1.0 - (paprikas[j].paprika.size.height) / (self.size.height/2)
                    
                    paprikas[j].paprika.position.x = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.width * 2 + self.size.width
                    
                    paprikas[j].paprika.position.y = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.height/2 * factor  + self.size.height/4 + 1/2 * (1 - factor) * self.size.height/2
                }
            }
            
            
            //Update positions of broccolis and detect eating broccoli
            for j in 0...(num_broccolis-1) {
                broccolis[j].broccoli.position.x -= background_speed
 
                var l1 = broccolis[j].broccoli.position
                var r1 = broccolis[j].broccoli.position
                l1.x -= broccolis[j].broccoli.size.width/2.5
                l1.y += broccolis[j].broccoli.size.height/2.5
                r1.x += broccolis[j].broccoli.size.width/2.5
                r1.y -= broccolis[j].broccoli.size.height/2.5
                
                var l2 = player.position
                var r2 = player.position
                l2.x -= player.size.width/2.5
                l2.y += player.size.height/2.5
                r2.x += player.size.width/2.5
                r2.y -= player.size.height/2.5
                
                let there_is_overlap_with_broccoli = doOverlap(l1: l1 ,r1: r1, l2: l2, r2: r2)
                
                if there_is_overlap_with_broccoli == true {
                    broccolis[j].broccoli.position.x = -self.size.width * 10
                    
                    if muted == false {
                        let ate_broccoli = SKSpriteNode()
                        self.addChild(ate_broccoli)
         
                        let ate_broccoli_biteSequence = SKAction.sequence([eat_sound1])
                        ate_broccoli.run(ate_broccoli_biteSequence)
                    }
                    
                    gameScore += points_broccoli
                }
                
                if broccolis[j].broccoli.position.x < -broccolis[j].broccoli.size.width {
                    
                    let factor = 1.0 - (broccolis[j].broccoli.size.height) / (self.size.height/2)
                    
                    broccolis[j].broccoli.position.x = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.width * 2 + self.size.width
                    
                    broccolis[j].broccoli.position.y = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.height/2 * factor  + self.size.height/4 + 1/2 * (1 - factor) * self.size.height/2
                }
            }
            
            
            //Update positions of beggin strips and detect eating beggin strip
            for j in 0...(num_beggin_strips-1) {
                beggin_strips[j].beggin_strip.position.x -= background_speed
 
                var l1 = beggin_strips[j].beggin_strip.position
                var r1 = beggin_strips[j].beggin_strip.position
                l1.x -= beggin_strips[j].beggin_strip.size.width/2.5
                l1.y += beggin_strips[j].beggin_strip.size.height/2.5
                r1.x += beggin_strips[j].beggin_strip.size.width/2.5
                r1.y -= beggin_strips[j].beggin_strip.size.height/2.5
                
                var l2 = player.position
                var r2 = player.position
                l2.x -= player.size.width/2.5
                l2.y += player.size.height/2.5
                r2.x += player.size.width/2.5
                r2.y -= player.size.height/2.5
                
                let there_is_overlap_with_beggin_strip = doOverlap(l1: l1 ,r1: r1, l2: l2, r2: r2)
                
                if there_is_overlap_with_beggin_strip == true {
                    beggin_strips[j].beggin_strip.position.x = -self.size.width * 10
                    
                    if muted == false {
                        let ate_beggin_strip = SKSpriteNode()
                        self.addChild(ate_beggin_strip)
         
                        let ate_beggin_strip_biteSequence = SKAction.sequence([eat_sound1])
                        ate_beggin_strip.run(ate_beggin_strip_biteSequence)
                    }
                    
                    gameScore += points_beggin_strip
                }
                
                if beggin_strips[j].beggin_strip.position.x < -beggin_strips[j].beggin_strip.size.width && gameScore >= points_at_which_beggin_strips_appear {
                    
                    let factor = 1.0 - (beggin_strips[j].beggin_strip.size.height) / (self.size.height/2)
                    
                    beggin_strips[j].beggin_strip.position.x = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.width * 2 + self.size.width
                    
                    beggin_strips[j].beggin_strip.position.y = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.height/2 * factor  + self.size.height/4 + 1/2 * (1 - factor) * self.size.height/2
                }
            }
            
            self.player.position.x += self.vel.x
            self.player.position.y += self.vel.y
            self.player2.position = self.player.position
            self.player_hit.position = self.player.position
            self.frito.image_frito.position.x -= self.frito.speed
            self.frito.image_frito.position.y += self.frito.vel_y
            self.frito.image_frito_hit.position = self.frito.image_frito.position
//            self.brownie.image_brownie.position.x -= self.brownie.speed
            self.brownie.image_brownie.position.x += self.brownie.speed
            self.brownie.image_brownie.position.y += self.brownie.vel_y
            self.brownie.image_brownie_hit.position = self.brownie.image_brownie.position
            self.misty.x_tracker -= self.misty.speed
            self.misty.image_misty.position.x = self.misty.x_tracker
            self.misty.image_misty_hit.position.x = self.misty.image_misty.position.x
            self.misty.image_misty_rotated.position.x = self.misty.image_misty.position.x
            self.misty.image_misty_hit_rotated.position.x = self.misty.image_misty.position.x
            
            
            frito_appeared = 0 < self.frito.image_frito.position.x && self.frito.image_frito.position.x < self.size.width
            
            if frito_appeared && play_frito_appeared_allowed {
                
                if muted == false {
                    let frito_appeared_spr = SKSpriteNode()
                    self.addChild(frito_appeared_spr)
     
                    let frito_appeared_spr_biteSequence = SKAction.sequence([frito_sound_appearing])
                    frito_appeared_spr.run(frito_appeared_spr_biteSequence)
                }
                
                play_frito_appeared_allowed = false
            }
            
            brownie_appeared = 0 < self.brownie.image_brownie.position.x && self.brownie.image_brownie.position.x < self.size.width
            
            if brownie_appeared && play_brownie_appeared_allowed {
                
                if muted == false {
                    let brownie_appeared_spr = SKSpriteNode()
                    self.addChild(brownie_appeared_spr)
     
                    let brownie_appeared_spr_biteSequence = SKAction.sequence([brownie_sound_appearing])
                    brownie_appeared_spr.run(brownie_appeared_spr_biteSequence)
                }
                
                play_brownie_appeared_allowed = false
            }
            
            var l1 = frito.image_frito.position
            var r1 = frito.image_frito.position
            l1.x -= frito.image_frito.size.width/3.5
            l1.y += frito.image_frito.size.height/3.5
            r1.x += frito.image_frito.size.width/3.5
            r1.y -= frito.image_frito.size.height/3.5
            var l2 = player.position
            var r2 = player.position
            l2.x -= player.size.width/3.5
            l2.y += player.size.height/3.5
            r2.x += player.size.width/3.5
            r2.y -= player.size.height/3.5
                            
            let there_is_overlap_frito = doOverlap(l1: l1 ,r1: r1, l2: l2, r2: r2)
            
            if there_is_overlap_frito {
                if muted == false && frito.play_sound_allowed {
                    let hit_frito = SKSpriteNode()
                    self.addChild(hit_frito)
     
                    let hit_frito_biteSequence = SKAction.sequence([frito_sound])
                    hit_frito.run(hit_frito_biteSequence)
                    frito.play_sound_allowed = false
                }
                
                frito.frito_hit()
            }
            
            
            l1 = brownie.image_brownie.position
            r1 = brownie.image_brownie.position
            l1.x -= brownie.image_brownie.size.width/3.5
            l1.y += brownie.image_brownie.size.height/3.5
            r1.x += brownie.image_brownie.size.width/3.5
            r1.y -= brownie.image_brownie.size.height/3.5
            l2 = player.position
            r2 = player.position
            l2.x -= player.size.width/3.5
            l2.y += player.size.height/3.5
            r2.x += player.size.width/3.5
            r2.y -= player.size.height/3.5
                            
            let there_is_overlap_brownie = doOverlap(l1: l1 ,r1: r1, l2: l2, r2: r2)
            
            if there_is_overlap_brownie {
                if muted == false && brownie.play_sound_allowed {
                    let hit_brownie = SKSpriteNode()
                    self.addChild(hit_brownie)
     
                    let hit_brownie_biteSequence = SKAction.sequence([brownie_sound])
                    hit_brownie.run(hit_brownie_biteSequence)
                    brownie.play_sound_allowed = false
                }
                
                brownie.brownie_hit()
            }
            
            //When misty goes out of bounds
            if self.misty.x_tracker < -self.misty.image_misty.size.width {
                self.misty.x_tracker = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.width + self.size.width * 3 * CGFloat(num_screen_lengths_for_disp)
                self.misty.image_misty.position.x = self.misty.x_tracker
                
                self.misty.image_misty_hit.position.x = self.misty.image_misty.position.x
                self.misty.image_misty_rotated.position.x = self.misty.image_misty.position.x
                self.misty.image_misty_hit_rotated.position.x = self.misty.image_misty.position.x
                
                play_misty_appeared_allowed = true
                self.misty.play_sound_allowed = true
                self.misty.trip1_complete_bot = false
                self.misty.trip2_complete_bot = false
                self.misty.trip1_complete_top = false
                self.misty.trip2_complete_top = false
                self.misty.reset_hit()
                                
                misty_comes_from_top = Bool.random()
                misty.x_pos = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.width * 0.9 + 0.05 * self.size.width
            }
            
            misty_appeared = 0 < self.misty.x_tracker && self.misty.x_tracker < self.size.width
            
            if misty_appeared && play_misty_appeared_allowed {
                
                if muted == false {
                    let misty_appeared_spr = SKSpriteNode()
                    self.addChild(misty_appeared_spr)
     
                    let misty_appeared_spr_biteSequence = SKAction.sequence([misty_sound_appearing])
                    misty_appeared_spr.run(misty_appeared_spr_biteSequence)
                }
                
                play_misty_appeared_allowed = false
            }
            
            if misty_appeared {
                
                if misty_comes_from_top {
                    self.misty.image_misty_rotated.position.x = self.misty.x_pos
                    self.misty.image_misty_hit_rotated.position.x = self.misty.x_pos
                    var y_coord = self.misty.image_misty_rotated.position.y
                    let y_cap = self.size.height * 0.75 - self.misty.image_misty_rotated.size.height/2
                    let y_high = self.size.height * 0.75 + self.misty.image_misty_rotated.size.height/2
                    let trip_complete = self.misty.trip1_complete_top && self.misty.trip2_complete_top
                    if y_coord >= y_cap && misty_top_going_up == false && !trip_complete {
                        y_coord += self.misty.vel_y_top
                        self.misty.image_misty_rotated.position.y = y_coord
                        self.misty.image_misty_hit_rotated.position.y = y_coord
                        
                    }
                    else if y_coord <= y_cap && misty_top_going_up == false && !trip_complete{
                        misty_top_going_up = true
                        self.misty.trip1_complete_top = true
                    }
                    if y_coord <= y_high && misty_top_going_up == true && !trip_complete {
                        y_coord -= self.misty.vel_y_top
                        self.misty.image_misty_rotated.position.y = y_coord
                        self.misty.image_misty_hit_rotated.position.y = y_coord
                        
                    }
                    else if y_coord >= y_high && misty_top_going_up == true && !trip_complete{
                        misty_top_going_up = false
                        self.misty.trip2_complete_top = true
                    }
                }
                else {
                    self.misty.image_misty.position.x = self.misty.x_pos
                    self.misty.image_misty_hit.position.x = self.misty.x_pos
                    var y_coord = self.misty.image_misty.position.y
                    let y_cap = self.size.height * 0.25 + self.misty.image_misty.size.height/2
                    let y_low = self.size.height * 0.25 - self.misty.image_misty.size.height/2
                    let trip_complete = self.misty.trip1_complete_bot && self.misty.trip2_complete_bot
                    if y_coord <= y_cap && misty_bot_going_up == true && !trip_complete {
                        y_coord += self.misty.vel_y_bot
                        self.misty.image_misty.position.y = y_coord
                        self.misty.image_misty_hit.position.y = y_coord
                    }
                    else if y_coord >= y_cap && misty_bot_going_up == true && !trip_complete {
                        misty_bot_going_up = false
                        self.misty.trip1_complete_bot = true
                    }
                    if y_coord >= y_low && misty_bot_going_up == false && !trip_complete {
                        y_coord -= self.misty.vel_y_bot
                        self.misty.image_misty.position.y = y_coord
                        self.misty.image_misty_hit.position.y = y_coord
                    }
                    else if y_coord <= y_low && misty_bot_going_up == false && !trip_complete{
                        misty_bot_going_up = true
                        self.misty.trip2_complete_bot = true
                    }
                }
                

                l1 = misty.image_misty.position
                r1 = misty.image_misty.position
                l1.x -= misty.image_misty.size.width/2.5
                l1.y += misty.image_misty.size.height/2.5
                r1.x += misty.image_misty.size.width/2.5
                r1.y -= misty.image_misty.size.height/2.5
                l2 = player.position
                r2 = player.position
                l2.x -= player.size.width/2.5
                l2.y += player.size.height/2.5
                r2.x += player.size.width/2.5
                r2.y -= player.size.height/2.5
                                
                let there_is_overlap_misty_bot = doOverlap(l1: l1 ,r1: r1, l2: l2, r2: r2)
                
                if there_is_overlap_misty_bot {
                    if muted == false && misty.play_sound_allowed {
                        let hit_misty = SKSpriteNode()
                        self.addChild(hit_misty)
         
                        let hit_misty_biteSequence = SKAction.sequence([misty_sound])
                        hit_misty.run(hit_misty_biteSequence)
                        misty.play_sound_allowed = false
                    }
                    
                    
                    misty.misty_hit()
                }
                
                
                l1 = misty.image_misty_rotated.position
                r1 = misty.image_misty_rotated.position
                l1.x -= misty.image_misty_rotated.size.width/2.5
                l1.y += misty.image_misty_rotated.size.height/2.5
                r1.x += misty.image_misty_rotated.size.width/2.5
                r1.y -= misty.image_misty_rotated.size.height/2.5
                l2 = player.position
                r2 = player.position
                l2.x -= player.size.width/2.5
                l2.y += player.size.height/2.5
                r2.x += player.size.width/2.5
                r2.y -= player.size.height/2.5
                                
                let there_is_overlap_misty_top = doOverlap(l1: l1 ,r1: r1, l2: l2, r2: r2)
                
                if there_is_overlap_misty_top {
                    if muted == false && misty.play_sound_allowed {
                        let hit_misty = SKSpriteNode()
                        self.addChild(hit_misty)
         
                        let hit_misty_biteSequence = SKAction.sequence([misty_sound])
                        hit_misty.run(hit_misty_biteSequence)
                        misty.play_sound_allowed = false
                    }
                    
                    
                    misty.misty_hit()
                }
                
            }
            
        }
        
        //Reflect velocities and keep player in boundaries
        if self.player.position.x < 0 {
            self.player.position.x = 0
            self.vel.x = -self.vel.x
        }
        if self.player.position.x > self.size.width {
            self.player.position.x = self.size.width
            self.vel.x = -self.vel.x
        }
        if self.player.position.y > (self.size.height/2 + self.size.height/4) {
            self.player.position.y = self.size.height/2 + self.size.height/4
            self.vel.y = -self.vel.y
        }
        if self.player.position.y < (self.size.height/2 - self.size.height/4) {
            self.player.position.y = self.size.height/2 - self.size.height/4
            self.vel.y = -self.vel.y
        }
        
        
        
        if frito.image_frito.position.x < -frito.image_frito.size.width {
            let factor = 1.0 - (frito.image_frito.size.height) / (self.size.height/2)
            frito.image_frito.position.x = self.size.width * CGFloat(num_screen_lengths_for_disp) * 3
            
            frito.image_frito.position.y = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.height/2 * factor  + self.size.height/4 + 1/2 * (1 - factor) * self.size.height/2
            
            play_frito_appeared_allowed = true
            frito.play_sound_allowed = true
            frito.reset_hit()
            
        }
        
        if brownie.image_brownie.position.x > self.size.width + brownie.image_brownie.size.width {
            let factor = 1.0 - (brownie.image_brownie.size.height) / (self.size.height/2)
            brownie.image_brownie.position.x = -self.size.width * CGFloat(num_screen_lengths_for_disp) * 3
            
            brownie.image_brownie.position.y = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * self.size.height/2 * factor  + self.size.height/4 + 1/2 * (1 - factor) * self.size.height/2
            
            play_brownie_appeared_allowed = true
            brownie.play_sound_allowed = true
            brownie.reset_hit()
        }
        if self.brownie.image_brownie.position.y > (self.size.height/2 + self.size.height/4) {
            self.brownie.image_brownie.position.y = self.size.height/2 + self.size.height/4
            self.brownie.vel_y = -self.brownie.vel_y
        }
        if self.brownie.image_brownie.position.y < (self.size.height/2 - self.size.height/4) {
            self.brownie.image_brownie.position.y = self.size.height/2 - self.size.height/4
            self.brownie.vel_y = -self.brownie.vel_y
        }
        if self.frito.image_frito.position.y > (self.size.height/2 + self.size.height/4) {
            self.frito.image_frito.position.y = self.size.height/2 + self.size.height/4
            self.frito.vel_y = -self.frito.vel_y
        }
        if self.frito.image_frito.position.y < (self.size.height/2 - self.size.height/4) {
            self.frito.image_frito.position.y = self.size.height/2 - self.size.height/4
            self.frito.vel_y = -self.frito.vel_y
        }
        
    }
    
    func runGameOver() {
        
        if gameScore > highScoreNumberLevel1 {
            let defaults = UserDefaults()
            defaults.set(gameScore, forKey: "HighScoreLevel1Saved")
        }
        
        player.zPosition = -1
        player2.zPosition = -1
        player_hit.zPosition = z_pos_player
        
        let changeSceneAction = SKAction.run(changeScene)
        let waitToChangeScene = SKAction.wait(forDuration: 1)
        let changeSceneSequence = SKAction.sequence([waitToChangeScene, changeSceneAction])
        self.run(changeSceneSequence)
        
    }
    
    func changeScene() {
        
        let sceneToMoveTo = MainMenuScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        
    }
    
    
    func startGame() {
        currentGameState = gameState.inGame
        
        let deleteAction = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([deleteAction])
        tapToStartLabel.run(deleteSequence)
        
        player.position.x = self.size.width/5
        player2.position = player.position
        player_hit.position = player.position
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if currentGameState == gameState.preGame {
            startGame()
            self.vel.x = 0
            self.vel.y = 0
        }
        else if currentGameState == gameState.inGame {
            
            for touch: AnyObject in touches {
                let pointOfTouch = touch.location(in: self)
                
                let position = CGPoint(x: self.size.width - 2*self.size.width/12, y: self.size.height/2 + self.size.height*1.5/5/2)
                
                let touch_in_game_area = pointOfTouch.x > 0 && pointOfTouch.x < self.size.width && pointOfTouch.y > self.size.height/4 && pointOfTouch.y < 0.75 * self.size.height
                
                if pointOfTouch.x > position.x  && pointOfTouch.y > position.y {
                    currentGameState = gameState.gamePaused
                    pause_button.zPosition = -1
                    play_button.zPosition = z_pos_pause
                }
                else if touch_in_game_area {
                    player.position.x = pointOfTouch.x
                    player.position.y = pointOfTouch.y
                    player2.position = player.position
                    player_hit.position = player.position
                    
                    self.vel.x = 0
                    self.vel.y = 0
                }
                
            }
        }
        else if currentGameState == gameState.gamePaused {
            
            for touch: AnyObject in touches {
                let pointOfTouch = touch.location(in: self)
                
                let position = CGPoint(x: self.size.width - 2*self.size.width/12, y: self.size.height/2 + self.size.height*1.5/5/2)
                
                if pointOfTouch.x > position.x  && pointOfTouch.y > position.y {
                    currentGameState = gameState.inGame
                    pause_button.zPosition = z_pos_pause
                    play_button.zPosition = -1
                }

            }
        }
        
        if player.position.x < 0 {
            player.position.x = player.size.width/2
        }
        if player.position.x > self.size.width {
            player.position.x = self.size.width - player.size.width/2
        }
        if player.position.y < self.size.height/4 {
            player.position.y = player.size.height/2 + self.size.height/4
        }
        if player.position.y > 0.75 * self.size.height {
            player.position.y = 0.75 * self.size.height - player.size.height/2
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.r_o = player.position
        
        if currentGameState == gameState.preGame {
            startGame()
            self.vel.x = 0
            self.vel.y = 0
        }
        else if currentGameState == gameState.inGame && move_counter > 10 {
            
            move_counter = 11
            
            for touch: AnyObject in touches {
                let pointOfTouch = touch.location(in: self)
                
                let position = CGPoint(x: self.size.width - 3*self.size.width/12, y: self.size.height/2 + self.size.height*1.5/5/2)
                
                let touch_in_game_area = pointOfTouch.x > 0 && pointOfTouch.x < self.size.width && pointOfTouch.y > self.size.height/4 && pointOfTouch.y < 0.75 * self.size.height
                
                if pointOfTouch.x > position.x  && pointOfTouch.y > position.y {

                }
                else if touch_in_game_area {
                
                    player.position.x = pointOfTouch.x
                    player.position.y = pointOfTouch.y
                    player2.position = player.position
                    player_hit.position = player.position
                    
                    self.vel.x = (self.player.position.x - self.r_o.x)/2
                    self.vel.y = (self.player.position.y - self.r_o.y)/2
                    
                    let max_speed2 = 1000.0
                    let max_speed = sqrt(max_speed2)
                    let min_speed2 = 3.1
                    let speed2 = self.vel.x * self.vel.x + self.vel.y * self.vel.y
                    let R = abs(self.vel.y / (abs(self.vel.x) + 1e-10))                    
                    if speed2 >= CGFloat(max_speed2) {
                        
                        if self.vel.x > 0 {
                            self.vel.x = CGFloat(max_speed) / sqrt(1 + R * R)
                        }
                        else {
                            self.vel.x = -CGFloat(max_speed) / sqrt(1 + R * R)
                        }
                        
                        if self.vel.y < 0 {
                            self.vel.y = -abs(R * self.vel.x)
                        }
                        else {
                            self.vel.y = abs(R * self.vel.x)
                        }
                        
                    }
                    
                    if speed2 < CGFloat(min_speed2) {
                        self.vel.x = 0
                        self.vel.y = 0
                    }
                }
            }
        }
        else if currentGameState == gameState.gamePaused {
            
            for touch: AnyObject in touches {
                let pointOfTouch = touch.location(in: self)
                
                let position = CGPoint(x: self.size.width - 3*self.size.width/12, y: self.size.height/2 + self.size.height*1.5/5/2)
                
                if pointOfTouch.x > position.x  && pointOfTouch.y > position.y {
//                    currentGameState = gameState.inGame
//                    pause_button.zPosition = 2
//                    play_button.zPosition = -1
                }

            }
        }
        
        if player.position.x < 0 {
            player.position.x = player.size.width/2
        }
        if player.position.x > self.size.width {
            player.position.x = self.size.width - player.size.width/2
        }
        if player.position.y < self.size.height/4 {
            player.position.y = player.size.height/2 + self.size.height/4
        }
        if player.position.y > 0.75 * self.size.height {
            player.position.y = 0.75 * self.size.height - player.size.height/2
        }
    }
    
}
