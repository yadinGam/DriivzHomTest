//
//  Box.swift
//  DriivzHomTest
//
//  Created by Yadin Gamliel on 26/05/2023.
//

import Foundation

class Box<T> {
    
    typealias Listener  = (T) -> Void
    // This is optional so we can nullify it
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        // Setting the listener to the listener that was provided
        self.listener = listener
        // Calling the listener immidiatly
        listener?(value)
    }
    
    func unBind() {
        self.listener = nil
    }
    
}
