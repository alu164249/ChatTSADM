//
//  BottomChatBar.swift
//  TSADMChat
//
//  Created by Bartomeu Mas Castillo on 9/2/24.
//

import Foundation
import SwiftUI
import Combine
import CloudKit

struct MessagesContainer : View {
    @ObservedObject var messagesModel: MessagesModel
    @ObservedObject var usersModel: UsersModel
    @State var username: String = ""
    @Namespace var bottomID

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack {
                    if messagesModel.messages.isEmpty {
                        Text("Cargando mensajes...")
                    } else {
                        ForEach(messagesModel.messages, id: \.self) { message in
                            MessageBubble(message: message.text, sender: message.sender)
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .padding([.leading, .trailing], 20)
                    }
                    Spacer()
                        .frame(height: 1)
                        .id(bottomID)
                }
                .frame(maxWidth: .infinity)
                .onChange(of: messagesModel.messages) { _ in
                    withAnimation {
                        proxy.scrollTo(bottomID)
                    }
                }
                .onChange(of: usersModel.users) { _ in
                    print(usersModel.users)
                }
                .onAppear {
                    withAnimation {
                        proxy.scrollTo(bottomID)
                    }
                }
            }
        }
        }
    }
