## Contributing to CoeFi

Thank you for your interest in contributing to CoeFi! Before you begin writing code, it is important
that you share your intention to contribute with the team, based on the type of contribution:

1. You want to propose a new feature and implement it.
    - Post about your intended feature in an [issue](https://github.com/cochainio/coefi/issues),
    and we shall discuss the design and implementation. Once we agree that the plan looks good,
    go ahead and implement it.
2. You want to implement a feature or bug-fix for an outstanding issue.
    - Search for your issue in the [CoeFi issue list](https://github.com/cochainio/coefi/issues).
    - Pick an issue and comment that you'd like to work on the feature or bug-fix.
    - If you need more context on a particular issue, please ask and we shall provide.

Once you implement and test your feature or bug-fix, please submit a Pull Request to
https://github.com/coefi/coefi.

This document covers some of the more technical aspects of contributing
to CoeFi.

## Developing CoeFi

Formatting code:
```bash
flutter pub run import_sorter:main lib/
flutter format lib/
```

### Tips

### Third-party libraries

## Testing

## Codebase structure

## Design Patterns

- 特性集合：功能/特性以可插拔模块的方式，集中放置于各自目录，按需启用。
- 特性开关：测试/管理/普通三种开关形式。
- 延迟初始化：某些消耗资源的全局变量可采用延迟初始化（比如数据库）。
- 故障隔离：某局部功能或特性产生故障，不应导致其他不相关功能或特性不可用。
- 网络请求集中化：所有涉及网络请求的 API 均集中放置于 `services` 目录。
- 持久化数据集中化：所有涉及数据持久化的 API 均集中放置于 `models` 目录。
- 样式主题化：样式均以主题化的方式集中管理。
