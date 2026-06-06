# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are correctly restored:

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

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to an appropriate and supported version of .NET, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If the target framework is outdated (e.g., `net6.0`), consider updating it to a currently supported long-term support (LTS) release.

### 4. Run Unit Tests

If the solution contains test projects, execute the test suite to verify that existing functionality behaves as expected:

```bash
dotnet test --configuration Release
```

Review the test results for any failures that may have been introduced during the migration.

### 5. Run the Application Locally

Start the application locally to perform basic smoke testing:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application's primary workflows to confirm that core functionality is intact.

### 6. Review Removed or Replaced APIs

Check the codebase for any usage of APIs that were commonly replaced during migration from .NET Framework to cross-platform .NET, including:

- `System.Web` references, which should have been replaced with `Microsoft.AspNetCore` equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages to confirm they reference the ASP.NET Core versions.
- Any usage of `ConfigurationManager`, which should now use `Microsoft.Extensions.Configuration`.
- `Global.asax` logic, which should have been migrated to `Program.cs` and middleware.

### 7. Verify Static Files and Configuration

- Confirm that `wwwroot` contains all necessary static assets (CSS, JavaScript, images).
- Verify that `appsettings.json` contains the configuration values that were previously held in `Web.config`.
- Check that connection strings and application settings are correctly mapped.

### 8. Test Database Connectivity

If the application uses a database, verify that the connection string in `appsettings.json` is correct and that the application can connect to the database successfully during local execution.

### 9. Check Middleware and Startup Configuration

Open `Program.cs` and confirm that the middleware pipeline is configured correctly, including:

- Authentication and authorization middleware, if applicable.
- Static file serving (`app.UseStaticFiles()`).
- Routing (`app.UseRouting()`).
- Any custom middleware that was previously registered in `Global.asax` or `Startup.cs`.

### 10. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.