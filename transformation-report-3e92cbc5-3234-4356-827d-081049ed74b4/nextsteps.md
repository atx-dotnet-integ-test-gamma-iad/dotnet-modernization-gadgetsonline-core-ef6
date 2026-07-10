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

Review the output for any warnings related to missing packages or incompatible target frameworks.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output shows `Build succeeded` with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported cross-platform .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing `net48` or any other .NET Framework moniker, update it accordingly.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to confirm behavior matches the legacy version.

### 5. Run Existing Tests

If the solution contains any test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Review Removed or Changed APIs

Check the codebase for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to review include:

- `System.Web` references (not available in .NET Core/.NET 5+)
- `HttpContext` and related ASP.NET pipeline components
- Windows-specific APIs such as the registry or Windows Communication Foundation (WCF)
- Entity Framework — confirm whether the project has migrated from EF 6 to EF Core

### 7. Validate Configuration Files

Confirm that `web.config` or `app.config` settings have been migrated to `appsettings.json` where applicable. In cross-platform .NET, `appsettings.json` is the standard configuration mechanism.

### 8. Check Static Assets and Middleware

If this is a web project, verify that static files, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs` using the ASP.NET Core pipeline.

### 9. Test on Target Platform

If the goal is cross-platform support, run and validate the application on the intended non-Windows platform (Linux or macOS) to surface any remaining platform-specific dependencies.