# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure this aligns with the runtime version installed on all target machines.

### 4. Run the Application Locally

Start the application locally to verify basic runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves as expected.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing logic has not been broken during transformation:

```bash
dotnet test
```

Review the test results and investigate any failures. Pay particular attention to tests covering data access, authentication, and any platform-specific functionality that may have changed behavior under cross-platform .NET.

### 6. Verify Data Access and Database Connectivity

If the project uses Entity Framework or another ORM, confirm the following:

- The correct database provider package is referenced (e.g., `Microsoft.EntityFrameworkCore.SqlServer`).
- Connection strings in `appsettings.json` or equivalent configuration files are correct for the target environment.
- Run any pending migrations if applicable:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 7. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references (these are not available in cross-platform .NET)
- `HttpContext` and related types (now accessed via `IHttpContextAccessor`)
- Windows-specific APIs such as the registry or WCF server-side components
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify remaining compatibility issues if needed.

### 8. Test on Target Operating Systems

If cross-platform support is a goal, test the application on each intended operating system (e.g., Windows, Linux, macOS) to surface any platform-specific runtime issues that would not appear during a build.

### 9. Review Static Files and Web Assets

If this is a web application, confirm that static files, views, and bundled assets are correctly included in the project output and served as expected at runtime.

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and self-contained if required:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and verify that all required files are present before deploying to the target environment.