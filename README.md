# Swiftui Xcode previews module resources fix

A demo of a fix for a XCPreviewAgent crash due to resource dependencies accross modules.

It specificially fixes crashes like this:

```swift
unable to find bundle named <PACKAGE>_<TARGET>

----------------------------------------

CrashReportError: `fatalError` in resource_bundle_accessor.swift

XCPreviewAgent crashed due to fatalError in resource_bundle_accessor.swift at line 27.

unable to find bundle named <PACKAGE>_<TARGET>

Process: XCPreviewAgent

```
