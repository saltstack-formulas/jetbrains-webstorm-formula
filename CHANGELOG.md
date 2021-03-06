# Changelog

## [1.2.1](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/compare/v1.2.0...v1.2.1) (2020-12-16)


### Continuous Integration

* **gitlab-ci:** use GitLab CI as Travis CI replacement ([4b13fbb](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/4b13fbb8de6cc770db99e5a8c64046c370c7416d))
* **pre-commit:** add to formula [skip ci] ([cf18dec](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/cf18dec1e3c9981f2fdd058bba36159d9a634de1))
* **pre-commit:** enable/disable `rstcheck` as relevant [skip ci] ([6b3a3eb](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/6b3a3ebee72ce18166b753cee8931658a70792ec))
* **pre-commit:** finalise `rstcheck` configuration [skip ci] ([a37df1a](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/a37df1ade5e056dccf4403015e0a226cc13e6293))


### Documentation

* **readme:** fix `rstcheck` violation [skip ci] ([088620f](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/088620faa500f7caa66fb9c188203ac59197bc9a)), closes [/travis-ci.org/github/myii/jetbrains-webstorm-formula/builds/731607222#L259](https://github.com//travis-ci.org/github/myii/jetbrains-webstorm-formula/builds/731607222/issues/L259)

# [1.2.0](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/compare/v1.1.0...v1.2.0) (2020-09-20)


### Features

* **clean:** add windows support ([f3d803d](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/f3d803dff5a9f0655a9359b884bc9c06ebbdb946))

# [1.1.0](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/compare/v1.0.2...v1.1.0) (2020-09-20)


### Features

* **windows:** basic windows support ([3cc410e](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/3cc410e86e44bfc4d6e374e6200e95fc97049c7c))

## [1.0.2](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/compare/v1.0.1...v1.0.2) (2020-07-28)


### Bug Fixes

* **cmd.run:** wrap url in quotes (zsh) ([c72b047](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/c72b0473816ebe79a308c9ef3ef0254ddf2fb295))
* **macos:** correct syntax ([8687ad2](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/8687ad2ecb2a4141da38be060e93e436c1052996))
* **macos:** do not create shortcut file ([cb6c6eb](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/cb6c6eb7c3dedfdf6b084dc9497f79a7f2d0adf9))
* **macos:** do not create shortcut file ([1af5eee](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/1af5eee59cf01d6984d9f80a274fd0125afee1f7))


### Code Refactoring

* **jetbrains:** align all jetbrains formulas ([beda598](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/beda59898224e0b95b8b160f076a792b62308c15))


### Continuous Integration

* **kitchen:** use `saltimages` Docker Hub where available [skip ci] ([ecab38e](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/ecab38ed52398d56f8b3c6360fb028c15b61b593))


### Documentation

* **readme:** minor update ([16cbf34](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/16cbf34b98ca157387f0613e26aa99b32b5bb621))
* **readme:** minor update ([8007d86](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/8007d860b0908eb818ace238d3a36a1b0e19dc7d))


### Styles

* **libtofs.jinja:** use Black-inspired Jinja formatting [skip ci] ([48b9046](https://github.com/saltstack-formulas/jetbrains-webstorm-formula/commit/48b90466626549010488ba7f1365364919521a5b))

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
