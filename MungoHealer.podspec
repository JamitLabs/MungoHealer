Pod::Spec.new do |s|

  s.name         = "MungoHealer"
  s.version      = "0.1.0"
  s.summary      = "Error Handler based on localized & healable (recoverable) errors without the overhead of NSError. "

  s.description  = <<-DESC
    Error Handler based on localized & healable (recoverable) errors without the overhead of NSError
    (which you would have when using LocalizedError & RecoverableError instead).
                   DESC

  s.homepage     = "https://github.com/JamitLabs/MungoHealer"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Cihat Gündüz" => "cocoapods@cihatguenduez.de" }
  s.social_media_url   = "https://twitter.com/Dschee"

  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/JamitLabs/MungoHealer.git", :tag => "#{s.version}" }
  s.source_files = "Frameworks/MungoHealer", "Frameworks/MungoHealer/**/*.swift"
  s.framework    = "UIKit"
  s.swift_version = "4.2"
  s.resource_bundle = { "MungoHealer" => ["Frameworks/SupportingFiles/*.lproj"] }

end
