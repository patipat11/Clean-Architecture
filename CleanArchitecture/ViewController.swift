//
//  ViewController.swift
//  CleanArchitecture
//
//  Created by Patipat Sahasapanan on 18/1/2562 BE.
//  Copyright © 2562 CreativeMe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var backgroundTextFieldView: UIView!
  @IBOutlet weak var listActorTableView: UITableView! {
    didSet{
      listActorTableView.delegate = self
      listActorTableView.dataSource = self
    }
  }

  let nameNibTableViewCell = "ActorTableViewCell"

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
    navigationItem.title = "Lessons"
	}
  
  override func viewWillAppear(_ animated: Bool) {
    createLayout()
  }

  func createLayout() {
    backgroundTextFieldView.layer.cornerRadius = 18.0
    UIApplication.shared.statusBarStyle = .lightContent
    preferredStatusBarStyle
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return UIStatusBarStyle.lightContent
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = listActorTableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell

    let cell = Bundle.main.loadNibNamed(nameNibTableViewCell, owner: self, options: nil)?.first as! ActorTableViewCell
    cell.setDataInCell("titleName", "Hello SubProduct")
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 95

  }
}
