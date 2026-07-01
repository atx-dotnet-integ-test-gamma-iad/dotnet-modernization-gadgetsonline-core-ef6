# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The solution build output contains no errors across all projects. The transformation to cross-platform .NET appears to have completed successfully.

## Validation

### 1. Restore Dependencies
Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution
Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended modern .NET version (e.g., `net8.0`). Verify that no legacy framework monikers such as `net472` or `netcoreapp3.1` remain unless intentionally kept.

### 4. Run the Application Locally
Start the application and navigate through its core functionality to identify any runtime issues that would not surface at compile time:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Check for runtime exceptions, missing configuration values, or middleware that may have been affected by the migration.

### 5. Check Configuration Files
Review `appsettings.json` (and environment-specific variants such as `appsettings.Development.json`) to ensure all connection strings, API keys, and application settings were carried over from the legacy configuration system (e.g., `Web.config` or `App.config`).

### 6. Verify Static Files and wwwroot
If the project is a web application, confirm that static assets (CSS, JavaScript, images) are present under the `wwwroot` folder and are being served correctly at runtime.

### 7. Database Connectivity
If the application uses a database, verify the connection string is valid and that the database provider package (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) is the correct version for the target framework. Run any pending migrations if applicable:

```bash
dotnet ef database update
```

### 8. Run Existing Tests
If a test project exists in the solution, execute the test suite to confirm that behavior has not regressed:

```bash
dotnet test
```

Review any failing tests to determine whether they indicate a functional regression or a test configuration issue introduced during migration.

### 9. Review Removed or Replaced APIs
Check for any use of APIs that were available in .NET Framework but have changed or been removed in modern .NET, such as:
- `System.Web` types (e.g., `HttpContext`, `HttpRequest`)
- `ConfigurationManager`
- `BinaryFormatter`
- Windows-specific APIs that may not be cross-platform

These will not always produce build errors but can cause runtime failures.

### 10. Deployment
Once the application passes local validation, publish the application using the appropriate runtime identifier for your target environment:

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

Or for Windows:

```bash
dotnet publish --configuration Release --runtime win-x64 --self-contained false
```

Review the contents of the publish output folder before deploying to the target environment.