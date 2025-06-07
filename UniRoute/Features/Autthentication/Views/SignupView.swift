//
//  SignupView.swift
//  UniRoute
//
//  Created by Pavithra Chamod on 2025-06-07.
//

import SwiftUI

struct SignupView: View {
    @State private var firstName: String = ""
    @State private var isFirstNameValid = true
    @State private var lastName: String = ""
    @State private var isLastNameValid = true
    @State private var campusID: String = ""
    @State private var isCampusValid = true
    @State private var password: String = ""
    @State private var isPasswordValid = true
    @State private var confirmPassword: String = ""
    @State private var isConfirmPasswordValid = true
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 24){
                VStack(spacing: 8)
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
                .padding(.bottom, 2)
                
                VStack
                {
                    Text("Sign Up")
                        .font(
                            .poppins(
                                fontStyle: .title,
                                fontWeight: .bold
                            ))
                    
                    Text("Sign up for personalized maps, notifications and much more.")
                        .font(.poppins(fontStyle: .footnote, fontWeight: .medium))
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.bottom, 10)
                
                VStack(spacing: 10) {
                    
                    MyInputField(
                        placeholder: "First Name",
                        text: $firstName,
                        isValid: $isFirstNameValid,
                        validation: RequiredValidationRule(message: "First Name is required")
                    )
                    
                    MyInputField(
                        placeholder: "Last Name",
                        text: $lastName,
                        isValid: $isLastNameValid,
                        validation: RequiredValidationRule(message: "Last Name is required")
                    )
                    
                    MyInputField(
                        placeholder: "Campus ID",
                        text: $campusID,
                        isValid: $isCampusValid,
                        validation: RequiredValidationRule(message: "Campus Id is required")
                    )
                    
                    MyInputField(
                        placeholder: "Password",
                        isSecure: true,
                        text: $password,
                        isValid: $isPasswordValid,
                        contentType: .password,
                        validation: CompositeValidationRule(rules: [
                            RequiredValidationRule(message: "Password is required"),
                            MinLengthValidationRule(length: 8, message: "Password must be at least 8 characters")
                        ])
                    )
                    
                    MyInputField(
                        placeholder: "Confirm Password",
                        isSecure: true,
                        text: $confirmPassword,
                        isValid: $isConfirmPasswordValid,
                        contentType: .password,
                        validation: CompositeValidationRule(rules: [
                            RequiredValidationRule(message: "Password is required"),
                            MinLengthValidationRule(length: 8, message: "Password must be at least 8 characters")
                        ])
                    )
                }
                
                MyButton(title: "Sign Up") {
                    print("Sign Up button tapped")
                }
                .padding(.top, 8)
                
                HStack(spacing: 4) {
                    Text("Already have an account?")
                        .font(.poppins(fontStyle: .footnote, fontWeight: .regular))
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        print("Sign In link tapped")
                        dismiss()
                    }) {
                        Text("Sign In")
                            .font(.poppins(fontStyle: .footnote, fontWeight: .medium))
                            .foregroundColor(.blue)
                    }
                }
                .padding(.top, 5)
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SignupView()
}
