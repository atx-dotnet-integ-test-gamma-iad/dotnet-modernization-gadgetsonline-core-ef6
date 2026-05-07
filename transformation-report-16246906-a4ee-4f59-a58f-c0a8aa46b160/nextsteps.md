# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate latent issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary workflows (e.g., browsing products, adding to cart, checkout) to confirm functional parity with the legacy version.

### 5. Check for Removed or Changed APIs

Legacy ASP.NET projects often rely on APIs that have been removed or significantly changed in cross-platform .NET. Specifically, verify the following:

- **`System.Web` dependencies**: Any remaining references to `System.Web` will not function on cross-platform .NET. Search the codebase for `using System.Web` and replace with appropriate ASP.NET Core equivalents.
- **`HttpContext` usage**: Ensure all access to `HttpContext` goes through dependency injection or `IHttpContextAccessor` rather than the static `HttpContext.Current`.
- **Session and Authentication**: Confirm that session management and authentication middleware have been migrated to the ASP.NET Core equivalents in `Program.cs` or `Startup.cs`.

### 6. Review Configuration Files

- Confirm that `web.config` settings have been migrated to `appsettings.json`.
- Verify that connection strings in `appsettings.json` are correct and accessible from the new runtime environment.

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "your-connection-string-here"
  }
}
```

### 7. Execute Tests

If the solution contains a test project, run the test suite to validate business logic and integration points:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions or tests that need to be updated to account for the new project structure.

### 8. Verify Static Files and Bundling

Cross-platform .NET does not use the legacy `BundleConfig` approach. Confirm that static files (CSS, JavaScript, images) are being served correctly and that any bundling or minification has been migrated to a supported tool such as the `BundleMinifier` NuGet package or a front-end build tool.

### 9. Database Migrations

If the project uses Entity Framework, verify that migrations are compatible with the new runtime:

```bash
dotnet ef database update
```

If the migrations were generated under the legacy framework, you may need to review them for compatibility with the current version of Entity Framework Core.

### 10. Publish the Application

Once all validation steps pass, produce a publish artifact:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.