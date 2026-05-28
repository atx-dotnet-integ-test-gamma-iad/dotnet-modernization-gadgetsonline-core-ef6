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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older or end-of-life version (e.g., `net5.0`, `net6.0`), consider updating it to a supported release.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, paying particular attention to areas that relied on Windows-specific APIs or legacy ASP.NET features prior to migration.

### 5. Execute Unit Tests

If the solution contains test projects, run them to validate business logic and application behavior:

```bash
dotnet test
```

Review the test results for any failures that may indicate behavioral differences introduced during the migration.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that may have been removed or changed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in .NET Core and later
- `HttpContext` and related ASP.NET pipeline components
- Windows Registry access (`Microsoft.Win32.Registry`)
- `AppDomain` usage with certain methods that are no longer supported
- Any third-party libraries that may still target .NET Framework only

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.ApiCompat` tooling to assist with this review if needed.

### 7. Validate Configuration Files

Ensure that configuration has been correctly migrated from `Web.config` or `App.config` to the `appsettings.json` format. Verify that:

- Connection strings are present and correct
- Application settings are accessible via `IConfiguration`
- Environment-specific settings are handled using `appsettings.{Environment}.json` files

### 8. Test Data Access

If the application uses Entity Framework or another data access layer, verify that:

- Database migrations are up to date by running `dotnet ef database update` if applicable
- Queries execute correctly against the target database
- Connection strings reference the correct server and database

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and dependencies are present.

### 10. Verify on Target Operating System

If the intent of the migration was to support Linux or macOS, deploy and run the published output on the target operating system to confirm there are no platform-specific runtime issues.