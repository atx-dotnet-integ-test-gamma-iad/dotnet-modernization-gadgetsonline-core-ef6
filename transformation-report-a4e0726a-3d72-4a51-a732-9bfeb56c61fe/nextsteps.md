# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas that need attention.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to confirm expected behavior.

### 5. Execute the Test Suite

If the solution contains test projects, run all tests to validate that existing functionality has not been broken during migration:

```bash
dotnet test
```

Review the results for any failing tests and investigate root causes before proceeding.

### 6. Verify Platform-Specific Code

Inspect the codebase for any code paths that previously relied on Windows-specific APIs or libraries (e.g., `System.Web`, COM interop, Windows registry access). These may compile successfully but fail at runtime on non-Windows platforms. Common areas to check include:

- Authentication and session management (previously reliant on `System.Web`)
- File path handling (ensure `Path.Combine` is used rather than hardcoded separators)
- Any third-party libraries that may not have cross-platform support

### 7. Check Runtime Configuration Files

Verify that `appsettings.json` (and environment-specific variants such as `appsettings.Development.json`) are present and correctly configured. Confirm that connection strings and other environment-specific settings have been properly migrated from `Web.config` or `App.config`.

### 8. Validate Static Assets and Middleware

If this is a web application, confirm that static files, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`. Test key routes and endpoints to ensure they respond as expected.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is as expected:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.