//
//  MyInputField.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-01.
//

import SwiftUI
import Combine

struct MyInputField: View {
    let placeholder: String
    let iconName: String?
    let isSecure: Bool
    let keyboardType: UIKeyboardType
    let contentType: UITextContentType?
    let validation: ValidationRule?
    let maxLength: Int?
    
    @Binding var text: String
    @Binding var isValid: Bool
    
    @State private var isShowingPassword: Bool = false
    @FocusState private var isFocused: Bool
    @State private var errorMessage: String? = nil
    @State private var isEditing: Bool = false
    
    init(
        placeholder: String,
        iconName: String? = nil,
        isSecure: Bool = false,
        text: Binding<String>,
        isValid: Binding<Bool> = .constant(true),
        keyboardType: UIKeyboardType = .default,
        contentType: UITextContentType? = nil,
        validation: ValidationRule? = nil,
        maxLength: Int? = nil
    ) {
        self.placeholder = placeholder
        self.iconName = iconName
        self.isSecure = isSecure
        self._text = text
        self._isValid = isValid
        self.keyboardType = keyboardType
        self.contentType = contentType
        self.validation = validation
        self.maxLength = maxLength
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(placeholder)
                .font(.poppins(fontStyle: .footnote, fontWeight: .medium))
                .foregroundColor(isFocused ? .blue : .gray)
                .padding(.leading, 12)
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: 1)
                    .background(RoundedRectangle(cornerRadius: 8)
                        .fill(backgroundColor)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2))
                
                HStack {
                    if let iconName = iconName {
                        Image(systemName: iconName)
                            .foregroundColor(iconColor)
                            .frame(width: 24, height: 24)
                            .padding(.leading, 12)
                    }
                    
                    Group {
                        if isSecure && !isShowingPassword {
                            SecureField("", text: limitText())
                                .focused($isFocused)
                                .onChange(of: text) { validateInput() }
                        } else {
                            TextField("", text: limitText(), onEditingChanged: { editing in
                                isEditing = editing
                            })
                            .focused($isFocused)
                            .onChange(of: text) { validateInput() }
                        }
                    }
                    .textContentType(contentType)
                    .keyboardType(keyboardType)
                    .autocorrectionDisabled()
                    .submitLabel(.done)
                    .font(.system(size: 16))
                    .padding(.leading, iconName == nil ? 12 : 0)
                    .padding(.vertical, 12)
                    
                    if !text.isEmpty && isFocused {
                        Button(action: {
                            text = ""
                            validateInput()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray.opacity(0.5))
                                .frame(width: 20, height: 20)
                        }
                        .padding(.trailing, isSecure ? 8 : 12)
                    }
                    
                    if isSecure {
                        Button(action: {
                            isShowingPassword.toggle()
                        }) {
                            Image(systemName: isShowingPassword ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                                .frame(width: 24, height: 24)
                        }
                        .padding(.trailing, 12)
                    }
                }
            }
            .frame(height: 48)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(.poppins(fontStyle: .caption2, fontWeight: .light))
                    .foregroundColor(.red)
                    .padding(.leading, 12)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: errorMessage)
        .animation(.easeInOut(duration: 0.2), value: isFocused)
        .onAppear {
            validateInput()
        }
    }
    
    private func limitText() -> Binding<String> {
        return Binding(
            get: { self.text },
            set: { newValue in
                if let maxLength = maxLength, newValue.count > maxLength {
                    self.text = String(newValue.prefix(maxLength))
                } else {
                    self.text = newValue
                }
            }
        )
    }
    
    private func validateInput() {
        guard let validation = validation else {
            isValid = true
            errorMessage = nil
            return
        }
        
        do {
            try validation.validate(text)
            isValid = true
            errorMessage = nil
        } catch ValidationError.invalid(let message) {
            isValid = false
            errorMessage = message
        } catch {
            isValid = false
            errorMessage = "Invalid input"
        }
    }
    
    private var borderColor: Color {
        if let _ = errorMessage {
            return .red
        } else if isFocused {
            return .blue
        } else {
            return .gray.opacity(0.3)
        }
    }
    
    private var backgroundColor: Color {
        if let _ = errorMessage {
            return .red.opacity(0.05)
        } else if isFocused {
            return .blue.opacity(0.05)
        } else {
            return .gray.opacity(0.05)
        }
    }
    
    private var iconColor: Color {
        if let _ = errorMessage {
            return .red
        } else if isFocused {
            return .blue
        } else {
            return .gray
        }
    }
}

enum ValidationError: Error {
    case invalid(String)
}

protocol ValidationRule {
    func validate(_ text: String) throws
}

struct RegexValidationRule: ValidationRule {
    let pattern: String
    let message: String
    
    func validate(_ text: String) throws {
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        if !predicate.evaluate(with: text) {
            throw ValidationError.invalid(message)
        }
    }
}

struct EmailValidationRule: ValidationRule {
    let message: String
    
    func validate(_ text: String) throws {
        let pattern = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        if !predicate.evaluate(with: text) {
            throw ValidationError.invalid(message)
        }
    }
}

struct PhoneValidationRule: ValidationRule {
    let message: String
    
    func validate(_ text: String) throws {
        let pattern = #"^\d{10}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        if !predicate.evaluate(with: text) {
            throw ValidationError.invalid(message)
        }
    }
}

struct MinLengthValidationRule: ValidationRule {
    let length: Int
    let message: String
    
    func validate(_ text: String) throws {
        if text.count < length {
            throw ValidationError.invalid(message)
        }
    }
}

struct RequiredValidationRule: ValidationRule {
    let message: String
    
    func validate(_ text: String) throws {
        if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw ValidationError.invalid(message)
        }
    }
}

struct CompositeValidationRule: ValidationRule {
    let rules: [ValidationRule]
    
    func validate(_ text: String) throws {
        for rule in rules {
            try rule.validate(text)
        }
    }
}
