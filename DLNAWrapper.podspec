Pod::Spec.new do |s|
  s.name            = "DLNAWrapper"
  s.version         = "0.1.0"
  s.author          = { "wxx" => "wangxiaoxiang623@163.com" }
  s.license         = { :type => "MIT", :file => "LICENSE" }
  s.homepage        = 'https://github.com/luckwxx'
  s.source          = { :git => "https://github.com/luckwxx/DLNAWrapper.git", :tag => s.version.to_s}
  s.summary         = "DLNAWrapper"
  s.platform        = :ios, '9.0'
  s.requires_arc    = true
  s.source_files    = 'DLNAWrapper/*.{h,m,mm}','DLNAWrapper/Action/*.{h,m,mm}','DLNAWrapper/ControlService/*.{h,m,mm}'
  s.frameworks      = "Foundation"
  s.module_name     = 'DLNAWrapper'
  s.resources       = ['README.md']
  #s.resource_bundles= {}
  s.pod_target_xcconfig = {
    'HEADER_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/**'
  }

    s.dependency 'CocoaAsyncSocket','>=7.6.4'
    s.dependency 'GCDWebServer','>=3.5.4'
    s.dependency 'Reachability','>=3.2'
    s.dependency 'GDataXML-HTML','>=1.4.1'

end
