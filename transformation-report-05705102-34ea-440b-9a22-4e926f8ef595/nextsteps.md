# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly.

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts. Resolve any flagged issues by updating package references in the `.csproj` file.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues.

```bash
dotnet build --configuration Release
```

Confirm the build completes with zero errors and review any warnings, as some may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the target framework is set to the intended cross-platform version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with your team's supported runtime version.

### 4. Run the Application Locally

Start the application and verify it runs as expected.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality and confirm behavior matches the legacy version.

### 5. Check for Windows-Specific Dependencies

Even without build errors, the project may reference APIs or libraries that only function correctly on Windows. Search the codebase for usages of the following and verify cross-platform compatibility:

- `Microsoft.Win32` namespaces
- `System.Windows` namespaces
- Registry access
- Windows file path assumptions (e.g., backslashes, drive letters)
- COM interop

### 6. Review Configuration Files

Confirm that configuration previously held in `Web.config` or `App.config` has been correctly migrated to `appsettings.json` or `appsettings.{Environment}.json`. Verify connection strings, application settings, and environment-specific values are present and correct.

### 7. Database Connectivity

If the application uses a database, verify the connection string in `appsettings.json` is valid for the target environment and that the application can connect and perform basic operations.

### 8. Run Existing Tests

If the solution contains test projects, execute them to validate core functionality.

```bash
dotnet test
```

Review any failing tests and address regressions introduced during the migration.

### 9. Manual Functional Testing

Perform manual testing of the primary user-facing features of the application, particularly any areas that relied on ASP.NET or .NET Framework-specific behavior, such as:

- Authentication and authorization
- Session and cookie handling
- HTTP module or handler equivalents (now middleware)
- Static file serving

### 10. Publish the Application

Once validation is complete, publish the application to confirm the output is correct.

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, assets, and dependencies are present before deploying to the target environment.