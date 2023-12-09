//
//  Defaults.swift
//  NewsApp
//
//  Created by Esraa on 09/12/2023.
//

import Foundation
import SwiftUI

//MARK: - AppStorage -> save the last app status for isDarkMode & Language

public class Defaults: ObservableObject {
    @AppStorage("isDarkMode") public var isDarkMode = true
    @AppStorage("appLanguage") public var isArabic = false
    
    public static let shared = Defaults()
}

@propertyWrapper
public struct Default<T>: DynamicProperty {
    @ObservedObject private var defaults: Defaults
    private let keyPath: ReferenceWritableKeyPath<Defaults, T>
    public init(_ keyPath: ReferenceWritableKeyPath<Defaults, T>, defaults: Defaults = .shared) {
        self.keyPath = keyPath
        self.defaults = defaults
    }

    public var wrappedValue: T {
        get { defaults[keyPath: keyPath] }
        nonmutating set { defaults[keyPath: keyPath] = newValue }
    }

    public var projectedValue: Binding<T> {
        Binding(
            get: { defaults[keyPath: keyPath] },
            set: { value in
                defaults[keyPath: keyPath] = value
            }
        )
    }
}
