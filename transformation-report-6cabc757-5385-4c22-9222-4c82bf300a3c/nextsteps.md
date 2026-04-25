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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate and supported version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If the target framework is outdated (e.g., `net6.0` or `net7.0`), consider updating it to the current LTS release.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality such as product browsing, cart operations, and any checkout flows to confirm they behave as expected.

### 5. Execute Unit Tests

If the solution contains a test project, run all tests to validate business logic:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 6. Check for Removed or Changed APIs

Review the code for usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references (these are not available in cross-platform .NET)
- `HttpContext` usage patterns
- `ConfigurationManager` replaced by `Microsoft.Extensions.Configuration`
- Any Windows-specific APIs (e.g., registry access, Windows authentication)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.ApiCompat` tooling to identify remaining compatibility concerns.

### 7. Validate Configuration Files

Ensure that `appsettings.json` (or equivalent) contains all configuration values that were previously in `web.config` or `app.config`. Confirm that connection strings, application settings, and any custom configuration sections have been migrated correctly.

### 8. Test Database Connectivity

If the application uses a database, verify that:

- The connection string in `appsettings.json` is correct for the target environment.
- Entity Framework migrations (if applicable) are up to date by running:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once local validation is complete, publish the application to verify the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files, static assets, and configuration files are present.

### 10. Smoke Test the Published Output

Run the published output directly to confirm it operates correctly outside of the development environment:

```bash
dotnet ./publish/GadgetsOnline.dll
```

Verify that the application starts without errors and that key endpoints or pages are accessible.