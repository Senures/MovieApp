//
//  CategoriesCell.swift
//  MoviesApp
//
//  Created by SEMANUR ESERLER on 2.04.2023.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var categoriLabel: UILabel!
    //isselected uikit icinde tanımlı değisken collection viewda secili olup olmadıgı, hücrenin özelliği o yüzden hangi itema tıklandıgı //algılanıyor, override sebebide bu cellin ayrı bi yerde olması diğer classtan ayrı yerde
    override var isSelected: Bool {
        
        
        didSet {
            self.contentView.backgroundColor = isSelected ? .magenta : .gray
            
        }
    }
    
    
}
