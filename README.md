# MBNetwork

[![CI Status](http://img.shields.io/travis/mmoaay/MBNetwork.svg?style=flat)](https://travis-ci.org/mmoaay/MBNetwork)
[![Version](https://img.shields.io/cocoapods/v/MBNetwork.svg?style=flat)](http://cocoapods.org/pods/MBNetwork)
[![License](https://img.shields.io/cocoapods/l/MBNetwork.svg?style=flat)](http://cocoapods.org/pods/MBNetwork)
[![Platform](https://img.shields.io/cocoapods/p/MBNetwork.svg?style=flat)](http://cocoapods.org/pods/MBNetwork)


**MBNetwork** is a network request framework based on [Alamofire](https://github.com/Alamofire/Alamofire) and [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper/), aiming at making network request easier for business development. 

- [Protocols](#protocols)
- [Features](#features)
- [Requirements](#requirements)
- [Usage](#usage)
- [Chained calls](#chained-calls)
- [Bonus](#bonus)
- [Example](#example)
- [Installation](#installation)
- [Usage](#usage)
- [Author](#author)
- [License](#license)

## Protocols

**MBNetwork** has made advantages of protocol-oriented programming and abstracted everything that relevant to network request into protocol. Here is the protocol list: 

 - `MBRequestable`: Network request protocol, object conforms to this protocol can make network request.
 - `MBFormable`: Form protocol. Object conforms to this protocol can be used by the `request`, `download`, `upload` method in `MBRequestable` protocol.
   - `MBUploadFormable`: Upload Form protocol, Base protocol for upload request form.
     - `MBUploadStreamFormable`: Conforming to this protocol to create an upload form that contains a stream object.
     - `MBUploadDataFormable`: Conforming to this protocol to create an upload form that contains a data object.
     - `MBUploadFileFormable`: Conforming to this protocol to create an upload form that contains a file.
     - `MBUploadMultiFormDataFormable`: Conforming to this protocol to create an upload form that contains multiformdata.
   - `MBDownloadFormable`: Download Form protocol, Base protocol for download request form.
     - `MBDownloadResumeFormable`: Conforming to this protocol to create a download form that can resume a download task.
   - `MBRequestFormable`: Conforming to this protocol to create a request form.
 - `MBLoadable`: Protocol used for showing mask on specified container when requesting (such as add `UIActivityIndicatorView` on `UIViewcontroller`'s view when request begins, and remove it when request ends). Object conforms to this protocol can be used by `load` method of `DataRequest`.
   - `MBMaskable`: Mask protocol for `MBLoadable`, View that conforms to this protocol will be treated as mask.
   - `MBContainable`: Container protocol for `MBLoadable`, Objects conforms to this protocol can be used as container for the mask.
   - `MBProgressable`: Progress protocol for request, Objects conforms to this protocol can get the progress of the request. Object conforms to this protocol can be used by `progress` method of `DataRequest`.
 - `MBMessageable`: Message protocol.
   - `MBWarnable`: Warn protocol. Conforming to this protocol to customize the way of warning messages displayed when error occured.
   - `MBInformable`: Inform protocol. Conforming to this protocol to customize the way of inform messages displayed when request done successfully
 - `MBErrorable`: Error protocol. Conforming to this protocol to customize the error config info.
   - `MBJSONErrorable`: Error protocol for the server. Conforming to this protocol to customize the error config info from the server.

Mostly you don't need to care much about these protocols, because we already have many **DEFAULT** implementations for them. However if you want to customize something, you just need to conform to these protocols and do what you want. Here is some default implementations for there protcols:

- `MBLoadType`: Enum that conforms to `MBLoadable` protocol, using `case default(container:MBContainable)` case to show `MBMaskView` on the container when requesting.
- `MBMessageType`: Enum that conforms to `MBMessageable` protocol, using `alertController(title: String, message: String? , actions: [UIAlertAction], container: MBContainable)` case to show alertController.
- `UIButton+MBLoadable`: With this extension, you can pass a button directly into the `load` method of `DataRequest`. 
- `UITableViewCell+MBLoadable`: With this extension, you can pass a cell directly into the `load` method of `DataRequest`.
- `UIRefreshControl+MBLoadable`: With this extension, you can pass a UIRefreshControl directly into the `load` method of `DataRequest`.
- `UIProgressView+MBProgressable`: With this extension, you can pass a UIProgressView directly into the `progress` method of `DataRequest`.
- `UIScrollView+MBContainable`: Extending UIScrollView to conform to `MBContainable` protocol.
- `UITableViewCell+MBContainable`: Extending UITableViewCell to conform to `MBContainable` protocol.
- `UIViewController+MBContainable`: Extending UIViewController to conform to `MBContainable` protocol.
- `MBActivityIndicator`: Default mask for UITableViewCell and UIButton
- `MBMaskView`: Default mask for other.

## Features

 1. There is no need to inherit any object to get the features it has, and you can extend any features you want without changing the code of **MBNetwork** itself.
 2. We have **Default** extension for most of the protocol, so you can easily startup.
 3. And if you have special needs, extend or conform to it.
 4. The API was designed with the principles of Alamofire, So you can also extend it as **MBNetwork** already have done for you.
 5. Mainly focus on things between business development and Alamofire, not network request itself.

## Requirements

 - [Alamofire](https://github.com/Alamofire/Alamofire): Elegant HTTP Networking in Swift
 - [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper/): Simple JSON Object mapping written in Swift
 - [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper): An Alamofire extension which converts JSON response data into swift objects using ObjectMapper

## Usage

### Create a form

For business development, most of the reqeusts' headers are the same, so you can extend it only for once.

``` swift
extension MBFormable {
    public func headers() -> [String: String] {
        return ["accessToken":"xxx"];
    }
}

```
And you can also have extension for specified protocol

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

### Make a request

All you have to do is conforming to `MBRequestable` protocol, in this protocol, we've already implement some methods for you: 

- `func request(_ form: MBRequestFormable) -> DataRequest`
- `func download(_ form: MBDownloadFormable) -> DownloadRequest`
- `func download(_ form: MBDownloadResumeFormable) -> DownloadRequest`
- `func upload(_ form: MBUploadDataFormable) -> UploadRequest`
- `func upload(_ form: MBUploadFileFormable) -> UploadRequest`
- `func upload(_ form: MBUploadStreamFormable) -> UploadRequest`
- `func upload(_ form: MBUploadMultiFormDataFormable, completion: ((UploadRequest) -> Void)?)`

Here is the usage of request method: 

``` swift
class LoadableViewController: UIViewController, MBRequestable {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        request(WeatherForm())
    }
}
```

### Show mask when requesting

We have extended `DataRequest` class of Alamofire and added a `load` method to it.

``` swift
func load(load: MBLoadable = MBLoadType.none) -> Self
```

#### Show mask on UIViewController

![](https://github.com/mmoaay/MBNetwork/blob/master/Demo/mbnetwork_loadable_uiviewcontroller.gif)

``` swift
request(WeatherForm()).load(load:MBLoadType.default(container: view))
```

#### Show mask on UINavigationController

![](https://github.com/mmoaay/MBNetwork/blob/master/Demo/mbnetwork_loadable_uinavigationcontroller.gif)

``` swift
request(WeatherForm()).load(load: MBLoadType.default(container: navigationController!.view))
```

#### Show mask on UIButton

![](https://github.com/mmoaay/MBNetwork/blob/master/Demo/mbnetwork_loadable_button.gif)

``` swift
request(WeatherForm()).load(load: button)
```

#### Show customized mask

![](https://github.com/mmoaay/MBNetwork/blob/master/Demo/mbnetwork_loadable_customized.gif)

Firstly, we create a `LoadConfig` class conforms to `MBLoadable` protocol.

``` swift
class LoadConfig: MBLoadable {
    init(container: MBContainable? = nil, mask: MBMaskable? = MBMaskView(), inset: UIEdgeInsets = UIEdgeInsets.zero) {
        insetMine = inset
        maskMine = mask
        containerMine = container
    }
    
    func mask() -> MBMaskable? {
        return maskMine
    }
    
    func inset() -> UIEdgeInsets {
        return insetMine
    }
    
    func maskContainer() -> MBContainable? {
        return containerMine
    }
    
    func begin() {
        show()
    }
    
    func end() {
        hide()
    }
    
    var insetMine: UIEdgeInsets
    var maskMine: MBMaskable?
    var containerMine: MBContainable?
}
```

Then we can use it as followed:


``` swift
let load = LoadConfig(container: view, mask:MBEyeLoading(), inset: UIEdgeInsetsMake(30+64, 15, UIScreen.main.bounds.height-64-(44*4+30+15*3), 15))
request(WeatherForm()).load(load:load)
```

This is the most powful usage of the `MBLoadable` protocol. In this way you can customized everything the `MBLoadable` protocol has.

#### Show mask on UITableView & UIScrollView

![](https://github.com/mmoaay/MBNetwork/blob/master/Demo/mbnetwork_loadable_uiscrollview.gif)

``` swift

let load = LoadConfig(container:self.tableView, mask: MBActivityIndicator(), inset: UIEdgeInsetsMake(UIScreen.main.bounds.width - self.tableView.contentOffset.y > 0 ? UIScreen.main.bounds.width - self.tableView.contentOffset.y : 0, 0, 0, 0))
request(WeatherForm()).load(load: load)
        
```

#### Show mask on UITableViewCell (PS: Still in development)

![](https://github.com/mmoaay/MBNetwork/blob/master/Demo/mbnetwork_loadable_cell.gif)

``` swift
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView .deselectRow(at: indexPath, animated: false)
    let cell = tableView.cellForRow(at: indexPath)
    request(WeatherForm()).load(load: cell!)
}
```

### Show progress when requesting

We have extended `DownloadRequest` and `UploadRequest` class of Alamofire and added a `progress` method to it.

``` swift
func progress(progress: MBProgressable) -> Self
```

And then we can use it as followed:

![](https://github.com/mmoaay/MBNetwork/blob/master/Demo/mbnetwork_progressable.gif)

``` swift
download(ImageDownloadForm()).progress(progress: progress)
```

### Show warning message if fail

We have extended `DataRequest` class of Alamofire and added a `warn` method to it.

``` swift
func warn<T: MBJSONErrorable>(error: T, warn: MBWarnable = MBMessageType.none, completionHandler: ((MBJSONErrorable) -> Void)? = nil) -> Self
```

And then we can use it as followed:

![](https://github.com/mmoaay/MBNetwork/blob/master/Demo/mbnetwork_warnable.gif)

``` swift
request(WeatherForm()).warn(error: WeatherError(), warn: MBMessageType.alertController(title: "Warning", message: "Network unavailable", actions: [UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)], container: self))
```


### Show inform message if success

We have extended `DataRequest` class of Alamofire and added a `inform` method to it.

``` swift
func inform<T: MBJSONErrorable>(error: T, inform: MBInformable = MBMessageType.none) -> Self
```

And then we can use it as followed:

![](https://github.com/mmoaay/MBNetwork/blob/master/Demo/mbnetwork_informable.gif)

``` swift
request(WeatherForm()).inform(error: WeatherInformError(), inform: MBMessageType.alertController(title: "Notice", message: "Load successfully", actions: [UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)], container: self))
```

### JSON to Object

```swift
request(WeatherForm()).responseObject(keyPath: "data") { (response: DataResponse<WeatherResponse>) in
    if let value = response.result.value {
        self.weatherResponse = value
        self.tableView.reloadData()
    }
}

```

For more information, see [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper).

## Chained calls

All the method mentioned above can be called in a chained manner, such as followed:

```swift
let load = LoadConfig(container: view, mask:MBEyeLoading(), inset: UIEdgeInsetsMake(30+64, 15, UIScreen.main.bounds.height-64-(44*4+30+15*3), 15))
request(WeatherForm()).load(load:load).progress(progress: progress).warn(error: WeatherError(), warn: MBMessageType.alertController(title: "Warning", message: "Network unavailable", actions: [UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)], container: self)).inform(error: WeatherInformError(), inform: MBMessageType.alertController(title: "Notice", message: "Load successfully", actions: [UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)], container: self))
```

## Bonus

### `MBEyeloading`



You can check the file `MBEyeloading` in example project.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

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
