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

Confirm that the output shows zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of Windows-specific or legacy APIs that may have been available in .NET Framework but behave differently or are unavailable in cross-platform .NET. Common areas to check include:

- `System.Web` references (not available in cross-platform .NET; replaced by `Microsoft.AspNetCore`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `HttpContext` usage patterns
- Session and authentication middleware configuration

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to verify runtime behavior matches the legacy version.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to behavioral differences introduced by the migration or pre-existing issues.

### 7. Review Static Files and Configuration

- Confirm that `appsettings.json` contains the necessary configuration values previously held in `Web.config` or `App.config`.
- Verify that static files, views, and other content files are present and correctly referenced in the new project structure.

### 8. Database and Data Access Validation

If the project uses Entity Framework or another data access layer:

- Confirm the connection strings in `appsettings.json` are correct.
- Run any pending migrations if using Entity Framework Core:

```bash
dotnet ef database update
```

- Validate that data reads and writes function correctly against the target database.

### 9. Review Middleware and Startup Configuration

If this is an ASP.NET Core application, review `Program.cs` (and `Startup.cs` if present) to ensure:

- Middleware is registered in the correct order.
- Services such as authentication, authorization, and session are properly configured.
- Routing is set up to match the legacy application's URL structure.