//
//  Serializer.shared.swift
//  SwiftYNAB
//
//  Created by Andre Bocchini on 5/4/19.
//  Copyright © 2019 Andre Bocchini. All rights reserved.
//

import Foundation

final class Serializer: Sendable {
    static let shared = Serializer(decoder: defaultDecoder, encoder: defaultEncoder)

    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    init(decoder: JSONDecoder, encoder: JSONEncoder) {
        self.decoder = decoder
        self.encoder = encoder
    }
}

extension Serializer {
    private static let defaultDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    private static let defaultEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.outputFormatting = .prettyPrinted
        return encoder
    }()
}

extension Serializer: SerializerType {
    func decode<T: Codable>(_: T.Type, from data: Data) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch let decodingError as DecodingError {
            switch decodingError {
            case let .keyNotFound(_, context),
                 let .dataCorrupted(context),
                 let .typeMismatch(_, context),
                 let .valueNotFound(_, context):
                throw SwiftYNABError.decodingFailure(message: "\(context)")
            default:
                throw SwiftYNABError.decodingFailure(message: "Unknown decoding error")
            }
        }
    }

    func encode<T: Codable>(_ model: T) throws -> Data {
        do {
            return try encoder.encode(model)
        } catch let encodingError as EncodingError {
            switch encodingError {
            case let .invalidValue(_, context):
                throw SwiftYNABError.encodingFailure(message: context.debugDescription)
            default:
                throw SwiftYNABError.encodingFailure(message: "Unknown encoding error")
            }
        }
    }
}
