# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.2] - 2019-01-15
### Added
- Convenience `make` method on `MungoHealer` to simplify typed make code with single `handle(error)` catch-all.

## [0.3.1] - 2018-10-24
### Added
- Convenience `do` method on `MungoHealer` to simplify usage with single `handle(error)` catch-all.

## [0.2.0] - 2018-10-24
### Added
- Convenience implementations of error protocols: `MungoError`, `MungoFatalError` & `MungoHealableError`
- A `debugDescription` as an addition to the `BaseError` protocol.

## [0.1.0] - 2018-10-16
### Added
- A `MungoHealer` main type for global error handling.
- An `ErrorHandler` protocol for customizing handling errors.
- `AlertLogErrorHandler` as the default implementation of `ErrorHandler`.
- Core error type protocols: `BaseError`, `FatalError` and `HealableError`.
- Core helper types & extensions to make this all work.
- A very simple Demo project for the iOS platform.
- Initial documentation within the README.md file.
- An Xcode file structure loosely based on [this](https://www.notion.so/jamitlabs/Xcode-File-Structure-201052f68e4f4108b44894b7afeb4776) Best Practice
- A .swiftlint.yml based on [this](https://github.com/JamitLabs/ProjLintTemplates/blob/master/Framework/SwiftLint.stencil) template.
- A .projlint.yml based on [this](https://github.com/JamitLabs/ProjLintTemplates/blob/master/Framework/ProjLint.stencil) template.
- Bitrise CI Integration including a badge in the README.md.
- A logo based on the eponym Mungo Bonham.
