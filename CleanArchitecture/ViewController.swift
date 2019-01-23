import UIKit
import DomainLib
import PlatformLib
import RxSwift
import RxCocoa
import AlamofireImage


class ViewController: UIViewController {
  var response: RickyAndMortyResponse? = nil
  var nextURL: String?
  let usecase = UseCaseProvider()
  let nameNibTableViewCell = "ActorTableViewCell"
  var results: [Result] = []
  var viewModel = ViewModel()
  var timer: Timer?
  var actorModel: [ActorModel]?
  
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var backgroundTextFieldView: UIView!
  @IBOutlet weak var listActorTableView: UITableView! {
    didSet{
      listActorTableView.delegate = self
      listActorTableView.dataSource = self
    }
  }

	override func viewDidLoad() {
		super.viewDidLoad()
//    getDataActor(KeywordName(name: ""))
    
    searchTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    
    viewModel.getDataActor(KeywordName(name: ""), callback: { (actorModel) in
      self.actorModel = actorModel
      self.listActorTableView.reloadData()
      
    })
    navigationItem.title = "Lessons"
    backgroundTextFieldView.layer.cornerRadius = 18.0
    listActorTableView.register(UINib(nibName: "ActorTableViewCell", bundle: nil), forCellReuseIdentifier: nameNibTableViewCell)
	}
  func secondCallTest() {
    
    viewModel.secondCall { (actorModel, info) in
      self.actorModel = actorModel
      self.listActorTableView.reloadData()
      self.title = "\(info.currentPage)/\(info.totalPage)"
    }
  }
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return UIStatusBarStyle.lightContent
  }
  
  func getData(name: String) {
    navigationItem.title = "Lessons"
    viewModel.getDataActor(KeywordName(name: name), callback: { (actorModel) in
      self.actorModel = actorModel
      self.listActorTableView.reloadData()
    })
  }
  

}
extension ViewController {
  
  @objc func textFieldDidChange(textField: UITextField){
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
      self.actorModel?.removeAll()
      self.listActorTableView.reloadData()
      self.getData(name: textField.text ?? "")
    }
  }
 
  
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.actorModel?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: nameNibTableViewCell, for: indexPath) as! ActorTableViewCell
    let imageURL = URL(string: (self.actorModel?[indexPath.row].image)!)
//    let dataImage = NSData(contentsOf: imageURL as! URL)
    
    cell.setDataInCell((self.actorModel?[indexPath.row].name ?? ""),
                       (self.actorModel?[indexPath.row].status ?? ""),
                       image: imageURL!)
    
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 95

  }
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let actorCount = actorModel?.count else {
      return
    }
    if indexPath.row > actorCount - 2 {
      self.secondCallTest()
      
    }
  }
}
