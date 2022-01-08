<center> <h1>JSEEN</h1> </center>

### Display JSON objects in a beautiful customizable flutter tree widget.
#### Check out the flutter web demo here: <a href="http://solid-throne.surge.sh/#/">http://solid-throne.surge.sh/#/</a>
<br>

## Usage

### Add dependency to pubspec.yaml
```yaml
dependencies:
  jseen: ^1.0.0
```

### Import package
```dart
import 'package:jseen/jseen_tree.dart';
```

### Use Widget
```dart
JSeenTree(
    json: '{"name":"Bob"}'
)
```

### Customize
```dart
JSeenTree(
    json: '{"name":"Bob"}',
    indent: 20,
    errorWidget: Text('ERROR!!!'),
    theme: JSeenTheme(
        keyStyle: TextStyle(color: Colors.purple.shade200),
        stringStyle: TextStyle(color: Colors.yellow),
    ),
)
```

<img src="https://github.com/jinyus/jseen/blob/master/example/jseen.gif?raw=true">
<img src="https://github.com/jinyus/jseen/blob/master/example/jseen.jpg?raw=true">