//
//  Comparison.swift
//  Predicate
//
//  Created by Alsey Coleman Miller on 4/2/17.
//  Copyright © 2017 PureSwift. All rights reserved.
//

public struct Comparision {
    
    public var expression: (left: Expression, right: Expression)
    
    public var type: Operator
    
    public var modifier: Modifier?
    
    public var options: Set<Option>
    
    init(expression: (left: Expression, right: Expression),
         type: Operator = .equalTo,
         modifier: Modifier? = nil,
         options: Set<Option> = []) {
        
        self.expression = expression
        self.type = type
        self.modifier = modifier
        self.options = options
    }
}

// MARK: - Supporting Types

public extension Comparision {

    public enum Modifier: String {
        
        case all        = "ANY"
        case any        = "ALL"
    }
    
    public enum Option: String {
        
        case caseInsensitive        = "[c]"
        case diacriticInsensitive   = "[d]"
        case normalized             = "[n]"
        case localeSensitive        = "[l]"
    }
    
    public enum Operator: String {
        
        case lessThan               = "<"
        case lessThanOrEqualTo      = "<="
        case greaterThan            = ">"
        case greaterThanOrEqualTo   = ">="
        case equalTo                = "="
        case notEqualTo             = "!="
        case matches                = "MATCHES"
        case like                   = "LIKE"
        case beginsWith             = "BEGINSWITH"
        case endsWith               = "ENDSWITH"
        case `in`                   = "IN"
        case contains               = "CONTAINS"
        case between                = "BETWEEN"
    }
}

// MARK: - Equatable

extension Comparision: Equatable {
    
    public static func == (lhs: Comparision, rhs: Comparision) -> Bool {
        
        return lhs.expression.left == rhs.expression.left
            && lhs.expression.right == rhs.expression.right
            && lhs.type == rhs.type
            && lhs.modifier == rhs.modifier
            && lhs.options == rhs.options
    }
}

// MARK: - CustomStringConvertible

extension Comparision: CustomStringConvertible {
    
    public var description: String {
        
        let modifier = self.modifier?.rawValue ?? ""
        
        let leftExpression = "\(self.expression.left)"
        
        let type = self.type.rawValue
        
        let options = self.options
            .sorted(by: { $0.0.rawValue < $0.1.rawValue })
            .reduce("") { $0.0 + $0.1.rawValue }
        
        let rightExpression = "\(self.expression.right)"
        
        let components = [modifier, leftExpression, type + options, rightExpression]
        
        return components.reduce("") { $0.0 + "\($0.0.isEmpty ? "" : " ")" + $0.1 }
    }
}

// MARK: - Operators

public func < (lhs: Expression, rhs: Expression) -> Predicate {
    
    let comparision = Comparision(expression: (left: lhs, right: rhs),
                                  type: .lessThan)
    
    return .comparison(comparision)
}

public func <= (lhs: Expression, rhs: Expression) -> Predicate {
    
    let comparision = Comparision(expression: (left: lhs, right: rhs),
                                  type: .lessThanOrEqualTo)
    
    return .comparison(comparision)
}

public func > (lhs: Expression, rhs: Expression) -> Predicate {
    
    let comparision = Comparision(expression: (left: lhs, right: rhs),
                                  type: .greaterThan)
    
    return .comparison(comparision)
}

public func >= (lhs: Expression, rhs: Expression) -> Predicate {
    
    let comparision = Comparision(expression: (left: lhs, right: rhs),
                                  type: .greaterThanOrEqualTo)
    
    return .comparison(comparision)
}

public func == (lhs: Expression, rhs: Expression) -> Predicate {
    
    let comparision = Comparision(expression: (left: lhs, right: rhs),
                                  type: .equalTo)
    
    return .comparison(comparision)
}

public func != (lhs: Expression, rhs: Expression) -> Predicate {
    
    let comparision = Comparision(expression: (left: lhs, right: rhs),
                                  type: .notEqualTo)
    
    return .comparison(comparision)
}

// LHS keypath and RHS predicate value

public func < <T: PredicateValue>(lhs: String, rhs: T) -> Predicate {
    
    let comparision = Comparision(expression: (left: .keyPath(lhs), right: .value(rhs.predicateValue)),
                                  type: .lessThan)
    
    return .comparison(comparision)
}

public func <= <T: PredicateValue>(lhs: String, rhs: T) -> Predicate {
    
    let comparision = Comparision(expression: (left: .keyPath(lhs), right: .value(rhs.predicateValue)),
                                  type: .lessThan)
    
    return .comparison(comparision)
}

public func > <T: PredicateValue>(lhs: String, rhs: T) -> Predicate {
    
    let comparision = Comparision(expression: (left: .keyPath(lhs), right: .value(rhs.predicateValue)),
                                  type: .lessThan)
    
    return .comparison(comparision)
}

public func >= <T: PredicateValue>(lhs: String, rhs: T) -> Predicate {
    
    let comparision = Comparision(expression: (left: .keyPath(lhs), right: .value(rhs.predicateValue)),
                                  type: .lessThan)
    
    return .comparison(comparision)
}

public func == <T: PredicateValue>(lhs: String, rhs: T) -> Predicate {
    
    let comparision = Comparision(expression: (left: .keyPath(lhs), right: .value(rhs.predicateValue)),
                                  type: .lessThan)
    
    return .comparison(comparision)
}

public func != <T: PredicateValue>(lhs: String, rhs: T) -> Predicate {
    
    let comparision = Comparision(expression: (left: .keyPath(lhs), right: .value(rhs.predicateValue)),
                                  type: .lessThan)
    
    return .comparison(comparision)
}
