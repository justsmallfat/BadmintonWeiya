//
//  SetViewController.swift
//  BadmintonWeiya
//
//  Created by 小胖 on 2024/1/23.
//

import UIKit

class SetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PlayerSetDelegate {
    
    @IBOutlet weak var playerEditTableView: UITableView!
    
    @IBOutlet var saveButton: UIButton!
    
    var allPlayers = [Player]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let defaults = UserDefaults.standard
        
        if let data = defaults.data(forKey: AppConstant.SAVE_DATA_KEY_2024Player) {
            allPlayers = try! PropertyListDecoder().decode([Player].self, from: data)
        }
        defaults.synchronize()
        
        if (allPlayers.isEmpty) {
            allPlayers = [Player]()
            for i in 0...17{
                
                var groupIndex = i % 3
                var group = i / 3
                var groupName = "\(Character(UnicodeScalar(group + 65)!))\(groupIndex+1)"
                
                let tempPlayer = Player(id: i,
                       groupName: groupName,
                       playerName: "",
                       scores: [],
                       position_x: AppConstant.PlayerViewWidth + AppConstant.PlayerViewWidth*Double(groupIndex),
                       position_y: AppConstant.PlayerViewHeight + (Double(group)*AppConstant.PlayerViewHeight))
                allPlayers.append(tempPlayer)
            }
        }
        
        
        playerEditTableView.delegate = self
        playerEditTableView.dataSource = self
        playerEditTableView.register(UINib(nibName: "PlayerEditTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerEditTableViewCell")
        playerEditTableView.estimatedRowHeight=50
        playerEditTableView.rowHeight=UITableView.automaticDimension
        
        self.playerEditTableView.reloadData()
        
        
    }
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        if let data = try? PropertyListEncoder().encode(allPlayers) {
            UserDefaults.standard.set(data, forKey: AppConstant.SAVE_DATA_KEY_2024Player)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerEditTableViewCell", for: indexPath) as! PlayerEditTableViewCell
        
        let data = allPlayers[indexPath.row]
        cell.tag = indexPath.row
        
        cell.initWithPlayer(player: data)
        cell.delegate = self
        
        return cell
    }
    
    func playerSet(index: Int, playerName: String?) {
        allPlayers[index].playerName = playerName!
    }
    
    
}
