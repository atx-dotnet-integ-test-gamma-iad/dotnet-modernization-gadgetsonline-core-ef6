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

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that existed in .NET Framework but have been removed or altered in cross-platform .NET. Common areas to check include:

- `System.Web` namespace usage (not available in cross-platform .NET)
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages that may need to be updated to ASP.NET Core equivalents
- `ConfigurationManager` replaced by `Microsoft.Extensions.Configuration`
- `System.Drawing` which may require the `System.Drawing.Common` NuGet package and has platform limitations

### 5. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, including any database connections, authentication flows, and key business logic paths.

### 6. Verify Database Connectivity

If the project uses Entity Framework or another data access layer, confirm that:

- The connection strings in `appsettings.json` are correct and accessible from the new environment
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

### 7. Execute Existing Tests

If a test project exists within the solution, run the test suite to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a real regression or require updates due to API changes introduced by the migration.

### 8. Review Application Configuration

Confirm that configuration previously held in `Web.config` or `App.config` has been properly migrated to `appsettings.json`. Pay particular attention to:

- Connection strings
- Application settings keys
- Authentication and authorization configuration

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and dependencies are present before deploying to the target environment.