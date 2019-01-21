import Foundation
import Moya
import DomainLib
import NetworkLib

final class RequestDataUseCase: DomainLib.RickyAndMortyUseCase {
	
	let provider: MoyaProvider<Target>?
	
	init(provider: MoyaProvider<Target>) {
		self.provider = provider
	}
	
	func rickyAndMortyFirstLoadData(firstSearch: FirstSearch, callback: @escaping RickyAndMortyResponseCallback) {
		provider?.request(.loadData(firstSearch), completion: { (response) in
			switch response {
			case .success(let result):
				guard result.statusCode == 200 else {
					callback(nil)
					return
				}
				do {
					let jsonData = result.data
					let decoder = JSONDecoder()
			
					let photoObject = try decoder.decode(RickyAndMortyResponse.self, from: jsonData) 
						callback(photoObject)
				}
				catch let error {
					print(error)
				}
			case .failure(let error):
				print(error)
			}
		})
	}
	
	func rickyAndMortyLoadMore(nextSearch: NextSearch, callback: @escaping RickyAndMortyResponseCallback) {
		provider?.request(.nextData(form: nextSearch), completion: { (response) in
			switch response {
			case .success(let result):
				do {
					let filteredResponse = try result.filterSuccessfulStatusCodes()
					let jsonData = filteredResponse.data
					if let photoObject = try? JSONDecoder().decode(RickyAndMortyResponse.self, from: jsonData) {
						callback(photoObject)
					}
				}
				catch let error {
					print(error)
				}
			case .failure(let error):
				print(error)
			}
		})
	}

}
