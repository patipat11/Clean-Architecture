import Foundation

public struct FirstSearch {
	public let keywordName: KeywordName?
	
	public init(keywordName: KeywordName) {
		self.keywordName = keywordName
	}
}

public struct NextSearch {
	public let nextURL: NextURL?
	public init(nextURL: NextURL) {
		self.nextURL = nextURL
	}
}

public struct NextURL {
	public let urlString: String?
	public init(urlString: String) {
		self.urlString = urlString
	}
	
	public var url: URL? {
		guard let url = urlString else {
			return nil
		}
		return URL(string: url)
	}
}
public struct KeywordName {
	public let name: String?
	public init(name: String?) {
		self.name = name
	}
}
