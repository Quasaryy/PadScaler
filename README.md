# PadScaler

**PadScaler** is a library for easy UI scaling between iPhone and iPad (11", 13", and future models). It automatically adapts interface element sizes for different screen sizes.

## 🚀 Installation

PadScaler can be installed using **Swift Package Manager (SPM)**.

### **1. Installation via Swift Package Manager**

#### **Xcode (Recommended Method)**
1. Open **File → Add Packages...** in Xcode.
2. Enter the repository URL:
   ```
   https://github.com/quasaryy/PadScaler.git
   ```
3. Select the version (`Up to Next Major Version` → `1.0.0`).
4. Click `Add Package` and attach `PadScaler` to your target.

#### **SPM in `Package.swift`**
If you are using Swift Package Manager manually, add the dependency in `Package.swift`:
```swift
dependencies: [
    .package(url: "https://github.com/quasaryy/PadScaler.git", from: "1.0.0")
]
```
Then import it into your code:
```swift
import PadScaler
```

---

## 📌 Usage

PadScaler provides convenient methods for adapting UI element sizes.

### **1. Scaling sizes (`scaledSize`)**
Scales numeric values for iPad based on standard multipliers:
```swift
let scaledValue = 10.scaledSize
```
✅ **Result:**
- `10` on iPhone
- `16` on iPad 11"
- `20` on iPad 13"

If you need to set custom multipliers:
```swift
let customScaled = 10.scaledSize(smallPadMultiplier: 1.5, largePadMultiplier: 2.3)
```

If only the **large iPad multiplier** is set, the small iPad multiplier will be automatically calculated:
```swift
let autoScaled = 10.scaledSize(largePadMultiplier: 2.3)
```
✅ **Result:**
- `10` on iPhone
- `1.839` (automatically calculated) on iPad 11"
- `23` on iPad 13"

### **2. Adaptive sizes (`adaptiveSize`)**
Allows specifying different values for iPhone, iPad 11", and iPad 13":
```swift
let adaptive = adaptiveSize(phone: 5, smallPad: 7.6, largePad: 8.7)
```
✅ **Result:**
- `5` on iPhone
- `7.6` on iPad 11"
- `8.7` on iPad 13"

### **3. Using with SwiftUI**
PadScaler works great with SwiftUI:
```swift
Text("Adaptive Text")
    .font(.system(size: 16.scaledSize))
    .padding(20.scaledSize)
```

---

## 🛠 Configuration

### **1. Global configuration (`shared` instance)**
```swift
PadScaler.setSharedConfiguration(ScalingConfiguration(
    defaultSmallPadMultiplier: 1.5,
    defaultLargePadMultiplier: 2.2
))
```
Now `scaledSize` will use these multipliers by default.

### **2. Using a custom instance**
If you need to use **different configurations in different places**, create a separate instance:
```swift
let customPadScaler = PadScaler.newInstance(ScalingConfiguration(
    defaultSmallPadMultiplier: 1.8,
    defaultLargePadMultiplier: 2.5
))
let scaled = customPadScaler.scaledSize(10)
```

---

## 📄 License
**PadScaler** is distributed under the **MIT License**.

```text
Copyright (c) 2025 Yury Lebedev

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```

---

🚀 **Support the project with a star!** ⭐
