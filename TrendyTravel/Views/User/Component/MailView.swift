//
//  MailView.swift
//  TrendyTravel
//
//  Created by Cynthia on 20/07/2023.
//

import SwiftUI
import UIKit
import MessageUI

public typealias MailViewCallback = ((Result<MFMailComposeResult, Error>) -> Void)?

public struct MailView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentation
    @Binding var data: ComposeMailData
    let callback: MailViewCallback
    
    public init(data: Binding<ComposeMailData>,
                callback: MailViewCallback) {
        _data = data
        self.callback = callback
    }

    public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var presentation: PresentationMode
        @Binding var data: ComposeMailData
        let callback: MailViewCallback

        public init(presentation: Binding<PresentationMode>,
             data: Binding<ComposeMailData>,
             callback: MailViewCallback) {
            _presentation = presentation
            _data = data
            self.callback = callback
        }

        public func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            if let error = error {
                callback?(.failure(error))
            } else {
                callback?(.success(result))
            }
            $presentation.wrappedValue.dismiss()
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(presentation: presentation, data: $data, callback: callback)
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setSubject(data.subject)
        vc.setToRecipients(data.recipients)
        vc.setMessageBody(data.message, isHTML: false)
        data.attachments?.forEach {
            vc.addAttachmentData($0.data, mimeType: $0.mimeType, fileName: $0.fileName)
        }
        vc.accessibilityElementDidLoseFocus()
        return vc
    }

    public func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailView>) {
    }
    
    public static var canSendMail: Bool {
        MFMailComposeViewController.canSendMail()
    }
}

public struct ComposeMailData {
    public let subject: String
    public let recipients: [String]?
    public let message: String
    public let attachments: [AttachmentData]?
    
    public init(subject: String,
                recipients: [String]?,
                message: String,
                attachments: [AttachmentData]?) {
        self.subject = subject
        self.recipients = recipients
        self.message = message
        self.attachments = attachments
    }
    
    public static let empty = ComposeMailData(subject: "", recipients: nil, message: "", attachments: nil)
}

public struct AttachmentData {
    public let data: Data
    public let mimeType: String
    public let fileName: String
    
    public init(data: Data,
                mimeType: String,
                fileName: String) {
        self.data = data
        self.mimeType = mimeType
        self.fileName = fileName
    }
}


//import UIKit
//import MessageUI
//
//struct MailView: UIViewControllerRepresentable {
//
//    @Binding var isShowing: Bool
//    @Binding var result: Result<MFMailComposeResult, Error>?
//
//    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
//
//        @Binding var isShowing: Bool
//        @Binding var result: Result<MFMailComposeResult, Error>?
//
//        init(isShowing: Binding<Bool>,
//             result: Binding<Result<MFMailComposeResult, Error>?>) {
//            _isShowing = isShowing
//            _result = result
//        }
//
//        func mailComposeController(_ controller: MFMailComposeViewController,
//                                   didFinishWith result: MFMailComposeResult,
//                                   error: Error?) {
//            defer {
//                isShowing = false
//            }
//            guard error == nil else {
//                self.result = .failure(error!)
//                return
//            }
//            self.result = .success(result)
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(isShowing: $isShowing,
//                           result: $result)
//    }
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
//        let vc = MFMailComposeViewController()
//        vc.mailComposeDelegate = context.coordinator
//        return vc
//    }
//
//    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
//                                context: UIViewControllerRepresentableContext<MailView>) {
//
//    }
//}

//import MessageUI
//
//class EmailHelper: NSObject {
//    /// singleton
//    static let shared = EmailHelper()
//    private override init() {}
//}
//
//extension EmailHelper {
//
//    /// Remember to add the below code to Info.plist
//    ///    <key>LSApplicationQueriesSchemes</key>
//    ///    <array>
//    ///       <string>googlegmail</string>
//    ///    </array>
//    func send(subject: String, body: String, to: [String]) {
//        guard let viewController = UIApplication.shared.windows.first?.rootViewController else {
//            return
//        }
//        if !MFMailComposeViewController.canSendMail() {
//            let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//            let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//            let mails = to.joined(separator: ",")
//
//            let alert = UIAlertController(title: "Cannot open Mail!", message: "", preferredStyle: .actionSheet)
//
//            var haveExternalMailbox = false
//
//            if let defaultUrl = URL(string: "mailto:\(mails)?subject=\(subjectEncoded)&body=\(bodyEncoded)"),
//               UIApplication.shared.canOpenURL(defaultUrl) {
//                haveExternalMailbox = true
//                alert.addAction(UIAlertAction(title: "Mail", style: .default, handler: { (action) in
//                    UIApplication.shared.open(defaultUrl)
//                }))
//            }
//
//            if let gmailUrl = URL(string: "googlegmail://co?to=\(mails)&subject=\(subjectEncoded)&body=\(bodyEncoded)"),
//               UIApplication.shared.canOpenURL(gmailUrl) {
//                haveExternalMailbox = true
//                alert.addAction(UIAlertAction(title: "Gmail", style: .default, handler: { (action) in
//                    UIApplication.shared.open(gmailUrl)
//                }))
//            }
//
//            if haveExternalMailbox {
//                alert.message = "Would you like to open an external mailbox?"
//            } else {
//                alert.message = "Please add your mail to Settings before using the mail service."
//
//                if let settingsUrl = URL(string: UIApplication.openSettingsURLString),
//                   UIApplication.shared.canOpenURL(settingsUrl) {
//                    alert.addAction(UIAlertAction(title: "Open Settings App", style: .default, handler: { (action) in
//                        UIApplication.shared.open(settingsUrl)
//                    }))
//                }
//            }
//
//            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//            viewController.present(alert, animated: true, completion: nil)
//            return
//        }
//
//        let mailCompose = MFMailComposeViewController()
//        mailCompose.setSubject(subject)
//        mailCompose.setMessageBody(body, isHTML: false)
//        mailCompose.setToRecipients(to)
//        mailCompose.mailComposeDelegate = self
//
//        viewController.present(mailCompose, animated: true, completion: nil)
//    }
//}
//
//// MARK: - MFMailComposeViewControllerDelegate
//extension EmailHelper: MFMailComposeViewControllerDelegate {
//
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        controller.dismiss(animated: true, completion: nil)
//    }
//}
