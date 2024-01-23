//
//  PlayerView.swift
//  BadmintonWeiya
//
//  Created by 小胖 on 2024/1/23.
//

import UIKit


protocol PlayerViewDelegate {
    func playerMove(player:Player)
}

class PlayerView: UIView, NibOwnerLoadable {

    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    var delegate : PlayerViewDelegate?
    
    @IBInspectable var groupName:String = "" {
        didSet{
            groupNameLabel.text = groupName
        }
    }
    @IBInspectable var playerName:String = "" {
        didSet{
            playerNameLabel.text = playerName
        }
    }
    
    var player: Player?
    
    var panGesture = UIPanGestureRecognizer()
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        groupNameLabel.text = groupName
        playerNameLabel.text = playerName
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    func initWithPlayer(player: Player) {
        groupNameLabel.text = player.groupName
        playerNameLabel.text = player.playerName
        self.player = player
    }
    
    
    func customInit(){
        loadNibContent()
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(panGesture)
    }
    
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        let translation = sender.translation(in: superview)
        self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: superview)
        print("self.player \(self.player)")
        if(self.player != nil){
            self.player?.position_x = self.center.x - (self.frame.width/2)
            self.player?.position_y = self.center.y - (self.frame.height/2)
            delegate?.playerMove(player: self.player!)
        }
    }
}
