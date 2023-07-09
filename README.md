# Shopping List App
An App written with Flutter based on this [course](https://www.udemy.com/user/academind/).

What I implement in this app:
* use provider `flutter_riverpod` to maintain object/state between screen
* required to use `ProviderScope` to make provider works in main class, like `runApp(const ProviderScope(child: MyApp()));`
* extend class with `StateNotifier` to make a provider
* initiate final `StateNotifierProvider` variable/object which can be called by another classes that needs providers 
* extend class with `ConsumerState` to use `WidgetRef` which can be used to call `StateNotifierProvider` variable/object
* use `ref.read` to call provider function without consuming a data
* use `SingleChildScrollView` to have screen scrollable. Better use this widget if we know how many widgets/items will show on screen.
* use `InkWell` to make a `ListTile` tap able
* use `CircleAvatar` to display image in circle border
* use `Form` and `TextFormField` as input text
* use `image_picker` to access device camera
* set `maxHeight` in `ImagePicker().pickImage` function will make picture is less quality and size
* use `GestureDetector` to wrap a widget with a gesture, such as a tap in container widget
* use `Stack` widget to make children position z-axis like
