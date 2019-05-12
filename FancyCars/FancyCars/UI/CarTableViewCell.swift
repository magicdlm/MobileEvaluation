//
//  CarTableViewCell.swift
//  FancyCars
//
//  Created by Leming Deng on 2019-05-11.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import UIKit
import SDWebImage

final class CarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var availableLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    func configure(with data: ViewModel.Data) {
        carImage.sd_setImage(with: URL(string: data.car.img), completed: nil)
        nameLabel.text = data.car.name
        makeLabel.text = data.car.make
        modelLabel.text = data.car.model
        availableLabel.text = data.availablility.rawValue
        buyButton.isHidden = data.availablility != .inDealership
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        carImage.sd_cancelCurrentAnimationImagesLoad()
        carImage.image = #imageLiteral(resourceName: "empty-gallery")
    }
}
