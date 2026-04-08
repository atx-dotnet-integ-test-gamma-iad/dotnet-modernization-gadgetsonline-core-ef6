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

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or another actively supported .NET version rather than a legacy `net4x` framework moniker.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the locally hosted URL and verify that the core functionality of the application behaves as expected.

### 5. Review Replaced or Removed APIs

Check the codebase for any usages of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to inspect include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related types, which may have moved to `Microsoft.AspNetCore.Http`
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`
- `Global.asax` lifecycle events, which should be migrated to `Program.cs` and middleware

### 6. Verify Database Connectivity

If the application uses Entity Framework or another data access layer, confirm that:

- The connection string in `appsettings.json` is correctly configured for the target environment
- Migrations are up to date by running:

```bash
dotnet ef database update
```

- Basic CRUD operations function correctly against the database

### 7. Execute Existing Tests

If a test project exists in the solution, run all tests to validate application behavior:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 8. Review Static Files and wwwroot

If this is a web application, confirm that static assets such as CSS, JavaScript, and images have been moved to the `wwwroot` folder, as required by ASP.NET Core conventions.

### 9. Check Middleware and Startup Configuration

If the project previously used `Startup.cs`, verify that the middleware pipeline and service registrations have been correctly moved to `Program.cs` using the minimal hosting model, or that `Startup.cs` is still properly wired up if retained.

### 10. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and verify all expected files are present before deploying to the target environment.