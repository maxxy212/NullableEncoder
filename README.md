## Up Next: Version 1.0.0

🎯 Version 1.0.0 is planned as the first major release.
- Performance improvements
- Finalized documentation

Target release: [Insert date or milestone]

NullableEncoder was created out of neccessity in a certain project where all json must return null if
value is empty instead of returning empty string. It was a requirement from the backend and I beleive
manually creating the conditions was not scalable. So I decided to create a library that does it
automatically.

To use:
Simply add "@NullIfEmpty" at the start of the variable you want to conform to this protocol

For Example:
struct ExampleJson: Codable {
    @NullIfEmpty var first_name: String?
}

var user = ExampleJson()
user.first_name = ""

When sending over the server, it will surely send as:
{
  "first_name" : null
}

