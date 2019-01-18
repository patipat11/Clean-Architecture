# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
use_frameworks!
def rx_swift
	pod 'RxSwift'
	pod 'RxCocoa'
end

def lib_on_app
	pod 'Natrium'
	pod 'SwiftLint'
end

def lib_on_framework
	pod 'Moya'
	pod 'SwiftLint'
end

def lib_test
	pod 'RxTest'
	pod 'RxBlocking'
	pod 'Nimble'
	pod 'SwiftLint'
end

target 'CleanArchitecture' do
	rx_swift
	lib_on_app
	lib_on_framework
	
	target 'CleanArchitectureTests' do
		lib_test
	end

	target 'CleanArchitectureUITests' do
		lib_test
	end
end

target 'DomainLib' do
	lib_on_framework
	
	#  target 'DomainTests' do
	#        lib_test
	#  end
	
end

target 'NetworkLib' do
   lib_on_framework

end

target 'PlatformLib' do
  lib_on_framework

end
