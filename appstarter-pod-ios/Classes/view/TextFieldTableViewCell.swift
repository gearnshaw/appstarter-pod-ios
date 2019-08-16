//
//  TextFieldTableViewCell.swift
//  appstarter-pod-ios
//
//  Created by Gabrielle Earnshaw on 16/08/2019.
//

import UIKit
import SnapKit

/// A subclass of UITableViewCell that shows detail in a text field rather than a label
public class TextFieldTableViewCell: UITableViewCell {
    // MARK: - Controls
    public let textField = UITextField()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
}

// MARK: - View configuration
private extension TextFieldTableViewCell {
    func configureView() {
        configureTextField()
    }

    func configureTextField() {
        // Style
        textField.textColor = detailTextLabel?.textColor ?? UIColor.gray
        textField.tintColor = .clear // This 'hides' the cursor

        // Behaviour
        contentView.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
}
