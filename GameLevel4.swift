//
//  GameLevel4.swift
//  SoloMission
//
//  Created by Derek Harrison on 25/09/2023.
//

import Foundation

import SpriteKit
import GameplayKit

class GameLevel4: SKScene {
    
    var base = GameLevel()
    var num_backgrounds : Int = 5
    
    override func update(_ currentTime: TimeInterval) {
        base.update_ocean(scene: self)
    }
    
    override func didMove(to view: SKView) {
        base.didMove_ocean(scene: self)

        base.add_bubbles(bubbles_char: base.player.bubbles, bubble_image: "bubble_bitmap_cropped")

        var images = [String]()
        images.append("frito_snorkel_bitmap_cropped")
        images.append("frito_snorkel_hit_bitmap_rotated_cropped")
        base.add_bubbles(bubbles_char: base.frito.bubbles, bubble_image: "bubble_bitmap_cropped")
        
        for x in base.frito.bubbles.bubbles {
            x.removeFromParent()
            self.addChild(x)
        }
        
        base.init_images_frito(images: images, height: self.size.height, width: self.size.width)
        
        var images_brownie = [String]()
        images_brownie.append("brownie_snorkel_bitmap_cropped")
        images_brownie.append("brownie_snorkel_bitmap_hit_cropped")
        base.add_bubbles(bubbles_char: base.brownie.bubbles, bubble_image: "bubble_bitmap_cropped")
        
        for x in base.brownie.bubbles.bubbles {
            x.removeFromParent()
            self.addChild(x)
        }
        
        base.init_images_brownie(images: images_brownie, height: self.size.height, width: self.size.width)
        
        var images_misty = [String]()
        images_misty.append("misty_withsnorkel_bitmap_cropped")
        images_misty.append("misty_withsnorkel_hit_bitmap_cropped")
        images_misty.append("misty_withsnorkel_bitmap_cropped_rotated")
        images_misty.append("misty_withsnorkel_hit_bitmap_cropped_rotated")
        base.add_bubbles(bubbles_char: base.misty.bubbles, bubble_image: "bubble_bitmap_cropped")
        
        for x in base.misty.bubbles.bubbles {
            x.removeFromParent()
            self.addChild(x)
        }
        
        base.init_images_misty(images: images_misty, height: self.size.height, width: self.size.width)
        
        base.init_background(scene: self, num_backgrounds: num_backgrounds, string1: "background_guapogame_underwaterlevel_")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        base.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        base.touchesMoved(touches, with: event)
    }
}
