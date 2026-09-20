/// Schema for a 'basicIteration' event, which can be extended or referenced for specific actions.
struct StoretoolsProductIconEvent {
    static let eventType = "basicIteration"

    func getBody() -> [String: Any] {
        return [
            "product_id": productID.rawValue,
            "product_name": "store_tools",
            "content_category": contentCategory,
            "content_title": contentTitle,
            "element_identifier": "icon_button",
            "element_name": "placeholder",
            "element_type": "icon",
            "event_name": "icon_tap",
            "event_type": "tap",
            "event_version": "1.0",
            "extra_params": extraParams?.toDict(),
            "location": location,
            "location_parameters": locationParameters,
            "next_location": nextLocation,
            "previous_location": previousLocation,
            "trigger_reason": triggerReason
        ]
    }

    var productID: ProductIDEnum
    var contentCategory: String? = nil
    var contentTitle: String? = nil
    var extraParams: ExtraParams? = nil
    var location: String
    var locationParameters: String? = nil
    var nextLocation: String? = nil
    var previousLocation: String? = nil
    var triggerReason: String? = nil
}

enum ProductIDEnum: String, Codable {
    case the00001 = "00001"
    case the00002 = "00002"
    case the00003 = "00003"
}

struct ExtraParams: Codable {
    var coupons: Coupons? = nil
    var elementID: String
    var relatedProduct: String
}

extension ExtraParams {
    func toDict() -> [String: Any] {
        return [
            "coupons": coupons,
            "element_id": elementID,
            "related_product": relatedProduct
        ]
    }
}

struct Coupons: Codable {
    var couponID: String? = nil
    var couponName: String? = nil
    var invent: Invent? = nil
}

extension Coupons {
    func toDict() -> [String: Any] {
        return [
            "coupon_id": couponID,
            "coupon_name": couponName,
            "invent": invent
        ]
    }
}

struct Invent: Codable {
    var inventAaaaaa: Double? = nil
    var inventDFD: String? = nil
}

extension Invent {
    func toDict() -> [String: Any] {
        return [
            "invent_aaaaaa": inventAaaaaa,
            "invent_dfd": inventDFD
        ]
    }
}

