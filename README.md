# MBNetwork

[![CI Status](http://img.shields.io/travis/mmoaay/MBNetwork.svg?style=flat)](https://travis-ci.org/mmoaay/MBNetwork)
[![Version](https://img.shields.io/cocoapods/v/MBNetwork.svg?style=flat)](http://cocoapods.org/pods/MBNetwork)
[![License](https://img.shields.io/cocoapods/l/MBNetwork.svg?style=flat)](http://cocoapods.org/pods/MBNetwork)
[![Platform](https://img.shields.io/cocoapods/p/MBNetwork.svg?style=flat)](http://cocoapods.org/pods/MBNetwork)

## What is MBNetwork

`MBNetwork` is a network request framework based on `Alamofire` and `ObjectMapper`, aiming at making network request easier for business development. `MBNetwork` has made advantages of protocol-oriented programming and abstracted everything that relevant to network requests into protocol. Here is the protocol list: 

 - `MBRequestable`: Network request protocol, objects that conform to this protocol can make network requests.
 - `MBFormable`: Form protocol. Objects that conforms to this protocol can be used by the `request`, `download`, `upload` method in `MBRequestable` protocol.
   - `MBUploadFormable`: Upload Form protocol, Base protocol for upload request form.
     - `MBUploadStreamFormable`: Conforming to this protocol to create an upload form that contains a stream object.
     - `MBUploadDataFormable`: Conforming to this protocol to create an upload form that contains a data object.
     - `MBUploadFileFormable`: Conforming to this protocol to create an upload form that contains a file.
     - `MBUploadMultiFormDataFormable`: Conforming to this protocol to create an upload form that contains multiformdata.
   - `MBDownloadFormable`: Download Form protocol, Base protocol for download request form.
     - `MBDownloadResumeFormable`: Conforming to this protocol to create a download form that can resume a download task.
   - `MBRequestFormable`: Conforming to this protocol to create a request form.
 - `MBSerializable`: Protocol used for serializing JSON object.
 - `MBLoadable`: Protocol used for showing mask on specified container, such as add `UIActivityIndicatorView` on `UIViewcontroller`'s view when request begins, and remove it when request ends
   - `MBMaskable`: Mask protocol for `MBLoadable`, View that conforms to this protocol will be treated as mask.
   - `MBContainable`: Container protocol for `MBLoadable`, Objects conforms to this protocol can be used as container for the mask.
   - `MBLoadProgressable`: Progress protocol for request, Objects conforms to this protocol can get the progress of the requset.
 - `MBMessageable`: Message protocol.
   - `MBWarnable`: Warn protocol. Conforming to this protocol to show warning messages that occur from the request.
   - `MBInformable`: Inform protocol. Conforming to this protocol to show specified message when request done successfully
 - `MBErrorable`: Error protocol. It defines the key things that an error should have.
   - `MBServerErrorable`: Error protocol for the server. Conforming to this protocol to serialize error from the server.

## Features

 1. There is no need to inherit any object to get the features it has, so you can extension any features you want without changing the code of `MBNetwork` itself.
 2. We have **Default** extension for most of the protocol, so you can easily startup.
 3. And if you have special needs, extension or conform to it.
 4. The API was designed with the principles of `Alamofire`, So you can also extension it as `MBNetwork` already have done for you.
 5. Mainly focus on things between business development and `Alamofire`, not network request itself.

## How to use

### `MBRequestable`


``` swift
class LoadableViewController: UIViewController, MBRequestable {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        request(WeatherForm())
    }
}
```

### `MBFormable`


For business development, most of the reqeusts' headers are the same, so you can extension it only for once.

``` swift
extension MBFormable {
    public func headers() -> [String: String] {
        return ["accessToken":"xxx"];
    }
}

```
But also you can have extension for specified protocol

``` swift

extension MBFormable where Self : MBUploadFormable {
    public func headers() -> [String : String] {
        return ["accessToken":"xxx", "fileName":"xxx"];
    }
}
```

And for other parameters such as `url`, `method`, `parameters` etc. 
Each request will has it's own value, So we create an object and make it conforms to the protocol

``` swift
struct WeatherForm: MBRequestFormable {
    var city = "shanghai"
    
    public func parameters() -> [String: Any] {
        return ["city":city]
    }

    var url = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/2ee8f34d21e8febfdefb2b3a403f18a43818d70a/sample_keypath_json"
    var method = Alamofire.HTTPMethod.get
}
```

### `MBSerializable`

First, we create an object and make it conforms to the protocol, where the `dataNode` property stands for the JSON path of the data node. For example, the path of the data node of the following JSON object is **data**

``` JSON

{
    "data": {
        "location": "Toronto, Canada",    
        "three_day_forecast": [
            { 
                "conditions": "Partly cloudy",
                "day" : "Monday",
                "temperature": 20 
            },
            { 
                "conditions": "Showers",
                "day" : "Tuesday",
                "temperature": 22 
            },
            { 
                "conditions": "Sunny",
                "day" : "Wednesday",
                "temperature": 28 
            }
        ]
    }
}
```

``` swift
struct BaseSerialize: MBSerializable {
    var dataNode: String? = "data"
}
```

Then, we pass it to the `responseObject` method of the `DataRequest` object 

``` swift
request(WeatherForm()).responseObject(serialize: BaseSerialize()) { (response:DataResponse<WeatherResponse>) in
            // repsonse is a WeatherResponse object.
        }
```

> Notice: `WeatherResponse` object conforms to `Mappable` protocol of [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper/), you can learn how to use it from the github page of it.

### `MBLoadable`

We've already have **Default** extension for this protocol.

#### `MBMaskable`

#### `MBContainable`

#### `MBLoadProgressable`

### `MBMessageable`

#### `MBWarnable`

#### `MBInformable`

### `MBErrorable`

#### `MBServerErrorable`

## Bonus

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
