//
//  Functional.swift
//  AvatarHashView
//
//  Created by Pavlo Boiko on 4/2/19.
//  Copyright © 2019 Impulse. All rights reserved.
//

import Foundation

// Apply
precedencegroup ForwardApplication {
    associativity: left
}

infix operator |>: ForwardApplication

public func |> <A, B>(a: [A], f: (A) -> B) -> [B] {
    return a.map { return $0 |> f }
}
public func |> <A, B>(a: A, f: (A) -> B) -> B {
    return f(a)
}
