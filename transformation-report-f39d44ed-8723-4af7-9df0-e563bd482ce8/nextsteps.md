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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework does not match your intended version, update it accordingly and re-run the build.

### 4. Check for Removed or Incompatible APIs

Even without build errors, some APIs that existed in .NET Framework may behave differently or have been replaced in cross-platform .NET. Review the following areas:

- Any usage of `System.Web` namespaces, which are not available in cross-platform .NET.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages, which have updated APIs in ASP.NET Core.
- Any Windows-specific APIs such as the registry, WMI, or COM interop, which may not function on non-Windows platforms.

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformCompat.Analyzer` NuGet package to surface any remaining compatibility issues.

### 5. Run Existing Tests

If the solution contains test projects, execute them to verify runtime behavior:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by behavioral differences between .NET Framework and cross-platform .NET.

### 6. Verify Application Startup

Run the application locally and confirm it starts without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application's primary workflows to confirm expected behavior.

### 7. Review Configuration Files

Ensure that configuration files such as `appsettings.json` contain all settings that were previously held in `web.config` or `app.config`. The `ConfigurationManager` approach used in .NET Framework has been replaced by `IConfiguration` in cross-platform .NET.

### 8. Static Files and Web Assets

If this is a web project, confirm that static files, views, and other web assets are correctly placed under the `wwwroot` directory and are being served as expected by the ASP.NET Core middleware pipeline.

### 9. Database Connectivity

If the project uses Entity Framework or direct database access, verify that:

- The correct EF Core packages are referenced (not the .NET Framework EF packages).
- Connection strings are correctly defined in `appsettings.json`.
- Any pending migrations are applied using:

```bash
dotnet ef database update
```

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.