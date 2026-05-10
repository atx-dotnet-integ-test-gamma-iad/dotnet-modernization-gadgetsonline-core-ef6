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

If the project is a web application, ensure it references `Microsoft.AspNetCore.App` or the appropriate framework-specific packages.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, including any database connections, authentication flows, and key business logic.

### 5. Review Removed or Changed APIs

Check for any usages of APIs that were available in the .NET Framework but have changed or been removed in cross-platform .NET. Common areas to review include:

- `System.Web` dependencies, which are not available in cross-platform .NET
- `HttpContext` and related types if this is a web project
- Windows-specific APIs such as the registry, WCF server-side components, or `System.Drawing` without a compatible replacement

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 7. Verify Database Connectivity

If the application uses a database, confirm that the connection strings in configuration files such as `appsettings.json` or `web.config` are correct and that the chosen data access library (e.g., Entity Framework Core) is functioning as expected. Run any pending migrations if applicable:

```bash
dotnet ef database update
```

### 8. Check Static Assets and Configuration

For web projects, verify that static files, bundling, and configuration settings are loading correctly under the new hosting model. Confirm that `Program.cs` and any middleware configuration in the startup pipeline reflect the intended behavior.