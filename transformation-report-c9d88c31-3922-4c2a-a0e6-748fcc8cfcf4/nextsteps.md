# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET compared to .NET Framework. Review the following areas manually:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Confirm all usages have been replaced with ASP.NET Core equivalents.
- **`HttpContext`, `HttpRequest`, `HttpResponse`**: Ensure these reference `Microsoft.AspNetCore.Http` types, not `System.Web` types.
- **`ConfigurationManager`**: This should be replaced with `Microsoft.Extensions.Configuration`.
- **`Global.asax`**: This should have been replaced with `Program.cs` and `Startup.cs` (or the minimal hosting model in `Program.cs` for .NET 6+).

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the URL printed in the console output and verify that the application loads and core functionality behaves as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate business logic and integration points:

```bash
dotnet test
```

Review the results for any failing tests that may indicate behavioral differences introduced during migration.

### 7. Review Static Files and Content

If the project is a web application, confirm that static files (CSS, JavaScript, images) are being served correctly. In ASP.NET Core, static files must be placed in the `wwwroot` folder and the middleware must be configured:

```csharp
app.UseStaticFiles();
```

### 8. Validate Database Connectivity

If the application uses Entity Framework or direct database access, confirm the connection strings are correctly configured in `appsettings.json` and that the database context initializes without errors on startup.

### 9. Check Windows-Specific Dependencies

If the application is intended to run on Linux or macOS, audit the codebase for any remaining Windows-specific dependencies such as:

- Windows Registry access
- Windows Authentication (requires additional configuration on non-Windows hosts)
- COM interop
- `System.Drawing` (use a cross-platform alternative such as `SkiaSharp` if needed)

### 10. Review Application Logs on Startup

Check the application's startup logs for any runtime warnings or errors that do not surface at build time but may indicate misconfigured middleware, missing services, or unresolved dependencies.