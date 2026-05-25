# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that surface, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing `net48` or any other .NET Framework moniker, update it accordingly.

### 4. Check for Windows-Specific Dependencies

Inspect the project's NuGet package references and code for any APIs or packages that are Windows-only. Common areas to check include:

- `System.Web` usage (not available in cross-platform .NET)
- Windows Registry access
- COM interop
- `HttpContext` and related ASP.NET types if this is a web project

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` package to identify platform-specific calls.

### 5. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality and confirm behavior matches the legacy version.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and investigate any failures. If no tests currently exist, consider writing unit tests for the core business logic before deployment.

### 7. Review Configuration Files

Check that configuration files have been properly migrated:

- `web.config` or `app.config` settings should be moved to `appsettings.json` if this is an ASP.NET Core project.
- Connection strings, application settings, and environment-specific values should be verified.

### 8. Verify Static Files and Views

If this is a web application, confirm that:

- Static assets (CSS, JavaScript, images) are placed under the `wwwroot` folder.
- Razor views or other front-end templates render correctly when the application is run.

### 9. Test on Target Platforms

Since the goal is cross-platform compatibility, test the application on each intended operating system (e.g., Windows, Linux, macOS) to surface any remaining platform-specific issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

### 10. Publish the Application

Once validation is complete, publish the application using the appropriate runtime identifier for your target environment:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --runtime linux-x64 --self-contained false
```

Replace `linux-x64` with the appropriate runtime identifier for your deployment target (e.g., `win-x64`, `osx-x64`). Review the contents of the publish output folder before deploying to the target environment.