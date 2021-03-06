import Foundation
import SwiftSyntax
import XCTest

@testable import SwiftFormatRules

public class UseEnumForNamespacingTests: DiagnosingTestCase {
  public func testNonEnumsUsedAsNamespaces() {
    XCTAssertFormatting(
      UseEnumForNamespacing.self,
      input: """
             struct A {
               static func foo() {}
               private init() {}
             }
             struct B {
               var x: Int = 3
               static func foo() {}
               private init() {}
             }
             class C {
               static func foo() {}
             }
             public final class D {
               static func bar()
             }
             final class E {
               static let a = 123
             }
             struct Structure {
               #if canImport(AppKit)
                   var native: NSSomething
               #elseif canImport(UIKit)
                   var native: UISomething
               #endif
             }
             struct Structure {
               #if canImport(AppKit)
                   static var native: NSSomething
               #elseif canImport(UIKit)
                   static var native: UISomething
               #endif
             }
             struct Structure {
               #if canImport(AppKit)
                   var native: NSSomething
               #elseif canImport(UIKit)
                   static var native: UISomething
               #endif
             }
             struct Structure {
               #if canImport(AppKit)
                   static var native: NSSomething
               #else
                   static var native: UISomething
               #endif
             }
             struct Structure {
               #if canImport(AppKit)
                 #if swift(>=4.0)
                   static var native: NSSomething
                 #else
                   static var deprecated_native: NSSomething
                 #endif
               #else
                   #if swift(>=4.0)
                     static var native: UISomething
                   #else
                     static var deprecated_native: UISomething
                   #endif
               #endif
             }
             struct Structure {
               #if canImport(AppKit)
                 #if swift(>=4.0)
                   static var native: NSSomething
                 #else
                   static var deprecated_native: NSSomething
                 #endif
               #else
                   #if swift(>=4.0)
                     static var native: UISomething
                   #else
                     var deprecated_native: UISomething
                   #endif
               #endif
             }
             """,
      expected: """
                enum A {
                  static func foo() {}
                }
                struct B {
                  var x: Int = 3
                  static func foo() {}
                  private init() {}
                }
                class C {
                  static func foo() {}
                }
                public final class D {
                  static func bar()
                }
                final class E {
                  static let a = 123
                }
                struct Structure {
                  #if canImport(AppKit)
                      var native: NSSomething
                  #elseif canImport(UIKit)
                      var native: UISomething
                  #endif
                }
                enum Structure {
                  #if canImport(AppKit)
                      static var native: NSSomething
                  #elseif canImport(UIKit)
                      static var native: UISomething
                  #endif
                }
                struct Structure {
                  #if canImport(AppKit)
                      var native: NSSomething
                  #elseif canImport(UIKit)
                      static var native: UISomething
                  #endif
                }
                enum Structure {
                  #if canImport(AppKit)
                      static var native: NSSomething
                  #else
                      static var native: UISomething
                  #endif
                }
                enum Structure {
                  #if canImport(AppKit)
                    #if swift(>=4.0)
                      static var native: NSSomething
                    #else
                      static var deprecated_native: NSSomething
                    #endif
                  #else
                      #if swift(>=4.0)
                        static var native: UISomething
                      #else
                        static var deprecated_native: UISomething
                      #endif
                  #endif
                }
                struct Structure {
                  #if canImport(AppKit)
                    #if swift(>=4.0)
                      static var native: NSSomething
                    #else
                      static var deprecated_native: NSSomething
                    #endif
                  #else
                      #if swift(>=4.0)
                        static var native: UISomething
                      #else
                        var deprecated_native: UISomething
                      #endif
                  #endif
                }
                """)
  }
}
