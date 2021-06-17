import XCTest
import Nimble
@testable import SwiftBleRpc

/// Proto parser tests (decoding/encoding proto messages).
class ProtoParserTests: XCTestCase {

    func testDecodeInt1Byte() throws {
        let decoded = try ProtoDecoder.decode(data: Data.init(hex: "AA7BAA"), from: 1, to: 2, type: .int32) as? Int32
        expect(decoded).to(equal(123))
    }

    func testDecodeInt2Bytes() throws {
        let decoded = try ProtoDecoder.decode(data: Data.init(hex: "AA7B45AA"), from: 1, to: 3, type: .int32) as? Int32
        expect(decoded).to(equal(17787))
    }

    func testDecodeInt4Bytes() throws {
        let decoded = try ProtoDecoder.decode(data: Data.init(hex: "AA7B45D4E6AA"), from: 1, to: 5, type: .int32) as? Int32
        expect(decoded).to(equal(-422296197))
    }

    func testDecodeInt3Bytes() throws {
        let decoded = try ProtoDecoder.decode(data: Data.init(hex: "AA7B4511"), from: 1, to: 4, type: .int32) as? Int32
        expect(decoded).to(equal(286344571))
    }

    func testDecodeIntMoreThan4BytesFails() throws {
        expect { try ProtoDecoder.decode(data: Data.init(hex: "AA7B45D4E6AA"), from: 0, to: 5, type: .int32) as? Int32 }.to(throwError(ProtoParserErrors.wrongData))
    }

    func testDecodeBoolFalse() throws {
        let decoded = try ProtoDecoder.decode(data: Data.init(hex: "AA00AA"), from: 1, to: 2, type: .bool) as? Bool
        expect(decoded).to(equal(false))
    }

    func testDecodeBoolTrue() throws {
        let decoded = try ProtoDecoder.decode(data: Data.init(hex: "AA01AA"), from: 1, to: 2, type: .bool) as? Bool
        expect(decoded).to(equal(true))
    }

    func testDecodeBoolWrongSize() throws {
        expect { try ProtoDecoder.decode(data: Data.init(hex: "AA01AA"), from: 0, to: 2, type: .bool) as? Bool }.to(throwError(ProtoParserErrors.wrongData))
    }

    func testDecodeBytes() throws {
        let data = Data.init(hex: "AA3617254BAA")
        let decoded = try ProtoDecoder.decode(data: data, from: 1, to: 5, type: .byte) as? Data
        expect(decoded).to(equal(Data.init(hex: "3617254B")))
    }

    func testDecodeWrongSize() throws {
        expect { try ProtoDecoder.decode(data: Data.init(hex: "36172540"), from: 0, to: 10, type: .byte) as? Data }.to(throwError(ProtoParserErrors.wrongData))
    }

    func testDecodeNilType() {
        expect { try ProtoDecoder.decode(data: Data.init(hex: "7BAAAAAA"), from: 0, to: 4, type: nil) as? Int32 }.to(throwError(ProtoParserErrors.notSupportedType))
    }

    func testDecodeWrongType() {
        expect { try ProtoDecoder.decode(data: Data.init(hex: "7BAAAAAA"), from: 0, to: 4, type: .unknown) as? Int32 }.to(throwError(ProtoParserErrors.notSupportedType))
    }
}
