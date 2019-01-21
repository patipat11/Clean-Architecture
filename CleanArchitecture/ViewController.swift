import UIKit
import DomainLib
import PlatformLib

class ViewController: UIViewController {
  var res: RickyAndMortyResponse? = nil
  var nextURL: String?
  let usecase = UseCaseProvider()
  
  
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
    firstCall()
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
extension ViewController {
  
  func firstCall() {
    let key = KeywordName(name: "ri")
    let keywordName = key
    let firstSearch = FirstSearch(keywordName: keywordName)
    usecase.makeRickyAndMortyUseCase().rickyAndMortyFirstLoadData(firstSearch: firstSearch) { (response) in
      self.res = response
      self.nextURL = self.res?.info.next
      self.secondCall()
    }
  }
  
  func secondCall() {
    let nextURL = NextURL(urlString: self.nextURL!)
    let nextSearch = NextSearch(nextURL: nextURL)
    usecase.makeRickyAndMortyUseCase().rickyAndMortyLoadMore(nextSearch: nextSearch) { (response) in
      self.res = response
      self.nextURL = self.res?.info.next
    }
    
  }
}
