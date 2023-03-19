import UIKit

extension UIImage {
func makeCombineImage(with label: UILabel) -> UIImage {
    let tempView = UIStackView(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.height))
        imageView.contentMode = .scaleAspectFit
//        tempView.axis = .vertical
//        tempView.alignment = .center
//        tempView.spacing = 8

        imageView.image = self.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white

//        tempView.addArrangedSubview(imageView)
//        tempView.addArrangedSubview(label)

        let renderer = UIGraphicsImageRenderer(bounds: tempView.bounds)
        let image = renderer.image { rendererContext in
            tempView.layer.render(in: rendererContext.cgContext)
        }

        return image
    }
}
