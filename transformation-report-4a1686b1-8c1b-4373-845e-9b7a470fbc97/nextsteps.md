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

Review the output for any warnings about missing packages, deprecated packages, or version conflicts that may not surface as build errors but could cause runtime issues.

### 2. Build the Solution

Perform a full build to confirm the clean state:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported, non-end-of-life version of .NET, such as:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting `net6.0` or `net7.0`, consider updating to `net8.0` as those versions have reached or are approaching end of life.

### 4. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. If any compatibility shims were used during transformation, verify they are functioning correctly.
- **HTTP modules and handlers**: These should have been migrated to ASP.NET Core middleware. Verify the middleware pipeline in `Program.cs` or `Startup.cs` covers the same behavior.
- **Session and authentication**: Confirm that session state and authentication mechanisms have been correctly migrated to their ASP.NET Core equivalents.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that:

- All pages render correctly.
- Database connections are established and queries return expected results.
- Any file system paths used in the application are using `Path.Combine` and are not hardcoded with Windows-style separators.

### 6. Review Configuration Files

Ensure that `appsettings.json` contains all configuration values that were previously in `web.config` or `app.config`, including:

- Connection strings
- Application settings
- Logging configuration

If `web.config` transformations were used previously, verify that environment-specific configuration is now handled through `appsettings.{Environment}.json` or environment variables.

### 7. Run Unit Tests

If the solution contains test projects, execute them to validate core functionality:

```bash
dotnet test
```

Review the results and address any failing tests before proceeding to deployment.

### 8. Verify Static Files and Web Assets

If the project serves static files (CSS, JavaScript, images), confirm that:

- Static files are located in the `wwwroot` folder.
- The `UseStaticFiles()` middleware is registered in the application pipeline.
- Asset paths in views or HTML files are correct.

### 9. Test on a Non-Windows Environment (Optional but Recommended)

Since the goal of the transformation is cross-platform compatibility, consider running the application on Linux or macOS to surface any remaining platform-specific issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Look for issues related to case-sensitive file paths, which are common when moving from Windows to Linux.

### 10. Review Publish Output

Before deploying, perform a publish to verify the output is complete:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all required files, including configuration files and static assets, are present.