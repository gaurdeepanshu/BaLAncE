
import SwiftUI

struct ContentView10: View {
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
                Text("Sign In")
                    .font(.title)
                    .foregroundColor(.orange)
             

                VStack(alignment: .leading, spacing: 8){
                    Text("Email address")
                        .foregroundColor(.gray)
                    TextField("Email address", text: $email)
                    .frame(height: 10)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(50)
                    
                    Text("Password")
                        .foregroundColor(.gray)
                    SecureField("Password", text: $password)
                        .frame(height: 10)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(50)
                    
                    Text("Forgot your password?")
                      .foregroundColor(.blue)
                      .padding(.top, 1)
                      .font(.caption)
                      .fontWeight(.light)
                }.padding(.horizontal, 50)
                    
                Button(action: {
                    print("login tapped")
                }) {
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
              
                   
                HStack{
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 25))
                        .foregroundColor(.gray)
                    Text("Don't have an account?")
                        .foregroundColor(.gray)
                    Button(action: {
                        print("sign up tapped")
                    }) {
                        Text("Sign Up")
                    }
                }
                
                Text("sign in using")
                    .foregroundStyle(Color.gray)
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
    ContentView10()
}
