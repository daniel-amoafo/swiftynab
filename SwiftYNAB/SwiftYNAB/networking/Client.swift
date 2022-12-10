//
//  Client.swift
//  SwiftYNAB
//
//  Created by Andre Bocchini on 7/7/22.
//  Copyright © 2022 Andre Bocchini. All rights reserved.
//

import Foundation

class Client {
    private let authorizationHeader: String
    private let urlSession: URLSessionType
    private let serializer: SerializerType

    init(accessToken: String, urlSession: URLSessionType, serializer: SerializerType) {
        self.authorizationHeader = "Bearer \(accessToken)"
        self.urlSession = urlSession
        self.serializer = serializer
    }
}

extension Client: ClientType {
    private func isHTTPError(response: URLResponse) -> Bool {
        guard let httpURLResponse = response as? HTTPURLResponse else {
            return false
        }

        return httpURLResponse.statusCode >= 400
    }

    func request<T>(_ request: Request) async throws -> T where T: Decodable, T: Encodable {
        var mutableURLRequest = request.request

        if request.requiresAuthentication {
            mutableURLRequest.setValue(authorizationHeader, forHTTPHeaderField: "Authorization")
        }

        let (data, urlResponse) = try await urlSession.data(for: mutableURLRequest, delegate: nil)

        try Task.checkCancellation()

        if isHTTPError(response: urlResponse) {
            guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
                throw SwiftYNABError.unknown
            }

            throw SwiftYNABError.httpError(statusCode: httpURLResponse.statusCode)
        }

        let response = try serializer.decode(Response<T>.self, from: data)
        return response.data
    }
}