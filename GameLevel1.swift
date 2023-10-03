//
//  GameLevel1.swift
//  SoloMission
//
//  Created by Derek Harrison on 25/09/2023.
//

import Foundation
import SpriteKit

class GameLevel1 : SKScene {
    var base = GameLevel()
    var num_backgrounds : Int = 10
    
    override func update(_ currentTime: TimeInterval) {
        base.update(scene: self)
    }
    
    override func didMove(to view: SKView) {
        base.didMove(scene: self)
        
        var images = [String]()
        images.append("frito_bitmap_cropped")
        images.append("frito_bitmap_rotated_cropped")
        
        base.init_images_frito(images: images, height: self.size.height, width: self.size.width)
        base.init_background(scene: self, num_backgrounds: num_backgrounds, string1: "background_guapo_game_nr")
        
        var images_brownie = [String]()
        images_brownie.append("brownie1_bitmap_cropped")
        images_brownie.append("brownie2_bitmap_cropped")
        
        base.init_images_brownie(images: images_brownie, height: self.size.height, width: self.size.width)
        
        var images_misty = [String]()
        images_misty.append("misty_bitmap_cropped")
        images_misty.append("misty_hit_bitmap_cropped")
        images_misty.append("misty_bitmap_cropped_rotated")
        images_misty.append("misty_hit_bitmap_cropped_rotated")
        base.init_images_misty(images: images_misty, height: self.size.height, width: self.size.width)
        
        var bird_images = [String]()
        
        bird_images.append("warawara1_bitmap_custom_mod_cropped")
        bird_images.append("warawara2_bitmap_custom_mod_cropped")
        bird_images.append("warawara3_bitmap_custom_mod_cropped")
        
        base.add_birds(images: bird_images)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        base.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        base.touchesMoved(touches, with: event)
    }
}
