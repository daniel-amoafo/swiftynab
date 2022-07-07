//
//  UserService.swift
//  SwiftYNAB
//
//  Created by Andre Bocchini on 5/4/19.
//  Copyright © 2019 Andre Bocchini. All rights reserved.
//

import Foundation

/// Provides access to user operations
public class UserService {
    private let client: ClientType

    init(client: ClientType) {
        self.client = client
    }
}

extension UserService: UserServiceType {
    /// Returns authenticated user information
    ///
    /// - Returns: A single user
    public func getUser() async throws -> User {
        let request = UserRequest()
        let response: UserResponse = try await client.request(request)
        return response.user
    }
}
