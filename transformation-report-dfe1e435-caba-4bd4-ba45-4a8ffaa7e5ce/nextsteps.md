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

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types or obsolete APIs, as these may indicate areas that were not fully modernized.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older or end-of-life version (e.g., `net5.0` or `net6.0`), consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality to confirm there are no runtime exceptions that were not caught at compile time.

### 5. Review Removed or Replaced APIs

Check the codebase for any usage of APIs that were commonly removed or changed during migration from .NET Framework to cross-platform .NET, including:

- `System.Web` namespaces (these are not available in cross-platform .NET)
- `HttpContext` usage outside of the ASP.NET Core request pipeline
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `System.Web.HttpUtility` (replaced by `System.Net.WebUtility` or `Microsoft.AspNetCore.WebUtilities`)

### 6. Verify Configuration Files

Ensure that `web.config` or `app.config` settings have been migrated to `appsettings.json` where applicable. Cross-platform .NET does not use `web.config` for application configuration in the same way as .NET Framework.

Check that connection strings, application settings, and any environment-specific values are present in `appsettings.json` or `appsettings.{Environment}.json`.

### 7. Execute Unit Tests

If the solution contains test projects, run them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a regression introduced during migration or a test that requires updating to reflect new API usage.

### 8. Verify Static Files and Middleware

If `GadgetsOnline` is a web application, confirm that static file serving, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs` using the ASP.NET Core conventions. Ensure the following are present where needed:

```csharp
app.UseStaticFiles();
app.UseRouting();
app.UseAuthorization();
```

### 9. Check Database Connectivity

If the application uses a database, verify that the connection string is correct for the target environment and that the data access layer (Entity Framework Core or ADO.NET) functions as expected by performing basic read and write operations.

### 10. Review Publish Output

Perform a publish to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to ensure all required files, static assets, and configuration files are present.