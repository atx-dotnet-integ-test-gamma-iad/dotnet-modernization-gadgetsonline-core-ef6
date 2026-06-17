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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas that may cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net6.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework is outdated (e.g., `net5.0` or `net6.0`), consider updating to the latest Long-Term Support (LTS) release.

### 4. Run the Application Locally

Start the application to verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key pages and features to confirm basic functionality is intact.

### 5. Check for Removed or Changed APIs

Cross-platform .NET removed several APIs that existed in .NET Framework. Verify the following areas manually:

- **`System.Web` dependencies**: Ensure no remaining references exist, as `System.Web` is not available in cross-platform .NET.
- **`HttpContext` and session handling**: Confirm these have been migrated to the ASP.NET Core equivalents.
- **`Web.config`**: Ensure configuration has been migrated to `appsettings.json` and the `IConfiguration` pattern.
- **Database access**: If Entity Framework is used, confirm it has been updated to Entity Framework Core.

### 6. Run Unit Tests

If the solution contains test projects, execute them to validate business logic:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a functional regression introduced during transformation.

### 7. Verify Static Files and Bundling

If the project uses static files, CSS, or JavaScript bundling, confirm that:

- Static files are served correctly via the `wwwroot` folder.
- Any bundling or minification tooling (e.g., LibMan, npm) is configured and functioning.

### 8. Review Middleware Pipeline

Open `Program.cs` or `Startup.cs` and confirm the middleware pipeline is correctly ordered. Key middleware to verify includes:

- `UseRouting()`
- `UseAuthentication()` and `UseAuthorization()` (if applicable)
- `UseStaticFiles()`
- `UseEndpoints()` or mapped controllers/Razor Pages

### 9. Test Against the Target Database

Run the application against the actual database to confirm:

- Connection strings in `appsettings.json` are correct.
- Any pending migrations are applied:

```bash
dotnet ef database update
```

- Data reads and writes function as expected.

### 10. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present before deploying to the target environment.