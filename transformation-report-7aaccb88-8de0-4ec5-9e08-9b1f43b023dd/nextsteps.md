# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types, obsolete APIs, or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net6.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.AspNetCore.App` or the appropriate ASP.NET Core packages.

### 4. Run the Application Locally

Start the application and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm expected behavior is preserved from the legacy version.

### 5. Check for Removed or Changed APIs

Cross-platform .NET removed several APIs that were available in .NET Framework. Review the code for usage of any of the following common problem areas:

- `System.Web` namespace (not available in cross-platform .NET; replaced by ASP.NET Core equivalents)
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage patterns that relied on `System.Web`
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `AppDomain` members that are not supported
- Windows-specific registry or COM interop calls

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify any remaining compatibility issues.

### 6. Validate Configuration Files

Confirm that `web.config` or `app.config` settings have been migrated to `appsettings.json` where applicable. Connection strings, application settings, and environment-specific values should be present and correctly structured:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "your-connection-string-here"
  },
  "AppSettings": {
    "Key": "Value"
  }
}
```

### 7. Database Connectivity

If the project uses Entity Framework or direct database access, verify the connection string is valid and the database is reachable from the new runtime environment. Run any pending migrations if using Entity Framework:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 8. Run Existing Tests

If a test project exists in the solution, execute the test suite to confirm functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions or tests that require updating due to API changes.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correctly structured:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required assets, configuration files, and binaries are present before deploying to the target environment.