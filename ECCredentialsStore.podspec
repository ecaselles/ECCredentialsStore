#
# Be sure to run `pod lib lint ECCredentialsStore.podspec' to ensure this is a
# valid spec before submitting.
#

Pod::Spec.new do |s|
  s.name             = 'ECCredentialsStore'
  s.version          = '0.1.0'
  s.summary          = "`ECCredentialsStore` wraps the main methods to store and retrieve credentials from the Keychain."

  s.description      = <<-DESC
  "`ECCredentialsStore` wraps the main methods to store and retrieve the credentials (username,
  password and tokens) using the system's Keychain on iOS. It relies on the `ECKeychain`
  library to interface with keychain.

  `ECCredentialsStore` is implemented as a singleton, so it can be shared through different
  parts of the app."
                       DESC

  s.homepage         = 'https://github.com/ecaselles/ECCredentialsStore'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ecaselles' => 'eduardo.caselles@fundingcircle.com' }
  s.source           = { :git => 'https://github.com/ecaselles/ECCredentialsStore.git', :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'

  s.source_files = 'ECCredentialsStore/**/*'

  s.public_header_files = 'ECCredentialsStore/**/*.h'
  s.frameworks = 'Foundation'
  s.dependency 'ECKeychain'
end
