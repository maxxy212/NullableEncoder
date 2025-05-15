## Up Next: Version 1.0.1

🎯 Version 1.0.0 is planned as the first major release.
- Performance improvements
- Finalized documentation

NullableEncoder was created out of neccessity in a certain project where all json must return null if
value is empty instead of returning empty string. It was a requirement from the backend and I beleive
manually creating the conditions was not scalable. So I decided to create a library that does it
automatically.

Simply add @NullIfEmpty before the variable you want to conform to this protocol.

🧱 Example
```swift
struct ExampleJson: Codable {
    @NullIfEmpty var first_name: String?
}
```

You can then use it like this:

```swift
var user = ExampleJson()
user.first_name = ""
```

When encoding and sending over the server, it will serialize like this:

```swift
{
  "first_name": null
}
```

