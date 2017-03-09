//
//  CPTabCell.swift
//  CollectionPageMenu
//
//  Created by lakshika bhardwaj on 20/04/16.
//  Copyright © 2016 Kellton Tech. All rights reserved.
//

import UIKit

class CPTabCell: UICollectionViewCell {
    
    @IBOutlet weak var tabTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func shouldSetCellSelected(_ selected :Bool) {
        if  selected {
            
            self.backgroundColor = ktabSelectedColor
            self.tabTitle.textColor = ktabTextColorSelected
            
        }
            
        else {
            
            self.backgroundColor = ktabDefaultColor
            self.tabTitle.textColor = ktabTextColorDefault
        }
        
        
    }
    
    
}
