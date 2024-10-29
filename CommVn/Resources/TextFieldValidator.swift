import Foundation

struct TextFieldValidator {
    
    //MARK: - Validate First Name
    static func validateFirstName(_ firstName: String?) -> TextFieldError? {
        // Loại bỏ khoảng trắng thừa
        guard let firstName = firstName?.trimmingCharacters(in: .whitespacesAndNewlines), !firstName.isEmpty else {
            return .emptyField(fieldName: "Họ đệm")
        }
        
        return nil
    }
    
    //MARK: - Validate Last Name
    static func validateLastName(_ lastName: String?) -> TextFieldError? {
        // Loại bỏ khoảng trắng thừa
        guard let lastName = lastName?.trimmingCharacters(in: .whitespacesAndNewlines), !lastName.isEmpty else {
            return .emptyField(fieldName: "Tên")
        }
        
        return nil
    }
    
    //MARK: - Validate Email
    static func validateEmail(_ email: String?) -> TextFieldError? {
        // Loại bỏ khoảng trắng thừa
        guard let email = email?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty else {
            return .emptyField(fieldName: "Email")
        }
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let result = emailPredicate.evaluate(with: email)
        
        return result ? nil : .invalidEmail
    }
    
    //MARK: - Validate Password
    /**
     + password: >= 6 and < 100, != nil
     */
    static func validatePassword(_ password: String?) -> TextFieldError? {
        guard let password, !password.isEmpty else {
            return .emptyField(fieldName: "Mật khẩu")
        }
        
        if password.count < 6 {
            return .passwordTooShort(minLength: 6)
        } else if password.count > 100 {
            return .passwordTooLong(maxLength: 100)
        } else {
            return nil
        }
    }
    
    //MARK: - Validate Confirm Password
    static func validateConfirmPassword(_ password: String?, confirmPassword: String?) -> TextFieldError? {
        guard let password, let confirmPassword else {
            return .emptyField(fieldName: "Mật khẩu")
        }
        return password == confirmPassword ? nil : .passwordNotMatch
    }
}
