import UIKit
import DomainLib
import PlatformLib
import RxSwift
import RxCocoa
import AlamofireImage
import MBProgressHUD

protocol ViewControllerDelagate {
  func show()
  func hide()
}

class ViewController: UIViewController, ViewControllerDelagate {
  
  var response: RickyAndMortyResponse? = nil
  var nextURL: String?
  let usecase = UseCaseProvider()
  let nameNibTableViewCell = "ActorTableViewCell"
  var results: [Result] = []
  var viewModel = ViewModel()
  var timer: Timer?
  var actorModel: [ActorModel]?
  var isLoading = false
  
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
    viewModel.viewcontroller = self
    searchTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    listActorTableView.register(UINib(nibName: "ActorTableViewCell", bundle: nil), forCellReuseIdentifier: nameNibTableViewCell)
    firstLoadActor()
    setDisplay()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return UIStatusBarStyle.lightContent
  }
  
  func show() {
    self.isLoading = true
    MBProgressHUD.showAdded(to: self.view, animated: true)
  }
  
  func hide() {
    self.isLoading = false
    MBProgressHUD.hide(for: self.view, animated: true)
  }
  
  func setDisplay() {
    backgroundTextFieldView.layer.cornerRadius = 18.0
    navigationItem.title = "Lessons"
  }
  
  func firstLoadActor() {
    viewModel.getDataActor(KeywordName(name: ""), callback: { (actorModel) in
      self.actorModel = actorModel
      self.listActorTableView.reloadData()
      
    })
  }
  
  func loadMore() {
    viewModel.secondCall { (actorModel, info) in
		self.listActorTableView.beginUpdates()
		actorModel.forEach({ (model) in
			self.actorModel?.append(model)
				self.listActorTableView.insertRows(at: [IndexPath.init(row: (self.actorModel?.count)!-1, section: 0)], with: .automatic)
		})
		self.listActorTableView.endUpdates()
		
		
      //self.listActorTableView.reloadData()
      self.title = "\(info.currentPage!)/\(info.totalPage!)"
    }
  }
  
  func getData(name: String) {

    viewModel.getDataActor(KeywordName(name: name), callback: { (actorModel) in
      self.actorModel = actorModel
      self.listActorTableView.reloadData()
    })
  }
}

extension ViewController {
  
  @objc func textFieldDidChange(textField: UITextField) {
    navigationItem.title = "Lessons"
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
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
    let cell = tableView.dequeueReusableCell(withIdentifier: nameNibTableViewCell, for: indexPath) as? ActorTableViewCell
    let imageURL = URL(string: (self.actorModel?[indexPath.row].image)!)
    //    let dataImage = NSData(contentsOf: imageURL as! URL)
    
    cell?.setDataInCell((self.actorModel?[indexPath.row].name ?? ""),
                       (self.actorModel?[indexPath.row].status ?? ""),
                       image: imageURL!)
    
	return cell ?? UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 95
    
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      
      guard let actorCount = self.actorModel?.count else {
        return
      }
      if indexPath.row == actorCount - 1 && self.isLoading == false {
        self.loadMore()
      }
    }
  }
}
