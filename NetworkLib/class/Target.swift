//
// Created by Arnon Keereena on 23/12/2018 AD.
//

import Foundation
import DomainLib
import Moya

public enum Target: TargetType {
	case loadData(FirstSearch)
	case nextData(form: NextSearch)
	
	public var baseURL: URL {
		return URL(string: "https://rickandmortyapi.com")!
	}
	
	public var path: String {
    switch self {
    case .loadData(_):
      return "/api/character/"
    case .nextData(let nextSearch):
      return (nextSearch.nextURL?.url?.path)!
    }
  }
  
	public var method: Moya.Method {
		return .get
	}
	public var sampleData: Data { return Data() }
	
	public var task: Task {
		switch self {
		case .loadData(let firstSearch):
			if let name = firstSearch.keywordName?.name, !name.isEmpty {
				let params: [String: Any] = ["name": name]
				return .requestParameters(parameters: params, encoding: URLEncoding(destination: .queryString))
			} else {
				return .requestPlain
			}
		case .nextData(let nextSearch):
			if let params: [String: Any] = nextSearch.nextURL?.url?.queryParameters {
				return .requestParameters(parameters: params, encoding: URLEncoding(destination: .queryString))
			} else {
				return .requestPlain
			}
		}
	}
	public var headers: [String: String]? {
		return ["Content-Type": "application/json",
							 "Accept": "application/json"]
	}
	public var validationType: ValidationType {
		return .customCodes(Array(200..<200))
	}
}
