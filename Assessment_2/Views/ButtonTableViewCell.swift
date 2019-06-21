//
//  ButtonTableViewCell.swift
//  Assessment_2
//
//  Created by Nic Gibson on 6/21/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    var delegate: ButtonTableViewCellDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var collectedButton: UIButton!
    
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.buttonCellButtonTapped(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateButton(_ isCollected: Bool) {
        if isCollected {
            collectedButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        } else {
            collectedButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        }
    }
}
extension ButtonTableViewCell {
    func update(withItem item: Item) {
        textLabel?.text = item.name
        updateButton(item.isCollected)
    }
}
protocol ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}



