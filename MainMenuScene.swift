//
//  MainMenuScene.swift
//  SoloMission
//
//  Created by Derek Harrison on 29/07/2021.
//

import Foundation
import SpriteKit

let unlock_level_points = LEVEL_UNLOCK_GUARD

class MainMenuScene: SKScene {

    let levels_text = SKLabelNode(fontNamed: GAME_FONT)
    let high_score_text = SKLabelNode(fontNamed: GAME_FONT)
    
    let level_1_np = SKSpriteNode(imageNamed: MAIN_MENU_BUTTON_NOTPRESSED_1)
    let level_1_p = SKSpriteNode(imageNamed: MAIN_MENU_BUTTON_PRESSED_1)
    let level_2_np = SKSpriteNode(imageNamed: MAIN_MENU_BUTTON_NOTPRESSED_2)
    let level_2_p = SKSpriteNode(imageNamed: MAIN_MENU_BUTTON_PRESSED_2)
    let level_3_np = SKSpriteNode(imageNamed: MAIN_MENU_BUTTON_NOTPRESSED_3)
    let level_3_p = SKSpriteNode(imageNamed: MAIN_MENU_BUTTON_PRESSED_3)
    let level_4_np = SKSpriteNode(imageNamed: MAIN_MENU_BUTTON_NOTPRESSED_4)
    let level_4_p = SKSpriteNode(imageNamed: MAIN_MENU_BUTTON_PRESSED_4)
    
    let level_2_grey = SKSpriteNode(imageNamed: MAIN_MENU_BUTTON_GRAY_2)
    let level_3_grey = SKSpriteNode(imageNamed: MAIN_MENU_BUTTON_GRAY_3)
    let level_4_grey = SKSpriteNode(imageNamed: MAIN_MENU_BUTTON_GRAY_4)
    
    let level_1_score = SKLabelNode(fontNamed: GAME_FONT)
    let level_2_score = SKLabelNode(fontNamed: GAME_FONT)
    let level_3_score = SKLabelNode(fontNamed: GAME_FONT)
    let level_4_score = SKLabelNode(fontNamed: GAME_FONT)
    
    var label = SKLabelNode(fontNamed: LABEL_FONT)

    let volume_on = SKSpriteNode(imageNamed: SOUND_ON_IMAGE_STR)
    let volume_off = SKSpriteNode(imageNamed: SOUND_OFF_IMAGE_STR)
    
    var muted = false

    var start_new_scene_touched = false
    var start_new_scene = false
    
    var start_level_1_touched = false
    var start_level_1 = false
    var start_level_1_scene = false
    var start_level_2_touched = false
    var start_level_2 = false
    var start_level_2_scene = false
    var start_level_3_touched = false
    var start_level_3 = false
    var start_level_3_scene = false
    var start_level_4_touched = false
    var start_level_4 = false
    var start_level_4_scene = false
    
    var highScoreNumberLevel1 = 0
    var highScoreNumberLevel2 = 0
    var highScoreNumberLevel3 = 0
    var highScoreNumberLevel4 = 0
    
    override func didMove(to view: SKView) {
        
        start_new_scene = false
        start_new_scene_touched = false
        
        let width = self.size.width / 16
        let height = self.size.height / 20
        
        volume_off.setScale(1)
        volume_off.size = CGSize(width: width, height: height)
        volume_off.position = CGPoint(x: self.size.width - self.size.width/12, y: self.size.height/2 + self.size.height*1.9/5/2)
        volume_off.zPosition = 2
        
        
        volume_on.setScale(1)
        volume_on.size = CGSize(width: width, height: height)
        volume_on.position = volume_off.position
        volume_on.zPosition = -1
        
        
        let defaults = UserDefaults()
        muted = defaults.bool(forKey: GAME_MUTED)
        if muted {
            volume_off.zPosition = 2
            volume_on.zPosition = -1
        }
        else {
            volume_off.zPosition = -1
            volume_on.zPosition = 2
        }
        
        self.addChild(volume_off)
        self.addChild(volume_on)
        let background = SKSpriteNode(imageNamed: BACKGROUND_START_SCREEN)
        
        let widthb = background.size.width
        let heightb = self.size.height/2
        
        background.size = CGSize(width: widthb, height: heightb)
        
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        self.addChild(background)
        
        
        levels_text.text = LEVELS_STR
        levels_text.fontSize = 80
        levels_text.fontColor = SKColor.gray
        levels_text.position = CGPoint(x: self.size.width/2 - self.size.width/8, y: self.size.height/2 * 0.85 + self.size.height/4)
        levels_text.zPosition = 1

        levels_text.zPosition = 1
        self.addChild(levels_text)
        
        high_score_text.text = HIGHSCORE_STR
        high_score_text.fontSize = 80
        high_score_text.fontColor = SKColor.gray
        high_score_text.position = CGPoint(x: self.size.width/2 + self.size.width/8, y: self.size.height/2 * 0.85 + self.size.height/4)
        high_score_text.zPosition = 1

        high_score_text.zPosition = 1
        self.addChild(high_score_text)
        
        highScoreNumberLevel1 = defaults.integer(forKey: HIGH_SCORE_ID_1)
        highScoreNumberLevel2 = defaults.integer(forKey: HIGH_SCORE_ID_2)
        highScoreNumberLevel3 = defaults.integer(forKey: HIGH_SCORE_ID_3)
        highScoreNumberLevel4 = defaults.integer(forKey: HIGH_SCORE_ID_4)

        let width_button = self.size.width/5
        let height_button = self.size.height/16
        
        level_1_np.size = CGSize(width: width_button, height: height_button)
        level_1_np.position = CGPoint(x: self.size.width/2 - self.size.width/8, y: self.size.height/2 * 0.73 + self.size.height/4)
        level_1_np.zPosition = 2
        self.addChild(level_1_np)
        
        level_1_p.size = CGSize(width: width_button, height: height_button)
        level_1_p.position = CGPoint(x: self.size.width/2 - self.size.width/8, y: self.size.height/2 * 0.73 + self.size.height/4)
        level_1_p.zPosition = -1
        self.addChild(level_1_p)
        
        level_1_score.text = String(highScoreNumberLevel1)
        level_1_score.fontSize = 70
        level_1_score.fontColor = SKColor.gray
        level_1_score.position = CGPoint(x: self.size.width/2 + self.size.width/8, y: self.size.height/2 * 0.70 + self.size.height/4)
        level_1_score.zPosition = 1

        level_1_score.zPosition = 1
        self.addChild(level_1_score)
        
        if highScoreNumberLevel1 >= unlock_level_points {
            level_2_np.size = CGSize(width: width_button, height: height_button)
            level_2_np.position = CGPoint(x: self.size.width/2 - self.size.width/8, y: self.size.height/2 * 0.58 + self.size.height/4)
            level_2_np.zPosition = 2
            self.addChild(level_2_np)
            
            level_2_p.size = CGSize(width: width_button, height: height_button)
            level_2_p.position = CGPoint(x: self.size.width/2 - self.size.width/8, y: self.size.height/2 * 0.58 + self.size.height/4)
            level_2_p.zPosition = -1
            self.addChild(level_2_p)
        }
        else {
            level_2_np.size = CGSize(width: width_button, height: height_button)
            level_2_np.position = CGPoint(x: self.size.width/2 - self.size.width/8, y: self.size.height/2 * 0.58 + self.size.height/4)
            level_2_np.zPosition = -1
            self.addChild(level_2_np)
            
            level_2_grey.size = CGSize(width: width_button, height: height_button)
            level_2_grey.position = CGPoint(x: self.size.width/2 - self.size.width/8, y: self.size.height/2 * 0.58 + self.size.height/4)
            level_2_grey.zPosition = 2
            self.addChild(level_2_grey)
            
            level_2_p.size = CGSize(width: width_button, height: height_button)
            level_2_p.position = CGPoint(x: self.size.width/2 - self.size.width/8, y: self.size.height/2 * 0.58 + self.size.height/4)
            level_2_p.zPosition = -1
            self.addChild(level_2_p)
        }
        
        level_2_score.text = String(highScoreNumberLevel2)
        level_2_score.fontSize = 70
        level_2_score.fontColor = SKColor.gray
        level_2_score.position = CGPoint(x: self.size.width/2 + self.size.width/8, y: self.size.height/2 * 0.55 + self.size.height/4)
        level_2_score.zPosition = 1
        self.addChild(level_2_score)
        
        if highScoreNumberLevel2 >= unlock_level_points {
            level_3_np.size = CGSize(width: width_button, height: height_button)
            level_3_np.position = CGPoint(x: self.size.width/2 - self.size.width/8, y: self.size.height/2 * 0.43 + self.size.height/4)
            level_3_np.zPosition = 2
            self.addChild(level_3_np)
            
            level_3_p.size = CGSize(width: width_button, height: height_button)
            level_3_p.position = CGPoint(x: self.size.width/2 - self.size.width/8, y: self.size.height/2 * 0.43 + self.size.height/4)
            level_3_p.zPosition = -1
            self.addChild(level_3_p)
        }
        else {
            level_3_np.size = CGSize(width: width_button, height: height_button)
            level_3_np.position = CGPoint(x: self.size.width/2 - self.size.width/8, y: self.size.height/2 * 0.43 + self.size.height/4)
            level_3_np.zPosition = -1
            self.addChild(level_3_np)
            
            
            level_3_grey.size = CGSize(width: width_button, height: height_button)
            level_3_grey.position = CGPoint(x: self.size.width/2 - self.size.width/8, y: self.size.height/2 * 0.43 + self.size.height/4)
            level_3_grey.zPosition = 2
            self.addChild(level_3_grey)
            
            level_3_p.size = CGSize(width: width_button, height: height_button)
            level_3_p.position = CGPoint(x: self.size.width/2 - self.size.width/8, y: self.size.height/2 * 0.43 + self.size.height/4)
            level_3_p.zPosition = -1
            self.addChild(level_3_p)
        }

        
        level_3_score.text = String(highScoreNumberLevel3)
        level_3_score.fontSize = 70
        level_3_score.fontColor = SKColor.gray
        level_3_score.position = CGPoint(x: self.size.width/2 + self.size.width/8, y: self.size.height/2 * 0.4 + self.size.height/4)
        level_3_score.zPosition = 1

        level_3_score.zPosition = 1
        self.addChild(level_3_score)
        
        if highScoreNumberLevel3 >= unlock_level_points {
            level_4_np.size = CGSize(width: width_button, height: height_button)
            level_4_np.position = CGPoint(x: self.size.width/2 - self.size.width/8, y: self.size.height/2 * 0.28 + self.size.height/4)
            level_4_np.zPosition = 2
            self.addChild(level_4_np)
            
            level_4_p.size = CGSize(width: width_button, height: height_button)
            level_4_p.position = CGPoint(x: self.size.width/2 - self.size.width/8, y: self.size.height/2 * 0.28 + self.size.height/4)
            level_4_p.zPosition = -1
            self.addChild(level_4_p)
        }
        else {
            level_4_np.size = CGSize(width: width_button, height: height_button)
            level_4_np.position = CGPoint(x: self.size.width/2 - self.size.width/8, y: self.size.height/2 * 0.28 + self.size.height/4)
            level_4_np.zPosition = -1
            self.addChild(level_4_np)
            
            level_4_grey.size = CGSize(width: width_button, height: height_button)
            level_4_grey.position = CGPoint(x: self.size.width/2 - self.size.width/8, y: self.size.height/2 * 0.28 + self.size.height/4)
            level_4_grey.zPosition = 2
            self.addChild(level_4_grey)
            
            level_4_p.size = CGSize(width: width_button, height: height_button)
            level_4_p.position = CGPoint(x: self.size.width/2 - self.size.width/8, y: self.size.height/2 * 0.28 + self.size.height/4)
            level_4_p.zPosition = -1
            self.addChild(level_4_p)
        }
        
        level_4_score.text = String(highScoreNumberLevel4)
        level_4_score.fontSize = 70
        level_4_score.fontColor = SKColor.gray
        level_4_score.position = CGPoint(x: self.size.width/2 + self.size.width/8, y: self.size.height/2 * 0.25 + self.size.height/4)
        level_4_score.zPosition = 1

        level_4_score.zPosition = 1
        self.addChild(level_4_score)
        
    }
    
    //Force the mute button to change by running update()
    override func update(_ currentTime: TimeInterval) {
        if muted {
            volume_off.zPosition = 2
            volume_on.zPosition = -1
        }
        else {
            volume_off.zPosition = -1
            volume_on.zPosition = 2
        }
        
        if start_level_1_scene {
            let sceneToMoveTo = GameLevel1(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let myTransition = SKTransition.fade(withDuration: 3.0)
            self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            
            start_level_1_scene = false
        }
        
        if start_level_2_scene {
            let sceneToMoveTo = GameLevel2(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let myTransition = SKTransition.fade(withDuration: 3.0)
            self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            
            start_level_2_scene = false
        }
        
        if start_level_3_scene {
            let sceneToMoveTo = GameLevel3(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let myTransition = SKTransition.fade(withDuration: 3.0)
            self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            
            start_level_3_scene = false
        }
        
        if start_level_4_scene {
            let sceneToMoveTo = GameLevel4(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let myTransition = SKTransition.fade(withDuration: 3.0)
            self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            
            start_level_4_scene = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            
            let position = CGPoint(x: self.size.width - 2*self.size.width/12, y: self.size.height/2 + self.size.height*1.5/5/2)
            
            if pointOfTouch.x > position.x  && pointOfTouch.y > position.y && muted == false {
                volume_on.zPosition = 2
                volume_off.zPosition = -1
                muted = true

                let defaults = UserDefaults()
                defaults.set(muted, forKey: GAME_MUTED)
            }
            else if pointOfTouch.x > position.x  && pointOfTouch.y > position.y && muted == true {
                volume_on.zPosition = -1
                volume_off.zPosition = 2
                muted = false
                
                let defaults = UserDefaults()
                defaults.set(muted, forKey: GAME_MUTED)
            }
            else {
                
                let touched_button_1_x = pointOfTouch.x > level_1_np.position.x - level_1_np.size.width/2 && pointOfTouch.x < level_1_np.position.x + level_1_np.size.width/2
                
                let touched_button_1_y = pointOfTouch.y > level_1_np.position.y - level_1_np.size.height/2 && pointOfTouch.y < level_1_np.position.y + level_1_np.size.height/2
                
                if touched_button_1_x && touched_button_1_y {
                    level_1_np.zPosition = -1
                    level_1_p.zPosition = 2
                    start_level_1_touched = true
                }
                
                let touched_button_2_x = pointOfTouch.x > level_2_np.position.x - level_2_np.size.width/2 && pointOfTouch.x < level_2_np.position.x + level_2_np.size.width/2
                
                let touched_button_2_y = pointOfTouch.y > level_2_np.position.y - level_2_np.size.height/2 && pointOfTouch.y < level_2_np.position.y + level_2_np.size.height/2
                
                if touched_button_2_x && touched_button_2_y && highScoreNumberLevel1 >= unlock_level_points {
                    level_2_np.zPosition = -1
                    level_2_p.zPosition = 2
                    level_2_grey.zPosition = -1
                    start_level_2_touched = true
                }
                
                let touched_button_3_x = pointOfTouch.x > level_3_np.position.x - level_3_np.size.width/2 && pointOfTouch.x < level_3_np.position.x + level_3_np.size.width/2
                
                let touched_button_3_y = pointOfTouch.y > level_3_np.position.y - level_3_np.size.height/2 && pointOfTouch.y < level_3_np.position.y + level_3_np.size.height/2
                
                if touched_button_3_x && touched_button_3_y  && highScoreNumberLevel2 >= unlock_level_points {
                    level_3_np.zPosition = -1
                    level_3_p.zPosition = 2
                    level_3_grey.zPosition = -1
                    start_level_3_touched = true
                }
                
                let touched_button_4_x = pointOfTouch.x > level_4_np.position.x - level_4_np.size.width/2 && pointOfTouch.x < level_4_np.position.x + level_4_np.size.width/2
                
                let touched_button_4_y = pointOfTouch.y > level_4_np.position.y - level_4_np.size.height/2 && pointOfTouch.y < level_4_np.position.y + level_4_np.size.height/2
                
                if touched_button_4_x && touched_button_4_y && highScoreNumberLevel3 >= unlock_level_points{
                    level_4_np.zPosition = -1
                    level_4_p.zPosition = 2
                    level_4_grey.zPosition = -1
                    start_level_4_touched = true
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if start_new_scene_touched {
            start_new_scene = true
        }
        
        if start_level_1_touched {
            start_level_1 = true
            start_level_1_scene = true
        }
        if start_level_2_touched {
            start_level_2 = true
            start_level_2_scene = true
        }
        if start_level_3_touched {
            start_level_3 = true
            start_level_3_scene = true
        }
        if start_level_4_touched {
            start_level_4 = true
            start_level_4_scene = true
        }
    }
}
