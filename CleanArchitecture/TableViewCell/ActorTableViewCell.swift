//
//  CustomTableViewCell.swift
//  CleanArchitecture
//
//  Created by TouchMe on 21/1/2562 BE.
//  Copyright © 2562 CreativeMe. All rights reserved.
//

import UIKit

class ActorTableViewCell: UITableViewCell {
  
  @IBOutlet weak var backgroundImage: UIView!
  @IBOutlet weak var backgroundCell: UIView!
  @IBOutlet weak var actorImage: UIImageView!
  @IBOutlet weak var nameActoinLable: UILabel!
  @IBOutlet weak var detailActor: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundImage.layer.cornerRadius = 40
    backgroundCell.layer.cornerRadius = 20
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func setDataInCell( _ name: String, _ detail: String) {
    self.nameActoinLable.text = name
    self.detailActor.text = detail
  }
  
}
