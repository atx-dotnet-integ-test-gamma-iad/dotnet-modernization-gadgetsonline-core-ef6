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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure no legacy `<TargetFrameworkVersion>` elements referencing the old .NET Framework (e.g., `v4.8`) remain.

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that are not available in cross-platform .NET. Common areas to inspect include:

- `System.Web` namespace usage (not available outside of ASP.NET on .NET Framework)
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage if migrating from ASP.NET to ASP.NET Core
- Windows Registry access (`Microsoft.Win32.Registry`)
- `AppDomain` members that are no longer supported
- Any P/Invoke calls targeting Windows-specific native libraries

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformCompat.Analyzer` NuGet package to surface these issues automatically.

### 5. Run Existing Tests

If the solution contains test projects, execute them to verify runtime behavior has not changed:

```bash
dotnet test --configuration Release
```

Review any failing tests to determine whether they indicate a behavioral difference introduced by the migration.

### 6. Verify Runtime Behavior Manually

Run the application locally and exercise its primary functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Check for any runtime exceptions that would not have been caught at compile time, such as missing configuration values, changed serialization behavior, or altered dependency injection registration.

### 7. Review Configuration Files

Confirm that any `web.config` or `app.config` settings have been migrated to the appropriate `appsettings.json` format if the project is an ASP.NET Core application. Connection strings, application settings, and custom configuration sections should all be accounted for.

### 8. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to ensure all expected files, static assets, and dependencies are present before deploying to the target environment.