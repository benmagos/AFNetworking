Pod::Spec.new do |s|
  s.name     = 'PFNetworking'
  s.version  = '2.5.2'
  s.license  = 'MIT'
  s.summary  = 'A delightful iOS and OS X networking framework.'
  s.homepage = 'https://github.com/benmagos/AFNetworking'
  s.social_media_url = 'https://twitter.com/AFNetworking'
  s.authors  = { 'Mattt Thompson' => 'm@mattt.me' }
  s.source   = { :git => 'https://github.com/benmagos/AFNetworking.git', :tag => s.version, :submodules => true }
  s.requires_arc = true

  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.8'

  s.public_header_files = 'PFNetworking/*.h'
  s.source_files = 'PFNetworking/PFNetworking.h'

  s.subspec 'Serialization' do |ss|
    ss.source_files = 'PFNetworking/PFURL{Request,Response}Serialization.{h,m}'
    ss.ios.frameworks = 'MobileCoreServices', 'CoreGraphics'
    ss.osx.frameworks = 'CoreServices'
  end

  s.subspec 'Security' do |ss|
    ss.source_files = 'PFNetworking/PFSecurityPolicy.{h,m}'
    ss.frameworks = 'Security'
  end

  s.subspec 'Reachability' do |ss|
    ss.source_files = 'PFNetworking/PFNetworkReachabilityManager.{h,m}'
    ss.frameworks = 'SystemConfiguration'
  end

  s.subspec 'NSURLConnection' do |ss|
    ss.dependency 'PFNetworking/Serialization'
    ss.dependency 'PFNetworking/Reachability'
    ss.dependency 'PFNetworking/Security'

    ss.source_files = 'PFNetworking/PFURLConnectionOperation.{h,m}', 'PFNetworking/PFHTTPRequestOperation.{h,m}', 'PFNetworking/PFHTTPRequestOperationManager.{h,m}'
  end

  s.subspec 'NSURLSession' do |ss|
    ss.dependency 'PFNetworking/Serialization'
    ss.dependency 'PFNetworking/Reachability'
    ss.dependency 'PFNetworking/Security'

    ss.source_files = 'PFNetworking/PFURLSessionManager.{h,m}', 'PFNetworking/PFHTTPSessionManager.{h,m}'
  end

  s.subspec 'UIKit' do |ss|
    ss.ios.deployment_target = '6.0'

    ss.dependency 'PFNetworking/NSURLConnection'
    ss.dependency 'PFNetworking/NSURLSession'

    ss.ios.public_header_files = 'UIKit+PFNetworking/*.h'
    ss.ios.source_files = 'UIKit+PFNetworking'
    ss.osx.source_files = ''
  end
end
