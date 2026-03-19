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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas that may cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and verify that core functionality, such as product browsing, cart operations, and checkout, behaves correctly.

### 5. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in .NET Core or later
- `HttpContext` usage outside of a controller or middleware context
- `ConfigurationManager` usage, which should be replaced with `IConfiguration`
- Any Windows-specific APIs such as the registry or certain I/O operations

### 6. Verify Configuration Files

Ensure that `appsettings.json` contains all necessary configuration values that were previously stored in `web.config` or `app.config`. Pay particular attention to:

- Database connection strings
- Application-specific settings
- Any third-party service keys or endpoints

### 7. Database Connectivity

If the application uses a database, verify that the connection string in `appsettings.json` is correct and that the database is accessible from the new runtime environment. Run any pending Entity Framework migrations if applicable:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 8. Execute Tests

If a test project exists within the solution, run all tests to confirm expected behavior:

```bash
dotnet test
```

Review any failing tests and resolve the underlying issues before proceeding to deployment.

### 9. Review Static Files and Bundling

If the project previously used `System.Web.Optimization` for bundling and minification, verify that an equivalent mechanism such as `WebOptimizer` or a front-end build tool has been configured correctly and that static assets are served as expected.

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, including static assets and configuration files, are present before deploying to the target environment.