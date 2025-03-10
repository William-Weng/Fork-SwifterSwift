// LocaleExtensions.swift - Copyright 2025 SwifterSwift

#if canImport(Foundation)
import Foundation

// MARK: - Properties

public extension Locale {
    /// SwifterSwift: UNIX representation of locale usually used for normalizing.
    static var posix: Locale {
        return Locale(identifier: "en_US_POSIX")
    }

    /// SwifterSwift: Returns bool value indicating if locale has 12h format.
    var is12HourTimeFormat: Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        dateFormatter.locale = self
        let dateString = dateFormatter.string(from: Date())
        return dateString.contains(dateFormatter.amSymbol) || dateString.contains(dateFormatter.pmSymbol)
    }
}

// MARK: - Functions

public extension Locale {
    /// SwifterSwift: Get the flag emoji for a given country region code.
    /// - Parameter isoRegionCode: The IOS region code.
    ///
    /// Adapted from https://stackoverflow.com/a/30403199/1627511
    /// - Returns: A flag emoji string for the given region code (optional).
    static func flagEmoji(forRegionCode isoRegionCode: String) -> String? {
        if #available(macOS 13, iOS 16, tvOS 16, watchOS 9, *) {
            guard Locale.Region.isoRegions.contains(where: { $0.identifier == isoRegionCode }) else { return nil }
        } else {
            guard isoRegionCodes.contains(isoRegionCode) else { return nil }
        }

        return isoRegionCode.unicodeScalars.reduce(into: String()) {
            guard let flagScalar = UnicodeScalar(UInt32(127_397) + $1.value) else { return }
            $0.unicodeScalars.append(flagScalar)
        }
    }
}

#endif
