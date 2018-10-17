<p align="center">
    <img src="https://raw.githubusercontent.com/JamitLabs/MungoHealer/stable/Logo.png"
      width=600>
</p>

<p align="center">
    <a href="https://app.bitrise.io/app/fbdb7fe2d4879760">
        <img src="https://app.bitrise.io/app/fbdb7fe2d4879760/status.svg?token=bXijt_o5Fsl1E8cqtrrXLw&branch=stable"
             alt="Build Status">
    </a>
    <a href="https://github.com/JamitLabs/MungoHealer/releases">
        <img src="https://img.shields.io/badge/Version-0.1.0-blue.svg"
             alt="Version: 0.1.0">
    </a>
    <img src="https://img.shields.io/badge/Swift-4.2-FFAC45.svg"
         alt="Swift: 4.2">
    <img src="https://img.shields.io/badge/Platforms-iOS%20%7C%20tvOS-FF69B4.svg"
        alt="Platforms: iOS | tvOS">
    <a href="https://github.com/JamitLabs/MungoHealer/blob/stable/LICENSE.md">
        <img src="https://img.shields.io/badge/License-MIT-lightgrey.svg"
              alt="License: MIT">
    </a>
</p>

<p align="center">
    <a href="#installation">Installation</a>
  • <a href="#usage">Usage</a>
  • <a href="https://github.com/JamitLabs/MungoHealer/issues">Issues</a>
  • <a href="#contributing">Contributing</a>
  • <a href="#license">License</a>
</p>

# MungoHealer

Error Handler based on localized & healable (recoverable) errors without the overhead of NSError (which you would have when using LocalizedError & RecoverableError instead).

## Why use MungoHealer?

When developing a new feature for an App developers often need to both have presentable results **fast** and at the same time provide **good user feedback** for edge cases like failed network requests or invalid user input.

While there are many ways to deal with such situations, MungoHealer provides a straightforward and Swift-powered approach that uses system alerts for user feedback by default, but can be easily customized to use custom UI when needed.

## Installation

Installing via [Carthage](https://github.com/Carthage/Carthage#carthage) & [CocoaPods](https://guides.cocoapods.org/using/getting-started.html) are both supported.

Support for SPM is currently not possible as this framework uses UIKit.

## Usage

Please also have a look at the `MungoHealer iOS-Demo` project in the subfolder `Demos` for a live usage example.

---
### Features Overview

- [Defining Errors](#defining-errors)
- [Default Error Types](#default-error-types)
- [Error Handling](#error-handling)
- [Usage Example](#usage-example)

---

### Defining Errors

MungoHealer is based on Swifts built-in [error handling mechanism](https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html). So before we can throw any useful error message when something goes wrong, we need to define our errors.

MungoHealer can deal with any errors thrown by system frameworks or third party libraries alike, but to make use of the user feedback automatics, you need to implement one of MungoHealers error type protocols:

#### `BaseError`

A localized error type without the overhead of NSError – truly designed for Swift. Use this for any error you want to provide localized user feedback for.

<details>
<summary>Requirements</summary>

**`source: ErrorSource`**
A classification of the errors source. MungoHealer will automatically provide an alert title based on it. The available options are:

-  `.invalidUserInput`
-  `.internalInconsistency`
-  `.externalSystemUnavailable`
-  `.externalSystemBehavedUnexpectedlyBased`

The options are explained in detail [here](https://khawerkhaliq.com/blog/swift-error-handling/#Sources_of_errors).

**`errorDescription: String`**
A localized message describing what error occurred. This will be presented to the user as the alerts message by default when the error occurs.

</details>

<details>
<summary>Example</summary>

```swift
struct PasswordValidationError: BaseError {
    let errorDescription = "Your password confirmation didn't match your password. Please try again."
    let source = ErrorSource.invalidUserInput
}
```

</details>

#### `FatalError`

A non-healable (non-recoverable) & localized fatal error type without the overhead of NSError – truly designed for Swift. Use this as an alternative for `fatalError` and tasks like force-unwrapping when you don't expect a `nil` value and therefore don't plan to heal (recover from).

Note that throwing a `FatalError` will crash your app, just like `fatalError()` or force-unwrapping `nil` would. The difference is, that here the user is first presented with an error message which is a better user experience. Additionally, before the app crashes you have the chance to do any cleanup or reporting tasks via a callback if you need to.

*It is highly recommended to ***keep the suffix `FatalError`*** in your custom errors class name to clearly communicate that throwing this will crash the app.*

<details>
<summary>Requirements</summary>

`FatalError` has the exact same requirements as `BaseError`. In fact its type declaration is as simple as this:

```swift
public protocol FatalError: BaseError {}
```

The only difference is semantics – the data provided by a `FatalError` will be used for alert title & message as well. But confirming the alert will crash the app.

</details>

<details>
<summary>Example</summary>

```swift
struct UnexpectedNilFatalError: FatalError {
    let errorDescription = "An unexpected data inconsistency has occurred. App execution can not be continued."
    let source = ErrorSource.internalInconsistency
}
```

</details>


#### `HealableError`

A healable (recoverable) & localized error type without the overhead of NSError – truly designed for Swift. Use this for any edge-cases you can heal (recover from) like network timeouts (healing via Retry), network unauthorized responses (healing via Logout) etc.

<details>
<summary>Requirements</summary>

`HealableError` extends `BaseError` and therefore has the same requirements. In addition to that, you need to add:

**`healingOptions: [HealingOption]`**
Provides an array of possible healing options to present to the user. A healing option consists of the following:

- **`style: Style`**: The style of the healing option. One of: `.normal`, `.recommended` or `.destructive`
- **`title: String`**: The title of the healing option.
- **`handler: () -> Void`**: The code to be executed when the user chooses the healing option.

Note that you must provide at least one healing option.

</details>

<details>
<summary>Example</summary>

```swift
struct NetworkUnavailableError: HealableError {
    private let retryClosure: () -> Void

    init(retryClosure: @escaping () -> Void) {
        self.retryClosure = retryClosure
    }

    let errorDescription = "Could not connect to server. Please check your internet connection and try again."
    let source = ErrorSource.externalSystemUnavailable

    var healingOptions: [HealingOption] {
        let retryOption = HealingOption(style: .recommended, title: "Try Again", handler: retryClosure)
        let cancelOption = HealingOption(style: .normal, title: "Cancel", handler: {})
        return [retryOption, cancelOption]
    }
}
```

</details>

### Default Error Types

MungoHealer provides one basic implementation of each error protocol which you can use for convenience so you don't have to write a new error type for simple message errors. These are:

<details>
<summary>**MungoError**</summary>

- Implements `BaseError`
- `init` takes `source: ErrorSource` & `message: String`

Example Usage:

```swift
func fetchImage(urlPath: String) {
  guard let url = URL(string: urlPath) else {
    throw MungoError(source: .invalidUserInput, message: "Invalid Path")
  }

  // ...
}
```

</details>

<details>
<summary>**MungoFatalError**</summary>

- Implements `FatalError`
- `init` takes `source: ErrorSource` & `message: String`

Example Usage:

```swift
func fetchImage(urlPath: String) {
  guard let url = URL(string: urlPath) else {
    throw MungoFatalError(source: .invalidUserInput, message: "Invalid Path")
  }

  // ...
}
```

</details>

<details>
<summary>*MungoHealableError**</summary>

- Implements `HealableError`
- `init` takes `source: ErrorSource` & `message: String`
- `init` additionally takes `healOption: HealOption`

Example Usage:

```swift
func fetchImage(urlPath: String) {
  guard let url = URL(string: urlPath) else {
    let healingOption = HealingOption(style: .recommended, title: "Retry") { [weak self] in self?.fetchImage(urlPath: urlPath) }
    throw MungoHealableError(source: .invalidUserInput, message: "Invalid Path", healingOption: healingOption)
  }

  // ...
}
```

</details>

### Error Handling

MungoHealer makes handling errors easier by providing the `ErrorHandler` protocol and a default implementation of it based on alert views, namely `AlertLogErrorHandler`.

The easiest way to get started with MungoHealer is to use a global variable and set it in your AppDelegate.swift like this:

```swift
import MungoHealer
import UIKit

var mungo: MungoHealer!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureMungoHealer()
        return true
    }

    private func configureMungoHealer() {
        let errorHandler = AlertLogErrorHandler(window: window!, logError: { print("Error: \($0)") })
        mungo = MungoHealer(errorHandler: errorHandler)
    }
}
```

Note that the following steps were taken in the above code:

1. Add `import MungoHealer` at the top
2. Add `var mungo: MungoHealer!` global variable
3. Add a private `configureMungoHealer()` method
4. Provide your preferred `logError` handler (e.g. [SwiftyBeaver](https://github.com/SwiftyBeaver/SwiftyBeaver))
5. Call `configureMungoHealer()` on app launch

As you can see, the `AlertLogErrorHandler` receives two parameters: The first is the `window` so it can find the current view controller to present alerts within. The second is a error log handler – the `AlertLogErrorHandler` not only presents alerts when there is a localized error, but it will also log all  errors calling the `logError` handler with the errors localized description.

#### Custom `ErrorHandler`

While starting with the `AlertLogErrorHandler` is recommended by default, you might of course want to handle errors differently then just with system alerts & logs. For these cases, you just need to implement your own error handler by conforming to `ErrorHandler` which requires the following methods:

- `handle(error: Error)`: Called for "normal" error types.
- `handle(baseError: BaseError)`: Called for base error types.
- `handle(fatalError: FatalError)`: Called for fatal error types – App should crash at the end of this method.
- `handle(healableError: HealableError)`: Calles for healable error types.

See the implementation of `AlertLogErrorHandler` [here](https://github.com/JamitLabs/MungoHealer/blob/stable/Frameworks/MungoHealer/ErrorHandlers/AlertLogErrorHandler.swift) for a working example.

Note that you don't have to use a single global variable named `mungo` as in the example above. You could also write your own Singleton with multiple `MungoHealer` objects, each with a different `ErrorHandler` type. This way you could choose to either show an alert or your custom handling, depending on the context. The Singleton might look something like this:

```swift
enum ErrorHandling {
    static var alertLogHandler: MungoHealer!
    static var myCustomHandler: MungoHealer!
}
```

### Usage Example

Once you've written your own error types and configured your error handler, you should write throwing methods and deal with errors either directly (as before) or use MungoHealer's `handle` method which will automatically deal with the error cases.

Here's a throwing method:

```swift
private func fetchImage(urlPath: String) throws -> UIImage {
    guard let url = URL(string: urlPath) else {
        throw StringNotAValidURLFatalError()
    }

    guard let data = try? Data(contentsOf: url) else {
        throw NetworkUnavailableError(retryClosure: { [weak self] intry self?.loadAvatarImage() })
    }

    guard let image = UIImage(data: data) else {
        throw InvalidDataError()
    }

    return image
}
```

You can see that different kinds of errors could be thrown here. All of them can be handled at once as easy as this:

```swift
private func loadAvatarImage() {
    do {
        imageView.image = try fetchImage(urlPath: user.avatarUrlPath)
    } catch {
        mungo.handle(error)
    }
}
```

We don't need to deal with error handling on the call side which  makes our code both more readable & more fun to write. Instead, we define how to deal with the errors at the point where the error is thrown/defined. On top of that, the way errors are communicated to the user is abstracted away and can be changed App-wide by simply editing the error handler code. This also makes it possible to handle errors in the model or networking layer without referencing any `UIKit` classes.

So as you can see, used wisely, MungoHealer can help to make your code **cleaner**, **less error prone** and it can **improve the User Experience** for your users.

## Contributing

See the file [CONTRIBUTING.md](https://github.com/JamitLabs/MungoHealer/blob/stable/CONTRIBUTING.md).


## License
This library is released under the [MIT License](http://opensource.org/licenses/MIT). See LICENSE for details.
