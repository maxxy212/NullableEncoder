// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@propertyWrapper
public struct NullIfEmpty<T> {
    public var wrappedValue: T?
    public init(wrappedValue: T? = nil) {
        self.wrappedValue = wrappedValue
    }
}

extension NullIfEmpty: Encodable where T: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if T.Type.self == String.Type.self {
            if(wrappedValue != nil) {
                if(wrappedValue as! String).isEmpty {
                    try container.encodeNil()
                }else {
                    try container.encode(wrappedValue)
                }
            }else {
                try container.encodeNil()
            }
        }else {
            switch wrappedValue {
            case .some(let value):
                try container.encode(value)
            case .none:
                try container.encodeNil()
            }
        }
    }
}

extension NullIfEmpty: Decodable where T: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = try? container.decode(T.self)
    }
}

internal extension Encodable {
    func dataPrettyPrinted() throws -> Data {
        try JSONEncoder.iso8601PrettyPrinted.encode(self)
    }
    
    func jsonPrettyPrinted() throws -> String {
        String(data: try dataPrettyPrinted(), encoding: .utf8) ?? ""
    }
}

internal extension JSONEncoder {
    static let shared = JSONEncoder()
    static let iso8601 = JSONEncoder(dateEncodingStrategy: .iso8601)
    static let iso8601PrettyPrinted = JSONEncoder(dateEncodingStrategy: .iso8601, outputFormatting: .prettyPrinted)
}

internal extension JSONEncoder {
    convenience init(dateEncodingStrategy: DateEncodingStrategy,
                         outputFormatting: OutputFormatting = [],
                      keyEncodingStrategy: KeyEncodingStrategy = .useDefaultKeys) {
        self.init()
        self.dateEncodingStrategy = dateEncodingStrategy
        self.outputFormatting = outputFormatting
        self.keyEncodingStrategy = keyEncodingStrategy
    }
}
