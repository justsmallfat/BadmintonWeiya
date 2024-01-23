//
//  Player.swift
//  BadmintonWeiya
//
//  Created by 小胖 on 2024/1/23.
//

import Foundation

struct Player: Codable {
    var id : Int
    var groupName : String
    var playerName : String
    var scores : [String]
    var position_x : Double
    var position_y : Double
}
