//
//  CustomTableViewCell.swift
//  TableViewRxSwift-practice
//
//  Created by 大西玲音 on 2021/05/18.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    
    func configure(item: Item) {
        nameLabel.text = item.name
        backgroundColor = item.color
    }
        
}
