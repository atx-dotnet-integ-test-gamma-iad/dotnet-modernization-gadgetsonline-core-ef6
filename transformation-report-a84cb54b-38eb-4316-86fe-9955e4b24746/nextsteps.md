# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Run Unit Tests

If the solution contains any test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test
```

Review the test output for any failures that may indicate behavioral differences introduced by the migration.

### 4. Run the Application Locally

Start the application locally and exercise its core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Verify that:
- The application starts without runtime exceptions
- All routes and pages load as expected
- Database connections and queries function correctly
- Any authentication or session handling behaves as before

### 5. Review Replaced or Removed APIs

Cross-platform .NET does not support certain legacy APIs that were available in .NET Framework. Manually review the codebase for usage of the following common problem areas:

- `System.Web` namespaces (e.g., `HttpContext`, `HttpRequest` from `System.Web`) — these should now use `Microsoft.AspNetCore.Http`
- `ConfigurationManager` — should be replaced with `IConfiguration` from `Microsoft.Extensions.Configuration`
- Windows-specific APIs such as the registry, `System.Drawing` (GDI+), or WCF server-side components
- Any third-party libraries that were targeting .NET Framework exclusively — confirm their NuGet packages have .NET-compatible versions

### 6. Check the Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework moniker (TFM) is set to a supported and intended version:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.AspNetCore.App` where appropriate.

### 7. Verify Static Files and Configuration

- Confirm that `appsettings.json` contains the correct configuration values that were previously in `Web.config` or `App.config`
- Verify that static files (CSS, JS, images) are still served correctly
- Check that connection strings have been moved to `appsettings.json` or environment variables

### 8. Review Middleware and Startup Configuration

If this is an ASP.NET Core project, review `Program.cs` (and `Startup.cs` if present) to confirm:
- Middleware is registered in the correct order
- Services such as Entity Framework, Identity, or MVC are registered properly in the dependency injection container