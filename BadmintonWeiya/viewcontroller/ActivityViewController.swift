//
//  ViewController.swift
//  BadmintonWeiya
//
//  Created by 小胖 on 2024/1/23.
//

import UIKit

class ActivityViewController: UIViewController, PlayerViewDelegate {
    
    @IBOutlet var activityView: UIView!
    
    var allPlayers = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        
        if let data = defaults.data(forKey: AppConstant.SAVE_DATA_KEY_2024Player) {
            allPlayers = try! PropertyListDecoder().decode([Player].self, from: data)
        }
        defaults.synchronize()
        self.activityView.subviews.forEach { subView in
            subView.removeFromSuperview()
        }
        allPlayers.forEach {player in
            print(player)
            var frame = CGRect(x: player.position_x,
                               y: player.position_y,
                               width: AppConstant.PlayerViewWidth,
                               height: AppConstant.PlayerViewHeight)
            var playerView = PlayerView(frame: frame)
            playerView.initWithPlayer(player: player)
            playerView.delegate = self
            self.activityView.addSubview(playerView)
        }
    }
    
    func playerMove(player: Player) {
        allPlayers.remove(at: player.id)
        allPlayers.insert(player, at: player.id)
//        var tempPlayer = allPlayers.first { tempPlayer in
//            tempPlayer.id == player.id
//
//            tempPlayer?.position_x = player.position_x
//            tempPlayer?.position_y = player.position_y
//        }
        
        
        if let data = try? PropertyListEncoder().encode(allPlayers) {
            UserDefaults.standard.set(data, forKey: AppConstant.SAVE_DATA_KEY_2024Player)
        }
    }
}

