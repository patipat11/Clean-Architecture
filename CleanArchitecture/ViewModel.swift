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
  var nextPageURL: String?
  var currentPage = 1
  var infoModel: InfoModel?

  func getDataActor(_ keyword: KeywordName, callback: @escaping ([ActorModel])->()) {
    self.actorModel.removeAll()
    let keywordSearchActor = FirstSearch(keywordName: keyword)
    
    usecase.makeRickyAndMortyUseCase().rickyAndMortyFirstLoadData(firstSearch: keywordSearchActor) { (response) in
      self.response = response
      guard let resulst = self.response?.results else {
        return
      }
      
      self.nextPageURL = self.response?.info.next
      self.results = resulst
      self.results.forEach({ (results) in
        let actor = ActorModel(results.name, results.status, results.image)
        self.actorModel.append(actor)
      })
      callback(self.actorModel)
    }
  }
  
  func secondCall(callback: @escaping ([ActorModel] ,InfoModel)->()) {
    let nextURL = NextURL(urlString: self.nextPageURL!)
    let nextSearch = NextSearch(nextURL: nextURL)
    
    usecase.makeRickyAndMortyUseCase().rickyAndMortyLoadMore(nextSearch: nextSearch) { (response) in
      self.response = response
      guard let resulst = self.response?.results else {
        return
      }
      self.currentPage += 1
      self.nextPageURL = self.response?.info.next
      self.info = self.response?.info
      self.results = resulst
      self.infoModel = InfoModel(currentPage: self.currentPage,totalPage: self.info?.pages)
//      self.InfoModel = InfoModel(

      self.results.forEach({ (results) in
        let actor = ActorModel(results.name, results.status, results.image)
        self.actorModel.append(actor)
      })
      callback(self.actorModel, self.infoModel!)
    }
  }
}
