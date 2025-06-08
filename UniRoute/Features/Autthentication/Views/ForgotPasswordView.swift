//
//  ForgotPasswordView.swift
//  UniRoute
//
//  Created by Sachin Gunawardena on 2025-06-08.
//

import SwiftUI

struct PasswordResetFlow: View {
    @State private var currentStep: PasswordResetStep = .forgotPassword
    @State private var userEmail = ""
    @State private var otpCode = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) private var dismiss
    
    enum PasswordResetStep {
        case forgotPassword
        case otpVerification
        case resetPassword
    }
    
    var body: some View {
        NavigationView {
            switch currentStep {
            case .forgotPassword:
                ForgotPasswordView(
                    email: $userEmail,
                    onVerifyEmail: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentStep = .otpVerification
                        }
                    },
                    onBack: {
                        dismiss()
                    }
                )
                
            case .otpVerification:
                OTPVerificationView(
                    email: userEmail,
                    otpCode: $otpCode,
                    onVerifyOTP: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentStep = .resetPassword
                        }
                    },
                    onBack: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentStep = .forgotPassword
                        }
                    }
                )
                
            case .resetPassword:
                ResetPasswordView(
                    newPassword: $newPassword,
                    confirmPassword: $confirmPassword,
                    onResetComplete: {
                        // Handle successful password reset
                        print("Password reset completed!")
                        dismiss() 
                    },
                    onBack: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentStep = .otpVerification
                        }
                    }
                )
            }
        }
        .navigationBarHidden(true)
    }
}

struct ForgotPasswordView: View {
    @Binding var email: String
    let onVerifyEmail: () -> Void
    let onBack: () -> Void
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: onBack) {
                    HStack(spacing: 8) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                        Text("Back")
                            .font(.system(size: 16, weight: .medium))
                    }
                    .foregroundColor(.blue)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            Spacer()
            
            VStack(spacing: 40) {
                VStack(spacing: 24) {
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 120, height: 120)
                        
                        ZStack {
                            Image(systemName: "lock.fill")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundColor(.white)
                            
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 40, height: 40)
                                .offset(x: 25, y: 25)
                            
                            Image(systemName: "questionmark")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .offset(x: 25, y: 25)
                        }
                    }
                    
                    VStack(spacing: 12) {
                        Text("Forgot Password?")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("Don't worry! Please enter your university email.")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                }
                
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("University Email")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gray)
                        
                        TextField("Enter your university email", text: $email)
                            .font(.system(size: 16))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.1))
                            )
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                    
                    Button(action: {
                        isLoading = true
                        // Simulate API call
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            isLoading = false
                            onVerifyEmail()
                        }
                    }) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            } else {
                                Text("Verify Email")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(email.isEmpty ? Color.gray.opacity(0.5) : Color.blue)
                        )
                    }
                    .disabled(email.isEmpty || isLoading)
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .background(Color.white)
    }
}

struct OTPVerificationView: View {
    let email: String
    @Binding var otpCode: String
    let onVerifyOTP: () -> Void
    let onBack: () -> Void
    @State private var isLoading = false
    @State private var timeRemaining = 123
    @State private var timer: Timer?
    @State private var otpDigits: [String] = ["", "", "", ""]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: onBack) {
                    HStack(spacing: 8) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                        Text("Back")
                            .font(.system(size: 16, weight: .medium))
                    }
                    .foregroundColor(.blue)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            Spacer()
            
            VStack(spacing: 40) {
                // Icon and Title
                VStack(spacing: 24) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.blue, lineWidth: 3)
                            .frame(width: 120, height: 80)
                        
                        Image(systemName: "lock.fill")
                            .font(.system(size: 30, weight: .medium))
                            .foregroundColor(.blue)
                        
                        HStack(spacing: 4) {
                            ForEach(0..<4, id: \.self) { _ in
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 6, height: 6)
                            }
                        }
                        .offset(y: 15)
                    }
                    
                    VStack(spacing: 12) {
                        Text("OTP Verification")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                        
                        VStack(spacing: 4) {
                            Text("We have sent a 4 digit code to your entered university")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 0) {
                                Text("email ")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)
                                Text("\"")
                                    .font(.system(size: 16))
                                    .foregroundColor(.blue)
                                Text(email)
                                    .font(.system(size: 16))
                                    .foregroundColor(.blue)
                                Text("\"")
                                    .font(.system(size: 16))
                                    .foregroundColor(.blue)
                            }
                        }
                        .multilineTextAlignment(.center)
                    }
                }
                
                // OTP Input
                VStack(spacing: 20) {
                    HStack(spacing: 15) {
                        ForEach(0..<4, id: \.self) { index in
                            OTPDigitField(
                                digit: $otpDigits[index],
                                isActive: index == otpDigits.firstIndex(where: { $0.isEmpty }) ?? 3
                            )
                        }
                    }
                    
                    // Verify Button
                    Button(action: {
                        isLoading = true
                        otpCode = otpDigits.joined()
                        // Simulate API call
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            isLoading = false
                            onVerifyOTP()
                        }
                    }) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            } else {
                                Text("Verify")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(otpDigits.contains("") ? Color.gray.opacity(0.5) : Color.blue)
                        )
                    }
                    .disabled(otpDigits.contains("") || isLoading)
                    
                    // Resend Code
                    HStack(spacing: 8) {
                        Text("Request code again")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        Text(formatTime(timeRemaining))
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .background(Color.white)
        .onAppear {
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
            }
        }
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02ds", minutes, remainingSeconds)
    }
}

struct OTPDigitField: View {
    @Binding var digit: String
    let isActive: Bool
    
    var body: some View {
        TextField("", text: $digit)
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .frame(width: 60, height: 60)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isActive ? Color.blue : Color.clear, lineWidth: 2)
                    )
            )
            .onChange(of: digit) { newValue in
                if newValue.count > 1 {
                    digit = String(newValue.prefix(1))
                }
            }
    }
}

struct ResetPasswordView: View {
    @Binding var newPassword: String
    @Binding var confirmPassword: String
    let onResetComplete: () -> Void
    let onBack: () -> Void
    @State private var isLoading = false
    @State private var showNewPassword = false
    @State private var showConfirmPassword = false
    
    var isPasswordValid: Bool {
        newPassword.count >= 8 &&
        newPassword.rangeOfCharacter(from: .decimalDigits) != nil &&
        newPassword.rangeOfCharacter(from: .uppercaseLetters) != nil &&
        newPassword.rangeOfCharacter(from: .lowercaseLetters) != nil &&
        newPassword.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*()_+-=[]{}|;:,.<>?")) != nil
    }
    
    var passwordsMatch: Bool {
        !confirmPassword.isEmpty && newPassword == confirmPassword
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: onBack) {
                    HStack(spacing: 8) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                        Text("Back")
                            .font(.system(size: 16, weight: .medium))
                    }
                    .foregroundColor(.blue)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            Spacer()
            
            // Main Content
            VStack(spacing: 40) {
                // Icon and Title
                VStack(spacing: 24) {
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 120, height: 120)
                        
                        Image(systemName: "lock.fill")
                            .font(.system(size: 40, weight: .medium))
                            .foregroundColor(.white)
                        
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 35, height: 35)
                            .offset(x: 30, y: -30)
                        
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .offset(x: 30, y: -30)
                    }
                    
                    Text("Reset Password")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                }
                
                // Password Input Fields
                VStack(spacing: 20) {
                    // New Password Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("New Password")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gray)
                        
                        HStack {
                            Group {
                                if showNewPassword {
                                    TextField("Enter new password", text: $newPassword)
                                } else {
                                    SecureField("Enter new password", text: $newPassword)
                                }
                            }
                            .font(.system(size: 16))
                            
                            Button(action: {
                                showNewPassword.toggle()
                            }) {
                                Image(systemName: showNewPassword ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.1))
                        )
                    }
                    
                    // Confirm Password Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Confirm Password")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gray)
                        
                        HStack {
                            Group {
                                if showConfirmPassword {
                                    TextField("Confirm new password", text: $confirmPassword)
                                } else {
                                    SecureField("Confirm new password", text: $confirmPassword)
                                }
                            }
                            .font(.system(size: 16))
                            
                            Button(action: {
                                showConfirmPassword.toggle()
                            }) {
                                Image(systemName: showConfirmPassword ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.1))
                        )
                    }
                    
                    // Password Requirements
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your password must be at least 8 characters,")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Text("include a number, an uppercase letter, a lowercase")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Text("letter and a special character.")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Reset Button
                    Button(action: {
                        isLoading = true
                        // Simulate API call
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            isLoading = false
                            onResetComplete()
                        }
                    }) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            } else {
                                Text("Reset")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill((isPasswordValid && passwordsMatch) ? Color.blue : Color.gray.opacity(0.5))
                        )
                    }
                    .disabled(!isPasswordValid || !passwordsMatch || isLoading)
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .background(Color.white)
    }
}

#Preview("Forgot Password") {
    ForgotPasswordView(
        email: .constant(""),
        onVerifyEmail: {},
        onBack: {}
    )
}

#Preview("OTP Verification") {
    OTPVerificationView(
        email: "cobsccomp232p002@student.nibm.lk",
        otpCode: .constant(""),
        onVerifyOTP: {},
        onBack: {}
    )
}

#Preview("Reset Password") {
    ResetPasswordView(
        newPassword: .constant(""),
        confirmPassword: .constant(""),
        onResetComplete: {},
        onBack: {}
    )
}

#Preview("Full Flow") {
    PasswordResetFlow()
}

