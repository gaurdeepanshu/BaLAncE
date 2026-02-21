
import SwiftUI

struct ContentView13: View {
    @State private var Name: String = ""
    @State private var Age: String = ""
    @State private var Weight: String = ""
    @State private var Height: String = ""
    @State private var BMI: String = ""
    @State private var Sex: String = ""
    @State private var Email: String = ""
    var body: some View{
        ScrollView{
            VStack{
                Circle()
                    .foregroundColor(.blue)
                    .frame(width: 80, height: 80)
                    .overlay(Circle().stroke(Color.black, lineWidth: 5))
                    .padding()
                    .cornerRadius(50)
                    .opacity(0.3)
                HStack{
                    Text("Update Picture")
                        .bold()
                    Image(systemName: "camera.fill")
                }
                VStack{
                    TextField("Name :", text: $Name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    TextField("Age :", text: $Age)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    HStack{
                        
                        TextField("Weight :", text: $Weight)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        TextField("Height :", text: $Height)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        TextField("BMI :", text: $BMI)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                       }
                    
                    
                    TextField("Sex :", text: $Sex)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    TextField("Email :", text: $Email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                     }
                Spacer()

                ZStack{
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(height: 40)
                        .frame(width: 120)
                        .opacity(0.4)
                    Text("Save")
                    
                }
                
                
                
                
                
          }
            Spacer()
        }
    }
}
#Preview {
    ContentView13()
}
