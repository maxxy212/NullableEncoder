import Testing
@testable import NullableEncoder

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    
    struct ExampleJson: Codable {
        @NullIfEmpty var first_name: String?
    }
    
    var user = ExampleJson()
    user.first_name = ""
    
    let res = try user.jsonPrettyPrinted().contains("null")
    
    #expect(true == res)
}

