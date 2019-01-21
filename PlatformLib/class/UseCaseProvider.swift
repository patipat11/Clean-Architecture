import Foundation
import DomainLib
import NetworkLib
import Moya

public class UseCaseProvider: DomainLib.UseCaseProvider {
	public init() {}
	public func makeRickyAndMortyUseCase() -> DomainLib.RickyAndMortyUseCase {
		return RequestDataUseCase(provider: MoyaProvider<Target>())
	}
}
