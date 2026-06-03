# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas that need attention.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net6.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework is outdated (e.g., `netcoreapp3.1`), update it to a current long-term support (LTS) version.

### 4. Run the Application Locally

Start the application to verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to confirm that core functionality behaves as expected.

### 5. Check for Removed or Changed APIs

Cross-platform .NET does not support certain APIs that were available in .NET Framework. Verify the following areas manually:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Ensure replacements such as `Microsoft.AspNetCore` equivalents are in place.
- **`HttpContext` and session handling**: Confirm these are accessed via dependency injection rather than static accessors.
- **Configuration**: Ensure `web.config` settings have been migrated to `appsettings.json` and are being read via `IConfiguration`.

### 6. Execute Unit Tests

If the solution contains test projects, run them to validate existing logic:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 7. Verify Static Files and Views

If this is a web application, confirm that static files (CSS, JavaScript, images) are located under the `wwwroot` folder and that Razor views or pages render correctly when the application is run locally.

### 8. Review Middleware and Startup Configuration

Inspect `Program.cs` (and `Startup.cs` if present) to ensure:

- Middleware is registered in the correct order.
- Services such as Entity Framework, authentication, and session are properly configured.
- Connection strings reference the correct database endpoints.

### 9. Database and Entity Framework Validation

If the project uses Entity Framework, apply and verify migrations:

```bash
dotnet ef migrations list
dotnet ef database update
```

Confirm that the database schema matches expectations and that queries execute without errors.

### 10. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present before deploying to the target environment.