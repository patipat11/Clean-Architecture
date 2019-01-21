import Foundation

public protocol UseCaseProvider {
	func makeRickyAndMortyUseCase() -> RickyAndMortyUseCase
}
