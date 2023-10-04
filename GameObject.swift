//
//  GameObject.swift
//  SoloMission
//
//  Created by Derek Harrison on 04/10/2023.
//

import Foundation
import SpriteKit

class GameObject {
    var z_pos: CGFloat
    var vel_x: CGFloat
    var vel_y: CGFloat
    var play_sound: Bool
    var play_hit_sound : Bool
    var images : [SKSpriteNode]
    var image : SKSpriteNode
    var image_hit : SKSpriteNode
    var images_hit : [SKSpriteNode]
    var image_names : [String]
    var bird_counter = 1
    var bird_counter_hit = 1
    var bird_id = 0
    var bird_id_hit = 0
    var width : CGFloat
    var height : CGFloat
    var hit : Bool
    var appeared : Bool
    var bubbles : Bubbles
    
    init() {
        self.z_pos = -1
        self.vel_x = 0
        self.vel_y = 0
        self.play_sound = true
        self.play_hit_sound = true
        self.images = [SKSpriteNode]()
        self.image = SKSpriteNode()
        self.image_hit = SKSpriteNode()
        self.images_hit = [SKSpriteNode]()
        self.image_names = [String]()
        self.width = 0
        self.height = 0
        self.hit = false
        self.appeared = false
        self.bubbles = Bubbles()
    }
    
    func set_height(height : CGFloat) {
        self.height = height
    }
    
    func set_width(width : CGFloat) {
        self.width = width
    }
    
    func set_z_pos(z_pos : CGFloat) {
        self.z_pos = z_pos
        for image in images {
            image.zPosition = z_pos
        }
        for image in images_hit {
            image.zPosition = z_pos
        }
    }
    
    func update_pos() {
        for image in images {
            image.position.x += self.vel_x
            image.position.y += self.vel_y
        }
        for image in images_hit {
            image.position = images[0].position
        }
    }
    
    func set_pos(pos : CGPoint) {
        for image in images {
            image.position = pos
        }
        for image in images_hit {
            image.position = pos
        }
    }
    
    func get_pos() -> CGPoint {
        return self.images[0].position
    }
    
    func set_vel(vel_x : CGFloat, vel_y : CGFloat) {
        self.vel_x = vel_x
        self.vel_y = vel_y
    }
    
    func set_play_sound(play_s : Bool) {
        self.play_sound = play_s
    }
    
    func set_image(image : SKSpriteNode) {
        self.image = image
    }
    
    func set_image_hit(image : SKSpriteNode) {
        self.image_hit = image
    }
    
    func get_image() -> SKSpriteNode {
        
        return self.image
    }
    
    func get_image_hit() -> SKSpriteNode {
        
        return self.image_hit
    }
    
    func add_image(image : String) {
        self.images.append(SKSpriteNode(imageNamed: image))
        self.image_names.append(image)
    }
    
    func add_image_hit(image : String) {
        self.images_hit.append(SKSpriteNode(imageNamed: image))
    }
    
    func add_childs(scene : SKScene) {
        for x in self.images {
            x.removeFromParent()
            scene.addChild(x)
        }
        for x in self.images_hit {
            x.removeFromParent()
            scene.addChild(x)
        }
        self.image_hit.removeFromParent()
        scene.addChild(self.image_hit)
    }
    
    func birdi_on_top(image_id : Int) {
        for image in 0..<self.images.count {
            if(image == image_id) {
                self.images[image].zPosition = self.z_pos
            }
            else {
                self.images[image].zPosition = -1
            }
        }
        for image in 0..<self.images_hit.count {
            self.images_hit[image].zPosition = -1
        }
    }
    
    func birdi_on_top_hit(image_id : Int) {
        for image in 0..<self.images_hit.count {
            if(image == image_id) {
                self.images_hit[image].zPosition = self.z_pos
            }
            else {
                self.images_hit[image].zPosition = -1
            }
        }
        for image in 0..<self.images.count {
            self.images[image].zPosition = -1
        }
    }
    
    func set_z_pos_api(z_pos : CGFloat) {
        self.set_z_pos(z_pos: z_pos)
    }
    
    func set_z_pos(image : SKSpriteNode, z_pos : CGFloat) {
        self.image.zPosition = z_pos
    }
    
    func set_size(size : CGSize) {
        for x in self.images {
            x.size = size
        }
    }
    
    func get_size() -> CGSize {
        return self.images[0].size
    }
    
    func reflect(scene : SKScene) {
        if self.images[0].position.y < 0.25 * scene.size.height {
            self.images[0].position.y = 0.25 * scene.size.height
            self.vel_y = -self.vel_y
        }
        if self.images[0].position.y > 0.75 * scene.size.height {
            self.images[0].position.y = 0.75 * scene.size.height
            self.vel_y = -self.vel_y
        }
    }
    
    func update_pos(scene : SKScene, bk_speed : CGFloat) {
        
        self.images[0].position.x += self.vel_x
        self.images[0].position.y += self.vel_y
        
        if self.images[0].position.x < -self.images[0].size.width {
            
            let speed = get_rand_num() * 2 * bk_speed + 1.2 * bk_speed
            set_vel(vel_x: speed, vel_y: 0)
            
            self.play_sound = true
            self.play_hit_sound = true
            
            let factor = 1.0 - (self.images[0].size.height) / (scene.size.height / 2)
            self.images[0].position.x = get_rand_num() * scene.size.width + scene.size.width
            self.images[0].position.y = get_rand_num() * scene.size.height / 2 * factor + scene.size.height / 4 + 1/2 * (1 - factor) * scene.size.height / 2
            
            self.hit = false
        }
        
        for x in self.images {
            x.position = self.images[0].position
        }
        
        for x in self.images_hit {
            x.position = self.images[0].position
        }
        
        advance_bird_counter()
    }
    
    func update_pos_rev(scene : SKScene, bk_speed : CGFloat) {
        
        self.images[0].position.x += self.vel_x
        self.images[0].position.y += self.vel_y
        
        if self.images[0].position.x - self.images[0].size.width > self.width {
            
            let speed = get_rand_num() * 2 * bk_speed + 1.2 * bk_speed
            set_vel(vel_x: speed, vel_y: 0)
            
            self.play_sound = true
            self.play_hit_sound = true
            
            let factor = 1.0 - (self.images[0].size.height) / (scene.size.height / 2)
            self.images[0].position.x = -get_rand_num() * scene.size.width - scene.size.width
            self.images[0].position.y = get_rand_num() * scene.size.height / 2 * factor + scene.size.height / 4 + 1/2 * (1 - factor) * scene.size.height / 2
            
            self.hit = false
        }
        
        for x in self.images {
            x.position = self.images[0].position
        }
        
        for x in self.images_hit {
            x.position = self.images[0].position
        }
        
        advance_bird_counter()
    }
    func update_pos_hit(scene : SKScene, bk_speed : CGFloat) {
        
        self.images[0].position.x += self.vel_x
        self.images[0].position.y += self.vel_y
        
        if self.images[0].position.x < -self.images[0].size.width {
            
            let speed = get_rand_num() * 2 * bk_speed + 1.2 * bk_speed
            set_vel(vel_x: speed, vel_y: 0)
            
            self.play_sound = true
            self.play_hit_sound = true
            
            let factor = 1.0 - (self.images[0].size.height) / (scene.size.height / 2)
            self.images[0].position.x = get_rand_num() * scene.size.width + scene.size.width
            self.images[0].position.y = get_rand_num() * scene.size.height / 2 * factor + scene.size.height / 4 + 1/2 * (1 - factor) * scene.size.height / 2
            
            self.hit = false
        }
        
        for x in self.images_hit {
            x.position = self.images[0].position
        }
        
        for x in self.images {
            x.position = self.images[0].position
        }
        
        advance_bird_counter_hit()
    }
    
    func reflect_player_velocity() {
        if self.images[0].position.x < 0 {
            self.images[0].position.x = 0
            self.vel_x = -self.vel_x
        }
        if self.images[0].position.x > self.width {
            self.images[0].position.x = self.width
            self.vel_x = -self.vel_x
        }
        if self.images[0].position.y > (self.height / 2 + self.height / 4) {
            self.images[0].position.y = self.height / 2 + self.height / 4
            self.vel_y = -self.vel_y
        }
        if self.images[0].position.y < (self.height / 2 - self.height / 4) {
            self.images[0].position.y = self.height / 2 - self.height / 4
            self.vel_y = -self.vel_y
        }
    }
    
    func update_pos3() {
        
        self.images[0].position.x += self.vel_x
        self.images[0].position.y += self.vel_y
        
        reflect_player_velocity()
        
        for x in self.images {
            x.position = self.images[0].position
        }
        
        self.image_hit.position = self.images[0].position
        
        advance_bird_counter()
    }
    
    func update_pos(scene : SKScene) {
        
        self.images[0].position.x += self.vel_x
        self.images[0].position.y += self.vel_y
        
        if self.images[0].position.x < -self.images[0].size.width {
            
            self.play_sound = true
            self.play_hit_sound = true
            self.hit = false
            
            let factor = 1.0 - (self.images[0].size.height) / (scene.size.height / 2)
            self.images[0].position.x = get_rand_num() * scene.size.width + scene.size.width
            self.images[0].position.y = get_rand_num() * scene.size.height / 2 * factor  + scene.size.height / 4 + 1/2 * (1 - factor) * scene.size.height / 2
        }
        for x in self.images {
            x.position = self.images[0].position
        }
    }
    
    func update_pos(scene : SKScene, at_screen : Int) {
        
        self.images[0].position.x += self.vel_x
        self.images[0].position.y += self.vel_y
        
        if self.images[0].position.x < -self.images[0].size.width {
            
            self.play_sound = true
            self.play_hit_sound = true
            self.hit = false
            
            let factor = 1.0 - (self.images[0].size.height) / (scene.size.height / 2)
            self.images[0].position.x = get_rand_num() * scene.size.width + CGFloat(at_screen) * scene.size.width
            self.images[0].position.y = get_rand_num() * scene.size.height / 2 * factor  + scene.size.height / 4 + 1/2 * (1 - factor) * scene.size.height / 2
        }
        for x in self.images {
            x.position = self.images[0].position
        }
        
        advance_bird_counter()
    }
    
    func advance_bird_counter() {
        bird_counter += 1
        
        if(bird_counter < num_frames_bird) {
            birdi_on_top(image_id: bird_id)
        }
        else {
            bird_counter = 0
            bird_id += 1
            if(bird_id == self.images.count) { bird_id = 0 }
            birdi_on_top(image_id: bird_id)

        }
    }
    
    func advance_bird_counter_hit() {
        bird_counter_hit += 1
        
        if(bird_counter_hit < num_frames_bird) {
            birdi_on_top_hit(image_id: bird_id_hit)
        }
        else {
            bird_counter_hit = 0
            bird_id_hit += 1
            if(bird_id_hit == self.images_hit.count) { bird_id_hit = 0 }
            birdi_on_top_hit(image_id: bird_id_hit)

        }
    }
}


func play_sound_api(scene : SKScene, sound : [SKAction]) {
    let bubble_sound = SKSpriteNode()
    scene.addChild(bubble_sound)

    let bubble_sound_biteSequence = SKAction.sequence(sound)
    bubble_sound.run(bubble_sound_biteSequence)
}


func get_rand_num() -> CGFloat {
    CGFloat(Float(arc4random()) / Float(UINT32_MAX))
}

func doOverlap(l1: CGPoint ,r1: CGPoint, l2: CGPoint, r2: CGPoint) -> Bool {
 
    // At least one of the rectangles is a line
    if (l1.x == r1.x || l1.y == r1.y || l2.x == r2.x
        || l2.y == r2.y) {
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

func check_collision(bird : GameObject, player : Player, den : CGFloat) -> Bool {
    
    var l1 = bird.images[0].position
    var r1 = l1
    l1.x -= bird.get_size().width / den
    l1.y += bird.get_size().height / den
    r1.x += bird.get_size().width / den
    r1.y -= bird.get_size().height / den
    var l2 = player.images[0].position
    var r2 = player.images[0].position
    l2.x -= player.images[0].size.width / den
    l2.y += player.images[0].size.height / den
    r2.x += player.images[0].size.width / den
    r2.y -= player.images[0].size.height / den
                    
    return doOverlap(l1: l1 ,r1: r1, l2: l2, r2: r2)
}
