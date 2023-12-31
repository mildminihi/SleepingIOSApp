//
//  LoginView.swift
//  SleepingIOS
//
//  Created by Supanat Wanroj on 31/7/2566 BE.
//

import SwiftUI
import Glaip

struct LoginView: View {
  @ObservedObject private var glaip: Glaip

  init() {
    self.glaip = Glaip(
      title: "Glaip Demo App",
      description: "Demo app to demonstrate Web3 login",
      supportedWallets: [.Rainbow, .MetaMask])
  }


  var body: some View {
    VStack {
      if glaip.userState == .unregistered {
        VStack {
          HStack {
            Image("WhiteLabelIcon")
              .resizable()
              .frame(width: 50, height: 50)

            Text("Web3")
              .font(.system(size: 40, weight: .bold))
              .padding(5)
              .foregroundColor(Color("AccentColor"))
          }

          Text("Welcome to Glaip")
            .font(.system(size: 25, weight: .semibold))
            .padding(5)
            .foregroundColor(Color("AccentColor"))

          Text("The easiest way to integrate ios into Web3")
            .font(.system(size: 16, weight: .regular))
            .multilineTextAlignment(.center)
            .foregroundColor(Color("AccentColor"))
        }
        .padding()
        .padding(.bottom, 30)

        WalletButtonView(
          title: "MetaMask",
          action: {
            glaip.loginUser(type: .MetaMask) { result in
              switch result {
              case .success(let user):
                print(user.wallet.address)
              case .failure(let error):
                print(error)
              }
            }
          },
          iconImage: Image("MetaMaskIcon")
        )
        .frame(width: 250)
        .padding(.leading)
        .padding(.trailing)

        WalletButtonView(
          title: "Rainbow Wallet",
          action: {
            glaip.loginUser(type: .Rainbow) { result in
              print(result)
            }
          },
          iconImage: Image("RainbowWalletIcon")
        )
        .frame(width: 250)
        .padding(.top)
        .padding(.leading)
        .padding(.trailing)
      }
      else {
        ProfileView(logoutAction: {
          glaip.userState = .unregistered
          glaip.logout()
        })
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.white)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}

