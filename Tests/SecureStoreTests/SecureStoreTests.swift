    import XCTest
    @testable import SecureStore

    final class SecureStoreTests: XCTestCase {
        var secureStoreWithGenericPwd: SecureStore!
        var secureStoreWithInternetPwd: SecureStore!
        
        override func setUp() {
          super.setUp()
          
          let genericPwdQueryable = GenericPasswordQueryable(service: "MyService",accessGroup: "com.ATMasoumi.LiliumPFM")
          secureStoreWithGenericPwd = SecureStore(secureStoreQueryable: genericPwdQueryable)
            
          
          let internetPwdQueryable = InternetPasswordQueryable(server: "someServer",
                                                               port: 8080,
                                                               path: "somePath",
                                                               securityDomain: "someDomain",
                                                               internetProtocol: .https,
                                                               internetAuthenticationType: .httpBasic)
          secureStoreWithInternetPwd = SecureStore(secureStoreQueryable: internetPwdQueryable)
        }
        override func tearDown() {
          try? secureStoreWithGenericPwd.removeAllValues()
          try? secureStoreWithInternetPwd.removeAllValues()

          super.tearDown()
        }
        func testReadGenericPassword() {
          do {
            try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
            let password = try secureStoreWithGenericPwd.getValue(for: "genericPassword")
            XCTAssertEqual("pwd_1234", password)
          } catch (let e) {
            XCTFail("Reading generic password failed with \(e.localizedDescription).")
          }
        }
    }
