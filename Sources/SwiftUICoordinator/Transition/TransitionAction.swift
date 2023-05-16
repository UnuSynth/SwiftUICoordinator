//
//  TransitionAction.swift
//  
//
//  Created by Erik Drobne on 12/12/2022.
//

import SwiftUI

public enum TransitionAction {
    case push(animated: Bool)
    case present(
        animated: Bool,
        modalPresentationStyle: UIModalPresentationStyle = .automatic,
        completion: (() -> Void)? = nil
    )
}
