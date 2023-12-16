// The Swift Programming Language
// https://docs.swift.org/swift-book

@attached(member, names: named(init))
public macro CSVFragmentInitialized() = #externalMacro(module: "CSVInitMacros", type: "CSVFragmentInitialized")
