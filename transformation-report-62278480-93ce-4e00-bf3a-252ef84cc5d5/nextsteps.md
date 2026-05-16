# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, verify it targets `net8.0` or the appropriate version and that the project SDK is set to `Microsoft.NET.Sdk.Web`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves as expected compared to the legacy version.

### 5. Execute Existing Tests

If a test project exists in the solution, run the test suite to validate business logic and integration points:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 6. Verify Database Connectivity

If the application uses a database, confirm that:

- Connection strings in `appsettings.json` or `appsettings.Production.json` are updated to reflect the target environment.
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

- The database provider package (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) is compatible with the target .NET version.

### 7. Check for Windows-Specific API Usage

Since this was a legacy project migration, scan the codebase for any remaining Windows-specific APIs that may not be cross-platform compatible. Common areas to check include:

- `System.Web` references (should be replaced with ASP.NET Core equivalents)
- Windows Registry access
- Windows-specific file path assumptions (use `Path.Combine` consistently)
- `HttpContext.Current` usage (replace with dependency-injected `IHttpContextAccessor`)

### 8. Review Application Configuration

Legacy .NET Framework projects used `Web.config`. Confirm that all relevant configuration values have been migrated to `appsettings.json` and that the application reads them using `IConfiguration`.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present, then deploy the published output to the target environment.