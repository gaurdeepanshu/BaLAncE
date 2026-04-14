import SwiftUI

struct ContentView13: View {
    @EnvironmentObject var profile: UserProfile

    @State private var name: String = ""
    @State private var age: String = ""
    @State private var weight: String = ""
    @State private var height: String = ""
    @State private var bmi: String = ""
    @State private var sex: String = ""
    @State private var email: String = ""
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false

    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case name, age, weight, height, bmi, sex, email
    }

    var body: some View{
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Text("Profile")
                        .bold(true)
                        .padding()
                    // Avatar + camera
                    VStack(spacing: 8) {
                        ZStack {
                            if let uiImage = selectedImage ?? (profile.imageData.flatMap { UIImage(data: $0) }) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.black.opacity(0.2), lineWidth: 1))
                            } else {
                                Circle()
                                    .fill(Color.blue.opacity(0.3))
                                    .frame(width: 100, height: 100)
                                    .overlay(Circle().stroke(Color.black.opacity(0.2), lineWidth: 1))
                                    .overlay(Image(systemName: "person.fill").imageScale(.large).foregroundStyle(.secondary))
                            }
                        }
                        Button(action: { showingImagePicker = true }) {
                            HStack(spacing: 6) {
                                Text("Update Picture").bold()
                                Image(systemName: "camera.fill")
                                    .imageScale(.medium)
                            }
                        }
                        .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)

                    // Form-like inputs
                    VStack(spacing: 12) {
                        LabeledTextField(title: "Name", placeholder: "Enter your name", text: $name)
                            .focused($focusedField, equals: .name)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .age }

                        LabeledTextField(title: "Age", placeholder: "e.g. 28", text: $age, keyboard: .numberPad)
                            .focused($focusedField, equals: .age)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .weight }

                        HStack(spacing: 12) {
                            LabeledTextField(title: "Weight (kg)", placeholder: "e.g. 72", text: $weight, keyboard: .decimalPad)
                                .focused($focusedField, equals: .weight)
                                .submitLabel(.next)
                                .onSubmit { focusedField = .height }

                            LabeledTextField(title: "Height (cm)", placeholder: "e.g. 175", text: $height, keyboard: .decimalPad)
                                .focused($focusedField, equals: .height)
                                .submitLabel(.next)
                                .onSubmit { focusedField = .bmi }
                        }

                        LabeledTextField(title: "BMI", placeholder: "auto or manual", text: $bmi, keyboard: .decimalPad)
                            .focused($focusedField, equals: .bmi)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .sex }

                        LabeledTextField(title: "Sex", placeholder: "e.g. Male / Female", text: $sex)
                            .focused($focusedField, equals: .sex)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .email }

                        LabeledTextField(title: "Email", placeholder: "you@example.com", text: $email, keyboard: .emailAddress)
                            .focused($focusedField, equals: .email)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .submitLabel(.done)
                    }

                    // Save button
                    Button(action: save) {
                        Text("Save")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.blue.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.top, 8)
                }
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
        }
        .onAppear {
            // Prefill from existing profile
            name = profile.name
            email = profile.email
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $selectedImage)
        }
    }

    private func save() {
        // Persist minimal profile info to shared model
        profile.name = name
        profile.email = email
        if let img = selectedImage, let data = img.jpegData(compressionQuality: 0.9) {
            profile.imageData = data
        }
        // Optionally dismiss keyboard
        focusedField = nil
        print("Saved profile: \(profile.name), \(profile.email)")
    }
}

private struct LabeledTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var keyboard: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            TextField(placeholder, text: $text)
                .keyboardType(keyboard)
                .textFieldStyle(.roundedBorder)
        }
    }
}

#Preview {
    ContentView13()
        .environmentObject(UserProfile())
}
