# Mist

A new Flutter application.

## Development

To generate boilerplate for a screen

`bash ./generator.sh {SCREEN_NAME} {SCREEN_PATH}`

example `bash ./generator.sh Profile lib/screen/account`

add screen route to [provider](lib/screen/screen_provider.dart) and re-generate dependency

The project uses [get_it](https://pub.dev/packages/get_it) and [injectable](https://pub.dev/packages/injectable_generator) for its dependency.

To generate the dependency code, run `flutter packages pub run build_runner build --delete-conflicting-outputs`

See [here](https://blog.usejournal.com/flutter-di-a-true-love-story-1e5a5ae2ba2d) for tutorial on how to get familiar with both tools

