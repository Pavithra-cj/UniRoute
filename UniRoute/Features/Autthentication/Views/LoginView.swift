//
//  LoginView.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-06.
//

import SwiftUI

struct LoginView: View {
    @State private var campusID: String = "Admin"
    @State private var isCampusValid = false
    @State private var password: String = "Admin@123"
    @State private var isPasswordValid = false
    @State private var isAuthenticated: Bool = false
    @State private var showingSignup: Bool = false
    
    @State private var showLoginSuccess = false
    @State private var showLoginError = false
    
    // Hardcoded credentials
    let validCampusID = "Admin"
    let validPassword = "Admin@123"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20)
            {
                VStack
                {
                    ZStack{
                        Circle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 90, height: 90)
                        
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100,
                                   height: 100)
                    }
                    HStack(spacing: 0){
                        Text("Uni")
                            .font(
                                .poppins(
                                    fontStyle: .title3, fontWeight: .regular
                                )
                            )
                            .foregroundStyle(.black)
                        
                        Text("Route")
                            .font(
                                .poppins(
                                    fontStyle: .title3,
                                    fontWeight: .regular
                                )
                            )
                            .foregroundStyle(.blue)
                    }
                    Text("Campus Navigator")
                        .font(
                            .poppins(fontStyle: .caption, fontWeight: .regular)
                        )
                        .foregroundStyle(.black)
                    
                }
                .padding(.bottom, 10)
                
                VStack
                {
                    Text("Sign In")
                        .font(
                            .poppins(
                                fontStyle: .title,
                                fontWeight: .bold
                            ))
                    
                    Text("Please Sign in to continue")
                        .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                        .foregroundStyle(.gray)
                }
                .padding(.bottom, 30)
                
                VStack(spacing: 20) {
                    MyInputField(
                        placeholder: "Campus ID",
                        iconName: "person.crop.circle",
                        text: $campusID,
                        isValid: $isCampusValid,
                        validation: RequiredValidationRule(message: "Campus Id is required")
                    )
                    
                    MyInputField(
                        placeholder: "Password",
                        iconName: "lock.fill",
                        isSecure: true,
                        text: $password,
                        isValid: $isPasswordValid,
                        contentType: .password,
                        validation: CompositeValidationRule(rules: [
                            RequiredValidationRule(message: "Password is required"),
                            MinLengthValidationRule(length: 8, message: "Password must be at least 8 characters")
                        ])
                    )
                }
                
                VStack {
                    HStack{
                        Spacer()
                        Button(action: {
                            PasswordResetFlow()
                        }) {
                            Text("Forgot Password ?")
                                .font(
                                    .system(size: 13, weight: .medium)
                                )
                                .foregroundColor(.blue)
                                .padding(.vertical, 5)
                        }
                    }
                    .padding(.vertical, 5)
                    
                    MyButton(
                        title: "Sign In",
                        variant: .primary,
                        size: .md,
                        width: .full,
                        action: {
                            // Hardcoded login check
                            if (campusID == validCampusID && password == validPassword) {
                                isAuthenticated = true
                            } else {
                                showLoginError = true
                            }
                        }
                    )
                    .disabled(campusID.isEmpty || password.isEmpty)
                }
                
                HStack(spacing: 5)
                {
                    Text("Don't have an account ?")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                    Button(action: {
                        showingSignup = true
                    }) {
                        Text("Sign Up")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.top, 5)
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 40)
            .background(Color.white)
            .customToast(
                isPresented: $showLoginSuccess,
                message: "Login Successful!",
                style: .success
            )
            .customToast(
                isPresented: $showLoginError,
                message: "Login Failed!",
                style: .error
            )
            .navigationDestination(isPresented: $isAuthenticated) {
                DashboardView()
            }
            .navigationDestination(isPresented: $showingSignup) {
                SignupView()
            }
        }
    }
}

#Preview {
    LoginView()
}
