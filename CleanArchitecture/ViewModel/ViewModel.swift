import Foundation
import DomainLib
import PlatformLib

protocol HomeViewModel: class {
  func getDataActor(_ keyword: KeywordName, callback: @escaping ([ActorModel])->())
}

class ViewModel: HomeViewModel {
  
  let usecase = UseCaseProvider()
  var actorModel: [ActorModel] = []
  var info: Info?
  var results: [Result] = []
  var response: RickyAndMortyResponse? = nil
  var nextPageURL: String = ""
  var currentPage = 1
  var infoModel: InfoModel?
  var viewcontroller: ViewControllerDelagate?

  func getDataActor(_ keyword: KeywordName, callback: @escaping ([ActorModel])->()) {
    self.actorModel.removeAll()
    self.currentPage = 1
    let keywordSearchActor = FirstSearch(keywordName: keyword)
    
    usecase.makeRickyAndMortyUseCase().rickyAndMortyFirstLoadData(firstSearch: keywordSearchActor) { (response) in
      self.response = response
      guard let resulst = self.response?.results else {
        return
      }
      
      self.nextPageURL = self.response?.info.next ?? ""
      self.results = resulst
      self.results.forEach({ (results) in
        let actor = ActorModel(results.name, results.status, results.image)
        self.actorModel.append(actor)
      })
      callback(self.actorModel)
    }
  }
  
  func secondCall(callback: @escaping ([ActorModel] ,InfoModel)->()) {
    
    guard !self.nextPageURL.isEmpty else { return }
    viewcontroller?.show()
    let nextURL = NextURL(urlString: self.nextPageURL)
    let nextSearch = NextSearch(nextURL: nextURL)
    
    usecase.makeRickyAndMortyUseCase().rickyAndMortyLoadMore(nextSearch: nextSearch) { (response) in
      self.response = response
      guard let resulst = self.response?.results else {
        return
      }
      self.currentPage += 1
      self.nextPageURL = self.response?.info.next ?? ""
      self.info = self.response?.info
      self.results = resulst
      self.infoModel = InfoModel(currentPage: self.currentPage,totalPage: self.info?.pages)
		var actorModel = [ActorModel]()
      self.results.forEach({ (results) in
        let actor = ActorModel(results.name, results.status, results.image)
		actorModel.append(actor)
      })
      self.viewcontroller?.hide()
      callback(actorModel, self.infoModel!)
    }
  }
}
