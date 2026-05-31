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

Review the output for any warnings related to missing packages or incompatible target frameworks.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports `0 Error(s)` and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported cross-platform .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing `net48` or any other .NET Framework moniker, update it accordingly and re-run the build.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the core functionality to confirm there are no runtime exceptions that were not caught at compile time.

### 5. Run Existing Tests

If the solution contains any test projects, execute them to validate business logic and integration points:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding further.

### 6. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Confirm all usages have been replaced with ASP.NET Core equivalents.
- **Windows-specific APIs**: Any calls to the Windows Registry, `System.Drawing` (GDI+), or COM interop may fail on non-Windows platforms.
- **Configuration**: Ensure `web.config` settings have been migrated to `appsettings.json` and that `IConfiguration` is used throughout.
- **Authentication/Authorization**: Confirm that any legacy `FormsAuthentication` or `WindowsAuthentication` usage has been replaced with ASP.NET Core middleware.

### 7. Review Static Files and Bundling

If the project previously used `System.Web.Optimization` for bundling and minification, verify that a replacement such as `WebOptimizer` or a front-end build tool has been configured correctly, and that static files are being served as expected.

### 8. Validate Database Connectivity

If the project uses Entity Framework, confirm the correct version is referenced (`Microsoft.EntityFrameworkCore`) and run a test query or apply any pending migrations:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

Verify that connection strings in `appsettings.json` are correct for the target environment.

### 9. Test on Target Platform

If cross-platform support is a goal, run and test the application on the intended non-Windows operating system (e.g., Linux or macOS) to surface any platform-specific runtime issues that would not appear on Windows.