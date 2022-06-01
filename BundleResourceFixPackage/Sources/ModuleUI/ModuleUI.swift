import ModuleA
import ModuleB
import SwiftUI

struct ModuleUIView: View {
    var body: some View {
        VStack {
            Image(uiImage: UIImage(contentsOfFile: ModuleA().resourceURL.path)!)
            Image(uiImage: UIImage(contentsOfFile: ModuleB().resourceURL.path)!)
        }
    }
}

struct ModuleUIView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleUIView()
    }
}
