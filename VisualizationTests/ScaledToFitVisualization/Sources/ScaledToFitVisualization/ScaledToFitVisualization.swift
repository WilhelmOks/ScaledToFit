import SwiftUI
import ScaledToFit

struct AspectFitTestView: View {
    enum FitKind {
        case fit
        case min
        case max
        
        var titleSuffix: String {
            switch self {
            case .fit: return ""
            case .min: return " min"
            case .max: return " max"
            }
        }
    }
    
    private let containerSize = CGSize(width: 80, height: 90)
    
    @State private var pickerSelection = FitKind.fit
    
    var body: some View {
        VStack {
            Picker(selection: $pickerSelection, label: EmptyView(), content: {
                Text("fit").tag(FitKind.fit)
                Text("fit min").tag(FitKind.min)
                Text("fit max").tag(FitKind.max)
            })
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            ScrollView {
                VStack {
                    Text("Blue = size to fit into").foregroundColor(.blue)
                    Text("Yellow = original size").foregroundColor(.yellow)
                    Text("Red = new size").foregroundColor(.red)
                    
                    Divider()
                    
                    testCase(
                        title: "fit horizontally smaller\(pickerSelection.titleSuffix)",
                        size: .init(width: 120, height: 60),
                        container: containerSize,
                        fitKind: pickerSelection
                    )
                    
                    testCase(
                        title: "fit horizontally bigger\(pickerSelection.titleSuffix)",
                        size: .init(width: 60, height: 30),
                        container: containerSize,
                        fitKind: pickerSelection
                    )
                    
                    testCase(
                        title: "fit vertically smaller\(pickerSelection.titleSuffix)",
                        size: .init(width: 60, height: 120),
                        container: containerSize,
                        fitKind: pickerSelection
                    )
                    
                    testCase(
                        title: "fit vertically bigger\(pickerSelection.titleSuffix)",
                        size: .init(width: 30, height: 60),
                        container: containerSize,
                        fitKind: pickerSelection
                    )
                }
            }
        }
    }
    
    @ViewBuilder private func testCase(title: String, size: CGSize, container: CGSize, fitKind: FitKind) -> some View {
        VStack {
            Text(title)
            
            ZStack {
                Rectangle()
                    .stroke()
                    .foregroundColor(.blue)
                    .frame(container)
                
                Rectangle()
                    .foregroundColor(Color.yellow.opacity(0.3))
                    .frame(size)
                    .overlay(Rectangle().stroke().foregroundColor(.yellow).opacity(0.5))
                
                let resultSize =
                    fitKind == .min ? size.scaledUpToFit(minSize: container) ?? size :
                    fitKind == .max ? size.scaledDownToFit(maxSize: container) ?? size :
                    size.scaledToFit(size: container)
                
                Rectangle()
                    .foregroundColor(Color.red.opacity(0.3))
                    .frame(resultSize)
                    .overlay(Rectangle().stroke().foregroundColor(.red).opacity(0.5))
            }
            
            Divider()
        }
    }
}

fileprivate extension View {
    func frame(_ size: CGSize) -> some View {
        return self.frame(width: size.width, height: size.height)
    }
}

struct AspectFitTestView_Previews: PreviewProvider {
    static var previews: some View {
        AspectFitTestView()
    }
}
