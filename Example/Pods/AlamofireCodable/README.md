
# AlamofireCodable

[![CI Status](http://img.shields.io/travis/wangchengqvan@gmail.com/AlamofireCodable.svg?style=flat)](https://travis-ci.org/wangchengqvan@gmail.com/AlamofireCodable)
[![Version](https://img.shields.io/cocoapods/v/AlamofireCodable.svg?style=flat)](http://cocoapods.org/pods/AlamofireCodable)
[![License](https://img.shields.io/cocoapods/l/AlamofireCodable.svg?style=flat)](http://cocoapods.org/pods/AlamofireCodable)
[![Platform](https://img.shields.io/cocoapods/p/AlamofireCodable.svg?style=flat)](http://cocoapods.org/pods/AlamofireCodable)

An extension to [Alamofire](https://github.com/Alamofire/Alamofire) which automatically converts JSON response data into swift objects using Codable. 
This project is heavily inspired by the popular[AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper). 

## Installation
AlamofireCodable can be added to your project using [CocoaPods](https://cocoapods.org/) by adding the following line to your Podfile:
```
pod 'AlamofireCodable'
```


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
Xcode 9+ , Swift 4+


## Usage

Given a URL which returns weather data in the following form:

```
{  
   "data":{  
      "location":"Toronto, Canada",
      "three_day_forecast":[  
         {  
            "conditions":"Partly cloudy",
            "day":"Monday",
            "temperature":20
         },
         {  
            "conditions":"Showers",
            "day":"Tuesday",
            "temperature":22
         },
         {  
            "conditions":"Sunny",
            "day":"Wednesday",
            "temperature":28
         }
      ]
   }
}
```

You can use the extension as the follows:

```swift
import AlamofireCodable

        let form = WeatherForm()
        Alamofire.request(
                form.url,
                method: HTTPMethod.get,
                parameters: form.parameters(),
                encoding: form.encoding(),
                headers: form.headers()
            )
            .responseObject(keyPath: "data",completionHandler: { (response: DataResponse<Weather>) in
                switch response.result {
                case .success(let object):
                    debugPrint("🌹", object.location)
                case .failure(let error):
                    debugPrint("🌹", error.localizedDescription)
                }
            })

```

The `Weather` object in the completion handler is a custom object which you define. The only requirement is that the object must conform to `Codable` protocol. In the above example, the `Weather` object looks like the following:


```swift
{  
   "data":{  
      "location":"Toronto, Canada",
      "three_day_forecast":[  
         {  
            "conditions":"Partly cloudy",
            "day":"Monday",
            "temperature":20
         },
         {  
            "conditions":"Showers",
            "day":"Tuesday",
            "temperature":22
         },
         {  
            "conditions":"Sunny",
            "day":"Wednesday",
            "temperature":28
         }
      ]
   }
}
```

The extension uses Generics to allow you to create your own custom response objects. Below is the `responseObject` function definition. Just replace `T` in the completionHandler with your custom response object and the extension handles the rest: 

```swift
public func responseObject<T: Codable>(queue: DispatchQueue? = nil, keyPath: String? = nil,  completionHandler: @escaping (DataResponse<T>) -> Void) -> Self 
```

The `responseObject` function has 2 optional parameters and a required completionHandler:
- `queue`: The queue on which the completion handler is dispatched.
- `keyPath`: The key path of the JSON where object mapping should be performed
- `completionHandler`: A closure to be executed once the request has finished and the data has been decoded by JSONDecoder.

### Easy decode of Nested Objects

AlamofireCodable supports dot notation within keys for easy mapping of nested objects. Given the following JSON String:

```json
{  
   "data":{  
      "location":"Toronto, Canada",
      "three_day_forecast":[  
         {  
            "conditions":"Partly cloudy",
            "day":"Monday",
            "temperature":20
         },
         {  
            "conditions":"Showers",
            "day":"Tuesday",
            "temperature":22
         },
         {  
            "conditions":"Sunny",
            "day":"Wednesday",
            "temperature":28
         }
      ]
   }
}
```
You can access the nested objects as follows:

```swift
      let form = WeatherForm()
        Alamofire.request(
            form.url,
            method: HTTPMethod.get,
            parameters: form.parameters(),
            encoding: form.encoding(),
            headers: form.headers()
            )
            .responseObject(completionHandler: { (response: DataResponse<RootModel>) in
                switch response.result {
                case .success(let root):
                    debugPrint("🌹", root)
                case .failure(let error):
                    debugPrint("🌹", error.localizedDescription)
                }
            })
```


### KeyPath

The `keyPath` variable is used to drill down into a JSON response and only map the data found at that `keyPath`. It supports nested values such as `data.three_day_forecast` to drill down several levels in a JSON response.

```swift
let form = WeatherForm()
        Alamofire.request(
                form.url,
                method: HTTPMethod.get,
                parameters: form.parameters(),
                encoding: form.encoding(),
                headers: form.headers()
            )
            .responseArray(keyPath: "data.three_day_forecast", completionHandler: { (response: DataResponse<[Forecast]>) in
                switch response.result {
                case .success(let array):
                    debugPrint("🌹", array)
                case .failure(let error):
                    debugPrint("🌹", error.localizedDescription)
                }
            })
```

## Array Responses
If you have an endpoint that returns data in `Array` form you can map it with the following function:

```swift
public func responseArray<T: Codable>(queue: DispatchQueue? = nil, keyPath: String? = nil, completionHandler: @escaping (DataResponse<[T]>) -> Void) -> Self 
```

For example, if your endpoint returns the following:

```
[
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
```

You can request and map it as follows:

```swift
        let form = WeatherForm()
        Alamofire.request(
                form.url,
                method: HTTPMethod.get,
                parameters: form.parameters(),
                encoding: form.encoding(),
                headers: form.headers()
            )
            .responseArray(keyPath: "data.three_day_forecast", completionHandler: { (response: DataResponse<[Forecast]>) in
                switch response.result {
                case .success(let array):
                    debugPrint("🌹", array)
                case .failure(let error):
                    debugPrint("🌹", error.localizedDescription)
                }
            })
```

## Author

wangchengqvan@gmail.com, chengquan.wang@ele.me

## License

AlamofireCodable is available under the MIT license. See the LICENSE file for more info.

