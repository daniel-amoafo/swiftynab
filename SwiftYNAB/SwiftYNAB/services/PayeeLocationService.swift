//
//  PayeeLocationService.swift
//  SwiftYNAB
//
//  Created by Andre Bocchini on 5/4/19.
//  Copyright © 2019 Andre Bocchini. All rights reserved.
//

import Foundation

/// Provides access to payee location operations
public class PayeeLocationService {
    private let client: ClientType

    init(client: ClientType) {
        self.client = client
    }
}

extension PayeeLocationService: PayeeLocationServiceType {
    /// Returns a list of all payee locations for a budget.
    ///
    /// - Parameters:
    ///    - budgetId: The id of the budget (*last_used* can also be used to specify the last used budget)
    ///
    /// - Returns: A list of payee locations
    public func getPayeeLocations(budgetId: String) async throws -> [PayeeLocation] {
        let request = PayeeLocationsRequest(budgetId: budgetId)
        let response: PayeeLocationsResponse = try await client.request(request)
        return response.payeeLocations
    }

    /// Returns a specific payee location.
    ///
    /// - Parameters:
    ///    - budgetId: The id of the budget (*last_used* can also be used to specify the last used budget)
    ///    - payeeId: The id of the payee
    ///
    /// - Returns: A single payee location
    public func getPayeeLocation(budgetId: String, payeeId: String) async throws -> PayeeLocation {
        let request = PayeeLocationRequest(budgetId: budgetId, payeeId: payeeId)
        let response: PayeeLocationResponse = try await client.request(request)
        return response.payeeLocation
    }

    /// Returns all locations for a payee.
    ///
    /// - Parameters:
    ///    - budgetId: The id of the budget (*last_used* can also be used to specify the last used budget)
    ///    - payeeId: The id of the payee
    ///
    /// - Returns: A list of payee locations
    public func getLocationsForPayee(
        budgetId: String,
        payeeId: String
    ) async throws -> [PayeeLocation] {
        let request = LocationsForPayeeRequest(budgetId: budgetId, payeeId: payeeId)
        let response: PayeeLocationsResponse = try await client.request(request)
        return response.payeeLocations
    }
}
