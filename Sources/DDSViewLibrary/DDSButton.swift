//
//  DDSButton.swift
//
//  Created by Gayle Dunham on 5/3/20.
//

import UIKit

@IBDesignable
final class DDSButton: UIButton {

    public func setColor(_ color: UIColor) {
        titleLabel?.textColor = color
        tintColor = color
        borderColor = color
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor {
        get {
            guard let color = layer.borderColor else {
                return UIColor.clear
            }
            return UIColor(cgColor: color)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View

    init(_ builder: @escaping () -> View) {
        view = builder()
    }

    // MARK: - UIViewRepresentable

    func makeUIView(context: Context) -> UIView {
        return view
    }

    func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}

@available(iOS 13.0, *)
struct DDSButton_Preview: PreviewProvider {
    static var previews: some View {

        ForEach(ContentSizeCategory.allCases, id: \.self) { sizeCategory in
            UIViewPreview {
                let button = DDSButton(type: .system)
                button.setTitle("Follow", for: .normal)
                button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
                button.setColor(.systemOrange)
                return button
            }.environment(\.sizeCategory, sizeCategory)
                .previewDisplayName("\(sizeCategory)")

        }.previewLayout(.sizeThatFits)
            .padding(10)

        UIViewPreview {
            let button = DDSButton(type: .system)
            button.setTitle("Follow", for: .normal)
            button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
            button.setColor(.systemOrange)
            return button
        }.previewLayout(.sizeThatFits)
            .padding(10)

    }
}
#endif
