//
//  CustomTextField.swift
//  EcoTracker
//
//  Created by Sofo Machurishvili on 29.11.23.
//

import UIKit

final class CustomTextField: UITextField {
    private let padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
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
        layer.borderColor = UIColor(red: 0.306, green: 0.416, blue: 1, alpha: 0.5).cgColor
        layer.cornerRadius = 6
        
        font = .systemFont(ofSize: 12)
        textColor = .white
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}
