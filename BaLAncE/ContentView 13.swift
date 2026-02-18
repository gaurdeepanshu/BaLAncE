
import SwiftUI

struct ContentView13: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View{
      NavigationStack {
        ZStack {
            Image("gym")
                .resizable()
                .opacity(0.3)
             VStack (spacing: 20){
                Text("BaLAncE")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                Text("Forget Password")
                 
                    .foregroundColor(.orange)
                 VStack(alignment: .leading, spacing: 8){
                     Text("Enter Email / Phone")
                         .foregroundColor(.gray)
                     TextField("Email address", text: $email)
                         .frame(height: 10)
                         .padding()
                         .background(Color.white)
                         .cornerRadius(50)
                     
                     Text("Enter OTP")
                         .foregroundColor(.gray)
                     SecureField("Password", text: $password)
                         .frame(height: 10)
                         .padding()
                         .background(Color.white)
                         .cornerRadius(50)
                     
                     Text("Enter New Password")
                         .foregroundColor(.gray)
                     SecureField("Password", text: $password)
                         .frame(height: 10)
                         .padding()
                         .background(Color.white)
                         .cornerRadius(50)
                 }.padding(.horizontal, 50)
                 Button(action: {
                    print("login tapped")
                }
                 )
                 {
                    Text("Sign In")
                        .font(.footnote)
                        .bold()
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: 100)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(25)
                }.buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 50)
                    .padding(.top, 8)
               HStack(spacing: 20){
                    Image(systemName: "applelogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 32)
                        .foregroundStyle(.primary)
                    Image(systemName: "globe")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 32)
                        .foregroundStyle(.primary)
                    Image(systemName: "f.square.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 32)
                        .foregroundStyle(.primary)
               }
            }
        }.ignoresSafeArea()
    }.toolbar(.hidden)
         }
}
#Preview {
    ContentView13()
}
