import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct CSVFragmentInitialized: MemberMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        let members = declaration.memberBlock.members
        let variableDecls = members.compactMap { $0.decl.as(VariableDeclSyntax.self) }
        let patterns = variableDecls.flatMap { $0.bindings }.compactMap { $0.pattern.as(IdentifierPatternSyntax.self) }

        let initializer = try InitializerDeclSyntax("init(fragment: CSVFragment)") {
            for pattern in patterns {
                """
                \(pattern.identifier) = fragment["\(raw: pattern.identifier.text.toSnakeCase())"]
                """
            }
        }
        return [DeclSyntax(initializer)]
    }
}

extension String {
    func toSnakeCase() -> Self {
        var result = ""
        for char in self {
            if !char.isLowercase {
                result.append("_")
            }
            result.append(char.lowercased())
        }
        return result
    }
}

@main
struct CSVInitPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        CSVFragmentInitialized.self
    ]
}
