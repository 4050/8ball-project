// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  internal enum Error {
    /// Error received requesting data
    internal static let errorReceivedRequestingData = L10n.tr("Error", "Error received requesting data")
    /// Failed to get data from URL: 
    internal static let failedToGetDataFromURL = L10n.tr("Error", "Failed to get data from URL: ")
  }
  internal enum HardCodedAnswers {
    /// CHANGE YOUR MIND!!!
    internal static let changeYourMind = L10n.tr("HardCodedAnswers", "CHANGE YOUR MIND!!!")
    /// JUST DO IT!!!
    internal static let justDoIt = L10n.tr("HardCodedAnswers", "JUST DO IT!!!")
    /// KEEP MOVING!!!
    internal static let keepMoving = L10n.tr("HardCodedAnswers", "KEEP MOVING!!!")
    /// YES!!!
    internal static let yes = L10n.tr("HardCodedAnswers", "YES!!!")
  }
  internal enum Text {
    /// ASK ME ANYTHING
    internal static let askMeAnything = L10n.tr("Text", "ASK ME ANYTHING")
    /// I AM A MAGIC BALL
    internal static let iAmAMagicBall = L10n.tr("Text", "I AM A MAGIC BALL")
    /// Нажмите сюда:
    internal static let pressHere = L10n.tr("Text", "pressHere")
    /// shake me!
    internal static let shakeMe = L10n.tr("Text", "shake me!")
    /// Здесь вы можете выбрать варианты ответа если отключится интернет. Выберите предложенный вариант из списка:
    internal static let textForSecondController = L10n.tr("Text", "textForSecondController")
  }
  internal enum Title {
    /// Add
    internal static let add = L10n.tr("Title", "Add")
    /// Add custom answer
    internal static let addCustomAnswer = L10n.tr("Title", "Add custom answer")
    /// Cancel
    internal static let cancel = L10n.tr("Title", "Cancel")
    /// Input your answer
    internal static let inputYourAnswer = L10n.tr("Title", "Input your answer")
  }
  internal enum URLstring {
    /// https://8ball.delegator.com/magic/JSON/question
    internal static let answerURL = L10n.tr("URLstring", "answerURL")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
