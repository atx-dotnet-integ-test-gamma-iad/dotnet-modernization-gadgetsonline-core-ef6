# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated or incompatible packages. If any packages could not be resolved, check their availability on [NuGet.org](https://www.nuget.org) and update version numbers in the `.csproj` file accordingly.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types, deprecated APIs, or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `TargetFramework` is set to the intended cross-platform version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, verify it is using:

```xml
<TargetFramework>net8.0</TargetFramework>
```

and that it references `Microsoft.AspNetCore.App` or similar meta-packages appropriate for the project type.

### 4. Check for Windows-Specific Dependencies

Scan the project for any APIs or packages that are Windows-only. Common areas to check include:

- Use of `System.Web` (not available in .NET Core/.NET 5+)
- Windows Registry access (`Microsoft.Win32.Registry`)
- WCF server-side components
- Any P/Invoke calls targeting Windows-specific DLLs

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` package to identify remaining platform-specific code.

### 5. Run Unit Tests

If the solution contains test projects, execute them to verify functional correctness after migration:

```bash
dotnet test --configuration Release
```

Review any failing tests to determine whether failures are caused by behavioral differences in the new runtime or by migration-related changes.

### 6. Run the Application Locally

Start the application and perform manual smoke testing:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Verify that:
- The application starts without runtime exceptions
- Core user-facing functionality works as expected
- Database connections (if applicable) are established correctly
- Any authentication or session management behaves as expected

### 7. Review Configuration Files

Ensure that `appsettings.json` (or equivalent) contains all configuration values previously held in `Web.config` or `App.config`. The `System.Configuration.ConfigurationManager` approach from .NET Framework has been replaced by `Microsoft.Extensions.Configuration` in modern .NET. Confirm:

- Connection strings are correctly migrated
- Application settings keys are present
- Environment-specific overrides (`appsettings.Development.json`, etc.) are in place

### 8. Verify Static Files and Web Assets

If this is a web project, confirm that static files (CSS, JavaScript, images) are being served correctly and that the `wwwroot` folder structure matches what the application expects.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.