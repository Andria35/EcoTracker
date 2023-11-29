//
//  CustomTextField.swift
//  EcoTracker
//
//  Created by Sofo Machurishvili on 29.11.23.
//

import UIKit

class CustomTextField: UITextField {
    private let padding = UIEdgeInsets(top: 17, left: 16, bottom: 17, right: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        layer.borderWidth = 1
        // TODO: - use .textfieldBackgroundColor instead
        layer.borderColor = UIColor(red: 0.306, green: 0.416, blue: 1, alpha: 0.5).cgColor
        layer.cornerRadius = 6
        
        font = .systemFont(ofSize: 12)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
