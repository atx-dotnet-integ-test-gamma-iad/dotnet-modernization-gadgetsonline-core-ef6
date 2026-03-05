# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version, such as:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to `net8.0` as those versions are out of support.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves the same as it did in the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate business logic and integration points:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect regressions introduced during the migration or pre-existing issues.

### 6. Check for Removed or Changed APIs

Cross-platform .NET removed or changed several APIs that existed in .NET Framework. Manually review the following areas:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Confirm that any previously used `System.Web` types (e.g., `HttpContext`, `HttpRequest`) have been replaced with their `Microsoft.AspNetCore` equivalents.
- **`ConfigurationManager`**: If the project previously used `System.Configuration.ConfigurationManager`, confirm it has been replaced with `Microsoft.Extensions.Configuration`.
- **`BinaryFormatter`**: This has been disabled by default. If serialization was used, confirm it has been replaced with a supported alternative such as `System.Text.Json` or `System.Xml.Serialization`.

### 7. Validate Static Files and Middleware

If this is a web project, confirm that static files, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`:

- Static file serving via `app.UseStaticFiles()`
- Routing via `app.UseRouting()`
- Authentication/Authorization middleware if applicable

### 8. Review Connection Strings and Configuration

Confirm that `appsettings.json` contains the correct connection strings and configuration values that were previously held in `Web.config` or `App.config`. Verify that environment-specific settings (e.g., `appsettings.Development.json`) are in place.

### 9. Test Database Connectivity

If the project uses a database, confirm that:

- The connection string in `appsettings.json` is correct.
- Migrations (if using Entity Framework Core) are up to date by running:

```bash
dotnet ef database update
```

- Data reads and writes function correctly through the application.

### 10. Publish the Application

Once validation is complete, produce a published output to confirm the deployment artifact builds correctly:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all expected files are present before deploying to the target environment.