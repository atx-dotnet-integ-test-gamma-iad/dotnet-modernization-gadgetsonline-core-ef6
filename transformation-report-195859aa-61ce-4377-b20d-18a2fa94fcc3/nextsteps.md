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

Review the output for any warnings related to missing packages or version conflicts. Resolve any flagged issues by updating or replacing packages in the relevant `.csproj` files.

### 2. Build the Solution

Perform a full build to confirm there are no compilation errors:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings, as some warnings may indicate deprecated APIs or compatibility concerns that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in the .NET Framework but have been removed or changed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET and should be replaced with ASP.NET Core equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages, which have different namespaces and behaviors in ASP.NET Core.
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`.
- `System.Drawing` usage, which may require the `System.Drawing.Common` NuGet package and has platform-specific limitations.

### 5. Run the Application Locally

Start the application using the .NET CLI to verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality and verify that pages load correctly, data access works as expected, and no unhandled exceptions are thrown.

### 6. Review Configuration Files

Confirm that `appsettings.json` contains all necessary configuration values that were previously stored in `Web.config` or `App.config`. Pay particular attention to:

- Database connection strings
- Application-specific settings
- Logging configuration

### 7. Validate Data Access

If the project uses Entity Framework, confirm the version being used is compatible with cross-platform .NET. Run any pending migrations and verify the database schema is correct:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 8. Execute Tests

If the solution contains test projects, run them to validate that existing functionality behaves as expected:

```bash
dotnet test
```

Review any failing tests and address the underlying issues before proceeding to deployment.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and configuration files are present.