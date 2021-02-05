//
//  UITextView.swift
//  Mouda
//
//  Created by Susan Kim on 2021/02/04.
//  Copyright © 2021 cauadc. All rights reserved.
//

import UIKit

extension UITextView: UITextViewDelegate {

    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }

    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            guard let placeholderLabel = self.viewWithTag(100) as? UILabel else { return nil }
            return placeholderLabel.text
        }
        set {
            addPlaceholder(newValue ?? "")
        }
    }
    
    private var placeholderLabel: UILabel? {
        get {
            return self.viewWithTag(100) as? UILabel
        }
    }

    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        placeholderLabel?.isHidden = self.text.count > 0
    }

    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        guard let placeholderLabel = self.placeholderLabel else { return }
        
        placeholderLabel.sizeToFit()
        let labelX = self.textContainer.lineFragmentPadding
        let labelY = self.textContainerInset.top
        let labelWidth = placeholderLabel.frame.width
        let labelHeight = placeholderLabel.frame.height

        placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
    }

    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        if let label = self.placeholderLabel {
            label.text = placeholderText
            label.sizeToFit()
        } else {
            let placeholderLabel = UILabel()

            placeholderLabel.text = placeholderText
            placeholderLabel.numberOfLines = 0
            placeholderLabel.sizeToFit()

            placeholderLabel.font = self.font
            placeholderLabel.textColor = .gray
            placeholderLabel.tag = 100

            placeholderLabel.isHidden = self.text.count > 0

            self.addSubview(placeholderLabel)
            self.delegate = self
        }
    }
}
