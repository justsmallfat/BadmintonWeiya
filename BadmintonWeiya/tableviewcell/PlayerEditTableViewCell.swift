//
//  PlayerEditTableViewCell.swift
//  BadmintonWeiya
//
//  Created by 小胖 on 2024/1/23.
//

import UIKit

protocol PlayerSetDelegate {
    func playerSet(index:Int, playerName:String?)
}

class PlayerEditTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var playerNameTextField: UITextField!
    
    var delegate : PlayerSetDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initWithPlayer(player : Player) {
        groupLabel.text = player.groupName
        playerNameTextField.text = player.playerName
        
        self.playerNameTextField.delegate = self
        self.playerNameTextField.tag = player.id
        
    }
    
    private func textFieldDidBeginEditing(_ textField: UITextField) -> Bool {
        let index = textField.tag
        textField.selectAll(nil)
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let value = textField.text
        self.delegate?.playerSet(index: textField.tag, playerName: value)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let index = self.tag
        let value = textField.text
        self.delegate?.playerSet(index: textField.tag, playerName: value)
        textField.resignFirstResponder()
        return true
    }
    
}
