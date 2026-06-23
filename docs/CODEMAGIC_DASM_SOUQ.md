# Codemagic Setup for DASM Souq

This repo uses `codemagic.yaml` to build and upload the iOS app to App Store Connect for internal TestFlight testing.

## App

| Item | Value |
| --- | --- |
| Codemagic app | `dasm-souq-mobile` |
| Workflow | `dasm-souq-ios-testflight` |
| GitHub repo | `DASMe-9/dasm-souq-mobile` |
| Branch | `main` |
| App Store name | `سوق داسم` |
| Bundle ID | `com.dasm.souq` |
| Apple Bundle ID record | `5C38VUA36T` |
| SKU suggestion | `dasm-souq-001` |

## Required App Store Connect Step

The Apple Bundle ID already exists. Create the App Store Connect app record manually:

1. App Store Connect -> Apps -> `+` -> New App.
2. Platform: `iOS`.
3. Name: `سوق داسم`.
4. Primary language: `Arabic`.
5. Bundle ID: `DASM Souq - com.dasm.souq`.
6. SKU: `dasm-souq-001`.
7. After creation, copy the numeric Apple ID from the URL and store it in Codemagic as `APP_STORE_APPLE_ID`.

## Required Codemagic Variable Group

Create one variable group named:

```text
dasm_souq_apple
```

Add these variables as secure values:

| Variable | Source |
| --- | --- |
| `APP_STORE_APPLE_ID` | Numeric App Store Connect ID after creating the app record |
| `APP_STORE_CONNECT_PRIVATE_KEY` | Full contents of `C:\dasm-env-backup\AuthKey_5T9W4CV7BU.p8` |
| `APP_STORE_CONNECT_KEY_IDENTIFIER` | Key ID from `C:\dasm-env-backup\apple_asc_api_key_codemagic.txt` |
| `APP_STORE_CONNECT_ISSUER_ID` | Issuer ID from `C:\dasm-env-backup\apple_asc_api_key_codemagic.txt` |
| `CERTIFICATE_PRIVATE_KEY` | Full contents of `C:\dasm-env-backup\dasm_inspector_ios_distribution_private_key.pem` |

`CERTIFICATE_PRIVATE_KEY` reuses the existing account-level Apple Distribution certificate private key. It does not delete, revoke, or modify the Inspector or Mr20 certificates.

## Codemagic UI Steps

1. Open Codemagic Applications.
2. Open `dasm-souq-mobile`.
3. Click `Finish build setup` if still shown.
4. Select `codemagic.yaml` configuration.
5. Add the `dasm_souq_apple` variable group above.
6. Run workflow `DASM Souq iOS TestFlight` from branch `main`.

## Local Assets

- Master icon: `docs/store-assets/dasm-souq-icon-1024.png`
- iOS icons: `ios/Runner/Assets.xcassets/AppIcon.appiconset/`
- Android icons: `android/app/src/main/res/mipmap-*/ic_launcher.png`

## What the Workflow Does

1. Validates Apple secrets.
2. Initializes a macOS keychain.
3. Fetches or creates App Store provisioning files for `com.dasm.souq`.
4. Applies provisioning profiles with `testFlightInternalTestingOnly`.
5. Runs `flutter pub get`, `flutter analyze`, and `flutter test`.
6. Builds a signed IPA.
7. Uploads the IPA to App Store Connect so it appears in TestFlight.

## Boundaries

- Do not delete Apple Distribution certificates for Inspector or Mr20.
- Do not commit `.p8`, `.pem`, `.p12`, or provisioning profile files.
- If Codemagic reports a certificate limit or certificate/private-key mismatch, stop and inspect before changing Apple certificates.
