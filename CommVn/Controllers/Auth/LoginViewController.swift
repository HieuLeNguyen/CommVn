import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    private let scrollView: UIScrollView = {
        let _scrollView = UIScrollView()
        _scrollView.clipsToBounds = true
        _scrollView.showsHorizontalScrollIndicator = false
        _scrollView.showsVerticalScrollIndicator = false
        return _scrollView
    }()
    
    private let logoImgView: UIImageView = {
        let _imageView = UIImageView()
        _imageView.image = UIImage(named: "logo")
        _imageView.contentMode = .scaleAspectFit
        return _imageView
    }()
    
    private let emailTF: UITextField = {
        let _textField = UITextField()
        _textField.placeholder = "Email Address..."
        _textField.autocapitalizationType = .none // off capital
        _textField.autocorrectionType = .no // off auto edit "."
        _textField.returnKeyType = .continue
        _textField.layer.cornerRadius = 12
        _textField.layer.borderColor = UIColor.lightGray.cgColor
        _textField.layer.borderWidth = 1
        
        _textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        _textField.leftViewMode = .always
        
        return _textField
    }()
    
    private let repoEmailLabel: UILabel = {
        let _label = UILabel()
        _label.textColor = .error
        _label.text = ""
        _label.font = .systemFont(ofSize: 12, weight: .medium)
        _label.textAlignment = .left
        _label.numberOfLines = 0
        return _label
    }()
    
    //MARK: -- Password Text Field
    private let passwordTF: UITextField = {
        let _textField = UITextField()
        _textField.placeholder = "Password..."
        _textField.autocapitalizationType = .none
        _textField.autocorrectionType = .no
        _textField.returnKeyType = .done
        _textField.layer.borderColor = UIColor.lightGray.cgColor
        _textField.layer.borderWidth = 1
        _textField.layer.cornerRadius = 12
        _textField.isSecureTextEntry = true
        
        _textField.leftView = UIView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: 15,
                                                   height: 0))
        _textField.leftViewMode = .always
        
        return _textField
    }()
    
    private let eyeIcon: UIImageView = {
        let _imageView = UIImageView()
        _imageView.image = UIImage(systemName: "eye.slash")
        _imageView.tintColor = .lightGray
        _imageView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: 24,
                                  height: 24)
        return _imageView
    }()
    
    private let rightViewTF: UIView = {
        let _view = UIView()
        _view.frame = CGRect(x: 0,
                             y: 0,
                             width: 24 + 15,
                             height: 24)
        return _view
    }()
    
    private let repoPwLabel: UILabel = {
        let _label = UILabel()
        _label.textColor = .error
        _label.text = ""
        _label.font = .systemFont(ofSize: 12, weight: .medium)
        _label.textAlignment = .left
        _label.numberOfLines = 0
        return _label
    }()
    
    //MARK: -- Login Button
    private let loginButton: UIButton = {
        let _button = UIButton()
        _button.setTitle("Log In", for: .normal)
        _button.backgroundColor = .accent
        _button.setTitleColor(.white, for: .normal)
        _button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        _button.layer.cornerRadius = 12
        _button.setUpButtonActions()
        return _button
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: - Layout SubView
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        let size = scrollView.width / 3
        logoImgView.frame = CGRect(x: (scrollView.width - size) / 2,
                                   y: 20,
                                   width: size,
                                   height: size)
        emailTF.frame = CGRect(x: 30,
                               y: logoImgView.bottom + 30,
                               width: scrollView.width - 60,
                               height: 52)
        repoEmailLabel.frame = CGRect(x: 30,
                                      y: emailTF.bottom + 4,
                                      width: scrollView.width - 60,
                                      height: 24)
        passwordTF.frame = CGRect(x: 30,
                                  y: repoEmailLabel.bottom + 4,
                                  width: scrollView.width - 60,
                                  height: 52)
        repoPwLabel.frame = CGRect(x: 30,
                                   y: passwordTF.bottom + 4,
                                   width: scrollView.width - 60,
                                   height: 24)
        loginButton.frame = CGRect(x: 30,
                                   y: repoPwLabel.bottom + 20,
                                   width: scrollView.width - 60,
                                   height: 52)
    }
    
    //MARK: - Login Button Tapped
    @objc private func loginButtonTapped() {
        repoEmailLabel.text = ""
        repoPwLabel.text = ""
        emailTF.layer.borderColor = UIColor.lightGray.cgColor
        passwordTF.layer.borderColor = UIColor.lightGray.cgColor
        
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        
        if let emailError = TextFieldValidator.validateEmail(emailTF.text) {
            repoEmailLabel.text = emailError.localizedDescription
            emailTF.layer.borderColor = UIColor.error.cgColor
            return
        }
        if let passwordError = TextFieldValidator.validatePassword(passwordTF.text) {
            repoPwLabel.text = passwordError.localizedDescription
            passwordTF.layer.borderColor = UIColor.error.cgColor
            return
        }
        // test pw
        if passwordTF.text != "123456" {
            repoPwLabel.text = "Mật khẩu không đúng!"
            passwordTF.layer.borderColor = UIColor.error.cgColor
            return
        }
        
        // Handle Firebase Login
        
    }
    
    //MARK: - Did Tap Register
    @objc private func didTapRegister() {
        let registerVC = RegisterViewController()
        registerVC.title = "Create Account"
        navigationController?.pushViewController(registerVC, animated: true)
    }
}

extension LoginViewController {
    
    //MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        title = "CommVN"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
        loginButton.addTarget(self,
                              action: #selector(loginButtonTapped),
                              for: .touchUpInside)
        
        // Add eyeIcon in passwordTF
        passwordTF.addShowPassword(eyeIcon)
        
        emailTF.delegate = self
        passwordTF.delegate = self
        
        // Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(logoImgView)
        scrollView.addSubview(emailTF)
        scrollView.addSubview(repoEmailLabel)
        scrollView.addSubview(passwordTF)
        scrollView.addSubview(repoPwLabel)
        /// subview
        rightViewTF.addSubview(eyeIcon)
        eyeIcon.center = rightViewTF.center
        passwordTF.rightView = rightViewTF
        
        scrollView.addSubview(loginButton)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    //MARK: - textFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTF {
            passwordTF.becomeFirstResponder()
        }
        else if textField == passwordTF {
            loginButtonTapped()
        }
        return true
    }
}
