import UIKit
import PhotosUI
import TOCropViewController

class RegisterViewController: UIViewController {
    
    //MARK: - Properties
    private let scrollView: UIScrollView = {
        let _scrollView = UIScrollView()
        _scrollView.clipsToBounds = true
        _scrollView.showsHorizontalScrollIndicator = false
        _scrollView.showsVerticalScrollIndicator = false
        return _scrollView
    }()
    
    private let imageView: UIImageView = {
        let _imgView = UIImageView()
        _imgView.image = UIImage(named: "addAvatar")
        _imgView.contentMode = .scaleAspectFill
        _imgView.layer.borderWidth = 1
        _imgView.layer.borderColor = UIColor.lightGray.cgColor
        _imgView.tintColor = .lightGray
        _imgView.layer.cornerRadius = _imgView.width / 2
        _imgView.clipsToBounds = true
        _imgView.isUserInteractionEnabled = true
        return _imgView
    }()
    
    private let firstNameTF: UITextField = {
        let _textField = UITextField()
        _textField.placeholder = "First Name..."
        _textField.autocorrectionType = .no // off auto edit "."
        _textField.returnKeyType = .continue
        _textField.layer.cornerRadius = 12
        _textField.layer.borderColor = UIColor.lightGray.cgColor
        _textField.layer.borderWidth = 1
        
        _textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        _textField.leftViewMode = .always
        
        return _textField
    }()
    
    private let repoFirstNameLabel: UILabel = {
        let _label = UILabel()
        _label.textColor = .error
        _label.text = ""
        _label.font = .systemFont(ofSize: 12, weight: .medium)
        _label.textAlignment = .left
        _label.numberOfLines = 0
        return _label
    }()
    
    private let lastNameTF: UITextField = {
        let _textField = UITextField()
        _textField.placeholder = "Last Name..."
        _textField.autocorrectionType = .no // off auto edit "."
        _textField.returnKeyType = .continue
        _textField.layer.cornerRadius = 12
        _textField.layer.borderColor = UIColor.lightGray.cgColor
        _textField.layer.borderWidth = 1
        
        _textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        _textField.leftViewMode = .always
        
        return _textField
    }()
    
    private let repoLastNameLabel: UILabel = {
        let _label = UILabel()
        _label.textColor = .error
        _label.text = ""
        _label.font = .systemFont(ofSize: 12, weight: .medium)
        _label.textAlignment = .left
        _label.numberOfLines = 0
        return _label
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
        _textField.returnKeyType = .continue
        _textField.layer.borderColor = UIColor.lightGray.cgColor
        _textField.layer.borderWidth = 1
        _textField.layer.cornerRadius = 12
        _textField.isSecureTextEntry = true
        _textField.textContentType = .oneTimeCode // fix wanring: Cannot show Automatic Strong Passwords for app bundleID when signup
        
        _textField.leftView = UIView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: 15,
                                                   height: 0))
        _textField.leftViewMode = .always
        
        return _textField
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
    
    //MARK: -- Confirm Password Text Field
    private let confirmPwTF: UITextField = {
        let _textField = UITextField()
        _textField.placeholder = "Confirm Password..."
        _textField.autocapitalizationType = .none
        _textField.autocorrectionType = .no
        _textField.returnKeyType = .done
        _textField.layer.borderColor = UIColor.lightGray.cgColor
        _textField.layer.borderWidth = 1
        _textField.layer.cornerRadius = 12
        _textField.isSecureTextEntry = true
        _textField.textContentType = .password
        _textField.leftView = UIView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: 15,
                                                   height: 0))
        _textField.leftViewMode = .always
        
        return _textField
    }()
    
    private let repoConfirmPwLabel: UILabel = {
        let _label = UILabel()
        _label.textColor = .error
        _label.text = ""
        _label.font = .systemFont(ofSize: 12, weight: .medium)
        _label.textAlignment = .left
        _label.numberOfLines = 0
        return _label
    }()
    
    private let eyeIcon2: UIImageView = {
        let _imageView = UIImageView()
        _imageView.image = UIImage(systemName: "eye.slash")
        _imageView.tintColor = .lightGray
        _imageView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: 24,
                                  height: 24)
        return _imageView
    }()
    
    private let rightViewTF2: UIView = {
        let _view = UIView()
        _view.frame = CGRect(x: 0,
                             y: 0,
                             width: 24 + 15,
                             height: 24)
        return _view
    }()
    
    
    private let registerButton: UIButton = {
        let _button = UIButton()
        _button.setTitle("Register", for: .normal)
        _button.backgroundColor = .systemGreen
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
        imageView.frame = CGRect(x: (scrollView.width - size) / 2,
                                 y: 20,
                                 width: size,
                                 height: size)
        imageView.layer.cornerRadius = size / 2
        firstNameTF.frame = CGRect(x: 30,
                                   y: imageView.bottom + 10,
                                   width: scrollView.width - 60,
                                   height: 52)
        repoFirstNameLabel.frame = CGRect(x: 30,
                                          y: firstNameTF.bottom + 4,
                                          width: scrollView.width - 60,
                                          height: 24)
        lastNameTF.frame = CGRect(x: 30,
                                  y: repoFirstNameLabel.bottom + 4,
                                  width: scrollView.width - 60,
                                  height: 52)
        repoLastNameLabel.frame = CGRect(x: 30,
                                         y: lastNameTF.bottom + 4,
                                         width: scrollView.width - 60,
                                         height: 24)
        emailTF.frame = CGRect(x: 30,
                               y: repoLastNameLabel.bottom + 4,
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
        confirmPwTF.frame = CGRect(x: 30,
                                   y: repoPwLabel.bottom + 4,
                                   width: scrollView.width - 60,
                                   height: 52)
        repoConfirmPwLabel.frame = CGRect(x: 30,
                                          y: confirmPwTF.bottom + 4,
                                          width: scrollView.width - 60,
                                          height: 24)
        registerButton.frame = CGRect(x: 30,
                                      y: repoConfirmPwLabel.bottom + 20,
                                      width: scrollView.width - 60,
                                      height: 52)
    }
    
    //MARK: - Login Button Tapped
    @objc private func registerButtonTapped() {
        repoFirstNameLabel.text = ""
        repoLastNameLabel.text = ""
        repoEmailLabel.text = ""
        repoPwLabel.text = ""
        repoConfirmPwLabel.text = ""
        firstNameTF.layer.borderColor = UIColor.lightGray.cgColor
        lastNameTF.layer.borderColor = UIColor.lightGray.cgColor
        emailTF.layer.borderColor = UIColor.lightGray.cgColor
        passwordTF.layer.borderColor = UIColor.lightGray.cgColor
        confirmPwTF.layer.borderColor = UIColor.lightGray.cgColor
        
        firstNameTF.resignFirstResponder()
        lastNameTF.resignFirstResponder()
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        confirmPwTF.resignFirstResponder()
        
        if let firstNameError = TextFieldValidator.validateFirstName(firstNameTF.text) {
            repoFirstNameLabel.text = firstNameError.localizedDescription
            firstNameTF.layer.borderColor = UIColor.error.cgColor
            return
        }
        if let lastNameError = TextFieldValidator.validateLastName(lastNameTF.text) {
            repoLastNameLabel.text = lastNameError.localizedDescription
            lastNameTF.layer.borderColor = UIColor.error.cgColor
            return
        }
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
        if let confirmPw = TextFieldValidator.validateConfirmPassword(passwordTF.text, confirmPassword: confirmPwTF.text) {
            repoConfirmPwLabel.text = confirmPw.localizedDescription
            confirmPwTF.layer.borderColor = UIColor.error.cgColor
            return
        }
        
        // Handle Firebase Login
        
    }
}

//MARK: - RegisterViewController
extension RegisterViewController {
    
    //MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        title = "Register"
        
        registerButton.addTarget(self,
                                 action: #selector(registerButtonTapped),
                                 for: .touchUpInside)
        
        // Add eyeIcon in passwordTF
        passwordTF.addShowPassword(eyeIcon)
        confirmPwTF.addShowPassword(eyeIcon2)
        
        firstNameTF.delegate = self
        lastNameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        confirmPwTF.delegate = self
        
        // Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameTF)
        scrollView.addSubview(repoFirstNameLabel)
        scrollView.addSubview(lastNameTF)
        scrollView.addSubview(repoLastNameLabel)
        scrollView.addSubview(emailTF)
        scrollView.addSubview(repoEmailLabel)
        scrollView.addSubview(passwordTF)
        scrollView.addSubview(repoPwLabel)
        scrollView.addSubview(confirmPwTF)
        scrollView.addSubview(repoConfirmPwLabel)
        /// subview
        rightViewTF.addSubview(eyeIcon)
        eyeIcon.center = rightViewTF.center
        passwordTF.rightView = rightViewTF
        
        rightViewTF2.addSubview(eyeIcon2)
        eyeIcon2.center = rightViewTF2.center
        confirmPwTF.rightView = rightViewTF2
        ///
        scrollView.addSubview(registerButton)
        
        //handle more avatars
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(didTapChangeProfilePic))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(gesture)
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
        case firstNameTF:
            lastNameTF.becomeFirstResponder()
        case lastNameTF:
            emailTF.becomeFirstResponder()
        case emailTF:
            passwordTF.becomeFirstResponder()
        case passwordTF:
            confirmPwTF.becomeFirstResponder()
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



