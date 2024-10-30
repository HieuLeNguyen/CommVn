import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    private let logoImgView: UIImageView = {
        let _imageView = UIImageView()
        _imageView.image = UIImage(named: "logo")
        _imageView.contentMode = .scaleAspectFit
        return _imageView
    }()
    
    private let stackView: UIStackView = {
        let _stackView = UIStackView()
        _stackView.axis = .vertical
        _stackView.distribution = .fill
        _stackView.spacing = 20
        _stackView.alignment = .fill
        return _stackView
    }()
    
    private lazy var emailTF: UITextField = createTextField(placeholder: "Email...")
    private lazy var passwordTF: UITextField = createTextField(placeholder: "Mật khẩu...", isSecureTextEntry: true, textContentType: .password, rightView: eyeIcon)
    
    private let eyeIcon: UIImageView = {
        let _imageView = UIImageView()
        _imageView.image = UIImage(named: "eye.slash")
        _imageView.tintColor = .lightGray
        _imageView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: 24,
                                  height: 24)
        return _imageView
    }()
    
    private let loginButton: UIButton = {
        let _button = UIButton()
        _button.setTitle("Đăng nhập", for: .normal)
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
        configurations()
    }
    
    
    //MARK: - Login Button Tapped
    @objc private func loginButtonTapped() {
        emailTF.placeholder = "Email..."
        passwordTF.placeholder = "Mật khẩu..."
        emailTF.layer.borderColor = UIColor.lightGray.cgColor
        passwordTF.layer.borderColor = UIColor.lightGray.cgColor
        
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        
        if let emailError = TextFieldValidator.validateEmail(emailTF.text) {
            emailTF.text = ""
            emailTF.placeholder = emailError.localizedDescription
            emailTF.layer.borderColor = UIColor.error.cgColor
            return
        }
        if let passwordError = TextFieldValidator.validatePassword(passwordTF.text) {
            passwordTF.text = ""
            passwordTF.placeholder = passwordError.localizedDescription
            passwordTF.layer.borderColor = UIColor.error.cgColor
            return
        }
        // test pw
        if passwordTF.text != "123456" {
            passwordTF.text = ""
            passwordTF.placeholder = "Mật khẩu không đúng!"
            passwordTF.layer.borderColor = UIColor.error.cgColor
            return
        }
        
        // Handle Firebase Login
        
    }
    
    //MARK: - Did Tap Register
    @objc private func didTapRegister() {
        let registerVC = RegisterViewController()
        registerVC.title = "Tạo tài khoản"
        navigationController?.pushViewController(registerVC, animated: true)
    }
}

extension LoginViewController {
    
    //MARK: - Configurations
    private func configurations(){
        emailTF.delegate = self
        passwordTF.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Đăng ký",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
        loginButton.addTarget(self,
                              action: #selector(loginButtonTapped),
                              for: .touchUpInside)
    }
    
    //MARK: - Setup Views
    private func setupViews() {
        let sizeImage = view.width / 3
        view.backgroundColor = .systemBackground
        title = ""
        
        view.addSubview(logoImgView)
        view.addSubview(stackView)
        view.addSubview(loginButton)
        logoImgView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(emailTF)
        stackView.addArrangedSubview(passwordTF)
        
        logoImgView.layer.cornerRadius = sizeImage / 2
        NSLayoutConstraint.activate([
            logoImgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            logoImgView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImgView.heightAnchor.constraint(equalToConstant: sizeImage),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: logoImgView.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
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
