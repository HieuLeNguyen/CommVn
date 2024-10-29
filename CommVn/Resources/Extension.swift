import UIKit

//MARK: - Config Global
extension UIView {
    
    //MARK: - Screen Width
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    //MARK: - Screen Height
    public var height: CGFloat {
        return self.frame.size.height
    }
    
    //MARK: - Location Top
    public var top: CGFloat {
        return self.frame.origin.y
    }
    
    //MARK: - Location Bottom
    public var bottom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }
    
    //MARK: - Location Left
    public var left: CGFloat {
        return self.frame.origin.x
    }
    
    //MARK: - Location Right
    public var right: CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }
}

//MARK: - "Thêm hiển thị chuyển đổi mật khẩu"
extension UITextField {
    
    //MARK: - Add Show Password Toggle: Thêm hiển thị chuyển đổi mật khẩu
    func addShowPassword(_ iconImgView: UIImageView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(togglePasswordVisibility))
        iconImgView.isUserInteractionEnabled = true
        iconImgView.addGestureRecognizer(tapGesture)
        self.rightView = iconImgView
        self.rightViewMode = .always
    }
    
    //MARK: - Toggle Password Visibility: Chuyển đổi hiển thị mật khẩu
    @objc private func togglePasswordVisibility(_ sender: UITapGestureRecognizer) {
        guard let iconImageView = sender.view as? UIImageView else { return }
        
        if isSecureTextEntry {
            isSecureTextEntry = false
            iconImageView.image = UIImage(systemName: "eye")
        } else {
            isSecureTextEntry = true
            iconImageView.image = UIImage(systemName: "eye.slash")
        }
    }
}


//MARK: - Create highlight for button (Tạo 'HightLight" cho nút bấm)
extension UIButton {
    
    //MARK: - Set Up Button Acttions
    func setUpButtonActions () {
        self.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
        self.addTarget(self, action: #selector(buttonTouchUp(_:)), for: [.touchUpInside, .touchUpOutside])
    }
    
    //MARK: - Handle event Touch
    @objc private func buttonTouchDown(_ sender: UIButton) {
        sender.backgroundColor = .lightGray // Màu nền khi nhấn
    }
    
    @objc private func buttonTouchUp(_ sender: UIButton) {
        sender.backgroundColor = (sender.title(for: .normal) == "Register") ? .systemGreen : .accent // Màu nền khi nhả
    }
    
}

/** Ex used:
 private let descriptionLabel: UILabel = {
 let label = UILabel()
 let _text = "Don't have an account? Sign Up"
 let range = ["Sign Up"]
 label.setAttributedText(label.configureMessage(message: _text, range))
 return label
 }()
 */
protocol AttributedTextConfigurable {
    func setAttributedText(_ attributedString: NSAttributedString)
}

extension UILabel: AttributedTextConfigurable {
    func setAttributedText(_ attributedString: NSAttributedString) {
        self.attributedText = attributedString
    }
}

extension UITextView: AttributedTextConfigurable {
    func setAttributedText(_ attributedString: NSAttributedString) {
        self.attributedText = attributedString
    }
}

//MARK: - Customize text
/*
 type: + text view
 + lable
 options:
 + Color highlight
 + Quantity changed
 */
extension AttributedTextConfigurable {
    
    //MARK: - Configure Message
    func configureMessage(
        message: String,
        _ texts: [String],
        font: UIFont = .boldSystemFont(ofSize: 14),
        textColor: UIColor = .accent
    ) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: message)
        
        for text in texts {
            let textRange = (message as NSString).range(of: text)
            if textRange.location != NSNotFound {
                attributedString.addAttribute(.font, value: font, range: textRange)
                attributedString.addAttribute(.foregroundColor, value: textColor, range: textRange)
            }
        }
        
        return attributedString
    }
}

