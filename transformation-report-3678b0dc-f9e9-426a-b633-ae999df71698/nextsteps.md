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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas of the code that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older or end-of-life version, update it accordingly:

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application locally to verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to confirm that core functionality is intact.

### 5. Review Platform-Specific Code

Search the codebase for any APIs or libraries that were previously Windows-specific, such as those from `System.Web`, `System.Drawing`, or the Windows Registry. Confirm that suitable cross-platform replacements have been applied. Common areas to check include:

- HTTP handling (migrated from `System.Web.HttpContext` to `Microsoft.AspNetCore.Http`)
- Session and authentication middleware
- File path handling using `Path.Combine` rather than hardcoded separators

### 6. Check Configuration Files

Verify that `appsettings.json` (and `appsettings.Development.json` if applicable) contains all configuration values that were previously stored in `Web.config` or `App.config`. Pay particular attention to:

- Connection strings
- Application settings keys
- Authentication or authorization settings

### 7. Database Connectivity

If the application uses a database, confirm the connection string in `appsettings.json` is correct and that the database provider package (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) is referenced and up to date. Run any pending migrations if Entity Framework Core is in use:

```bash
dotnet ef database update
```

### 8. Execute Tests

If a test project exists in the solution, run the test suite to validate application behavior:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions introduced during the migration or test code that itself requires updating for the new framework.

### 9. Review Static Files and Web Assets

If this is a web application, confirm that static files (CSS, JavaScript, images) are located under the `wwwroot` folder and that the static file middleware is enabled in `Program.cs` or `Startup.cs`:

```csharp
app.UseStaticFiles();
```

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and self-contained:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.