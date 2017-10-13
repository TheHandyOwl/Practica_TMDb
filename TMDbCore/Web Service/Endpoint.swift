//
//  Endpoint.swift
//  TMDbCore
//
//  Created by Guille Gonzalez on 21/09/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

internal enum Endpoint {
	case configuration
}

internal extension Endpoint {
	func request(with baseURL: URL, adding parameters: [String: String]) -> URLRequest {
		let url = baseURL.appendingPathComponent(path)

		var newParameters = self.parameters
		parameters.forEach { newParameters.updateValue($1, forKey: $0) }

		var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
		components.queryItems = newParameters.map(URLQueryItem.init)

		var request = URLRequest(url: components.url!)
		request.httpMethod = method.rawValue

		return request
	}
}

private enum HTTPMethod: String {
	case get = "GET"
}

private extension Endpoint {
	var method: HTTPMethod {
		return .get
	}

	var path: String {
		switch self {
		case .configuration:
			return "configuration"
		}
	}
	var parameters: [String: String] {
		return [:]
	}
}
