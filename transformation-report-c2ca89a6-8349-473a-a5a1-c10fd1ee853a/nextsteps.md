# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or another actively supported .NET version and not a legacy framework such as `net462` or `netcoreapp3.1`.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to confirm runtime behavior matches the legacy version.

### 5. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. If any runtime errors reference `System.Web`, those areas will need to be refactored to use ASP.NET Core equivalents.
- **`HttpContext` usage**: Ensure access to `HttpContext` is done through dependency injection rather than `HttpContext.Current`.
- **`ConfigurationManager`**: Replace any usage with `Microsoft.Extensions.Configuration` and `appsettings.json`.
- **`Session` and `Authentication`**: Verify these are configured through ASP.NET Core middleware in `Program.cs` or `Startup.cs`.

### 6. Review Static Files and wwwroot

Confirm that static assets such as CSS, JavaScript, and images have been placed under the `wwwroot` folder, as this is required by ASP.NET Core's static file middleware.

### 7. Database and Entity Framework

If the project uses Entity Framework, verify the following:

- The correct EF Core provider package is installed (e.g., `Microsoft.EntityFrameworkCore.SqlServer`).
- Run any pending migrations:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

- Confirm connection strings in `appsettings.json` are correct for the target environment.

### 8. Run Tests

If a test project exists in the solution, execute the tests to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and address regressions introduced by the migration.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is as expected:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present before deploying to the target environment.