# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application locally and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm expected behavior.

### 5. Run Existing Tests

If the solution contains test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Check for Windows-Specific APIs

Even when a project builds successfully, it may contain APIs that are Windows-specific and will fail at runtime on other platforms. Use the .NET Compatibility Analyzer or review the code manually for usages such as:

- `Microsoft.Win32` namespace references
- `System.Windows.Forms` or `System.Drawing` (non-web-safe variants)
- Registry access via `RegistryKey`
- Windows-specific file path assumptions (e.g., hardcoded backslashes)

### 7. Review Configuration and Connection Strings

Check `appsettings.json` or `web.config` (if still present) for any environment-specific configuration values such as:

- Database connection strings
- API keys or secrets
- File system paths

Ensure these are externalized appropriately using `appsettings.json` and environment variables rather than relying on legacy `web.config` transforms.

### 8. Verify Static Files and wwwroot

If this is a web application, confirm that static assets (CSS, JavaScript, images) are located under the `wwwroot` folder and are being served correctly when the application runs.

### 9. Test on Target Platform

If cross-platform support is a goal, run and test the application on the intended non-Windows operating system (e.g., Linux or macOS) to surface any platform-specific runtime issues that would not appear during a Windows build.