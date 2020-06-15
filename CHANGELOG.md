# Changelog

## [1.0.1](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/compare/v1.0.0...v1.0.1) (2020-06-15)


### Bug Fixes

* **edition:** better edition jinja code ([e33df74](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/e33df74eca2dee8e3bbdcfa3f0e681bbf5fe7a2b))


### Code Refactoring

* **jinja:** rename 'webstorm' to w for shorter lines ([15077cd](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/15077cd1b50a10283896bc2b362b238aab49a8e5))


### Continuous Integration

* **kitchen+travis:** add new platforms [skip ci] ([15276ed](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/15276ed0c84a026acf5127d06577e62ce0f5f004))
* **travis:** add notifications => zulip [skip ci] ([d4caf97](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/d4caf97bd7d245938a3e8ec5ef5b2efbe911576e))


### Documentation

* **readme:** update style ([81246a6](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/81246a646bc1548b3247278ab86501a30e775987))

# [1.0.0](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/compare/v0.2.0...v1.0.0) (2020-05-19)


### Bug Fixes

* **id:** rename conflicting id ([09a9e52](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/09a9e524af55597153edf9c7103db5bb6d787f3d))


### Continuous Integration

* **kitchen+travis:** adjust matrix to add `3000.3` ([caca7b3](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/caca7b3d2d351bcc50992d72bf1e58ef627addf3))
* **travis:** update travis tests ([501119d](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/501119de96661c38e23affecaa35795ce43f6a93))


### Documentation

* **readme:** add depth one ([507a578](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/507a5786ea80d4a703deb21ec9dffd59e2698288))


### Features

* **formula:** align to template formula; add ci tests ([477f618](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/477f618390a6978112f67cb32447b7995ebddbb1))
* **formula:** align to template formula; add ci tests ([76eab72](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/76eab72099ca0846bec8143a81fe5d6b239a7736))
* **semantic-release:** standardise for this formula ([8e65a40](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/8e65a40122f2859130d883b3483e41a1bcb4020b))


### BREAKING CHANGES

* **formula:** Major refactor of formula to bring it in alignment with the
template-formula. As with all substantial changes, please ensure your
existing configurations work in the ways you expect from this formula.
