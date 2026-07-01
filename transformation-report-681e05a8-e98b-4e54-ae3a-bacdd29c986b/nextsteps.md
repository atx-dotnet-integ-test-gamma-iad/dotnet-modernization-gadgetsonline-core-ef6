# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no compile-time issues:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is set to an older version like `net6.0` or `net7.0`, consider updating to `net8.0` as it is the current Long Term Support (LTS) release.

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have been removed or altered in cross-platform .NET. The [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling can assist with this.

Common areas to check include:
- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related ASP.NET types if this is a web project
- Windows-specific APIs such as the registry or Windows Communication Foundation (WCF)

### 5. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows and confirm behavior matches the legacy version.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a functional regression or a test that requires updating due to API changes.

### 7. Review Configuration Files

Ensure that configuration files have been migrated correctly:
- `Web.config` or `App.config` values should be moved to `appsettings.json` if they have not been already
- Connection strings, application settings, and environment-specific values should be verified in the new configuration format

### 8. Verify Static Assets and Views

If this is a web project, confirm that static assets, Razor views, or other front-end resources are being served correctly by browsing the running application.

### 9. Check Runtime Behavior on Target Platform

If the intended deployment target is Linux or macOS, run the application on that platform specifically to catch any remaining platform-specific issues such as file path casing sensitivity or platform-dependent libraries.

```bash
dotnet publish --configuration Release --runtime linux-x64
```

Review the published output and confirm all required files are present.