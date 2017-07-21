Pod::Spec.new do |s|
	s.name = 'OrangeIRC'
	s.version = '1.0.0'
	s.summary = 'IRC Client for iOS written in Swift'
	s.homepage = 'https://github.com/ahyattdev/OrangeIRC'
	s.license = 'Apache License 2'
	s.platform = :ios, '9.3'

	s.author = 'Andrew Hyatt'
	s.social_media_url = 'https://github.com/ahyattdev'

	s.screenshots = []

	s.source = { :git => 'https://github.com/ahyattdev/OrangeIRC.git', :tag => s.version }
	s.source_files = 'OrangeIRC Core/**/*.swift'

	s.resources = []

    s.dependency = 'CocoaAsyncSocket', :git => 'https://github.com/robbiehanson/CocoaAsyncSocket.git', :branch => 'master'

	s.requires_arc = true
end