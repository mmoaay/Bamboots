# MBNetwork

[![CI Status](http://img.shields.io/travis/mmoaay/MBNetwork.svg?style=flat)](https://travis-ci.org/mmoaay/MBNetwork)
[![Version](https://img.shields.io/cocoapods/v/MBNetwork.svg?style=flat)](http://cocoapods.org/pods/MBNetwork)
[![License](https://img.shields.io/cocoapods/l/MBNetwork.svg?style=flat)](http://cocoapods.org/pods/MBNetwork)
[![Platform](https://img.shields.io/cocoapods/p/MBNetwork.svg?style=flat)](http://cocoapods.org/pods/MBNetwork)

## 简介

`MBNetwork` 是基于 `Alamofire` 和 `ObjectMapper` 实现，面向业务层的网络请求库。`MBNetwork` 的设计主要采用了 `POP` 的思想，将网络请求时涉及的各个环节和对象都抽象成协议。下面是目前已经包含的协议列表：

 - `MBRequestable`：网络请求协议。满足该协议可以进行网络请求。
 - `MBFormable`：Form表单协议。实现该协议可以将 `Object` 转换成可以供 `Alamofire` 使用请求参数。
 - `MBLoadable`： 加载协议。
   - `MBMaskable`：加载遮罩协议。
   - `MBContainable`：加载容器协议。
   - `MBLoadProgressable`：加载进度协议。
 - `MBAlertable`：告警协议。
   - `MBErrorConfigurable`：错误配置协议。
   - `MBErrorSerializable`：错误解析协议。

## 特点

 1. 相比 `OOP`，使用者不需要再采用继承基类的方法去获得相应功能，无侵入性。
 2. 部分协议已经进行了默认实现，可以快速上手。
 3. 如果需要定制，对协议进行重新实现即可。
 4. 遵循 `Alamofire` 的 API 设计，使用者可以对数据解析部分进行自定义，从而支持 `JSON` 以外的数据格式解析。

## 用法

### `MBRequestable`

满足 `MBRequestable` 协议的类即可进行网络请求。

``` swift
class LoadableViewController: UIViewController, MBRequestable {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        request(WeatherForm(), load:MBLoadType.default(container: view))
    }
}
```

### `MBFormable`

一般来说网络请求头全局都是一致的，可以按照如下的方式进行实现：

``` swift
extension MBFormable {
    public func headers() -> [String: String] {
        return ["accessToken":"xxx"];
    }
}
```

具体的请求表单按照如下的方式进行实现：

``` swift
struct WeatherForm: MBFormable {
    var city = "shanghai"
    
    public func parameters() -> [String: Any] {
        return ["city":city]
    }

    var url = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/2ee8f34d21e8febfdefb2b3a403f18a43818d70a/sample_keypath_json"
    var method = Alamofire.HTTPMethod.get
}
```

### `MBLoadable`

该协议的主要解决网络请求时需要遮罩的问题。

#### `MBMaskable`

#### `MBContainable`

#### `MBLoadProgressable`

### `MBAlertable`

#### `MBErrorConfigurable`

#### `MBErrorSerializable`

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

 - [Alamofire](https://github.com/Alamofire/Alamofire)
 - [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper/)
 - [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper)

## Installation

MBNetwork is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MBNetwork"
```

## Author

mmoaay, mmoaay@sina.com

## License

MBNetwork is available under the MIT license. See the LICENSE file for more info.
