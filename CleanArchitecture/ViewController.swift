import UIKit
import DomainLib
import PlatformLib

class ViewController: UIViewController {
	var res: RickyAndMortyResponse? = nil
	var nextURL: String?
	let usecase = UseCaseProvider()
	override func viewDidLoad() {
		super.viewDidLoad()
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
