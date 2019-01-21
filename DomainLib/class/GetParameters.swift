//
//  GetParameters.swift
//  DomainLib
//
//  Created by Patipat Sahasapanan on 21/1/2562 BE.
//  Copyright © 2562 CreativeMe. All rights reserved.
//

import Foundation
extension URL {
	
	public var queryParameters: [String: String]? {
		guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
			return nil
		}
		
		var parameters = [String: String]()
		for item in queryItems {
			parameters[item.name] = item.value
		}
		
		return parameters
	}
}
