import Foundation

public typealias RickyAndMortyResponseCallback = (RickyAndMortyResponse?)->()

public protocol RickyAndMortyUseCase {
	func rickyAndMortyFirstLoadData(firstSearch: FirstSearch, callback: @escaping  RickyAndMortyResponseCallback)
	func rickyAndMortyLoadMore(nextSearch: NextSearch, callback: @escaping  RickyAndMortyResponseCallback)
}
