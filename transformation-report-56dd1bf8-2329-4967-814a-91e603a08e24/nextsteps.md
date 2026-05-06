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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported cross-platform .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing `net48` or another legacy framework moniker, update it accordingly.

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality to check for any runtime errors that would not surface at compile time.

### 5. Execute the Test Suite

If the solution contains test projects, run all tests to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review the results for any failing tests and address regressions introduced during the migration.

### 6. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET compared to .NET Framework. Pay particular attention to the following areas:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. If any remain, they will need to be replaced with ASP.NET Core equivalents.
- **Windows-specific APIs**: Any calls to the Windows Registry, `System.Drawing` (GDI+), or COM interop may fail on non-Windows platforms.
- **Configuration**: `System.Configuration.ConfigurationManager` usage should be replaced with `Microsoft.Extensions.Configuration`.
- **Entity Framework**: If the project uses Entity Framework 6, consider migrating to Entity Framework Core for full cross-platform support.

### 7. Test on Target Platform

If the goal is to run the application on a non-Windows operating system, deploy and run the application on that target OS (e.g., Linux or macOS) and verify all functionality works correctly, as some issues only surface at runtime on non-Windows environments.

### 8. Review Static Files and Middleware (If ASP.NET Core)

If `GadgetsOnline` is a web application, verify that:

- Static file serving is configured correctly via `app.UseStaticFiles()`.
- Authentication and session middleware has been migrated from the legacy OWIN/Katana pipeline to the ASP.NET Core middleware pipeline.
- Any `Global.asax` logic has been moved to `Program.cs` or `Startup.cs`.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is as expected:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all required assets and dependencies are present before deploying to the target environment.