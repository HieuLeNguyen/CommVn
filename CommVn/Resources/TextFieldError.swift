import Foundation

enum TextFieldError: Error {
    case emptyField(fieldName: String)
    case invalidEmail
    case invalidPhoneNumber
    case passwordTooShort(minLength: Int)
    case passwordTooLong(maxLength: Int)
    case passwordNotMatch
}

extension TextFieldError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptyField(let fieldName):
            return "\(fieldName) không được bỏ trống"
        case .invalidEmail:
            return "Email chưa hợp lệ"
        case .passwordTooShort(let minLength):
            return "Mật khẩu phải dài ít nhất \(minLength) ký tự"
        case .passwordTooLong(maxLength: let maxLength):
            return "Mật khẩu vượt quá giới hạn (\(maxLength) ký tự)"
        case .passwordNotMatch:
            return "Mật khẩu không trùng khớp"
        case .invalidPhoneNumber:
            return "Số điện thoại chưa hợp lệ"
        }
    }
}
