import UIKit
import PhotosUI
import TOCropViewController

class RegisterViewController: UIViewController {
    
    //MARK: - Properties
    
    private let imageView: UIImageView = {
        let _imgView = UIImageView()
        _imgView.image = UIImage(named: "avatarDefault")
        _imgView.contentMode = .scaleAspectFill
        _imgView.layer.borderWidth = 1
        _imgView.layer.borderColor = UIColor.lightGray.cgColor
        _imgView.tintColor = .lightGray
        _imgView.clipsToBounds = true
        _imgView.isUserInteractionEnabled = true
        return _imgView
    }()
    
    private let stackView: UIStackView = {
        let _stackView = UIStackView()
        _stackView.axis = .vertical
        _stackView.spacing = 20
        _stackView.alignment = .fill
        _stackView.distribution = .fill
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        return _stackView
    }()
    
    private lazy var firstNameField: UITextField = createTextField(placeholder: "Họ đệm...", autocapitalizationType: .words)
    private lazy var lastNameField: UITextField = createTextField(placeholder: "Tên...", autocapitalizationType: .words)
    private lazy var emailField: UITextField = createTextField(placeholder: "Email...")
    private lazy var passwordField: UITextField = createTextField(placeholder: "Mật khẩu mới...", isSecureTextEntry: true, textContentType: .oneTimeCode)
    private lazy var confirmPasswordField: UITextField = createTextField(placeholder: "Xác nhận mật khẩu mới...", returnKeyType: .done, isSecureTextEntry: true, textContentType: .password)
    
    private let registerButton: UIButton = {
        let _button = UIButton()
        _button.setTitle("Đăng ký", for: .normal)
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
    
    //MARK: - Register Button Tapped
    @objc private func registerButtonTapped() {
        firstNameField.placeholder = "Họ đệm..."
        lastNameField.placeholder = "Tên..."
        emailField.placeholder = "Email..."
        passwordField.placeholder = "Mật khẩu mới..."
        confirmPasswordField.placeholder = "Xác nhận mật khẩu mới..."
        firstNameField.layer.borderColor = UIColor.lightGray.cgColor
        lastNameField.layer.borderColor = UIColor.lightGray.cgColor
        emailField.layer.borderColor = UIColor.lightGray.cgColor
        passwordField.layer.borderColor = UIColor.lightGray.cgColor
        confirmPasswordField.layer.borderColor = UIColor.lightGray.cgColor
        
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        confirmPasswordField.resignFirstResponder()
        
        if let firstNameError = TextFieldValidator.validateFirstName(firstNameField.text) {
            firstNameField.text = ""
            firstNameField.placeholder = firstNameError.localizedDescription
            firstNameField.layer.borderColor = UIColor.error.cgColor
            return
        }
        if let lastNameError = TextFieldValidator.validateLastName(lastNameField.text) {
            lastNameField.text = ""
            lastNameField.placeholder = lastNameError.localizedDescription
            lastNameField.layer.borderColor = UIColor.error.cgColor
            return
        }
        if let emailError = TextFieldValidator.validateEmail(emailField.text) {
            emailField.text = ""
            emailField.placeholder = emailError.localizedDescription
            emailField.layer.borderColor = UIColor.error.cgColor
            return
        }
        if let passwordError = TextFieldValidator.validatePassword(passwordField.text) {
            passwordField.text = ""
            passwordField.placeholder = passwordError.localizedDescription
            passwordField.layer.borderColor = UIColor.error.cgColor
            return
        }
        if let confirmPw = TextFieldValidator.validateConfirmPassword(passwordField.text, confirmPassword: confirmPasswordField.text) {
            confirmPasswordField.text = ""
            confirmPasswordField.placeholder = confirmPw.localizedDescription
            confirmPasswordField.layer.borderColor = UIColor.error.cgColor
            return
        }
        
        // Handle Firebase Login
        
    }
}

//MARK: - RegisterViewController
extension RegisterViewController {
    
    //MARK: - Configurations
    private func configurations() {
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
        
        registerButton.addTarget(self,
                                 action: #selector(registerButtonTapped),
                                 for: .touchUpInside)
        
        //Handle more avatars
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(didTapChangeProfilePic))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(gesture)
    }
    
    //MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .systemBackground
        let sizeImage = view.width / 3
        
        view.addSubview(imageView)
        view.addSubview(stackView)
        view.addSubview(registerButton)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(firstNameField)
        stackView.addArrangedSubview(lastNameField)
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(confirmPasswordField)
        
        
        imageView.layer.cornerRadius = sizeImage / 2
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: sizeImage),
            imageView.heightAnchor.constraint(equalToConstant: sizeImage)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registerButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: - Show form sheet select "chọn ảnh" or " chụp ảnh "
    @objc private func didTapChangeProfilePic() {
        presentPhotoActionSheet()
    }
}

//MARK: - UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
    
    //MARK: - textFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Xử lý enter một cách tuần tự
        switch textField {
        case firstNameField:
            lastNameField.becomeFirstResponder()
        case lastNameField:
            emailField.becomeFirstResponder()
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            confirmPasswordField.becomeFirstResponder()
        default:
            registerButtonTapped()
        }
        return true
    }
}

//MARK: - UIImagePickerControllerDelegate
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Ảnh đại diện",
                                            message: "Bạn muốn chọn ảnh như thế nào?",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Huỷ bỏ",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Chọn ảnh",
                                            style: .default,
                                            handler: { [weak self]_ in
            self?.presentPhotoPicker()
        }))
        actionSheet.addAction(UIAlertAction(title: "Chụp ảnh mới",
                                            style: .default,
                                            handler: { [weak self]_ in
            self?.presentCamera()
        }))
        
        present(actionSheet, animated: true)
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.sourceType = .camera
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // Xử lý khi chụp ảnh từ camera
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let editedImage = info[.editedImage] as? UIImage {
            imageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            imageView.image = originalImage
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK: - PHPickerViewControllerDelegate
extension RegisterViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        if let result = results.first {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        // Hiển thị CropViewController để chỉnh sửa ảnh
                        self?.presentCropViewController(with: image)
                    }
                }
            }
        }
    }
}

//MARK: - TOCropViewControllerDelegate
extension RegisterViewController: TOCropViewControllerDelegate {
    
    func presentCropViewController(with image: UIImage) {
        let cropViewController = TOCropViewController(image: image)
        cropViewController.delegate = self
        
        // Tuỳ chỉnh CropViewController
        cropViewController.aspectRatioPreset = .presetSquare // Tỉ lệ hình vuông
        cropViewController.aspectRatioLockEnabled = true // Khoá tỉ lệ khung hình
        cropViewController.rotateButtonsHidden = false // Hiển thị nút xoay
        cropViewController.resetButtonHidden = true  // Ẩn nút back
        cropViewController.aspectRatioPickerButtonHidden = true // Ẩn tùy chọn thay đổi tỉ lệ
        cropViewController.cancelButtonTitle = "Hủy bỏ"
        cropViewController.doneButtonTitle = "Tiếp tục"
        present(cropViewController, animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        // Ảnh đã được cắt, cập nhật vào imageView hoặc xử lý tiếp
        imageView.image = image
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true, completion: nil)
    }
}



