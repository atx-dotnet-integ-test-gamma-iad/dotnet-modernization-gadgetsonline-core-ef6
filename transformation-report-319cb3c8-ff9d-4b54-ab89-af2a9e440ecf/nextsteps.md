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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing `net48` or another legacy framework, update it accordingly and rebuild.

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the locally hosted URL and verify that the core functionality of the application behaves correctly.

### 5. Execute Unit Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Review Removed or Changed APIs

Cross-platform .NET does not support certain Windows-specific or legacy ASP.NET APIs. Manually review the codebase for usage of the following, which may cause runtime issues even if they do not produce build errors:

- `System.Web` namespaces (these are not available in .NET Core and later)
- `HttpContext` usage patterns specific to classic ASP.NET
- Windows Registry access via `Microsoft.Win32`
- Any P/Invoke calls targeting Windows-only system libraries

### 7. Review Configuration Files

Ensure that `web.config` or `app.config` settings have been migrated to `appsettings.json` where applicable. The `web.config` file is not used for application configuration in cross-platform .NET; only IIS-specific settings remain relevant in that file.

### 8. Verify Static Files and wwwroot

If this is a web application, confirm that static assets (CSS, JavaScript, images) are located in the `wwwroot` folder and that the project file includes them correctly.

### 9. Test on Target Platform

If the goal is cross-platform support, run and test the application on the intended non-Windows platform (Linux or macOS) to surface any remaining platform-specific issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and self-contained:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and verify all required files are present before deploying to the target environment.