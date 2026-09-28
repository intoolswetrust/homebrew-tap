# AGENTS.md

Homebrew tap `intoolswetrust/tap`. It currently holds one formula, `Formula/jsignpdf.rb`, for
[JSignPdf](https://github.com/intoolswetrust/jsignpdf/) ([jsignpdf.eu](https://jsignpdf.eu)).

## Layout

- `Formula/*.rb`: formulae
- `.github/workflows/tests.yml`: CI (audit, install and test on macOS arm/x86 and Ubuntu)
- `README.md`: user install steps and the version-bump recipe

## Rules

- Track final JSignPdf releases only. Release tags look like `JSignPdf_3_2_0`, and the asset is
  `jsignpdf-<version>-full.zip`.
- On a version bump, update `url` and `sha256` together. Get the checksum from the real asset;
  never guess it.
- Keep the install pinned to `openjdk@21` via `Language::Java.overridable_java_home_env("21")`
  so users can override `JAVA_HOME`.
- Keep the JavaFX pruning in `install` in sync with the classifiers upstream ships under
  `lib/javafx/`.
- `test do` must keep signing a real PDF with the bundled demo keystore, not just check
  `--version`.
- Follow Homebrew style: `brew audit --strict` must pass.

## Verify locally

```shell
brew tap-new intoolswetrust/tap --no-git   # once
cp -f Formula/*.rb "$(brew --repository intoolswetrust/tap)/Formula/"
brew trust --tap intoolswetrust/tap
brew style intoolswetrust/tap
brew audit --strict --online intoolswetrust/tap/jsignpdf
brew install --build-from-source intoolswetrust/tap/jsignpdf
brew test intoolswetrust/tap/jsignpdf
```
