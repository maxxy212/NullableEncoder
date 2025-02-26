// The Swift Programming Language
// https://docs.swift.org/swift-book

@propertyWrapper
struct NullIfEmpty<T> {
    var wrappedValue: T?
    init(wrappedValue: T? = nil) {
        self.wrappedValue = wrappedValue
    }
}

extension NullIfEmpty: Encodable where T: Encodable {
    func encode(to encoder: Encoder) throws {
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
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = try? container.decode(T.self)
    }
}
