![Bamboots: Extension 4 Alamofire](https://github.com/mmoaay/Bamboots/blob/master/Demo/bamboots_banner.png)

[![CI Status](http://img.shields.io/travis/mmoaay/Bamboots.svg?style=flat)](https://travis-ci.org/mmoaay/Bamboots)
[![Version](https://img.shields.io/cocoapods/v/Bamboots.svg?style=flat)](http://cocoapods.org/pods/Bamboots)
[![Platform](https://img.shields.io/cocoapods/p/Bamboots.svg?style=flat)](http://cocoapods.org/pods/Bamboots)
[![Language](https://img.shields.io/badge/language-swift-orange.svg)](https://github.com/apple/swift)
[![License](https://img.shields.io/cocoapods/l/Bamboots.svg?style=flat)](http://cocoapods.org/pods/Bamboots)
[![Gitter](https://img.shields.io/gitter/room/Bamboots/Bamboots.svg)](https://gitter.im/Bamboots-Gitter/Lobby)
[![Weibo](https://img.shields.io/badge/weibo-@mmoaay-red.svg?style=flat)](https://weibo.com/smmoaay)
![\<3](https://img.shields.io/badge/made%20with-%3C3-orange.svg)

**Bamboots** is a network request framework based on [Alamofire](https://github.com/Alamofire/Alamofire) , aiming at making network request easier for business development.

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

**Bamboots** has made advantages of protocol-oriented programming and abstracted everything that relevant to network request into protocol. Here is the protocol list: 

 - `Requestable`: Network request protocol, object conforms to this protocol can make network request.
 - `Formable`: Form protocol. Object conforms to this protocol can be used by the `request`, `download`, `upload` method in `Requestable` protocol.
   - `UploadFormable`: Upload Form protocol, Base protocol for upload request form.
     - `UploadStreamFormable`: Conforming to this protocol to create an upload form that contains a stream object.
     - `UploadDataFormable`: Conforming to this protocol to create an upload form that contains a data object.
     - `UploadFileFormable`: Conforming to this protocol to create an upload form that contains a file.
     - `UploadMultiFormDataFormable`: Conforming to this protocol to create an upload form that contains multiformdata.
   - `DownloadFormable`: Download Form protocol, Base protocol for download request form.
     - `DownloadResumeFormable`: Conforming to this protocol to create a download form that can resume a download task.
   - `RequestFormable`: Conforming to this protocol to create a request form.
 - `Loadable`: Protocol used for showing mask on specified container when requesting (such as add `UIActivityIndicatorView` on `UIViewcontroller`'s view when request begins, and remove it when request ends). Object conforms to this protocol can be used by `load` method of `DataRequest`.
   - `Maskable`: Mask protocol for `Loadable`, View that conforms to this protocol will be treated as mask.
   - `Containable`: Container protocol for `Loadable`, Objects conforms to this protocol can be used as container for the mask.
   - `Progressable`: Progress protocol for request, Objects conforms to this protocol can get the progress of the request. Object conforms to this protocol can be used by `progress` method of `DataRequest`.
 - `Messageable`: Message protocol.
   - `Warnable`: Warn protocol. Conforming to this protocol to customize the way of warning messages displayed when error occured.
   - `Informable`: Inform protocol. Conforming to this protocol to customize the way of inform messages displayed when request done successfully
 - `Errorable`: Error protocol. Conforming to this protocol to customize the error configuration.
   - `JSONErrorable`: Error protocol for JSON data. Conforming to this protocol to customize the error configuration for JSON data.

Mostly you don't need to care much about these protocols, because we already have many **DEFAULT** implementations for them. However if you want to customize something, you just need to conform to these protocols and do what you want. Here is some default implementations for these protcols:

- `LoadType`: Enum that conforms to `Loadable` protocol, using `case default(container:Containable)` case to show `MaskView` on the container when requesting.
- `UIAlertController+Messageable`: With this extension, you can pass a UIAlertController directly into the `warn` and `inform` method of `DataRequest`. 
- `UIButton+Loadable`: With this extension, you can pass a button directly into the `load` method of `DataRequest`. 
- `UITableViewCell+Loadable`: With this extension, you can pass a cell directly into the `load` method of `DataRequest`.
- `UIRefreshControl+Loadable`: With this extension, you can pass a UIRefreshControl directly into the `load` method of `DataRequest`.
- `UIProgressView+Progressable`: With this extension, you can pass a UIProgressView directly into the `progress` method of `DataRequest`.
- `UIScrollView+Containable`: Extending UIScrollView to conform to `Containable` protocol.
- `UITableViewCell+Containable`: Extending UITableViewCell to conform to `Containable` protocol.
- `UIViewController+Containable`: Extending UIViewController to conform to `Containable` protocol.
- `ActivityIndicator`: Default mask for UITableViewCell and UIButton
- `MaskView`: Default mask for others.

## Features

 1. There is no need to inherit any object to get the features it has, and you can extend any features you want without changing the code of **Bamboots** itself.
 2. We have **Default** extension for most of the protocol, so you can easily startup.
 3. And if you have special needs, extend or conform to it.
 4. The API was designed with the principles of Alamofire, So you can also extend it as **Bamboots** already have done for you.
 5. Mainly focus on things between business development and Alamofire, not network request itself.

## Requirements

 - [Alamofire](https://github.com/Alamofire/Alamofire): Elegant HTTP Networking in Swift
 - [AlamofireCodable](https://github.com/CNKCQ/AlamofireCodable): An Alamofire extension which converts JSON response data into swift objects using Codable

## Usage

### Create a form

For business development, most of the requests' headers are the same, so you can extend it only for once.

``` swift
extension Formable {
    public func headers() -> [String: String] {
        return ["accessToken":"xxx"];
    }
}

```
And you can also have extension for specified protocol

``` swift

extension Formable where Self: UploadFormable {
    public func headers() -> [String: String] {
        return ["accessToken":"xxx", "file":"xxx"];
    }
}
```

And for other parameters such as `url`, `method`, `parameters` etc. 
Each request will has it's own value, So we create an object and make it conforms to the protocol

``` swift
struct WeatherForm: RequestFormable {
    var city = "shanghai"
    
    public func parameters() -> [String: Any] {
        return ["city": city]
    }

    var url = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/2ee8f34d21e8febfdefb2b3a403f18a43818d70a/sample_keypath_json"
    var method = Alamofire.HTTPMethod.get
}
```

### Make a request

All you have to do is conforming to `Requestable` protocol, in this protocol, we've already implement some methods for you: 

- `func request(_ form: RequestFormable) -> DataRequest`
- `func download(_ form: DownloadFormable) -> DownloadRequest`
- `func download(_ form: DownloadResumeFormable) -> DownloadRequest`
- `func upload(_ form: UploadDataFormable) -> UploadRequest`
- `func upload(_ form: UploadFileFormable) -> UploadRequest`
- `func upload(_ form: UploadStreamFormable) -> UploadRequest`
- `func upload(_ form: UploadMultiFormDataFormable, completion: ((UploadRequest) -> Void)?)`

Here is the usage of request method: 

``` swift
class LoadableViewController: UIViewController, Requestable {
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
func load(load: Loadable = LoadType.none) -> Self
```

#### Show mask on `UIViewController`

![](https://github.com/mmoaay/Bamboots/blob/master/Demo/bamboots_loadable_uiviewcontroller.gif)

``` swift
request(WeatherForm()).load(load: LoadType.default(container: self))
```

#### Show mask on `UIButton`

![](https://github.com/mmoaay/Bamboots/blob/master/Demo/bamboots_loadable_button.gif)

``` swift
request(WeatherForm()).load(load: button)
```

> **Notice**: The color of `UIActivityIndicatorView` is the `tintColor` of `UIButton `

#### Show customized mask

![](https://github.com/mmoaay/Bamboots/blob/master/Demo/bamboots_loadable_customized.gif)

Firstly, we create a `LoadConfig` class conforms to `Loadable` protocol.

``` swift
class LoadConfig: Loadable {
    init(container: Containable? = nil, mask: Maskable? = MaskView(), inset: UIEdgeInsets = UIEdgeInsets.zero) {
        insetMine = inset
        maskMine = mask
        containerMine = container
    }
    
    func mask() -> Maskable? {
        return maskMine
    }
    
    func inset() -> UIEdgeInsets {
        return insetMine
    }
    
    func maskContainer() -> Containable? {
        return containerMine
    }
    
    func begin() {
        show()
    }
    
    func end() {
        hide()
    }
    
    var insetMine: UIEdgeInsets
    var maskMine: Maskable?
    var containerMine: Containable?
}
```

Then we can use it as followed:


``` swift
let load = LoadConfig(container: view, mask:EyeLoading(), inset: UIEdgeInsetsMake(30+64, 15, UIScreen.main.bounds.height-64-(44*4+30+15*3), 15))
request(WeatherForm()).load(load: load)
```

This is the most powerful usage of the `Loadable` protocol. In this way you can customized everything the `Loadable` protocol has.

#### Show mask on `UITableView` & `UIScrollView`

![](https://github.com/mmoaay/Bamboots/blob/master/Demo/bamboots_loadable_uiscrollview.gif)

``` swift

let load = LoadConfig(container:self.tableView, mask: ActivityIndicator(), inset: UIEdgeInsetsMake(UIScreen.main.bounds.width - self.tableView.contentOffset.y > 0 ? UIScreen.main.bounds.width - self.tableView.contentOffset.y : 0, 0, 0, 0))
request(WeatherForm()).load(load: load)
        
```

#### Show mask on `UITableViewCell` (PS: Still in development)

![](https://github.com/mmoaay/Bamboots/blob/master/Demo/bamboots_loadable_cell.gif)

``` swift
refresh.attributedTitle = NSAttributedString(string: "Loadable UIRefreshControl")
refresh.addTarget(self, action: #selector(LoadableTableViewController.refresh(refresh:)), for: .valueChanged)
tableView.addSubview(refresh)
     
func refresh(refresh: UIRefreshControl) {
    request(WeatherForm()).load(load: refresh)
}
```

### Loadable `UIRefreshControl`

![](https://github.com/mmoaay/Bamboots/blob/master/Demo/bamboots_loadable_refresh.gif)

``` swift
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView .deselectRow(at: indexPath, animated: false)
    let cell = tableView.cellForRow(at: indexPath)
    request(WeatherForm()).load(load: cell!)
}
```

We can also support other refresh control such as `MJRefresh`.

### Show progress when requesting

We have extended `DownloadRequest` and `UploadRequest` class of Alamofire and added a `progress` method to it.

``` swift
func progress(progress: Progressable) -> Self
```

And then we can use it as followed:

![](https://github.com/mmoaay/Bamboots/blob/master/Demo/bamboots_progressable.gif)

``` swift
download(ImageDownloadForm()).progress(progress: progress)
```

### Show warning message if fail

We have extended `DataRequest` class of Alamofire and added a `warn` method to it.

``` swift
func warn<T: JSONErrorable>(error: T, warn: Warnable, completionHandler: ((JSONErrorable) -> Void)? = nil) -> Self
```

And then we can use it as followed:

![](https://github.com/mmoaay/Bamboots/blob/master/Demo/bamboots_warnable.gif)

``` swift
let alert = UIAlertController(title: "Warning", message: "Network unavailable", preferredStyle: .alert)
alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
        
request(WeatherForm()).warn(
    error: WeatherError(),
    warn: alert
)
```

> **Notice**: We only have `warn` for JSON format response now.

### Show inform message if success

We have extended `DataRequest` class of Alamofire and added a `inform` method to it.

``` swift
func inform<T: JSONErrorable>(error: T, inform: Informable) -> Self
```

And then we can use it as followed:

![](https://github.com/mmoaay/Bamboots/blob/master/Demo/bamboots_informable.gif)

``` swift
let alert = UIAlertController(title: "Notice", message: "Load successfully", preferredStyle: .alert)
alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
request(WeatherForm()).inform(
    error: WeatherInformError(),
    inform: alert
)
```

> **Notice**: We only have `inform ` for JSON format response now.

### JSON to Object

```swift
request(WeatherForm()).responseObject(keyPath: "data") { (response: DataResponse<WeatherResponse>) in
    if let value = response.result.value {
        self.weatherResponse = value
        self.tableView.reloadData()
    }
}

```

For more information, see [AlamofireCodable](https://github.com/CNKCQ/AlamofireCodable).

## Chained calls

All the method mentioned above can be called in a chained manner, such as followed:

```swift
let load = LoadConfig(container: view, mask:EyeLoading(), inset: UIEdgeInsetsMake(30+64, 15, UIScreen.main.bounds.height-64-(44*4+30+15*3), 15))

let warn = UIAlertController(title: "Warning", message: "Network unavailable", preferredStyle: .alert)
warn.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))

let inform = UIAlertController(title: "Notice", message: "Load successfully", preferredStyle: .alert)
inform.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))

request(WeatherForm()).load(load:load).progress(progress: progress).warn(error: WeatherError(), warn: warn).inform(error: WeatherInformError(), inform: inform)
```

## Bonus

### `Eyeloading`

![](https://github.com/mmoaay/Bamboots/blob/master/Demo/EyeLoading.gif)

We've written this motion effect when implementing the customized loading, and it's all implemented with `CAAnimationGroup`.

If interested, you can check the file `Eyeloading` in example project.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

Bamboots is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Bamboots"
```

## Author

mmoaay, mmoaay@sina.com

## License

![](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/License_icon-mit-88x31-2.svg/128px-License_icon-mit-88x31-2.svg.png)

Bamboots is available under the MIT license. See the LICENSE file for more info.
