//
//  CustomTableViewCell.swift
//  CleanArchitecture
//
//  Created by TouchMe on 21/1/2562 BE.
//  Copyright © 2562 CreativeMe. All rights reserved.
//

import UIKit
import AlamofireImage

class ActorTableViewCell: UITableViewCell {
  
  @IBOutlet weak var backgroundImage: UIView!
  @IBOutlet weak var backgroundCell: UIView!
  @IBOutlet weak var actorImage: UIImageView!
  @IBOutlet weak var nameActoinLable: UILabel!
  @IBOutlet weak var detailActor: UILabel!
  @IBOutlet weak var imageActor: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundImage.layer.cornerRadius = 40
    backgroundCell.layer.cornerRadius = 20
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
  func setDataInCell( _ name: String, _ detail: String, image: URL) {
    self.nameActoinLable.text = name
    self.detailActor.text = detail
    actorImage.af_setImage(withURL: image)
  //self.imageActor.image = UIImage(data: image as Data)
  }
  
}
